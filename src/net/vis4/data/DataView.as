package net.vis4.data 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.vis4.geom.IPolygon;
	import net.vis4.geom.PointSet;
	import net.vis4.geom.Polygon;
	
	/**
	 * ...
	 * @author gka
	 */
	public class DataView 
	{
		private var _xOffset:Number;
		private var _yOffset:Number;
		private var _scale:Number;
		private var _halign:String;
		private var _screen:Rectangle;
		
		public function DataView(dataBounds:Rectangle, screenBounds:Rectangle, hAlign:String = 'center') 
		{
			var dataRatio:Number = dataBounds.width / dataBounds.height;
			var screenRatio:Number = screenBounds.width / screenBounds.height;
			_screen = screenBounds;
			
			_halign = hAlign;
			var scale:Number;
			if (dataRatio > screenRatio) {
				_scale = screenBounds.width / dataBounds.width;			
				_xOffset = -dataBounds.left  + screenBounds.left * _scale;				
				_yOffset = (screenBounds.height / _scale - dataBounds.height) / 2  - dataBounds.top  + screenBounds.top * _scale;	;
			} else {
				_scale = screenBounds.height / dataBounds.height;
				_yOffset = -dataBounds.top + screenBounds.top * _scale;	
				_xOffset = -dataBounds.left  + screenBounds.left * _scale;
				if (_halign == 'center') _xOffset += (screenBounds.width / _scale - dataBounds.width) / 2;
				else if (_halign == 'right') _xOffset += (screenBounds.width / _scale - dataBounds.width);
			}		
		}
		
		public function get xOffset():Number { return _xOffset; }
		
		public function get yOffset():Number { return _yOffset; }
		
		public function get scale():Number { return _scale; }
		
		public function get screen():Rectangle { return _screen; }
		/*
		 * reverse screen bounds
		 */
		public function get rscreen():Rectangle { return rr(_screen); }
		
		public function cp(point:Point):Point
		{
			return new Point(cx(point.x), cy(point.y));
		}
		
		public function rp(point:Point):Point
		{
			return new Point(rx(point.x), ry(point.y));
		}		
		
		public function cx(x:Number):Number
		{
			return (xOffset + x) * scale;
		}
		
		public function cy(y:Number):Number
		{
			return (yOffset + y) * scale;
		}
	
		public function rx(x:Number):Number
		{
			return (x / scale) - xOffset;
		}
		
		public function ry(y:Number):Number
		{
			return (y / scale) - yOffset;
		}
		
		public function equals(dv:DataView):Boolean
		{
			return dv.scale == scale && dv.xOffset == xOffset && dv.yOffset == yOffset;
		}
		
		public function cr(r:Rectangle):Rectangle
		{
			return new Rectangle(cx(r.left), cy(r.top), r.width * scale, r.height * scale); 
		}
		
		public function rr(r:Rectangle):Rectangle
		{
			return new Rectangle(rx(r.left), ry(r.top), r.width / scale, r.height / scale);
		}
		
		/*
		 * use this function to check weather an object is visible in the current
		 * view or not
		 */
		public function intersectsRect(box:Rectangle):Boolean
		{
			return _screen.intersects(cr(box));
		}
		
		public function cpoly(polygon:IPolygon):Polygon {
			var ps:PointSet = new PointSet();
			for each (var p:Point in polygon.points) {
				ps.push(cp(p));
			}
			return new Polygon(ps);
		}
		
		/*
		 * use this function to check weather an object is visible in the current
		 * view or not
		 */
		public function containsPoint(p:Point):Boolean
		{
			return _screen.containsPoint(cp(p));
		}		
	}
	
}