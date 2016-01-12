package {
	import ch.badmojo.color.Color;
	import ch.badmojo.color.ColorWheel;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	[SWF(width="800",height="800",frameRate="60",backgroundColor="#1f1f1f")]
	public class Main extends Sprite {
		
		private static var RADIUS_TO_GENERATE:uint = 250;
		private static var ANGLE_TO_RADIAN:Number = Math.PI / 180;
		
		
		private var 
			_vertexCount		:uint = 7
		,	_point				:Point = new Point()
		,	_vector				:Point = new Point()
		,	_mouse				:Point = new Point()
		,	_center				:Point = new Point()
		
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
		
		private var _graphics		:Graphics;
		private var _mouseGraphics	:Graphics;
		private var _boundingBox	:BoundingBox;
		private var	_counter		:uint;
		
		private var pointsData:*;
		
		private var isInside		:Boolean = false;
		private var isConstructed	:Boolean = false;
		
		public function Main():void { if (stage) init(); else addEventListener(Event.ADDED_TO_STAGE, init); }
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_graphics = this.graphics;
			_center.x = this.stage.stageWidth * 0.5; 
			_center.y = this.stage.stageHeight * 0.5;
			
			var mousePositionLayer:Shape = new Shape();
			_mouseGraphics = mousePositionLayer.graphics;
			
			process_Regenerate();
			isConstructed = true;
			
			this.addChild(mousePositionLayer);
			
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, handler_MouseMove);
			this.stage.addEventListener(MouseEvent.CLICK, handler_MouseClick);
			this.stage.addEventListener(Event.ENTER_FRAME, handler_EnterFrame);
		}
		
		private function handler_EnterFrame(e:Event):void {
			_counter = _vertexCount;
			while (_counter--) {
			
			}
		}
		
		private function handler_MouseClick(e:MouseEvent):void {
			process_Regenerate();
			handler_MouseMove(null);
		}
		
		private function process_Regenerate():void {
			_graphics.clear();
			process_Generate_InCircleWithDelta(RADIUS_TO_GENERATE, 90);
			//process_Generate_RandomPoints();
			process_DrawPolygonShape();
		}
		
		private function process_Generate_RandomPoints():void {
			_counter = _vertexCount;
			_pointsArray = new Array();
			while (_counter--) {
				_point = new Point(uint(random(100, 400)), uint(random(100, 400)));
				_points[_counter] = _point;
				_pointsArray.push(_point);
			}
			_points = SortingVectors.quickSort(_points, 0 , 3);
			//pointsData = _points;

			pointsData = GrahamScan.order( _pointsArray ).reverse();
			
			//_pointsArray.sort(function f(p1:Point, p2:Point): int { return p1.x - p2.x; } );
			//_pointsArray.sort(function f(p1:Point, p2:Point): int { return p1.y - p2.y; } );
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
		
		private function process_DrawPolygonShape():void {
			_graphics.lineStyle(1, 0xffff00, 0.5);
			_graphics.beginFill(0xffcc00, 1);
			
			_counter 	= _vertexCount;
			_point 		= pointsData[--_counter];
			_nextPoint 	= pointsData[_counter - 1];
			
			var tempcalc:Number = (_point.x * _nextPoint.y - _nextPoint.x * _point.y);
			_shapeArea = (_point.x * _nextPoint.y) - (_nextPoint.x * _point.y);
			_shapeCenterX = (_point.x  + _nextPoint.x) * tempcalc;
			_shapeCenterY = (_point.y  + _nextPoint.y) * tempcalc;
			
			_graphics.moveTo(_point.x + 1, _point.y + 1);
			
			/**
			 * COLLISION PRE-CALCULATION
			 */
			_vector = new Point(int(_nextPoint.x - _point.x), int(_nextPoint.y - _point.y))
			_vectors[_counter] = _vector;
			while (_counter--) {
				_point 		= pointsData[_counter];
				_nextPoint 	= _counter != 0 ?  pointsData[_counter - 1] : pointsData[_points.length - 1];
				
				_shapeArea += (_point.x * _nextPoint.y) - (_nextPoint.x * _point.y);
				tempcalc = (_point.x * _nextPoint.y - _nextPoint.x * _point.y);
				_shapeCenterX += (_point.x  + _nextPoint.x) * tempcalc;
				_shapeCenterY += (_point.y  + _nextPoint.y) * tempcalc;
				
				/* CALCULATE VECTORS */ _vector = new Point(int(_nextPoint.x - _point.x), int(_nextPoint.y - _point.y))
				_vectors[_counter] = _vector;
				
				drawEntity();
			}
			/**
			 * END PRE-CALCULATION
			 */
			_counter = _vertexCount-1;
			_point = pointsData[_vertexCount - 1];
			drawEntity();
			
			_shapeArea = _shapeArea * 0.5;
			tempcalc = 1 / (6 * _shapeArea);
			_shapeCenter = new Point(_shapeCenterX * tempcalc, _shapeCenterY * tempcalc);
			
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
			
			_graphics.beginFill(0x00ffff, 1);
			_graphics.drawCircle(_shapeCenter.x, _shapeCenter.y, 1);
			_graphics.beginFill(0x00ffff, .1);
			_graphics.drawCircle(_shapeCenter.x, _shapeCenter.y, _shapeRadius);
			              
			_graphics.beginFill(0xfff, .1);
			_graphics.moveTo(_boundingBox.left, _boundingBox.top);
			_graphics.lineTo(_boundingBox.right, _boundingBox.top);
			_graphics.lineTo(_boundingBox.right, _boundingBox.bottom);
			_graphics.lineTo(_boundingBox.left, _boundingBox.bottom);
			_graphics.lineTo(_boundingBox.left, _boundingBox.top);
			
			trace("Area: Circle | BoundingBox = ", Math.PI * Math.pow(_shapeRadius,2) * 2.54 / Capabilities.screenDPI, _boundingBox.areaCM);
			
			function drawEntity():void {
				_graphics.lineTo(_point.x + 1, _point.y + 1);
				_graphics.drawCircle(_point.x, _point.y, 1);
			}
		}
		
		private var _nextPoint:Point;
		private var _isCollide:Boolean;
		private var _isInside:Boolean;
		private var timer:uint;
		
		private function handler_MouseMove(e:MouseEvent):void {
			_mouseGraphics.clear();
			_counter = _vertexCount;
			_mouse.x = mouseX;
			_mouse.y = mouseY;

			timer = getTimer();
			
			_isInside = Point.distance(_shapeCenter, _mouse) < _shapeRadius;
			if (_isInside) {
				/**
				 * COLLISION CALCULATION
				 */
				while (_counter--) {
					_point = pointsData[_counter];
					_vector = _vectors[_counter];
					_isCollide = VProd(_vector.x, _vector.y, _point.x - _mouse.x, _point.y - _mouse.y) < 0;
					if (_isCollide == false) {
						_isInside = false;
						break;
					}
				}
				/**
				 * END COLLISION CALCULATION
				 */
				
				_counter = _vertexCount;
				while (_counter) {
					_point = pointsData[--_counter];
					_nextPoint = _counter != 0 ?  pointsData[_counter - 1] : pointsData[_points.length - 1];
					
					_mouseGraphics.moveTo(_mouse.x, _mouse.y);
					_mouseGraphics.lineStyle(1, _isCollide ? 0x00f000 : 0xf00000, 0.5);
					_mouseGraphics.lineTo(_point.x + 1, _point.y + 1);
					
					_mouseGraphics.beginFill(_isInside ? _colors[_counter] : _colorsGrey[_counter], 0.8);
					_mouseGraphics.moveTo(mouseX, mouseY);
					_mouseGraphics.lineTo(_point.x, _point.y);
					_mouseGraphics.lineTo(_nextPoint.x, _nextPoint.y);
					_mouseGraphics.lineTo(_mouse.x, _mouse.y);
				}
				
				//trace("Draw Time: ", (getTimer() - timer));
			}
			_mouseGraphics.beginFill(_isInside ? 0x00fa00 : 0xfa0000);
			_mouseGraphics.drawCircle(mouseX, mouseY, 4);
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
