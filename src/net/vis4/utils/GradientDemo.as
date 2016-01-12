package net.vis4.utils 
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author gka
	 */
	public class GradientDemo extends Sprite
	{
		
		public function GradientDemo() 
		{
			GradientUtil.drawSimpleGradientRect(graphics, 0xFF0000, 1, 0xFF0000, 0, new Rectangle(150, 150, 500,030), 45);
		}
		
	}
	
}