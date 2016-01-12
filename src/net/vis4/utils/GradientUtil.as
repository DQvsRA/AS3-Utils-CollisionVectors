package net.vis4.utils 
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author gka
	 */
	public class GradientUtil 
	{

		public static function drawSimpleGradientRect(canvas:Graphics, fromColor:uint, fromAlpha:Number, toColor:uint, toAlpha:Number, fillRect:Rectangle, angle:Number):void
		{
			var matr:Matrix = new Matrix();
			
			matr.createGradientBox(fillRect.width, fillRect.height, angle/180*Math.PI, fillRect.left, fillRect.top);
			canvas.beginGradientFill(
				GradientType.LINEAR, 
				[fromColor, toColor],
				[fromAlpha, toAlpha],
				[0, 255],
				matr
			);
			canvas.drawRect(fillRect.x, fillRect.y, fillRect.width, fillRect.height);
			canvas.endFill();
		}
		
	}
	
}