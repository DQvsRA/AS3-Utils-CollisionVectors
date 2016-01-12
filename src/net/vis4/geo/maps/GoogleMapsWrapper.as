package net.vis4.geo.maps
{
	import com.google.maps.*;
	import com.google.maps.controls.NavigationControl;
	import com.google.maps.controls.NavigationControlOptions;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author gka
	 */
	public class GoogleMapsWrapper extends Sprite 
	{
		
		public function GoogleMapsWrapper():void 
		{
			
		}
		
		private var _map:Map;
		private var _bounds:Rectangle;
		
		public function init(apikey:String, bounds:Rectangle):void 
		{
			_map = new Map();
			_map.key = apikey;
			_map.addEventListener(MapEvent.MAP_PREINITIALIZE, _onPreInit);
			_map.addEventListener(MapEvent.MAP_READY, _onInit);
			_bounds = bounds;
			_map.x = bounds.x;
			_map.y = bounds.y;
			addChild(_map);
		}
		
		private function _onPreInit(e:MapEvent):void 
		{
			_map.setInitOptions(new MapOptions( {
				backgroundFillStyle: { alpha: Alpha.UNSEEN }
			}));
		}
		
		private function _onInit(e:MapEvent):void 
		{
			_map.setSize(new Point(_bounds.width, _bounds.height));
			_map.clearControls();
			dispatchEvent(new Event(Event.INIT));
		}
		
		public function setView(centerLat:Number, centerLng:Number, zoomLevel:Number):void
		{
			_map.setCenter(new LatLng(centerLat, centerLng), zoomLevel);
		}
		
		public function setCenter(centerLat:Number, centerLng:Number):void
		{
			_map.setCenter(new LatLng(centerLat, centerLng));
		}	
		
		public function panTo(centerLat:Number, centerLng:Number):void
		{
			_map.panTo(new LatLng(centerLat, centerLng));
		}			
		
		public function setBounds(bounds:Rectangle):void
		{
			_map.x = bounds.x;
			_map.y = bounds.y;
			_map.setSize(new Point(bounds.width, bounds.height));
		}
		
		public function hideControls():void
		{
			_map.clearControls();
		}
		
		public function showSmallControls():void
		{
			_map.addControl(new NavigationControl(new NavigationControlOptions( { hasScrollTrack: false } )));
		}
		
		public function addMarker(mLat:Number, mLng:Number, mIcon:DisplayObject, offset:Point, hasShadow:Boolean):void
		{
			var markerOptions:MarkerOptions = new MarkerOptions( { icon:mIcon, iconOffset:offset, hasShadow:hasShadow, iconAlignment: 0x11 } );
			var marker:Marker = new Marker(new LatLng(mLat, mLng), markerOptions);
			_map.addOverlay(marker);
		}
		
		public function enableContinuousZoom():void { _map.enableContinuousZoom(); }
		public function disableContinuousZoom():void { _map.disableContinuousZoom(); }
		public function enableControlByKeyboard():void { _map.enableControlByKeyboard(); }
		public function disableControlByKeyboard():void { _map.disableControlByKeyboard(); }
		public function enableCrosshairs():void { _map.enableCrosshairs(); }
		public function disableCrosshairs():void { _map.disableCrosshairs(); }
		public function enableDragging():void { _map.enableDragging(); }
		public function disableDragging():void { _map.disableDragging(); }
		public function enableScrollWheelZoom():void { _map.enableScrollWheelZoom(); }
		public function disableScrollWheelZoom():void { _map.disableScrollWheelZoom(); }
		public function savePosition():void	{ _map.savePosition();	}
		public function returnToSavedPosition():void { _map.returnToSavedPosition();	}
		public function clearOverlays():void { _map.clearOverlays();	}
		
		
	}
	
}