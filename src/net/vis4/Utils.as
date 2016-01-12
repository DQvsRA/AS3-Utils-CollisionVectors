package net.vis4
{
	import flash.utils.Dictionary;
	import net.vis4.utils.NumberUtil;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Utils 
	{
		/*
		 * converts a uint-color to hex-string #ABCDEF
		 * 
		 */ 
		public static function intToHex(color:int = 0):String {
			var mask:String = "000000";
			var str:String = mask + color.toString(16).toUpperCase()
			return "#" + str.substr(str.length - 6);
		}

		public static function hex2Int(color:String):uint {
			color = '0x' + color.substr(1,6);
			return uint(color);
		}
		/*
		 * returns unix-timestamp
		 * (seconds since 1.1.1970)
		 * 
		 */ 
		public static function currentTime():uint {
			return Math.floor(new Date().time / 1000);
		}
		
		public static function round(x:Number, prec:uint = 2):Number {
			return Math.round(x * Math.pow(10, prec)) / Math.pow(10, prec);
		}
		
		public static function decodeUrlVars(url:String):Dictionary
		{
			var result:Dictionary = new Dictionary();
			var pairs:Array = url.split('&');
			for (var i:uint = 0; i < pairs.length; i++) {
				var item:Array = (pairs[i] as String).split('=');
				result[item[0]] = unescape(item[1]);
			}
			return result;
		}

		public static function shortenText(s:String, length:uint):String
		{
			if (s.length > length) {
				s = s.substr(0, 5) + '...' + s.substr(Math.max(9, s.length + 8 - length));
			} 
			return s;
		}
		
		public static function traceArray(a:Array):void
		{
			for (var i:uint = 0; i < a.length; i++) {
				if (a[i] is Array) {
					
					for (var j:uint = 0; j < (a[i] as Array).length; j++) {
						if (j == 0) {
							trace(i, '>', '  ', j,'>',a[i][j]);
						}
						else trace('      ', j, '>', a[i][j]);
					}
					//trace('    ]');
				} else {
					trace(i, '>', a);
				}				
			}
		}
		
		public static function leadingZeros(num:int, count:uint):String
		{
			var r:String = "";
			for (var i:uint = 0; i < count - String(num).length; i++) {
				r += "0";
			}
			return r + num;
		}
		
		public static function formatNumber(value:Number, language:String = 'en', precision:uint = 0):String
		{
			var num:Number;
			if (value is String) {
				num = Number(value as String);
			} else {
				num = value as Number;
			}
			
			var r:String = '',a:String = String(Math.floor(num));
			
			for (var i:uint = 0; i < a.length; i++) 
			{
				if (i > 0 && i % 3 == 0) r = (language != 'en' ? '.' : ',') + r;
				r = a.charAt(a.length - 1 - i) + r;
			}
			
			var b:Number = num - Math.floor(num);
			if (b == 0) return r;
			b = Math.round(b * Math.pow(10,precision));
			var beyond:Boolean = false; // num < 0.1 && num > 0;
			
			return (beyond ? '< ' : '') +String(r) + (language != 'en' ? ',' : '.') + b;
		}
		

	}
	
}