package net.vis4.text 
{
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import net.vis4.text.fonts.Font;
	import net.vis4.text.Label;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TextArea extends UsableTextField
	{
		
		public function TextArea(txt:String, w:Number, font:Font, html:Boolean = true, wordWrap:Boolean = true, ignoreWhitespaces:Boolean = true) 
		{
			super();	
			this.wordWrap = wordWrap;
			if (ignoreWhitespaces) txt = txt.replace(/\n/, "");
			
			this.condenseWhite = ignoreWhitespaces;
			
			if (html) super.htmlText = txt; else super.text = txt;
			width = w; 
			embedFonts = font.embedded;
			autoSize = TextFieldAutoSize.LEFT;
			if (font.embedded) {
				antiAliasType = font.antiAliasType;
				sharpness = font.sharpness;		
				thickness = font.thickness;
			}
			selectable = true;
			
			tabEnabled = false;
		}
		
	}
	
}