package net.vis4.text 
{
	import com.actionscript_flash_guru.fireflashlite.Console;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TextAreaCSS extends TextArea
	{
		
		public function TextAreaCSS(txt:String, w:Number, css:String, fonts:Array) 
		{
			multiline = true;
			var s:StyleSheet = new StyleSheet();
			s.parseCSS(css);
			
			styleSheet = s;
				
			super(_parseText(txt), w, fonts[0], true, true, true);
			
			
			
		}
		
		private function _parseText(txt:String):String
		{
			
			txt = txt.replace(/<\/h2>/g, '</h2><h2 class="br"> </h2>');
			txt = txt.replace(/<\/p>/g, '</p><p class="br"> </p>');
			txt = txt.replace(/<b>/g, '<span class="bold">');
			txt = txt.replace(/<\/b>/g, '</span>');
			txt = txt.replace(/&shy;/g, '-');
			
			return txt;
		}
		
		override public function set htmlText(value:String):void 
		{
			super.htmlText = _parseText(value);
			var h:Number = textHeight;
			autoSize = TextFieldAutoSize.NONE;
			height = h + 10;
		}
		
	}
	
}