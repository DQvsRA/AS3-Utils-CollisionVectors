package net.vis4.utils 
{
	import net.vis4.geo.MapCoordinate;
	import net.vis4.utils.NumberUtil;
	
	/**
	 * ...
	 * @author gka
	 */
	public class GeoUtil
	{
		
		/*
		 * returns distance in km
		 */
		public static function distance(a:MapCoordinate, b:MapCoordinate):Number
		{
			var R:Number = 6371; // km
			var d:Number = Math.acos(Math.sin(NumberUtil.deg2rad(a.lat))*Math.sin(NumberUtil.deg2rad(b.lat)) + 
                  Math.cos(NumberUtil.deg2rad(a.lat))*Math.cos(NumberUtil.deg2rad(b.lat)) *
                  Math.cos(NumberUtil.deg2rad(b.lng) - NumberUtil.deg2rad(a.lng))) * R;
			return d;
		}
	}
	
}