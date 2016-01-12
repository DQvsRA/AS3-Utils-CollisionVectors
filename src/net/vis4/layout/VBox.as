package net.vis4.layout 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author gka
	 */
	public class VBox extends Sprite implements IBox
	{
		private var _innerPadding:Number;
		private var _outerPadding:Number;
		private var _halign:String = 'left';
		private var _childOffset:Number = 0;
		private var _children:Array = [];
		private var _maxW:Number = 0;
		private var _forceHeights:Number = 0;
		
		public function VBox(innerPadding:Number = 5, horizontalAlign:String = 'left', children:Array = null, outerPadding:Number = 0, forceHeights:Number = 0) 
		{
			_halign = horizontalAlign;
			_innerPadding = innerPadding;
			_outerPadding = outerPadding;
			_forceHeights = forceHeights;
			if (children is Array) for (var i:uint = 0; i < children.length; i++) addChild(children[i] as DisplayObject);
		}
		
		override public function addChild(o:DisplayObject):DisplayObject
		{	
			super.addChild(o);
			_children.push(o);
			o.y = _outerPadding + _childOffset;
			_maxW = Math.max(_maxW, o.width);
			_childOffset += (_forceHeights > 0 ? _forceHeights : o.height) + _innerPadding;
			for each (var child:DisplayObject in _children) {
				if (_halign == 'left') child.x = _outerPadding;
				else if (_halign == 'right') child.x = _outerPadding + _maxW - child.width;
				else {
					child.x = _outerPadding + (_maxW - child.width) / 2;
				}
			}
			return o;
		}
		
	}
	
}