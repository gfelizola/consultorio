package controles.utils 
{
	import controles.engines.IUserControlEngine;
	import controles.engines.IUserControlMotionEngine;
	import controles.events.UserControlsEvent;
	import controles.UserControls;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class MotionVerifier extends EventDispatcher
	{
		private var _oldX:Number = 0 ;
		private var _oldY:Number = 0 ;
		
		private var _curX:Number = 0 ;
		private var _curY:Number = 0 ;
		
		private var _curDirection:DirectionsPoint ;
		private var _oldDirection:DirectionsPoint ;
		
		private var _margemCardeal:Number = 10 ;
		
		private var _moveTimer:Timer ;
		private var _stopDispatched:Boolean = true ;
		
		private var _shakeSteps:Array ;
		private var _shakeTotalSteps:Number = 5 ;
		private var _stage:Stage;
		private var _engine:IUserControlMotionEngine ;
		private var stopCounts:int = 0 ;
		
		public function MotionVerifier( stage:Stage, engine:IUserControlMotionEngine ) 
		{
			_stage = stage ;
			_engine = engine ;
			_moveTimer = new Timer(50);
			_moveTimer.addEventListener(TimerEvent.TIMER, onMove ) ;
		}
		
		public function init():void 
		{
			_shakeSteps = [] ;
			_moveTimer.start();
			dispatchEvent( new UserControlsEvent( UserControlsEvent.CONFIGURED, new Rectangle(), Directions.CENTER ) );
		}
		
		public function stop():void 
		{
			_moveTimer.stop();
		}
		
		private function onMove(e:TimerEvent):void 
		{
			var _curPoint:Point = _engine.getPoint();
			_curX = _curPoint.x ;
			_curY = _curPoint.y ;
			
			var eventType:String = UserControlsEvent.MOVED ;
			
			if ( _oldX == 0 && _oldY == 0 && _curX == 0 && _curY == 0 ) 
			{
				return void;
			}
			else 
			{
				if ( _curX == _oldX && _curY == _oldY ) 
				{
					stopCounts++ ;
					_curDirection = Directions.CENTER ;
					
					if ( stopCounts > 3 ) {
						eventType = UserControlsEvent.STOPED ;
						_shakeSteps = [] ;
					}
				}
				else 
				{
					stopCounts = 0 ;
					_stopDispatched = false ;
					
					if ( _curX < _oldX + _margemCardeal && _curX > _oldX - _margemCardeal )
					{
						// MOVIMENTO VERTICAL
						_curDirection = _curY < _oldY ? Directions.NORTH : Directions.SOUTH ;
					}
					else
					{
						if ( _curY < _oldY + _margemCardeal && _curY > _oldY - _margemCardeal ) 
						{
							// MOVIMENTO HORIZONTAL
							_curDirection = _curX < _oldX ? Directions.WEST : Directions.EAST ;
						}
						else 
						{
							// MOVIMENTO DIAGONAL
							if ( _curY < _oldY ) 
							{
								_curDirection = _curX < _oldX ? Directions.NORTHWEST : Directions.NORTHEAST ;
							}
							else 
							{
								_curDirection = _curX < _oldX ? Directions.SOUTHWEST : Directions.SOUTHEAST ;
							}
						}
					}
					
					if ( this.hasEventListener( UserControlsEvent.SHAKED ) ) 
					{
						_shakeSteps.push( _curDirection );
						
						if ( _shakeSteps.length >= _shakeTotalSteps )
						{
							var oldShakeDirection:DirectionsPoint = _shakeSteps[0] ;
							var shaked:Boolean = true ;
							var accepts:int = 0 ;
							var i:int = 1 ;
							var iT:int = _shakeSteps.length ;
							for (i; i < iT; i++) 
							{
								var item:DirectionsPoint = _shakeSteps[i];
								if ( ! Oposities.IsOposite( item , oldShakeDirection ) ) accepts++ ;
								oldShakeDirection = item ;
								if ( accepts > 2 ) shaked = false ;
							}
							
							if ( shaked )  eventType = UserControlsEvent.SHAKED ;
							
							_shakeSteps = [] ;
						}
					}
				}
				
				_oldX = _curX ;
				_oldY = _curY ;
				_oldDirection = _curDirection ;
				
				if ( eventType == UserControlsEvent.STOPED )
				{
					if ( ! _stopDispatched ) {
						_stopDispatched = true ;
					} else {
						return void ;
					}
				}
				
				var position:Rectangle = new Rectangle( _curX, _curY );
				dispatchEvent( new UserControlsEvent( eventType, position, _curDirection ) );
			}
		}
		
		public function get control():UserControls 
		{
			return _engine.control ;
		}
		
		public function get margemCardeal():Number { return _margemCardeal; }
		public function set margemCardeal(value:Number):void 
		{
			_margemCardeal = value;
		}
		
	}

}