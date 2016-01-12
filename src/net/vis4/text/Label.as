package net.vis4.text 
{
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import net.vis4.text.fonts.Font;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Label extends UsableTextField
	{
		protected var _font:Font;
		protected var _letterSpacing:Number;
		protected var _htmlMode:Boolean;
		
		public function Label(txt:*, font:Font, halign:String = 'left') 
		{
			_font = font;
			
			super();
			if (styleSheet is StyleSheet) {
				_htmlMode = true;
				// ignoring font
			} else {
				_htmlMode = false;
				var format:TextFormat = new TextFormat(font.name, font.size, font.color, font.bold, font.italic, font.underline,
											null, null, halign);
				format.kerning = font.kerning;
				format.letterSpacing = font.letterSpacing;
				format.leading = font.leading;
				defaultTextFormat = format;
			}
			alpha = font.alpha;
			embedFonts = font.embedded;
			
			autoSize = TextFieldAutoSize.LEFT;
			if (font.embedded) {
				antiAliasType = font.antiAliasType;
				sharpness = font.sharpness;
				thickness = font.thickness;
				
			}
			selectable = true;
			if (_htmlMode) {
				var html:String =  String(txt);
				html = html.replace(/<b>/g, '<span class="bold">');
				html = html.replace(/<\/b>/g, '</span>');
				htmlText = String(html);
				condenseWhite = true;
			} else {
				text = String(txt);
			}
			
			if (font.size > 127) {
				scaleX = scaleY = font.size / 127;
			}
		}
		
		
	
		
		public function set color(col:uint):void
		{
			var fmt:TextFormat = defaultTextFormat;
			fmt.color = col;
			setTextFormat(fmt);
		}
		
		public function get font():Font { return _font; }
		
		override public function set width(value:Number):void 
		{
			super.width = value;
			wordWrap = true;
			autoSize = TextFieldAutoSize.LEFT;
			var h:Number = height;
			autoSize = TextFieldAutoSize.NONE;
			height = h + 2;
			//background = true;
			//backgroundColor = 0xFFF3D9;
		}
				
	}
	
}