package  {
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class BoundingBox {
		
		public var 		left		:uint;
		public var 		right		:uint;
		public var 		top			:uint;
		public var 		bottom		:uint;
		
		private var 	_area:Number;
		private var 	_areaCM:Number;
		
		public function BoundingBox(l:uint,r:uint,t:uint,b:uint) {
			left 	= l;
			right 	= r;
			top 	= t;
			bottom 	= b;
		}
		
		public function get area():Number {
			if (!_area) {
				_area = (right - left) * (bottom - top);
			}
			return _area;
		}
		
		public function get areaCM():Number {
			if (!_areaCM) {
				_areaCM = area * 2.54 / Capabilities.screenDPI;
			}
			return _areaCM;
		}
	}

}