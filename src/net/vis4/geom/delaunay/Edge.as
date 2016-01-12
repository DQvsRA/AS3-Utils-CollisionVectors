package  net.vis4.geom.delaunay 
{
	import flash.geom.Point;
	import flash.ui.ContextMenuItem;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Edge 
	{
		public var p1:int; // references to point array
		public var p2:int;
		public var tris:Array;
		public var numtris:uint = 0;
		public var interPoints:Array;
		public var t1:Triangle;
		public var t2:Triangle;
		
		public function Edge(p1:int = -1, p2:int = -1) 
		{
			this.p1 = p1;
			this.p2 = p2;
		}
		
	}
	
}