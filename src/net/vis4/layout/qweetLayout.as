package net.vis4.layout 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author gka
	 */
	public class qweetLayout 
	{
		protected var _bounds:Rectangle;
		protected var _children:Array;
		protected var _dx:Dictionary;
		protected var _dy:Dictionary;
		protected var _ox:Dictionary;
		protected var _oy:Dictionary;
		protected var _stage:Stage;
		
		public function qweetLayout(bounds:Rectangle) 
		{
			_bounds = bounds;
			_dx = new Dictionary();
			_ox = new Dictionary();
			_dy = new Dictionary(); 
			_oy = new Dictionary(); 
			_children = [];
		}
		
		public function add(obj:DisplayObject):void 
		{
			_children.push(obj);
			_dx[obj] = 0;
			_ox[obj] = obj.x;
			_dy[obj] = 0;
			_oy[obj] = obj.y;
		}
		
		public function layout(stage:Stage):void
		{
			_stage = stage;
			_stage.addEventListener(Event.ENTER_FRAME, _layout);			
			//while (_relax()) _move();
		}
		
		protected function _layout(e:Event):void
		{
			if (_relax()) _move();
		}
		
		protected function _relax():Boolean
		{
			var moved:Boolean = false;
			for each (var u:DisplayObject in _children) {
				for each (var v:DisplayObject in _children) {
					if (u != v) {
						if (u.hitTestObject(v)) {
							var l:Number = Math.sqrt((v.x - u.x) * (v.x - u.x) - (v.y - u.y) * (v.y - u.y));							
							//if (u.width < u.height) {
							//	_dx[u] += u.x > v.x ? 1 : -1;
							//} else {
							//	_dy[u] += u.y > v.y ? 1 : -1;
							//}
							_dx[u] += (u.x - v.x) / l;
							_dy[u] += (u.y - v.y) / l;
							moved = true;
						}
					}
				}
			}
			return moved;
		}
		
		protected function _move():void
		{
			for each (var u:DisplayObject in _children) {
				u.x = u.x + _dx[u];
				u.y = u.y + _dy[u];
				_dx[u] = 0; 
				_dy[u] = 0;
			}
		}
		
	}
	
}