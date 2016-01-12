package net.vis4.layout 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author gka
	 */
	public interface IResizable 
	{
		
		function resize(width:Number, height:Number):void;
		function get bounds():Rectangle;
		function set bounds(b:Rectangle):void;
		
	}
	
}