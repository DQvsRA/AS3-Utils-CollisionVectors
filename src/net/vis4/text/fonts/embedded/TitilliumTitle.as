package net.vis4.text.fonts.embedded 
{
	import net.vis4.text.fonts.VectorFont;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TitilliumTitle extends VectorFont
	{
		[Embed(
			source = "TitilliumTitle12.otf", 
			fontName = "TitilliumTitle", 
			unicodeRange = "U+0020-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183",
			mimeType = "application/x-font-truetype"
		)]
		private var _font:Class;
		
		public function TitilliumTitle(color:uint = 0, size:Number = 12, alpha:Number = 1) 
		{
			super('TitilliumTitle', color, size, alpha);
		}
		
	}
	
}