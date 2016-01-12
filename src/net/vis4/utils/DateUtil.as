package net.vis4.utils 
{
	import com.adobe.utils.DateUtil;
	/**
	 * ...
	 * @author gka
	 */
	public class DateUtil extends com.adobe.utils.DateUtil
	{
		public static function dayOfYear(date:Date):uint 
		{
			var d:Date = new Date(date.fullYear, 0, 1);
			return Math.floor((date.time - d.time) / 86400000);
		}		
	}
	
}