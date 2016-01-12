package net.vis4.geom.delaunay
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Triangle 
	{
		public var p1:int;
		public var p2:int;
		public var p3:int;
		public var edges:Array;
		public var e1:Edge; // p2 > p3
		public var e2:Edge; // p1 > p3
		public var e3:Edge; // p1 > p2
		
		public function Triangle() 
		{}
		
	}
	
}