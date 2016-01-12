package net.vis4.geom 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public interface IPolygon 
	{
		function get points():PointSet;
		function get area():Number;
		function get centroid():Point;
		function get boundingBox():Rectangle;
		function get convexHull():IPolygon;
		function simplify(radius:Number):IPolygon;
		function containsPoint(point:Point):Boolean;
		function containsCircle(circle:Circle):Boolean;
		function get sortedClockwise():Boolean;		
		function intersectLine(line:Line):Array;
		
//		TODO:		
//		function join(polygon:IPolygon):IPolygon;
//		function intersect(polygon:IPolygon):IPolygon;
//		function get boundingCircle():Circle;
	}
}