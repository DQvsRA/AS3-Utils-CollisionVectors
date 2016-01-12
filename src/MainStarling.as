package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	[SWF(width="800",height="800",frameRate="60",backgroundColor="#1f1f1f")]
	public class MainStarling extends Sprite {
		private var _starling:Starling;
		
		public static var SW:Number = 0, SH:Number = 0;
		
		public function MainStarling():void { 
			
			if (stage) init(); else addEventListener(Event.ADDED_TO_STAGE, init); 
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			MainStarling.SW = stage.stageWidth;
			MainStarling.SH = stage.stageHeight;
			
			_starling=new Starling(Game, stage);
            _starling.showStats=true;
            _starling.start();
		}
	}

}