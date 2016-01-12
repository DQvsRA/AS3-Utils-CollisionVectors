package net.vis4.managers 
{
	import flash.filters.BitmapFilter;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author gka
	 */
	public class FilterManager 
	{
		private static var _instance:FilterManager;
		private var _filters:Dictionary;
		
		public function FilterManager() 
		{
			_filters = new Dictionary();
		}
		
		public static function getInstance():FilterManager
		{
			if (_instance is FilterManager) return _instance;
			_instance = new FilterManager();
			return _instance;
		}
		
		public static function getFilter(name:String):BitmapFilter
		{
			return FilterManager.getInstance()._getFilter(name);
		}
		
		public static function hasFilter(name:String):Boolean
		{
			return FilterManager.getInstance()._hasFilter(name);
		}
		
		public static function addFilter(name:String, filter:BitmapFilter):void
		{
			FilterManager.getInstance()._addFilter(name, filter);
		}
		
		public function _addFilter(name:String, filter:BitmapFilter):void
		{
			_filters[name] = filter;
		}
		
		public function _getFilter(name:String):BitmapFilter
		{
			if (_filters[name] is BitmapFilter) return _filters[name] as BitmapFilter;
			trace('unknown filter "' + name + '" :(');
			return null;
		}
		
		public function _hasFilter(name:String):Boolean
		{
			if (_filters[name] is BitmapFilter) return true;			
			return false;
		}		
	}
	
}