package net.vis4.geom
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author gka
	 */
	public dynamic class PointSet extends Array
	{
		private var _minX:Number = Number.POSITIVE_INFINITY;
		private var _minY:Number = Number.POSITIVE_INFINITY;
		private var _maxX:Number = Number.NEGATIVE_INFINITY;
		private var _maxY:Number = Number.NEGATIVE_INFINITY;

		public function PointSet(...arguments)
		{
			var n:uint = arguments.length
		
			if (n == 1 && (arguments[0] is Number)) {
				var dlen:Number = arguments[0];
				var ulen:uint = dlen;
				if (ulen != dlen)
				{
					throw new RangeError("Array index is not a 32-bit unsigned integer ("+dlen+")");
				}
				length = ulen;
			}
			else
			{
				length = n;
				for (var i:int=0; i < n; i++)
				{
					this.push(arguments[i]);
				}
			}
		}

		AS3 override function push(...arguments):uint 
		{
			for each (var i:* in arguments) {
				if (!(i is Point)) {
					throw new Error('PointSet: not allowed to push something except from Points --> '+i);
				}
				
				_minX = Math.min(_minX, (i as Point).x);
				_maxX = Math.max(_maxX, (i as Point).x);
				_minY = Math.min(_minY, (i as Point).y);
				_maxY = Math.max(_maxY, (i as Point).y);			
			}
			return (super.push.apply(this, arguments));
		}
		
		public function get minX():Number { return length > 0 ? _minX : Number.NaN; }
		
		public function get minY():Number { return length > 0 ? _minY : Number.NaN; }
		
		public function get maxX():Number { return length > 0 ? _maxX : Number.NaN; }
		
		public function get maxY():Number { return length > 0 ? _maxY : Number.NaN; }
		
		public function get bounds():Rectangle {
			return new Rectangle(minX, minY, Math.abs(maxX - minX), Math.abs(maxY - minY));
		}
		
		public function toString():String
		{
			return 'PointList [count: ' + length + ']';
		}
		
		public function reverseOrder():void
		{
			var l:uint = this.length;
			var tmp:Array = [];
			for (var i:uint = 0; i < l; i++) {
				tmp.push(this.pop());
			}
			for (i = 0; i < l; i++) {
				this.push(tmp[i]);
			}
		}
		
	}
	
}