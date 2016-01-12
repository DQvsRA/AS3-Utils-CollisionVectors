package net.vis4.text.fonts 
{
	
	/**
	 * class for build in system fonts
	 * @author gka
	 */
	public class SystemFont extends Font
	{
		
		public function SystemFont(name:String = 'Arial', color:uint = 0, size:Number = 12, alpha:Number = 1, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false) 
		{
			super(name, color, size, alpha, bold, italic, underline, false);
		}
		
		public function set size(value:Number):void 
		{
			_size = value;
		}
		
		public function set bold(value:Boolean):void 
		{
			_bold = value;
		}
		
		public function set italic(value:Boolean):void 
		{
			_italic = value;
		}		
	}
	
}