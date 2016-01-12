package net.vis4.managers 
{
	import flash.utils.Dictionary;
	
	/**
	 * manages the preloading process of all resources of a page
	 * 
	 * @author gka
	 */
	public class ResourceManager 
	{
		
		/*
		 * singleton implementation
		 */
		private static var _instance:ResourceManager;

		public static function getInstance():ResourceManager
		{
			if (!(_instance is ResourceManager)) _instance = new ResourceManager();
			return _instance;
		}
		
		public static function get instance():ResourceManager
		{
			return getInstance();
		}	
		
		/*
		 * data
		 */
		private var _resources:Dictionary = new Dictionary();
		
		public function ResourceManager() 
		{
			
		}

		
		/*
		 * wie weit ist eine bestimmte seite schon geladen?
		 * 
		 * bsp:
		 *  if (!isPageLoaded('my/page')) {
		 * 		loadPage('my/page');
		 * 		timer.addEventListener(TimerEvent.TICK, function(e:Event):void {
		 * 			if (isPageLoaded('my/page') timer.cancel();
		 * 			else updatePreloader(pageLoadProgress('my/page'));
		 * 		});
		 * 	}
		 * returns [0..1]
		 */
		
		public function isPageLoaded(pageId:String):Boolean {
			return false;
		}
		
		public function pageLoadProgress(pageId:String):Number {
			return 0;
		}
		
		/*
		 * private part
		 */
		private var loadResource(url:String):void {
			
		}
	}
	
}