package net.vis4.graph 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author gka
	 */
	public class ForceDirectedLayout 
	{
		protected var _graph:Graph;
		protected var _edgeLenMin:Number;
		protected var _edgeLenMax:Number;
		
		public function ForceDirectedLayout(graph:Graph, edgeLengthMin:Number, edgeLengthMax:Number) 
		{
			_graph = graph;
			_edgeLenMin = edgeLengthMin;
			_edgeLenMax = edgeLengthMax;
		}
		
		public function layout(bounds:Rectangle):void
		{
			relaxEdges();
			relaxNodes();
			for each (var n:Node in _graph.nodes) {
				n.update(bounds);
			}
		}
		
		private function relaxNodes():void
		{
			for each (var n1:Node in _graph.nodes) {
				var dd:Point = new Point(0, 0);
				for each (var n2:Node in _graph.nodes) {
					if (n1 != n2) {
						var vx:Number = n1.x - n2.x;
						var vy:Number = n1.y - n2.y;
						var lensq:Number = vx * vx + vy * vy;
						if (lensq == 0) {
							dd.x += Math.random();
							dd.y += Math.random();
						} else if (lensq < 180 * 180) {
							dd.x += vx / lensq;
							dd.y += vy / lensq;
						}
					}
				}
				var dlen:Number = dd.length / 2;
				if (dlen > 0) {
					n1.dpos.x += dd.x / dlen;
					n1.dpos.y += dd.y / dlen;
				}
			}
		}
		
		protected function relaxEdges():void
		{
			for each (var edge:Edge in _graph.edges) {
				var d:Number = Point.distance(edge.fromNode.pos, edge.toNode.pos);
				
				if (d > 0) {
					if (d < _edgeLenMin) {
						var f:Number = (_edgeLenMin - d) / (d * 3);
					} else if (d > _edgeLenMax) {
						f = (_edgeLenMax - d) / (d * 3);
					} else f = 0;
					
					
					var dv:Point = new Point(f * (edge.toNode.x - edge.fromNode.x),  f * (edge.toNode.y - edge.fromNode.y));
					edge.toNode.dpos = edge.toNode.dpos.add(dv);
					edge.fromNode.dpos = edge.fromNode.dpos.subtract(dv);
				}
				
			}
			
		}
	}
	
}