package controles.engines 
{
	import com.greensock.TweenMax;
	import com.gustavofelizola.tracker.ColorTracker;
	import controles.UserControls;
	import controles.utils.CameraUtils;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class ColorTrackerEngine extends MotionEngine
	{
		private var _colorTracker:ColorTracker ;
		
		private var _regulador:uint = 1 ;
		private var _input:Video;
		private var _clear:Video;
		private var _output:Shape;
		private var _getColorArea:Shape;
		private var _sensibility:Number = 5 ;
		private var _oldArea:Rectangle;
		
		private var _options:Object ;
		private var _container:DisplayObjectContainer
		
		private var camW:int;
		private var camH:int;
		private var timeToColor:Number = 10 ;
		private var timerShow:Shape;
		
		public function ColorTrackerEngine( stage:Stage, controle:UserControls, options:Object ) 
		{
			super( stage, controle );
			_options = options ;
		}
		
		override public function init():void 
		{
			if ( _options.regulador ) _regulador = _options.regulador ;
			
			camW = _stage.stageWidth / _regulador;
			camH = _stage.stageHeight / _regulador;
			
			if ( _options.width ) 	camW = _options.width ;
			if ( _options.height ) 	camH = _options.height ;
			
			_container = _stage ;
			if ( _options.container != null ) _container = _options.container ; 
			
			var cam:Camera = CameraUtils.getCamera();
			if ( cam == null ) {
				trace( "NO CAMERA FOUND!!!!" );
				return ;
			}
			
			cam.setMode(camW, camH, _stage.frameRate);
			
			_input = new Video(camW, camH);
			_input.attachCamera(cam);
			_input.filters = [new BlurFilter(10, 10, 1)];
			
			_colorTracker = new ColorTracker(_input);
			_verifier.margemCardeal = 5 ;
			
			_clear = new Video( camW, camH );
			_clear.attachCamera(cam);
			_clear.scaleX = -1 ;
			_clear.x = camW ;
			_container.addChild( _clear );
			
			_oldArea = new Rectangle();
			
			if ( cam.muted ) {
				cam.addEventListener(StatusEvent.STATUS, onCameraReady );
			} else {
				initGetColor();
			}
		}
		
		private function onCameraReady(e:StatusEvent):void 
		{
			if ( e.code == "Camera.Unmuted" ) {
				initGetColor();
			}
		}
		
		private function initGetColor( e:Event = null ):void 
		{
			var size:Number = 10 ;
			_getColorArea = new Shape();
			_getColorArea.graphics.clear();
			_getColorArea.graphics.lineStyle( 4, 0x00ff00 );
			_getColorArea.graphics.drawRect( 0, 0, size, size );
			_getColorArea.x = ( _clear.x - _clear.width ) + ( _input.width - size ) * .5 ;
			_getColorArea.y = _clear.y + ( _input.height - size ) * .5 ;
			
			_container.addChild( _getColorArea );
			_clear.visible = true ;
			
			_stage.addEventListener(MouseEvent.CLICK, stageClick );
				
			var timeRender:Timer = new Timer( 20 );
			timeRender.addEventListener(TimerEvent.TIMER, render );
			timeRender.start();
			
			//var time:Timer = new Timer( 10, 150 );
			//time.addEventListener(TimerEvent.TIMER_COMPLETE, getColor );
			//time.addEventListener(TimerEvent.TIMER, render );
			//time.start();
		}
		
		private function stageClick(e:MouseEvent):void 
		{
			timerShow = new Shape();
			timerShow.graphics.clear();
			timerShow.graphics.lineStyle( 4, 0xff0000 );
			timerShow.graphics.drawRect( 0, 0, camW, camH );
			_container.addChild( timerShow );
			
			timeToColor = 2000 ;
			
			TweenMax.to( timerShow, timeToColor / 1000, { width: _getColorArea.width, height: _getColorArea.height, x: _getColorArea.x, y:_getColorArea.y, onComplete:getColor } );
			
			_stage.removeEventListener(MouseEvent.CLICK, stageClick );
		}
		
		private function render(e:TimerEvent):void 
		{
			_colorTracker.track(_regulador);
			if ( _colorTracker.colorToTrack > 0 ) Timer(e.target).stop();
		}
		
		private function getColor(e:TimerEvent = null):void 
		{
			var tempData:BitmapData = new BitmapData( _input.width, _input.height, false );
			tempData.draw( _colorTracker.output );
			
			var colorCapture:uint = tempData.getPixel( int( _input.width * .5 ), int( _input.height * .5 ) );
			
			_colorTracker.colorToTrack = colorCapture ;
			_container.removeChild( _getColorArea );
			_container.removeChild( timerShow );
			
			//_clear.visible = false ;
			
			super.init();
		}
		
		override public function getPoint():Point 
		{
			if ( ! isNaN( _colorTracker.colorToTrack ) ) {
				_colorTracker.track( _regulador );
				
				if ( verifyRect( _colorTracker.colorArea ) ) {
					return new Point( _colorTracker.colorArea.x, _colorTracker.colorArea.y );
				}
				else
				{
					return new Point( _oldArea.x, _oldArea.y );
				}
			}
			
			return new Point();
		}
		
		private function verifyRect( area:Rectangle ):Boolean 
		{
			if( area.x == 0 && area.y == 0 && area.width == 0 && area.height == 0 ) return false 
			var retorno:Boolean = false ;
			
			if ( area.x > _oldArea.x + _sensibility ) retorno = true ;
			if ( area.x < _oldArea.x - _sensibility ) retorno = true ;
			
			if ( area.y > _oldArea.y + _sensibility ) retorno = true ;
			if ( area.y < _oldArea.y - _sensibility ) retorno = true ;
			
			if( retorno ) _oldArea = area ;
			
			return retorno ;
		}
	}

}