package net.vis4.renderer.polygon 
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import net.vis4.data.DataView;
	import net.vis4.geom.IPolygon;
	import net.vis4.geom.Line;
	import net.vis4.renderer.line.ILineRenderer;
	import net.vis4.renderer.line.SolidLineRenderer;
	
	/**
	 * ...
	 * @author gka
	 */
	public class LinedPolygonRenderer implements IPolygonRenderer
	{
		private var _lineRenderer:ILineRenderer;
		private var _cache:Dictionary;
		private var _lineGap:Number;
		private var _lastView:DataView;
		
		public function LinedPolygonRenderer(lineRenderer:ILineRenderer, lineGap:uint = 3)
		{
			_lineRenderer = lineRenderer;
			_lineGap = lineGap;
			_cache = new Dictionary(true);
		}
		
		private function clearCache():void {
			_cache = new Dictionary(true);
		}
		
		public function render(polygon:IPolygon, canvas:Graphics, view:DataView):void
		{
			if (_lastView is DataView && view.equals(_lastView) && _cache[polygon] is Array && _cache[polygon].length > 0) {
				// redraw from cache
				//trace('using cache:', _cache[polygon]);
				for each (line in _cache[polygon]) {
					_lineRenderer.render(line, canvas, view);
				}
				_lineRenderer.render(line, canvas, view);
			} else {
				_cache[polygon] = [];
				for (var i:uint = view.cy(polygon.boundingBox.top); i <= view.cy(polygon.boundingBox.height*2+polygon.boundingBox.top ); i+=_lineRenderer.thickness+_lineGap) {				
					var dataY:Number = (i / view.scale) - view.yOffset;
					// compute intersections b/w line and polygon
					var line:Line = new Line(new Point(polygon.boundingBox.left, dataY), new Point(polygon.boundingBox.width, 20));
					var pts:Array = polygon.intersectLine(line);	
					
					if (pts.length > 0) {
						pts.unshift(line.O);
						
						var first:uint = polygon.containsPoint(pts[0]) ? 0 : 1;
						
						for (var j:uint = first; j < pts.length; j+=2) {
							line = new Line(pts[j], (pts[j + 1] as Point).subtract(pts[j]));
							if (line is Line) _cache[polygon].push(line);
							_lineRenderer.render(line, canvas, view);
						}
					}
				}	
				_lastView = view;
			}
			
			//var //debugRenderer:ILineRenderer = new SolidLineRenderer(0, 0, .4);

			
		}
		
		/* INTERFACE net.vis4.renderer.polygon.IPolygonRenderer */
		
		public function get color():int
		{
			return _lineRenderer.color;
		}
		
		public function set color(value:int):void
		{
			_lineRenderer.color = value;
		}
		
	}
	
}