package net.vis4.geo.projection 
{
	import flash.geom.Point;
	import net.vis4.geo.MapCoordinate;
	
	/**
	 * ...
	 * @author gka
	 */
	public class MillerCylindrical extends MapProjection
	{
		public function MillerCylindrical(scale:Number = 10000)
		{
			super(scale);
		}
		
		public override function coord2point(c:MapCoordinate):Point 
		{
			var lat:Number = c.lat * Math.PI / -180;
			var lng:Number = c.lng * Math.PI / 180;
			
			return new Point(				
				_scale * (lng),
				_scale * 1.25 * Math.log(Math.tan(0.25 * Math.PI + 0.4 * lat))
			);
		}
	}
	
}