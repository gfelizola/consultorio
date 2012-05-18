package controles.engines 
{
	import controles.UserControls;
	import controles.utils.MotionVerifier;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class MotionEngine implements IUserControlMotionEngine
	{
		protected var _stage:Stage ;
		protected var _verifier:MotionVerifier ;
		protected var _control:UserControls ;
		
		public function MotionEngine( stage:Stage, controle:UserControls ) 
		{
			_stage = stage ;
			_control = controle ;
			_verifier = new MotionVerifier( _stage, this );
		}
		
		public function init():void 
		{
			_verifier.init();
		}
		
		public function stop():void 
		{
			_verifier.stop();
		}
		
		public function getPoint():Point 
		{
			return new Point();
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_verifier.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			_verifier.removeEventListener( type, listener, useCapture );
		}
		
		public function dispatchEvent( e:Event ):Boolean 
		{
			return _verifier.dispatchEvent( e );
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _verifier.hasEventListener( type );
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _verifier.willTrigger( type );
		}
		
		public function get control():UserControls { return _control; }
		public function set control(value:UserControls):void 
		{
			_control = value;
		}
		
	}

}