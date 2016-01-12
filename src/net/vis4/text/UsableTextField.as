package net.vis4.text 
{
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import net.vis4.managers.UsabilityManager;
	
	/**
	 * ...
	 * @author gka
	 */
	public class UsableTextField extends TextField
	{
		
		public function UsableTextField() 
		{
			super();
			
			addEventListener(FocusEvent.FOCUS_IN, _focusIn);
			addEventListener(FocusEvent.FOCUS_OUT, _focusOut);
		}
		
		private function _focusOut(e:FocusEvent):void 
		{
			UsabilityManager.KEEP_FOCUS = false;
		}
		
		private function _focusIn(e:FocusEvent):void 
		{
			UsabilityManager.KEEP_FOCUS = true;
		}			
		
	}

}