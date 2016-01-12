package net.vis4.graph 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import net.vis4.text.fonts.embedded.TitilliumMaps;
	import net.vis4.text.Label;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TextNodeSprite extends Sprite
	{
		protected var _label:Label;
		protected var _size:Number;
		protected var _bgcolor:uint;
		protected var _node:Node;
		protected var _dragging:Boolean = false;
		
		public function TextNodeSprite(node:Node, size:Number = 8, textColor:uint = 0x000000, bgColor:uint = 0xffffff) 
		{
			size += Math.pow(node.weight, 2);
			_label = new Label(node.label, new TitilliumMaps(textColor, size));
			_label.x = -_label.width / 2;
			_label.y = -_label.height / 2;
			_label.selectable = false;
			_bgcolor = bgColor;
			draw();
			addChild(_label);
			mouseEnabled = true;
			_node = node;
			addEventListener(MouseEvent.MOUSE_DOWN, _startDrag);
			addEventListener(MouseEvent.MOUSE_MOVE, _onDrag);
			addEventListener(MouseEvent.MOUSE_UP, _endDrag);
			addEventListener(MouseEvent.MOUSE_OUT, _endDrag);
		}
		
		private var _dragOrigin:Point;
		private var _dragOffset:Point;
		private var _fixed:Boolean;
		
		private function _startDrag(e:MouseEvent):void 
		{
			_dragging = true;
			_dragOrigin = new Point(e.stageX, e.stageY);
			_dragOffset = new Point(e.localX, e.localY);
			_fixed = _node.fixed;
			_node.fixed = true;
		}
		
		private function _onDrag(e:MouseEvent):void 
		{
			if (_dragging) {
				_node.x = e.stageX;
				_node.y = e.stageY;
			}
		}
		
		private function _endDrag(e:MouseEvent):void 
		{
			_dragging = false;
			_node.fixed = !_fixed;
		}
		
		
		
		public function draw():void
		{
		
			
			graphics.clear();
			graphics.beginFill(_bgcolor);
			graphics.drawRect(_label.x - 3, _label.y - 3, _label.width + 6, _label.height + 6);
		}
		
	}
	
}