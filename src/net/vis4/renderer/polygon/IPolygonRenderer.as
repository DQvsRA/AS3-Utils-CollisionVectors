package net.vis4.renderer.polygon 
{
	import flash.display.Graphics;
	import net.vis4.data.DataView;
	import net.vis4.geom.IPolygon;
	
	/**
	 * ...
	 * @author gka
	 */
	public interface IPolygonRenderer 
	{
		function render(polygon:IPolygon, canvas:Graphics, view:DataView):void;
		function get color():int;
		function set color(value:int):void;
	}
	
}