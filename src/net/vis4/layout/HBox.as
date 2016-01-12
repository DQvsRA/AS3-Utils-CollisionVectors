package net.vis4.layout 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author gka
	 */
	public class HBox extends Sprite 
	{
		private var _innerPadding:Number = 5;
		private var _valign:String = 'top';
		private var _childOffset:Number = 0;
		private var _children:Array = [];
		private var _maxH:Number = Number.MIN_VALUE;
		
		public function HBox(innerPadding:Number = 5, verticalAlign:String = 'middle', children:Array = null) 
		{
			_valign = verticalAlign;
			_innerPadding = innerPadding;
			if (children is Array) for (var i:uint = 0; i < children.length; i++) addChild(children[i] as DisplayObject);
			
		}
		
		override public function addChild(o:DisplayObject):DisplayObject
		{
			super.addChild(o);
			_children.push(o);
			o.x = _childOffset;
			_maxH = Math.max(_maxH, o.height);
				
			_childOffset += o.width + _innerPadding;
			
			for each (var child:DisplayObject in _children) {
				if (_valign == 'top') child.y = 0;
				else if (_valign == 'bottom') child.y = _maxH - child.height;
				else {
					child.y = (_maxH - child.height) / 2;
				}
			}
			return o;
		}
		
	}
	
}