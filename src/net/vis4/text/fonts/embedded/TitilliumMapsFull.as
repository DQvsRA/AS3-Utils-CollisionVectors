package net.vis4.text.fonts.embedded 
{
	import net.vis4.text.fonts.VectorFont;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TitilliumMapsFull extends VectorFont
	{
		[Embed(
			source = "TitilliumMaps26L002.otf", 
			fontName = "TitilliumMaps", 
			unicodeRange = "U+0020-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183",
			mimeType = "application/x-font-truetype"
		)]
		private var _f1:Class;
		[Embed(
			source = "TitilliumMaps26L001.otf", 
			fontName = "TitilliumMapsBold", 
			unicodeRange = "U+0020-U+00FF,U+2000-U+206F,U+20A0-U+20CF,U+2100-U+2183",
			mimeType = "application/x-font-truetype"
		)]
		private var _f3:Class;
		
		public function TitilliumMapsFull(color:uint = 0, size:Number = 12, alpha:Number = 1) 
		{
			super('TitilliumMaps', color, size, alpha, false, false, false);
		}
		
	}
	
}