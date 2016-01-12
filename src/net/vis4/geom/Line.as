package net.vis4.geom 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Line 
	{
		private var _O:Point;
		private var _R:Point;
		
		public function Line(o:Point, r:Point) 
		{
			_O = o;
			_R = r;
		}
		
		public function get O():Point { return _O; }
		
		public function set O(value:Point):void 
		{
			_O = value;
		}
		
		public function get R():Point { return _R; }
		
		public function set R(value:Point):void 
		{
			_R = value;
		}
		
		public function get length():Number
		{
			return _R.length;
		}
		
		public function intersectLine(line:Line):Point
		{
			var a:Number = intersectLineMu(line);
			if (!isNaN(a) && a >= 0 && a <= 1) {
				return pointOnLine(a);
			} else return null;
		}

		public function intersectLineMu(line:Line):Number
		{
			var a:Number = 
				(line.R.x * (O.y - line.O.y) - line.R.y * (O.x - line.O.x)) / 
				((line.R.y * R.x) - (line.R.x * R.y));
			var b:Number = 
				(R.x * (O.y - line.O.y) - R.y * (O.x - line.O.x)) / 
				((line.R.y * R.x) - (line.R.x * R.y));	
			
			if (!isNaN(a) && a >= 0 && a <= 1 && !isNaN(b) && b >= 0 && b <= 1) {
				return a;
			} else return Number.NaN;
		}		
		
		public function pointOnLine(mu:Number):Point
		{
			return new Point(O.x + mu * R.x, O.y + mu * R.y);
		}
		
	}
	
}