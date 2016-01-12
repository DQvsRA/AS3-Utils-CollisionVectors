package net.vis4.managers 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import net.vis4.data.ContentPreloader;
	
	/**
	 * ...
	 * @author gka
	 */
	public class DownloadMananger extends EventDispatcher
	{
		private static var _instance:DownloadMananger;
		
		private var _resources:Dictionary;
		private var _callbacks:Dictionary;
		
		
		public function DownloadMananger() 
		{
			_resources = new Dictionary();
			_callbacks = new Dictionary();
		}
		
		public static function getInstance():DownloadMananger
		{
			if (_instance is DownloadMananger) return _instance;
			_instance = new DownloadMananger();
			return _instance;
		}
		
		public static function get instance():DownloadMananger
		{
			return getInstance();
		}
		

		public function load(urls:Array, callBack:Function = null):void
		{
			var cp:ContentPreloader = new ContentPreloader(urls);
			_callbacks[cp] = callBack;
			cp.addEventListener(Event.COMPLETE, _onLoadComplete);
		}
		
		private function _loadResource(url:String):void
		{
			
		}
		
		private function _onLoadComplete(event:Event):void
		{
			var cp:ContentPreloader = event.target as ContentPreloader;
			
		}
	}
	
}