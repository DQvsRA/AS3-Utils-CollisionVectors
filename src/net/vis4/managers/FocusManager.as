package net.vis4.managers 
{
	import flash.events.FocusEvent;
	
	/**
	 * ...
	 * @author gka
	 */
	public class FocusManager 
	{
		private var _needKeyboardInput:Boolean = false;
		private static var _instance:FocusManager;

		public static function getInstance():FocusManager
		{
			if (!(_instance is FocusManager)) _instance = new FocusManager();
			return _instance;
		}
		
		public static function get instance():FocusManager
		{
			return getInstance();
		}		
		
		public function FocusManager() 
		{
			
		}
		
		public function set needKeyboardInput(bool:Boolean):void
		{
			_needKeyboardInput = bool;
		}
		
		public function get needKeyboardInput():Boolean
		{
			return _needKeyboardInput;
		}
		

		
	}
	
}