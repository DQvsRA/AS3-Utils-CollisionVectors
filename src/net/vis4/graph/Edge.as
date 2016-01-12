package net.vis4.graph 
{
	
	/**
	 * ...
	 * @author gka
	 */
	public class Edge 
	{
		protected var _fromNode:Node;
		protected var _toNode:Node;
		protected var _directed:Boolean;
		
		public function Edge(fromNode:Node, toNode:Node, directed:Boolean = true) 
		{
			_fromNode = fromNode;
			_toNode = toNode;
			_directed = directed;
		}
		
		public function get fromNode():Node { return _fromNode; }
		
		public function get toNode():Node { return _toNode; }
		
		public function get directed():Boolean { return _directed; }
		
	}
	
}