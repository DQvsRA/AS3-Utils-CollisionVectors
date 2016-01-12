package  {
	import ch.badmojo.color.Color;
	import ch.badmojo.color.ColorWheel;
	import flash.geom.Point;
	import flash.system.System;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import starling.display.Graphics;
	import starling.display.graphics.NGon;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class Game extends Sprite {
		
		private static var RADIUS_TO_GENERATE:uint = 250;
		private static var ANGLE_TO_RADIAN:Number = Math.PI / 180;
		
		private var 
				_vertexCount		:uint = 7
			,	_point				:Point = new Point()
			,	_nextPoint			:Point = new Point()
			,	_vector				:Point = new Point()
			,	_mouse				:Point = new Point()
			,	_center				:Point = new Point()
			,	_positionLocal		:Point = new Point()
			
			,	_shapeArea			:Number = 0
			,	_shapeRadius		:Number = 0
			,	_shapeCenterX		:Number = 0
			,	_shapeCenterY		:Number = 0
			,	_shapeCenter		:Point
		
			,	_prevpoints			:Vector.<Point> 	= new Vector.<Point>(_vertexCount)
			,	_deltapoints		:Vector.<Point> 	= new Vector.<Point>(_vertexCount)
			,	_points				:Vector.<Point> 	= new Vector.<Point>(_vertexCount)
			,	_vectors			:Vector.<Point> 	= new Vector.<Point>(_vertexCount)
			,	_colors				:Vector.<uint> 		= new Vector.<uint>(_vertexCount)
			,	_colorsGrey			:Vector.<uint> 		= new Vector.<uint>(_vertexCount)
			,	_pointsArray		:Array
		;	
		
		private var		_counter			:uint;
		private var 	pointsData:*;
		
		private var isInside			:Boolean = false;
		private var isConstructed		:Boolean = false;
		private var isCollide			:Boolean = false;
		private var _boundingBox		:BoundingBox;
		private var _graphicsMouse		:Graphics;
		private var _graphicsPolygon	:Graphics;
		private var _graphicsTriangles	:Graphics;
		private var _touchEnd			:Touch;
		private var _touchMove			:Touch;
		
		private var _shapeMouse			:Shape;
		private var _shapePolygon		:Shape;
		private var _shapeTriangles		:Shape;
		
		private var mouseX:Number, mouseY:Number;
		
		private var timer:uint;
		
		public function Game() {
			_shapeMouse = new Shape();
			_graphicsMouse = _shapeMouse.graphics;
			_graphicsMouse.clear();
			_graphicsMouse.lineStyle(2,0xffffff);
			_graphicsMouse.beginFill(0xffcc00);
			_graphicsMouse.drawCircle(0, 0, 10);
			_graphicsMouse.endFill();
			
			this.addChild(_shapeMouse);
			
			_center.x = MainStarling.SW * 0.5; 
			_center.y = MainStarling.SH * 0.5;
			
			//_shapeMouse.x = mouseX = _positionLocal.x = _center.x;
			//_shapeMouse.y = mouseY = _positionLocal.y = _center.y;
			
			var bgShape:Shape=new Shape();
			bgShape.graphics.beginFill(0x111);
			bgShape.graphics.drawRect(0, 0, MainStarling.SW, MainStarling.SH);
			bgShape.graphics.endFill();
			addChild(bgShape);
			
			isConstructed = true;
			addEventListener(TouchEvent.TOUCH, handle_TouchEnds);
			addEventListener(KeyboardEvent.KEY_UP, handle_KeyboardKeyUp);
			
			process_Regenerate();
		}
		
		private function handle_KeyboardKeyUp(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.SPACE) {
				_shapeMouse.x = mouseX = _positionLocal.x;
				_shapeMouse.y = mouseY = _positionLocal.y;
				process_Regenerate();
			}
		}
		
		private function handle_TouchEnds(e:TouchEvent):void {
			_touchEnd = e.getTouch(this, TouchPhase.ENDED);
			_touchMove = e.getTouch(this, TouchPhase.MOVED);
			if (_touchEnd) {
				removeChild(_shapeMouse);
				System.gc();
			}
			
			if (_touchMove) {
				_positionLocal = _touchMove.getLocation(this);
				_shapeMouse.x = mouseX = _positionLocal.x;
				_shapeMouse.y = mouseY = _positionLocal.y;
				addChild(_shapeMouse);
				process_DrawTrianglesShape();
			}
		}
		private function process_DrawTrianglesShape():void {
			_counter = _vertexCount;
			
			timer = getTimer();
			isInside = false;
			if (Point.distance(_shapeCenter, _positionLocal) < _shapeRadius) {
				isInside = true;
				while (_counter) {
					_point = pointsData[--_counter];
					_vector = _vectors[_counter];
					isCollide = VProd(_vector.x, _vector.y, _point.x - mouseX, _point.y - mouseY) < 0;
					if (isCollide == false) isInside = false;
				}
				
				_counter = _vertexCount;
				
				this.removeChild(_shapeTriangles, true);
				_shapeTriangles = new Shape(); 
				
				_graphicsTriangles = _shapeTriangles.graphics;
				while (_counter) {
					_point = pointsData[--_counter];
					_nextPoint = _counter != 0 ?  pointsData[_counter - 1] : pointsData[_points.length - 1];
					
					_graphicsTriangles.beginFill(isInside ? _colors[_counter] : _colorsGrey[_counter], 0.8);
					_graphicsTriangles.moveTo(mouseX, mouseY);
					_graphicsTriangles.lineTo(_point.x, _point.y);
					_graphicsTriangles.lineTo(_nextPoint.x, _nextPoint.y);
					_graphicsTriangles.lineTo(mouseX, mouseY);
				}
				
				this.addChild(_shapeTriangles);
				trace("Draw Time: ", (getTimer() - timer));
			}
		}
		
		private function process_DrawPolygonShape():void {
			this.removeChild(_shapePolygon, true);
			_shapePolygon = new Shape();
			_graphicsPolygon = _shapePolygon.graphics;
			_graphicsPolygon.lineStyle(1, 0xffff00, 0.5);
			_graphicsPolygon.beginFill(0xffcc00, 0.2);
			
			_counter 	= _vertexCount;
			_point 		= pointsData[--_counter];
			_nextPoint 	= pointsData[_counter - 1];
			
			var tempcalc:Number = (_point.x * _nextPoint.y - _nextPoint.x * _point.y);
			_shapeArea = (_point.x * _nextPoint.y) - (_nextPoint.x * _point.y);
			_shapeCenterX = (_point.x  + _nextPoint.x) * tempcalc;
			_shapeCenterY = (_point.y  + _nextPoint.y) * tempcalc;
			
			_vector = new Point(int(_nextPoint.x - _point.x), int(_nextPoint.y - _point.y))
			_vectors[_counter] = _vector;
			
			_graphicsPolygon.moveTo(_point.x + 1, _point.y + 1);
			while (_counter) {
				_point 		= pointsData[--_counter];
				_nextPoint 	= _counter != 0 ?  pointsData[_counter - 1] : pointsData[_points.length - 1];
				
				_shapeArea += (_point.x * _nextPoint.y) - (_nextPoint.x * _point.y);
				tempcalc = (_point.x * _nextPoint.y - _nextPoint.x * _point.y);
				_shapeCenterX += (_point.x  + _nextPoint.x) * tempcalc;
				_shapeCenterY += (_point.y  + _nextPoint.y) * tempcalc;
				
				_vector = new Point(int(_nextPoint.x - _point.x), int(_nextPoint.y - _point.y))
				_vectors[_counter] = _vector;
				
				drawEntity();
			}
			
			_counter = _vertexCount-1;
			_point = pointsData[_vertexCount - 1];
			drawEntity();
			
			_shapeArea = _shapeArea * 0.5;
			tempcalc = 1 / (6 * _shapeArea);
			_shapeCenter = new Point(_shapeCenterX * tempcalc, _shapeCenterY * tempcalc);
			
			mouseX = _positionLocal.x = _shapeCenter.x;
			mouseY = _positionLocal.y = _shapeCenter.y;
			_boundingBox = new BoundingBox(_shapeCenter.x, _shapeCenter.x, _shapeCenter.y, _shapeCenter.y);
			_counter = _vertexCount;
			_shapeRadius = 0;
			
			while (_counter--) {
				_point = pointsData[_counter];
				
				if (_point.x < _boundingBox.left) 	_boundingBox.left = _point.x;
				if (_point.x > _boundingBox.right) 	_boundingBox.right = _point.x;
				if (_point.y < _boundingBox.top) 	_boundingBox.top = _point.y;
				if (_point.y > _boundingBox.bottom) _boundingBox.bottom = _point.y;
				
				tempcalc = Point.distance(_point, _shapeCenter);
				if (tempcalc > _shapeRadius) _shapeRadius = tempcalc;
			}
			
			_graphicsPolygon.beginFill(0x00ffff, 1);
			_graphicsPolygon.drawCircle(_shapeCenter.x, _shapeCenter.y, 1);
			_graphicsPolygon.beginFill(0x00ffff, .1);
			_graphicsPolygon.drawCircle(_shapeCenter.x, _shapeCenter.y, _shapeRadius);
			
			_graphicsPolygon.beginFill(0xfff, .1);
			_graphicsPolygon.moveTo(_boundingBox.left,	_boundingBox.top);
			_graphicsPolygon.lineTo(_boundingBox.right, _boundingBox.top);
			_graphicsPolygon.lineTo(_boundingBox.right, _boundingBox.bottom);
			_graphicsPolygon.lineTo(_boundingBox.left, 	_boundingBox.bottom);
			_graphicsPolygon.lineTo(_boundingBox.left, 	_boundingBox.top);
			
			function drawEntity():void {
				_graphicsPolygon.lineTo(_point.x, _point.y);
				_graphicsPolygon.drawCircle(_point.x - 1, _point.y - 1, 2);
			}
			
			this.addChild(_shapePolygon);
		}
		
		private function process_Regenerate():void {
			process_Generate_InCircleWithDelta(RADIUS_TO_GENERATE);
			process_DrawPolygonShape();
			process_DrawTrianglesShape();
		}
		
		private function process_Generate_InCircleWithDelta(value:Number, angleFrom:uint = 90, angleTo:uint = 360, correlationIndex:Number = 0.3):void {
			_counter = _vertexCount;
			var 	randomangle 	:Number		= random(angleFrom, angleTo)
				,	angle			:Number 	= randomangle * ANGLE_TO_RADIAN
				,	alfa			:Number 	= angle / _counter
				,	alfaOffsetMax	:Number 	= alfa * 0.25
				,	alfaOffset		:Number 	= 0
				,	alpha			:Number 	= 0
				,	rotate			:Number 	= 0
				,	prevAngle		:Number 	= 0
				
				,	radius			:Number 	= 0
				,	radiusDeltaMax	:Number		= 0//RADIUS_TO_GENERATE * ( 1 / _vertexCount)
				,	radiusDelta		:Number 	= 0
			;
			var	keycolor1		:Color		= new Color(Math.random() * 255, Math.random() * 255, Math.random() * 255);
			//var	keycolor2		:Color		= new Color(Math.random() * 255, Math.random() * 255, Math.random() * 255);
			var	colorwheel		:ColorWheel	= keycolor1
												//.toHard(_vertexCount);
												//.toLight(_vertexCount);
												//.toFresh(_vertexCount);
												.toWarm(_vertexCount); 
												//gradientTo(keycolor2, _vertexCount);
			colorwheel.shuffle();
			var colors:Array = colorwheel.getAsList();
			radius = RADIUS_TO_GENERATE;
			
			while (_counter--) {
				_point = new Point(
					_center.x + radius * Math.sin(rotate), 
					_center.y - radius * Math.cos(rotate)
				);
				keycolor1 = colors[_counter];
				_points[_counter] = _point;
				_colors[_counter] = keycolor1.getHex();
				keycolor1.deSaturate(100);
				_colorsGrey[_counter] = keycolor1.getHex();
				prevAngle 	= rotate;
				alpha 		+= alfa;
				alfaOffset 	= random( -alfaOffsetMax, alfaOffsetMax );
				rotate 		= alpha + alfaOffset;
				
				radiusDelta = random( 0, radiusDeltaMax );
				radius = RADIUS_TO_GENERATE + radiusDelta;
			}
			//trace(randomangle, alfa);
			pointsData = _points;
			_shapeRadius = RADIUS_TO_GENERATE;
		}
		
		private function random(from:Number, to:Number):Number
		{
			if (from < 0) to += Math.abs(from);
			else to -= from;
			return Number(from + Math.random() * to);
		}
		
		public static function VProd(x1 : Number , y1 : Number , x2 : Number , y2 : Number) : Number
		{
			return x1 * y2 - y1 * x2;
		}
	}
}