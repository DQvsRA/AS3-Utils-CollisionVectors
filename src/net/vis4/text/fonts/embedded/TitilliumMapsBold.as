package net.vis4.text.fonts.embedded 
{
	import net.vis4.text.fonts.VectorFont;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TitilliumMapsBold extends VectorFont
	{
		[Embed(
			source = "TitilliumMaps26L001.otf", 
			fontName = "TitilliumMapsBold", 
			unicodeRange = "U+0020-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183",
			mimeType = "application/x-font-truetype"
		)]
		private var _font:Class;
		
		public function TitilliumMapsBold(color:uint = 0, size:Number = 12, alpha:Number = 1) 
		{
			super('TitilliumMapsBold', color, size, alpha, false, false, false);
		}
		
	}
	
}