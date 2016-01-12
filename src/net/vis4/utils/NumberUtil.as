package net.vis4.utils 
{
	
	/**
	 * ...
	 * @author gka
	 */
	public class NumberUtil
	{
		public static function formatBytes(n:uint):String
		{
			var unit:String, di:Number;
			if (n < 2000) { unit = 'B'; di = 1; }
			else if (n < 500000) { unit = 'kB'; di = 1024; }
			else { unit = 'MB'; di = 1048576; }
			
			return format(n / di, di > 1024 ? 2 : 0) + ' ' + unit;
		}
		
		public static function format(n:Number, precision:uint = 2, ksep:String = '.', dsep:String = ','):String 
		{
			n = round(n, precision);
			var M:Number = Math.floor(n);
			var d:Number = n - M;
			var m:String = String(M);
			var S:String = '';
			for (var i:uint = 0; i < m.length; i++) {
				S += m.charAt(m.length - 1 - i);
				if ((i+1) % 3 == 0) S += ksep;
			}
			return S + dsep + Math.floor(d*100);
		}
		
		public static function round(n:Number, precision:uint = 2):Number
		{
			return Math.round(n * Math.pow(10, precision)) / Math.pow(10, precision);
		}

		public static function roundToFactor(x:Number, factor:Number):Number 
		{
			return Math.round(Math.round(x * factor) / factor);
		}		
		
		public static function floorToFactor(x:Number, factor:Number):Number 
		{
			return Math.floor(Math.floor(x * factor) / factor);
		}	
		
		public static function ceilToFactor(x:Number, factor:Number):Number 
		{
			return Math.ceil(Math.ceil(x * factor) / factor);
		}	
		
		public static function angleDistance(a1:Number, a2:Number, clockwise:Boolean = true):Number 
		{
			if (a1 < a2) return clockwise ? a2 - a1 : 360 - a2 - a1;
			else return clockwise ? a2 + 360 - a1 : a1 - a2;
		}
		
		public static function value2size(value:Number, minValue:Number, maxValue:Number, minWidth:Number, maxWidth:Number, gamma:Number = 1000):Number
		{
			/*
			 * value = max
			 */
			var x:Number = (value - minValue) / (maxValue - minValue);
			var y:Number;
			
			if (gamma == 0) {
				// linearer zusammenhang
				y = x;
			} else if (gamma > 0) {
				// 1/x
				y = 1 - 1 / (x * gamma + 1);
			} else if (gamma < 0) {
				y = -1 / (x * ( -gamma) - ( -gamma + 1));
			}
			
			return y * (maxWidth - minWidth) + minWidth;
		}
		
		private static const K:Number = Math.PI / 180;
		
		public static function deg2rad(deg:Number):Number
		{
			return deg * K;
		}
			
		public static function rad2deg(rad:Number):Number
		{
			return rad / K;
		}
		
		public static function constrain(value:Number, min:Number, max:Number):Number
		{
			return Math.max(Math.min(value, max), min);
		}
		

	}
	
}