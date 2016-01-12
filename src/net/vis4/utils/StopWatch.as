package net.vis4.utils 
{
	
	/**
	 * ...
	 * @author gka
	 */
	public class StopWatch 
	{
		private static var _time:Number;
		private static var _subject:String;
		
		public static function start(subject:String = ''):void
		{
			_subject = subject;
			_time = new Date().time;
		}
		
		public static function stop():Number
		{
			trace((_subject == '' ? 'StopWatch' : _subject)+': ' + (new Date().time - _time) + ' ms');
			return new Date().time - _time;
			
		}
	}
	
}