package net.vis4.text 
{
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	import net.vis4.text.fonts.Font;
	
	/**
	 * ...
	 * @author gka
	 */
	public class LabelCSS extends Label
	{
		
		public function LabelCSS(txt:String, css:String, font:Font) 
		{
			var s:StyleSheet = new StyleSheet();
			s.parseCSS(css);
			condenseWhite = true;
			styleSheet = s;
			selectable = true;
			super(txt, font, 'justify');
			
		}
		

		
	}
	
}