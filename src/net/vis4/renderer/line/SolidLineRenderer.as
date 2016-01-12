package net.vis4.renderer.line 
{
	import flash.display.Graphics;
	import net.vis4.data.DataView;
	import net.vis4.geom.Line;
	
	/**
	 * ...
	 * @author gka
	 */
	public class SolidLineRenderer implements ILineRenderer
	{
		private var _color:uint;
		private var _alpha:Number;
		private var _thickness:Number;
		
		public function SolidLineRenderer(thickness:Number=0, color:uint = 0, alpha:Number = 1) 
		{
			_thickness = thickness;
			_color = color;
			_alpha = alpha;
		}
		
		public function render(line:Line, canvas:Graphics, view:DataView):void
		{
			if (line == null || view == null) return;
			canvas.lineStyle(_thickness, _color, _alpha);
			canvas.moveTo(view.cx(line.O.x), view.cy(line.O.y));
			canvas.lineTo(view.cx(line.O.x + line.R.x), view.cy(line.O.y + line.R.y));
			canvas.lineStyle();
		}
		
		/* INTERFACE net.vis4.renderer.line.ILineRenderer */
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(c:uint):void
		{
			_color = c;
		}
		
		public function get thickness():Number { return _thickness; }
			
	}
	
}