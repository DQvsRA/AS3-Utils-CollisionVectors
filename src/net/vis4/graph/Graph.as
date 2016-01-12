package net.vis4.graph 
{
	
	/**
	 * ...
	 * @author gka
	 */
	public class Graph 
	{
		protected var _nodes:Array;
		protected var _edges:Array;
		
		public function Graph() 
		{
			_nodes = [];
			_edges = [];
		}
		
		public function addNode(label:String):Node
		{
			return getNode(label);
		}
		
		public function getNode(label:String):Node
		{
			for each (var node:Node in nodes) {
				if (node.label == label) return node;
			}
			node = new Node(label);
			_nodes.push(node);
			trace('added node ' + label);
			return node;
		}
		
		public function addEdge(label1:String, label2:String, directed:Boolean = true):Edge
		{
			var edge:Edge = new Edge(getNode(label1), getNode(label2), directed);
			edge.fromNode.weight++;
			edge.toNode.weight++;
			_edges.push(edge);
			return edge;
		}
		
		public function get nodes():Array { return _nodes; }
		
		public function get edges():Array { return _edges; }
		
	}
	
}