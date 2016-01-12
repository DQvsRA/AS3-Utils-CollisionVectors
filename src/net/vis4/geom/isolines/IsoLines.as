package net.vis4.geom.isolines 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import net.vis4.geom.delaunay.Edge;
	import net.vis4.geom.delaunay.Triangle;
	
	/**
	 * ...
	 * @author gka
	 */
	public class IsoLines 
	{
		private var _points:Array;
		private var _triangles:Array;
		private var _edges:Array;
		private var _values:Dictionary;
		
		public function IsoLines(points:Array, triangles:Array, values:Dictionary = null) 
		{
			_points = points;
			_triangles = triangles;
			_values = values;
			initEdges();			
		}
		
		/*
		 * sub-routine of isolines()
		 * prepares some data structures
		 */
		private function initEdges():void 
		{
			_edges = [];
			for each (var t:Triangle in _triangles) {
				t.e1 = _getEdge(t, t.p2, t.p3);
				t.e2 = _getEdge(t, t.p1, t.p3);
				t.e3 = _getEdge(t, t.p1, t.p2);
			}
		}
		
		/*
		 * sub-routine of initEdges
		 */		
		private function _getEdge(t:Triangle, from:uint, to:uint):Edge
		{
			for each (var e:Edge in _edges) {
				if ((e.p1 == from && e.p2 == to) || (e.p1 == to && e.p2 == from)) {
					e.t2 = t;
					return e;
				}
			}
			e = new Edge(from, to);
			e.t1 = t;
			_edges.push(e);
			return e;
		}
		
		/*
		 * calculates isoline points for a given value 
		 * return array of flash.geom.Point
		 */
		public function isoline(value:Number):Array
		{
			var tv:Dictionary = new Dictionary(true);
			
			var lines:Array = [];
			
			for each (var t:Triangle in _triangles) {
				if (tv[t] == true) continue;
				tv[t] = true;
				if (_checkTriangle(t, value)) {
					var line:Array = _traceIsoline(t, value, tv);
					if (line.length > 1) lines.push(line);				
				}
			}
			return lines;
		}

		/*
		 * sub-routine of isoline()
		 * checks if a given triangle contains a point of the isoline
		 */
		private function _checkTriangle(t:Triangle, v:Number):Boolean
		{
			return _checkEdge(t.e1, v) || _checkEdge(t.e2, v) || _checkEdge(t.e3, v);
		}
		
		private function _checkEdge(e:Edge, v:Number):Boolean
		{
			return _checkPoints(e.p1, e.p2, v);
		}	
		
		private function _checkPoints(p1:int, p2:int, v:Number):Boolean
		{
			var v1:Number = _values[_points[p1]],
				v2:Number = _values[_points[p2]];
			return (v1 < v && v2 > v) || (v1 > v && v2 < v) || (v1 == v) || (v2 == v);
		}
			
		/*
		 * sub-routine of isoline();
		 * traces an isoline through the TIN from one triangle to the next until the line stops
		 * or closes itself (in this case, the last point == the first point)
		 */
		private function _traceIsoline(start:Triangle, v:Number, tv:Dictionary):Array
		{
			var points:Array = [];
			var t:Triangle = start;
			var start_edge:Edge = _checkEdge(t.e1, v) ? t.e1 : (_checkEdge(t.e2, v) ? t.e2 : t.e3);
			
			points.push(__interpolateEdge(start_edge, v));
			var a:Array = __traceLine(start_edge, true, v, tv).reverse();
			var b:Array = __traceLine(start_edge, false, v, tv);
			
			
			points = new Array().concat(a, points, b);
			
			return points;
		}
		
		private function __traceLine(e_prev:Edge, dir_t1:Boolean, v:Number, tv:Dictionary):Array
		{
			var points:Array = [];
			var first:Edge = e_prev;
			
			var t:Triangle = dir_t1 ? e_prev.t1 : e_prev.t2;
			if (t == null) return [];
			var e_next:Edge;
			
			var z:uint = 0;
			do {
				if (_checkEdge(t.e1, v) && t.e1 != e_prev) e_next = t.e1;
				else if (_checkEdge(t.e2, v) && t.e2 != e_prev) e_next = t.e2;
				else if (_checkEdge(t.e3, v) && t.e3 != e_prev) e_next = t.e3;
				else break;
				
				points.push(__interpolateEdge(e_next, v));
				
				tv[t] = true;
				t = e_next.t1 == t ? e_next.t2 : e_next.t1;
				
				if (e_next == first) {					
					points.push(points[0]);
					break;
				} else if (t == null) break;
				e_prev = e_next;
				if (tv[t] == true) break;
			} while (z++ < _points.length * 3);
			return points;
		}
		
		private function __interpolateEdge(e:Edge, v:Number):Point
		{
			var v1:Number = _values[_points[e.p1]],
				v2:Number = _values[_points[e.p2]];
			if (v1 == v) return _points[e.p1];
			if (v2 == v) return _points[e.p2];
			
			if (v1 < v && v2 > v) return Point.interpolate(_points[e.p1], _points[e.p2], 1-(v - v1) / (v2 - v1));
			if (v1 > v && v2 < v) return Point.interpolate(_points[e.p1], _points[e.p2], (v - v2) / (v1 - v2));
			return new Point(0,0);			
		}
				
		public function get values():Dictionary { return _values; }
		
		public function set values(value:Dictionary):void 
		{
			_values = value;
		}
		
		public function get edges():Array { return _edges; }
	}
	
}