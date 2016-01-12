package net.vis4.geom 
{
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Polygon implements IPolygon
	{
		private var _pointSet:PointSet;
		private var _areaCentroidFlag:Boolean = false;
		private var _area:Number;
		private var _centroid:Point;
		private var _convexHullFlag:Boolean = false;
		private var _convexHull:IPolygon;
		
		public function Polygon(pointSet:PointSet) 
		{
			_pointSet = pointSet;
		}
		
		public function get points():PointSet
		{
			return _pointSet;
		}
		
		public function get area():Number
		{
			if (!_areaCentroidFlag) computeAreaAndCentroid();
			return Math.abs(_area);
		}
		
		public function get centroid():Point
		{
			if (!_areaCentroidFlag) computeAreaAndCentroid();
			return _centroid;
		}
		
		private function computeAreaAndCentroid():void
		{
			_area = 0;
			var x:Number = 0;
			var y:Number = 0;
			for (var i:uint = 0; i < _pointSet.length; i++) {
				var p1:Point = _pointSet[i];
				var p2:Point = _pointSet[(i + 1) % _pointSet.length];
				_area += (p1.x * p2.y) - (p2.x * p1.y);
				x += (p1.x + p2.x) * (p1.x * p2.y - p2.x * p1.y);
				y += (p1.y + p2.y) * (p1.x * p2.y - p2.x * p1.y);
			}
			_area = _area / 2;
			_centroid = new Point(x / (6 * _area), y / (6 * _area));	
			_areaCentroidFlag = true;
		}
		
		public function get boundingBox():Rectangle
		{
			return _pointSet.bounds;
		}
		
		public function get convexHull():IPolygon
		{
			if (!_convexHullFlag) computeConvexHull();
			return _convexHull;
		}
		
		/*
		 * computation of the convex hull according to melkman algorithm
		 * (taken from http://softsurfer.com/Archive/algorithm_0203/algorithm_0203.htm)
		 */
		private function computeConvexHull():void
		{
			var V:PointSet = _pointSet;
			var n:Number = V.length;
			var D:PointSet = new PointSet(2 * n + 1);
			var H:PointSet = new PointSet();
			var bot:int = n - 2, top:int = bot + 3;
			
			if (n < 4) {
				H = V;
			} else {
				D[bot] = D[top] = V[2];
				
				if (_isLeft(V[0], V[1], V[2]) > 0) {
					D[bot+1] = V[0];
					D[bot+2] = V[1];          // ccw vertices are: 2,0,1,2
				}
				else {
					D[bot+1] = V[1];
					D[bot+2] = V[0];          // ccw vertices are: 2,1,0,2
				}

				// compute the hull on the deque D[]
				for (var i:int=3; i < n; i++) {   // process the rest of vertices
					// test if next vertex is inside the deque hull
					if ((_isLeft(D[bot], D[bot+1], V[i]) > 0) &&
						(_isLeft(D[top-1], D[top], V[i]) > 0) )
							continue;         // skip an interior vertex

					// incrementally add an exterior vertex to the deque hull
					// get the rightmost tangent at the deque bot
					while (_isLeft(D[bot], D[bot+1], V[i]) <= 0)
						++bot;                // remove bot of deque
					D[--bot] = V[i];          // insert V[i] at bot of deque

					// get the leftmost tangent at the deque top
					while (_isLeft(D[top-1], D[top], V[i]) <= 0)
						--top;                // pop top of deque
					D[++top] = V[i];          // push V[i] onto top of deque
				}

				// transcribe deque D[] to the output hull array H[]
				var h:int;        // hull vertex counter
				for (h = 0; h <= (top - bot); h++) H.push(D[bot + h]);
			}
			
			_convexHull = new Polygon(H);
			_convexHullFlag = true;
		}
		
		/*
		 * helper function for computeConvexHull()
		 */
		private function _isLeft(p0:Point, p1:Point, p2:Point):Number
		{
			if (p0 is Point && p1 is Point && p2 is Point) 
				return (p1.x - p0.x) * (p2.y - p0.y) - (p2.x - p0.x) * (p1.y - p0.y);
			else {
				trace('Polygon-Warning: one Point in _isLeft is null');
				return -1;
			}
		}
		
		/*
		 * polygon simplification as shown here: 
		 * http://softsurfer.com/Archive/algorithm_0205/algorithm_0205.htm#Vertex%20Reduction
		 */ 
		public function simplify(radius:Number):IPolygon
		{
			var newPoints:PointSet = new PointSet();
			
			var q:Point = _pointSet[0];
			
			var maxdist:Number = radius * radius;
			for (var i:uint = 1; i < _pointSet.length; i++) {
				var p:Point = _pointSet[i];
				if ((p.x - q.x)*(p.x - q.x) + (p.y - q.y)*(p.y - q.y) > maxdist) {
					newPoints.push(p);
					q = p;
				}
			}
			return new Polygon(newPoints);
		}
		
		private function _roundPoint(p:Point, rad:Number):Point
		{
			return new Point (
				Math.round(p.x / rad) * rad,
				Math.round(p.y / rad) * rad
			);		
		}
		
		/*
		 * point in polygon solution
		 * 
		 */ 
		public function containsPoint(point:Point):Boolean
		{
			if (!boundingBox.containsPoint(point)) return false;
			if (!_pointInPolygon(convexHull.points, point)) return false;
			return _pointInPolygon(points, point);
		}
		
		private function _pointInPolygon(pointSet:PointSet, point:Point):Boolean
		{
			var counter:int = 0;
			var i:int;
			var xinters:Number;
			var p1:Point, p2: Point;

			p1 = pointSet[0];
			for (i = 1; i <= pointSet.length; i++) {
				p2 = pointSet[i % pointSet.length];
				if (point.y > Math.min(p1.y, p2.y)) { 
					if (point.y <= Math.max(p1.y, p2.y)) { 
						if (point.x <= Math.max(p1.x, p2.x)) { 
							if (p1.y != p2.y) { 
								xinters = (point.y - p1.y) * (p2.x - p1.x) / (p2.y - p1.y) + p1.x;
								if (p1.x == p2.x || point.x <= xinters)	counter++;
							}
						}
					}
				}
				p1 = p2;
			}
			return (counter % 2 != 0);			
		}
		
		public function containsCircle(circle:Circle):Boolean
		{
			var sample:Point;
			const sampleCnt:uint = 15;
			for (var i:uint = 0; i < sampleCnt; i++) {
				sample = new Point(circle.center.x + Math.cos(i / sampleCnt * 2 * Math.PI)*circle.radius, 
					circle.center.y + Math.sin(i / sampleCnt * 2 * Math.PI) * circle.radius);
				if (!containsPoint(sample)) return false;
			}
			return true;
		}
		
		public function get sortedClockwise():Boolean
		{
			if (!_areaCentroidFlag) computeAreaAndCentroid();
			return _area > 0;
		}
		
		/*
		 * returns array of intersection coordinates or an empty array if no intersection occures 
		 */
		public function intersectLine(line:Line):Array
		{
			var mus:Array = [];
			
			for (var i:uint = 0; i < _pointSet.length; i++) {
				var a:Point = _pointSet[i] as Point;
				var b:Point = _pointSet[(i + 1) % _pointSet.length] as Point;
				var edge:Line = new Line(a, b.subtract(a));
				
				var m:Number = line.intersectLineMu(edge);
				
				if (!isNaN(m)) mus.push(m);
			}
			mus.sort();
			var points:Array = [];
			for (i = 0; i < mus.length; i++) points.push(line.pointOnLine(mus[i]));
			
			return points;
		}
		
	}
	
}