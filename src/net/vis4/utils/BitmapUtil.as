package net.vis4.utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author gka
	 */
	public class BitmapUtil 
	{

		public static function patternFill(target:Bitmap, pattern:BitmapData, alpha:Boolean = false):void
		{
			var rr:Rectangle = new Rectangle(0, 0, pattern.width, pattern.height);
			var tx:uint = Math.ceil(target.bitmapData.width / pattern.width);
			var ty:uint = Math.ceil(target.bitmapData.height / pattern.height);
			
			for (var i:uint = 0; i < tx; i++) {
				for (var j:uint = 0; j < ty; j++) {		
					target.bitmapData.copyPixels(pattern, rr, new Point(i * pattern.width, j * pattern.height));
				}
			}			
		}
		
		public static function patternFillAlpha(target:Bitmap, pattern:BitmapData):void
		{
			var rr:Rectangle = new Rectangle(0, 0, pattern.width, pattern.height);
			var tx:uint = Math.ceil(target.bitmapData.width / pattern.width);
			var ty:uint = Math.ceil(target.bitmapData.height / pattern.height);
			
			for (var i:uint = 0; i < tx; i++) {
				for (var j:uint = 0; j < ty; j++) {					
					target.bitmapData.copyChannel(pattern, rr, new Point(i * pattern.width, j * pattern.height), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);					
				}
			}			
		}
		
		public static function patternFillAlpha2(target:Bitmap, pattern:BitmapData):void
		{
			var rr:Rectangle = new Rectangle(0, 0, pattern.width, pattern.height);
			var tx:uint = Math.ceil(target.bitmapData.width / pattern.width);
			var ty:uint = Math.ceil(target.bitmapData.height / pattern.height);
			
			for (var i:uint = 0; i < tx; i++) {
				for (var j:uint = 0; j < ty; j++) {					
					target.bitmapData.copyChannel(pattern, rr, new Point(i * pattern.width, j * pattern.height), BitmapDataChannel.BLUE, BitmapDataChannel.ALPHA);					
				}
			}			
		}		
	}
	
}