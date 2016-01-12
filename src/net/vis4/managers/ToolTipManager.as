package net.vis4.managers 
{
	import com.greensock.easing.Quart;
	import com.greensock.TweenNano;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;

	
	/**
	 * ...
	 * @author gka
	 */
	public class ToolTipManager extends Sprite
	{
		private var _fmt:TextFormat,
			_tf:TextField,
			_addedToStage:Boolean = false,
			_showTimer:Timer,
			_hideTimer:Timer;
			
		private static var _instance:ToolTipManager;
		public var padding:Number = 2;
		
		public function ToolTipManager() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			_showTimer = new Timer(600, 1);
			_showTimer.addEventListener(TimerEvent.TIMER, show);
			_hideTimer = new Timer(6000, 1);
			_hideTimer.addEventListener(TimerEvent.TIMER, hide);
			
		}
		
		private function init(e:Event = null):void
		{
			_addedToStage = true;
		}
		
		public static function getInstance():ToolTipManager
		{
			if (!(_instance is ToolTipManager)) _instance = new ToolTipManager();
			return _instance;
		}
		
		public function initiate(textFormat:TextFormat, embedFonts:Boolean = false, background:uint = 0xffffe1, border:uint = 0x000000):void
		{
			_fmt = textFormat;
			_tf = new TextField();
			_tf.setTextFormat(_fmt);
			_tf.background = true;
			_tf.backgroundColor = background;
			_tf.border = true;
			_tf.selectable = false;
			_tf.borderColor = border;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			if (embedFonts) {
				_tf.embedFonts = true;
				_tf.antiAliasType = AntiAliasType.ADVANCED;
				_tf.sharpness = 50;
			}
			_tf.visible = false;
			addChild(_tf);
		}
		
		public function showToolTip(text:String, x:Number, y:Number):void {
			if (_addedToStage) {

				_tf.text = text;
				_tf.setTextFormat(_fmt);
				
				y = y - _tf.height;
				
				if (x + _tf.width > stage.stageWidth) x = stage.stageWidth - _tf.width - padding;
				if (x < 0) x = padding;
				if (y + _tf.height > stage.stageHeight) y = stage.stageHeight - _tf.height - padding;
				if (y < 0) y = padding;			
				_tf.x = x;
				_tf.y = y;
				_showTimer.reset();
				_showTimer.start();
			} else {
				trace('ToolTipManager: No tooltips w/o adding me to stage');
			}
		}
		
		private function show(e:Event = null):void
		{
			if (_tf.visible) {
				_tf.alpha = 1;
				return; 
			}
			_tf.visible = true;
			_tf.alpha = 0;
			TweenNano.to(_tf, 0.3, { alpha: 1 } );
			_hideTimer.start();
		}
		
		public function hideToolTip():void
		{
			_showTimer.stop();
			_hideTimer.stop();
			hide();
			
		}
		
		private function hide(e:Event = null):void
		{
			TweenNano.to(_tf, 1, { alpha: 0, onComplete:function():void { _tf.visible = false; } , ease:Quart.easeOut } );
			
		}
				
	}
	
}