package net.vis4.data.tsv 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TSVLoader 
	{
		private var _onComplete:Function;
		
		public function TSVLoader(url:String, onComplete:Function) 
		{
			_onComplete = onComplete;
			var ldr:URLLoader = new URLLoader();
			ldr.addEventListener(Event.COMPLETE, loaded);
			ldr.load(new URLRequest(url));
			
		}
		
		private function loaded(e:Event):void 
		{
			_onComplete(TSVParser.parse((e.target as URLLoader).data));
		}
		
	}
	
}