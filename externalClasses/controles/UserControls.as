package controles 
{
	import controles.engines.ColorTrackerEngine;
	import controles.engines.IUserControlEngine;
	import controles.engines.KeyboardEngine;
	import controles.engines.MotionTrackerEngine;
	import controles.engines.MouseEngine;
	import controles.utils.KeyboadButtons;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class UserControls
	{
		private var _controlMode:String ;
		private var _stage:Stage ;
		private var _options:Object ;
		
		private var _currentEngine:IUserControlEngine ;
		
		public function UserControls( controlMode:String, stageRef:Stage, options:Object = null ) 
		{
			this._stage = stageRef ;
			this._options = options ;
			
			this.controlMode = controlMode ;
		}
		
		public function init():void 
		{
			if ( _currentEngine != null ) 
			{
				_currentEngine.init();
			}
		}
		
		public function stop():void 
		{
			if ( _currentEngine )
			{
				_currentEngine.stop();
			}
		}
		
		public function addEventListener(type:String, listener:Function):void 
		{
			if ( _currentEngine ) _currentEngine.addEventListener( type, listener );
		}
		
		public function removeEventListener(type:String, listener:Function):void 
		{
			if ( _currentEngine ) _currentEngine.removeEventListener( type, listener );
		}
		
		public function dispatchEvent( e:Event ):void 
		{
			if ( _currentEngine ) _currentEngine.dispatchEvent( e );
		}
		
		private function ConfigInputMode():void
		{
			switch ( _controlMode ) 
			{
				case UserControlsMode.MOUSE:
					_currentEngine = new MouseEngine( _stage, this );
					break;
					
				case UserControlsMode.KEYBOARD:
					var buttons:Object = KeyboadButtons.DEFAULTS ;
					if ( _options ) {
						if ( _options.buttons ) buttons = _options.buttons ;
					}
					_currentEngine = new KeyboardEngine( _stage, this, buttons );
					break;
					
				case UserControlsMode.MOTION_TRACKER:
					_currentEngine = new MotionTrackerEngine( _stage, this );
					break;
					
				case UserControlsMode.COLOR_TRACKER:
					_currentEngine = new ColorTrackerEngine( _stage, this, _options );
					break;
			}
		}
		
		public function get controlMode():String { return _controlMode; }
		public function set controlMode(value:String):void 
		{
			_controlMode = value;
			ConfigInputMode();
		}
		
	}

}