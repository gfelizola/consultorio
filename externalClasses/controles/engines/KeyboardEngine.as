package controles.engines 
{
	import controles.events.UserControlsEvent;
	import controles.UserControls;
	import controles.utils.Directions;
	import controles.utils.DirectionsPoint;
	import controles.utils.KeyboadButtons;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class KeyboardEngine extends EventDispatcher implements IUserControlEngine
	{
		private var _stage:Stage ;
		private var _control:UserControls ;
		private var _buttons:Object ;
		private var _moveTimer:Timer ;
		private var _stopDispatched:Boolean = true ;
		
		private var _curDirection:DirectionsPoint
		
		private var leftPress:Boolean = false ;
		private var rightPress:Boolean = false ;
		private var upPress:Boolean = false ;
		private var downPress:Boolean = false ;
		
		public function KeyboardEngine( stageRef:Stage, controle:UserControls, buttons:Object ) 
		{
			_stage = stageRef ;
			_buttons = buttons ;
			_control = controle ;
		}
		
		public function init():void 
		{
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress );
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease );
			
			_moveTimer = new Timer(100);
			_moveTimer.addEventListener(TimerEvent.TIMER, onTime ) ;
			_moveTimer.start();
			
			dispatchEvent( new UserControlsEvent( UserControlsEvent.CONFIGURED, new Rectangle(), Directions.CENTER ) );
		}
		
		public function stop():void 
		{
			_moveTimer.stop();
			_moveTimer.removeEventListener(TimerEvent.TIMER, onTime );
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress );
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyRelease );
		}
		
		private function onKeyRelease(e:KeyboardEvent):void 
		{
			switch ( e.keyCode ) 
			{
				case _buttons.left:
					leftPress = false ;
					break;
				case _buttons.right:
					rightPress = false ;
					break;
				case _buttons.up:
					upPress = false ;
					break;
				case _buttons.down:
					downPress = false ;
					break;
			}
		}
		
		private function onKeyPress(e:KeyboardEvent):void 
		{
			switch ( e.keyCode ) 
			{
				case _buttons.left:
					leftPress = true ;
					break;
				case _buttons.right:
					rightPress = true ;
					break;
				case _buttons.up:
					upPress = true ;
					break;
				case _buttons.down:
					downPress = true ;
					break;
			}
		}
		
		private function onTime(e:TimerEvent):void 
		{
			var eventType:String = UserControlsEvent.MOVED ;
			
			if ( ! leftPress && ! rightPress && ! upPress && ! downPress ) 
			{
				eventType = UserControlsEvent.STOPED ;
				_curDirection = Directions.CENTER ;
			}
			else 
			{
				_stopDispatched = false ;
				
				if ( upPress ) {
					_curDirection = Directions.NORTH ;
					if ( leftPress ) _curDirection = Directions.NORTHWEST ;
					if ( rightPress ) _curDirection = Directions.NORTHEAST ;
				}
				
				if ( downPress ) {
					_curDirection = Directions.SOUTH ;
					if ( leftPress ) _curDirection = Directions.SOUTHWEST ;
					if ( rightPress ) _curDirection = Directions.SOUTHEAST ;
				}
				
				if ( leftPress ) {
					_curDirection = Directions.WEST ;
					if ( upPress ) _curDirection = Directions.NORTHWEST ;
					if ( downPress ) _curDirection = Directions.SOUTHWEST ;
				}
				
				if ( rightPress ) {
					_curDirection = Directions.EAST ;
					if ( upPress ) _curDirection = Directions.NORTHEAST ;
					if ( downPress ) _curDirection = Directions.SOUTHEAST ;
				}
			}
			
			if ( eventType == UserControlsEvent.STOPED )
			{
				if ( ! _stopDispatched ) {
					_stopDispatched = true ;
				} else {
					return void ;
				}
			}
			
			var position:Rectangle = new Rectangle();
			dispatchEvent( new UserControlsEvent( eventType, position, _curDirection ) );
		}
		
		public function get control():UserControls { return _control; }
		public function set control(value:UserControls):void 
		{
			_control = value;
		}
	}

}