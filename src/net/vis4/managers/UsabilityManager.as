package net.vis4.managers 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;

	public class UsabilityManager
	{
		
		public static var KEEP_FOCUS:Boolean = false;
		public static var _obj:Sprite;
		
		public static function activateKeyboardUsability(stage:Stage):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			
		}
		
		
		public static function deactivateKeyboardUsability(stage:Stage):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
		}
		
		private static function _onKeyDown(e:KeyboardEvent):void 
		{
			switch (e.keyCode) { // F5
				case 116: // F5
					if (ExternalInterface.available) ExternalInterface.call('reload');
					break;
				case 17: // user hit ctrl key, so give focus to browser
				case 27: // user hit esc key, so give focus to browser
					if (ExternalInterface.available && !KEEP_FOCUS) 
						ExternalInterface.call('blurFlash');
					break;
			}
		}
		
	}

}