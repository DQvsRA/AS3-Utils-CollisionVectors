package net.vis4.graph 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.vis4.utils.NumberUtil;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Node 
	{
		protected var _label:String;
		protected var _pos:Point;
		protected var _dpos:Point;
		protected var _weight:Number = 0;
		protected var _fixed:Boolean = false;
		
		public function Node(label:String) 
		{
			_label = label;
			_pos = new Point(Math.random()*800, Math.random()*600);
			_dpos = new Point(0,0);
		}
		
		public function get label():String { return _label; }
		
		public function get x():Number { return _pos.x; }
		
		public function set x(value:Number):void 
		{
			_pos.x = value;
		}
		
		public function get y():Number { return _pos.y; }
		
		public function set y(value:Number):void 
		{
			_pos.y = value;
		}
		
		public function get pos():Point { return _pos; }
		
		public function set pos(value:Point):void 
		{
			_pos = value;
		}
		
		public function get dpos():Point { return _dpos; }
		
		public function set dpos(value:Point):void 
		{
			_dpos = value;
		}
		
		public function get fixed():Boolean { return _fixed; }
		
		public function set fixed(value:Boolean):void 
		{
			_fixed = value;
		}
		
		public function get weight():Number { return _weight; }
		
		public function set weight(value:Number):void 
		{
			_weight = value;
		}
		
		public function update(bounds:Rectangle):void
		{
		
			if (!_fixed) {
				_pos.x += NumberUtil.constrain(_dpos.x, -25, 25);
				_pos.y += NumberUtil.constrain(_dpos.y, -25, 25);
				_pos.x = NumberUtil.constrain(_pos.x, bounds.left, bounds.right);
				_pos.y = NumberUtil.constrain(_pos.y, bounds.top, bounds.bottom);
				
			}
			_dpos.x /= 2;
			_dpos.y /= 2;
		}
	}
	
}