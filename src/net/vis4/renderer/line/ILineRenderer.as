package net.vis4.renderer.line 
{
	import flash.display.Graphics;
	import net.vis4.data.DataView;
	import net.vis4.geom.Line;
	
	/**
	 * ...
	 * @author gka
	 */
	public interface ILineRenderer 
	{
		function render(line:Line, canvas:Graphics, view:DataView):void;
		function get thickness():Number;
		function get color():uint;
		function set color(c:uint):void;
		
	}
	
}