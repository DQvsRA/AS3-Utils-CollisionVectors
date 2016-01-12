package net.vis4.geom 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Circle 
	{
		private var _center:Point;
		private var _radius:Number;
		
		public function Circle(center:Point, radius:Number) 
		{
			_center = center;
			_radius = radius;
		}
		
		public function get area():Number
		{
			return Math.PI * _radius * _radius;
		}
		
		public function get center():Point { return _center; }
		
		public function set center(value:Point):void 
		{
			_center = value;
		}
		
		public function get radius():Number { return _radius; }
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}
		
		public function intersectsCircle(c:Circle):Boolean
		{
			var minDist:Number = _radius + c.radius;
			return Math.sqrt((center.x - c.center.x) * (center.x - c.center.x) + (center.y - c.center.y) * (center.y - c.center.y)) < minDist;
		}
	}
	
}