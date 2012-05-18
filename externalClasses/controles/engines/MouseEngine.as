package controles.engines 
{
	import controles.events.UserControlsEvent;
	import controles.UserControls;
	import controles.utils.Directions;
	import controles.utils.DirectionsPoint;
	import controles.utils.MotionVerifier;
	import controles.utils.Oposities;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class MouseEngine extends MotionEngine
	{
		public function MouseEngine( stage:Stage, controle:UserControls ) 
		{
			super( stage, controle );
		}
		
		override public function getPoint():Point 
		{
			return new Point( _stage.mouseX, _stage.mouseY );
		}
	}

}