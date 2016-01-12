package net.vis4.geo 
{
	import net.vis4.utils.NumberUtil;
	
	/**
	 * ...
	 * @author gka
	 */
	public class MapCoordinate 
	{
		private var _lat:Number;
		private var _lng:Number;
		
		
		// latitude = y
		// longitude = x
		public function MapCoordinate(lat:Number, lng:Number) 
		{
			latitude = lat;
			longitude = lng;
		}
		
		public function get lng():Number { return _lng; }
		
		public function set lng(value:Number):void 
		{
			_lng = value;
		}
		
		public function get lat():Number { return _lat; }
		
		public function set lat(value:Number):void 
		{
			_lat = value;
		}
		
		public function get longitude():Number { return _lng; }
		
		public function set longitude(value:Number):void 
		{
			lng = value;
		}
		
		public function get latitude():Number { return _lat; }
		
		public function set latitude(value:Number):void 
		{
			lat = value;
		}
		
		public function toString():String
		{
			return lat+','+lng;
		}
		
		public function equals(m:MapCoordinate):Boolean
		{
			var p:uint = 2;
			return NumberUtil.round(m.lat, p) == NumberUtil.round(lat, p) && NumberUtil.round(m.lng, p) == NumberUtil.round(lng, p);
		}
	}
	
}