package net.vis4.svg 
{
	import adobe.utils.CustomActions;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import net.vis4.color.ColorUtil;
	import net.vis4.geom.IPolygon;
	import net.vis4.geom.Polygon;
	
	/**
	 * ...
	 * @author gka
	 */
	public class SVGCache 
	{
		private static var _instance:SVGCache;
		
		public function SVGCache() 
		{
			
		}
		
		static public function get instance():SVGCache 
		{
			if (_instance is SVGCache) return _instance; 
			_instance = new SVGCache();
			return _instance;
		}
		
		private var _cache:String = '';
		
		public function init(width:Number, height:Number):void
		{
			_cache = '<?xml version="1.0" encoding="UTF-8"?>\n';
			_cache += '<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">\n';
			_cache += '<svg xmlns="http://www.w3.org/2000/svg"\n';
			_cache += '\txmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ev="http://www.w3.org/2001/xml-events"\n';
			_cache += '\tversion="1.1" baseProfile="full"\n';
			_cache += '\twidth="'+width+'" height="'+height+'">\n';
		}
		
		public function addPolygon(polygon:IPolygon, fillColor:uint, fillAlpha:Number, lineColor:uint, lineWidth:Number, lineAlpha:Number):void
		{
			_cache += '<polygon points="';
			for each (var p:Point in polygon.points) {
				_cache += p.x + ' ' + p.y + ' ';
			}
			_cache += '" style="fill:' + ColorUtil.int2hex(fillColor) + ';fill-opacity:' + fillAlpha;
			_cache += ';stroke:' + ColorUtil.int2hex(lineColor) + ';stroke-opacity:' + lineAlpha;
			_cache += ';stroke-width: '+lineWidth+';" />\n';
		}
		
		public function openGroup(id:String = ''):void
		{
			_cache += '<g' + (id != '' ? ' id="' + id + '"' : '') + '>\n';
		}

		public function closeGroup():void
		{
			_cache += '</g>\n';
		}
		
		public function addText(x:Number, y:Number, text:String, fontFamily:String,fontSize:Number,color:uint,alpha:Number, bold:Boolean, centered:Boolean = false):void
		{
			_cache += '<text x="'+x+'" y="'+y+'" style="font-size:' + fontSize + 'px;fill:' + ColorUtil.int2hex(color) + ';fill-opacity:' + alpha + ';';
			_cache += 'stroke:none; font-family:'+fontFamily+';'+(bold ? 'font-weight:bold;': '')+(centered ? 'text-anchor:middle; text-align:center;': '')+'">'+text+'</text>';
		}
		
		public function addLine(x1:Number, y1:Number, x2:Number, y2:Number, color:uint, alpha:Number, width:Number):void
		{
			_cache += '<line x1="'+x1+'" y1="'+y1+'" x2="'+x2+'" y2="'+y2+'" style="stroke:'+ColorUtil.int2hex(color)+'; stroke-width:'+width+'; opacity:'+alpha+'" />\n';
		}
		
		private var _stored:Boolean = false;
		
		public function store(url:String):void
		{
			if (!_stored) {
				_cache += '</svg>';
				var req:URLRequest = new URLRequest(url);
				var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
				req.requestHeaders.push(header);
				req.method = URLRequestMethod.POST;
				req.data = _cache;
				new URLLoader(req);
				_stored = true;
			}
		}
		
	}
	
}