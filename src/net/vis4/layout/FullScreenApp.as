package net.vis4.layout 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.Dictionary;
	import net.vis4.managers.FocusManager;
	
	/**
	 * ...
	 * @author gka
	 */
	public class FullScreenApp extends Sprite
	{
		private var _resizables:Array = [];
		private var _cresizables:Array = [];
		private var __cmfullscreen:ContextMenuItem;
		
		public override function addChild(o:DisplayObject):DisplayObject
		{
			if (o is IResizable) {
				_resizables.push(o as IResizable);
				if (stage) (o as IResizable).resize(stage.stageWidth, stage.stageHeight);
				return super.addChild(o);
			} else {
				return super.addChild(o);
			}
		}
		
		public function FullScreenApp():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, onResize);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			__cmfullscreen = new ContextMenuItem('Vollbild');
			__cmfullscreen.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, fullscreen);
			var cmvis4:ContextMenuItem = new ContextMenuItem('vis4.net', true);
			cmvis4.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, home);
			cm.customItems.push(__cmfullscreen);
			cm.customItems.push(cmvis4);
			this.contextMenu = cm;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function home(e:ContextMenuEvent):void 
		{
			navigateToURL(new URLRequest('http://vis4.net'), '_blank');
		}
		
		private function fullscreen(e:ContextMenuEvent):void 
		{
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				__cmfullscreen.caption = 'Vollbild';
				stage.displayState = StageDisplayState.NORMAL;
			} else {
				__cmfullscreen.caption = 'Vollbild beenden';
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
		}
		
		private function onClick(e:Event):void 
		{
			if (ExternalInterface.available) {
				if (!FocusManager.instance.needKeyboardInput) ExternalInterface.call('blurFlash');
			}
		}
		
		private function onResize(e:Event = null):void 
		{
			for each (var r:IResizable in _resizables) {
				r.resize(stage.stageWidth, stage.stageHeight);
			}
			for each (var c:DisplayObject in _cresizables) {
				c.width = stage.stageWidth; 
				c.height = stage.stageHeight;
			}
			
			for each (c in _topAlign) c.y = _verticalPadding[c];
			for each (c in _middleAlign) c.y = (stage.stageHeight - c.height) / 2 + _verticalPadding[c];
			for each (c in _bottomAlign) c.y = stage.stageHeight - c.height - _verticalPadding[c];
			for each (c in _leftAlign) c.x = _horizontalPadding[c];
			for each (c in _rightAlign) c.x = stage.stageWidth - c.width - _horizontalPadding[c];
			for each (c in _centerAlign) c.x = (stage.stageWidth - c.width) / 2 + _horizontalPadding[c];
		}
		
		protected function addCustomResizable(o:DisplayObject):void
		{
			_cresizables.push(o);
		}
		
		private var _topAlign:Array;
		private var _middleAlign:Array;
		private var _bottomAlign:Array;
		private var _leftAlign:Array;
		private var _centerAlign:Array;
		private var _rightAlign:Array;
		private var _horizontalPadding:Dictionary;
		private var _verticalPadding:Dictionary;
		private var _borderFlag:Boolean = false;
		/*
		 * vertical = top|bottom
		 * horizontal = left|center|right
		 */
		protected function addChildOnBorder(o:DisplayObject, vertical:String, horizontal:String, verticalPadding:Number = 0, horizontalPadding:Number = 0):DisplayObject
		{
			if (!_borderFlag) {
				_borderFlag = true;
				_topAlign = [];
				_middleAlign = [];
				_bottomAlign = [];
				_leftAlign = [];
				_centerAlign = [];
				_rightAlign = [];
				_horizontalPadding = new Dictionary();
				_verticalPadding = new Dictionary();
			}
			addChild(o);
			if (o is IResizable) o.addEventListener(Event.RESIZE, onResize);
			if (vertical == 'top') _topAlign.push(o);
			if (vertical == 'middle') _middleAlign.push(o);
			if (vertical == 'bottom') _bottomAlign.push(o);
			if (horizontal == 'left') _leftAlign.push(o);
			if (horizontal == 'center') _centerAlign.push(o);
			if (horizontal == 'right') _rightAlign.push(o);
			_horizontalPadding[o] = horizontalPadding;
			_verticalPadding[o] = verticalPadding;
			onResize();
			return o;
		}
		
	}
	
}