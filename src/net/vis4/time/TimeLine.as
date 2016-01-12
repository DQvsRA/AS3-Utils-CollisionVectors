package net.vis4.time 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import net.vis4.layout.IResizable;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TimeLine extends Sprite implements IResizable
	{
		protected var _begin:Number;
		protected var _end:Number;
		protected var _selStart:Number;
		protected var _selEnd:Number;
		protected var _bounds:Rectangle;
		protected var _posHandle:Sprite;
		protected var _position:Number;
		
		public function TimeLine(begin:Number = 0, end:Number = 1, bounds:Rectangle = null) 
		{
			_bounds = bounds;
			_begin = begin;
			_end = end;
			_posHandle = posHandle();
			draw();
			
		}
		
		private function posHandle():Sprite
		{
			var p:Sprite = new Sprite();
			p.graphics.beginFill(0xffffff);
			p.graphics.moveTo( -6, 0);
			p.graphics.lineTo( 6, 0);
			p.graphics.lineTo( 0, 12);
			p.graphics.lineTo( -6, 0);
			addChild(p);
			return p;
		}
		
		public function setSelection(start:Number, end:Number):void 
		{
			_selEnd = end;
			_selStart = start;
			draw();
		}
		
		public function resize(width:Number, height:Number):void
		{
			_bounds.width = width;
			_bounds.height = height;
			//dispatchEvent(new Event(Event.RESIZE));
			draw();
		}
		
		public function get bounds():Rectangle { return _bounds; }
		
		public function set bounds(b:Rectangle):void
		{
			_bounds = b;
			//dispatchEvent(new Event(Event.RESIZE));
			draw();
		}
		
		public function get selectionStart():Number { return _selStart; }
		
		public function get selectionEnd():Number { return _selEnd; }
		
		public function set selectionStart(value:Number):void 
		{
			_selStart = value; draw();
		}
		
		public function set selectionEnd(value:Number):void 
		{
			_selEnd = value; draw();
		}
		
		public function get begin():Number { return _begin; }
		
		public function set begin(value:Number):void 
		{
			_begin = value; draw();
		}
		
		public function get end():Number { return _end; }
		
		public function set end(value:Number):void 
		{
			_end = value; draw();
		}
		
		public function get position():Number { return _position; }
		
		public function set position(value:Number):void 
		{
			_position = value;
			updatePosHandle();
		}
		
		private function updatePosHandle():void
		{
			_posHandle.y = 0;
			_posHandle.x = Math.round((_position - _begin) / (_end - _begin) * _bounds.width);
		}
		
		private function draw(e:Event = null):void
		{
			graphics.clear();
			graphics.lineStyle(1, 0xffffff);
			graphics.moveTo(0, _posHandle.height);
			graphics.lineTo(_bounds.width, _posHandle.height);
		}
		
	
		
	}
	
}