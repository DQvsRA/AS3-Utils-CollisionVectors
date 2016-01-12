package net.vis4.color 
{
	
	/**
	 * ...
	 * @author gka
	 */
	public class ColorUtil 
	{
		
		public static function int2hex(col:uint):String
		{
			var str:String = "000000" + col.toString(16).toUpperCase()
			return "#" + str.substr(str.length - 6);
		}
		
	}
	
}