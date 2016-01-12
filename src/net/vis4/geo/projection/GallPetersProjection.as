package net.vis4.geo.projection 
{
	import net.vis4.geo.MapCoordinate;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author gka
	 */
	public class GallPetersProjection extends MapProjection
	{
		
		public function GallPetersProjection(scale:Number = 10000) 
		{
			super(scale);
		}
		
		override public function coord2point(c:MapCoordinate):Point 
		{
			var lat:Number = c.lat * Math.PI / -180;
			var lng:Number = c.lng * Math.PI / 180;
			
			return new Point(
				(_scale * lng) / (Math.SQRT2),	
				(_scale * Math.SQRT2 * Math.sin(lat))
			);
		}
	}
	
}