package net.vis4.utils 
{
	import com.adobe.utils.ArrayUtil;
	/**
	 * ...
	 * @author gka
	 */
	public class ArrayUtil extends com.adobe.utils.ArrayUtil
	{
		public static function sum(arr:Array):Number
		{
			var sum:Number = 0;
			for each (var n:Number in arr) sum += n;
			return sum;
		}
		
	}
	
}