package net.vis4.renderer.polygon 
{
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.vis4.data.DataView;
	import net.vis4.geom.IPolygon;
	import net.vis4.geom.Polygon;
	import net.vis4.svg.SVGCache;
	
	/**
	 * ...
	 * @author gka
	 */
	public class SolidPolygonRenderer implements IPolygonRenderer
	{
		private var _lineColor:int;
		private var _color:int;
		private var _alpha:Number;
		private var _lineAlpha:Number;
		private var _lineWidth:Number;
		private var _autoSimplify:Boolean = false;
		private var _svgExport:Boolean = true;
		
		public function SolidPolygonRenderer(fillColor:int = 0, fillAlpha:Number = 1, lineColor:int = -1, lineAlpha:Number = 1, lineWidth:Number = 1)
		{
			_color = fillColor;
			_alpha = fillAlpha;
			_lineAlpha = lineAlpha;
			_lineColor = lineColor;
			_lineWidth = lineWidth;
		}
		
		public function render(polygon:IPolygon, canvas:Graphics, view:DataView):void
		{
			
			if (_color > -1) canvas.beginFill(_color, _alpha);
			if (_lineColor > -1) canvas.lineStyle(_lineWidth, _lineColor, _lineAlpha, false, LineScaleMode.NONE);
			else canvas.lineStyle();
			
			polygon = _autoSimplify ? view.cpoly(polygon).simplify(0.55) : view.cpoly(polygon);
			if (polygon.points.length < 3) return;
			
			var p1:Point, first:Boolean = true, p2:Point;
			
			for (var i:uint = 0; i < polygon.points.length; i++) {		
				p1 = polygon.points[i] as Point;
				p2 = polygon.points[(i + 1) % polygon.points.length] as Point;
				
				if (first) {
					canvas.moveTo(p1.x, p1.y);
					first = false;
				}
				//canvas.drawCircle(p2.x, p2.y, 1);
				canvas.lineTo(p2.x, p2.y);
				
			}
			canvas.endFill();
			
			// SVG output
			if (_svgExport) SVGCache.instance.addPolygon(polygon, _color, _alpha, _lineColor, _lineWidth, _lineAlpha);
		}
		
		public function get color():int { return _color; }
		
		public function set color(value:int):void 
		{
			_color = value;
		}
		
		public function get alpha():Number { return _alpha; }
		
		public function set alpha(value:Number):void 
		{
			_alpha = value;
		}
		
		public function get lineColor():int { return _lineColor; }
		
		public function set lineColor(value:int):void 
		{
			_lineColor = value;
		}
		
		public function get lineAlpha():Number { return _lineAlpha; }
		
		public function set lineAlpha(value:Number):void 
		{
			_lineAlpha = value;
		}
		
		public function get lineWidth():Number { return _lineWidth; }
		
		public function set lineWidth(value:Number):void 
		{
			_lineWidth = value;
		}
		
		public function get autoSimplify():Boolean { return _autoSimplify; }
		
		public function set autoSimplify(value:Boolean):void 
		{
			_autoSimplify = value;
		}
		
		public function get svgExport():Boolean { return _svgExport; }
		
		public function set svgExport(value:Boolean):void 
		{
			_svgExport = value;
		}
		
	}
	
}