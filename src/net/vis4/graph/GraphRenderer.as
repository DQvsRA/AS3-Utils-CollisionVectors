package net.vis4.graph 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author gka
	 */
	public class GraphRenderer 
	{
		protected var _graph:Graph;
		protected var _canvas:Sprite;
		protected var _initalized:Boolean;
		protected var _nodeSprites:Dictionary;
		
		public function GraphRenderer(graph:Graph, canvas:Sprite) 
		{
			_initalized = false;
			_graph = graph;
			_canvas = canvas;
			_nodeSprites = new Dictionary();
		}
		
		public function render(evt:Event = null):void
		{
			_canvas.graphics.clear();
			// draw nodes
			for each (var node:Node in _graph.nodes) {
				if (_nodeSprites[node] is TextNodeSprite) {
					var ns:TextNodeSprite = _nodeSprites[node] as TextNodeSprite;
				} else {
					ns = new TextNodeSprite(node);
					ns.draw();
					_canvas.addChild(ns);
					_nodeSprites[node] = ns;
				}
				ns.x = node.x;
				ns.y = node.y;
			}
			// draw edges
			_canvas.graphics.lineStyle(0.35, 0, .35);
			for each (var edge:Edge in _graph.edges) {
				_canvas.graphics.moveTo(edge.fromNode.x, edge.fromNode.y);
				_canvas.graphics.lineTo(edge.toNode.x, edge.toNode.y);
			}
		}
		
	}
	
}