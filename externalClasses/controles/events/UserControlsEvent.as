package controles.events 
{
	import controles.UserControls;
	import controles.utils.DirectionsPoint;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class UserControlsEvent extends Event 
	{
		public static const MOVED:String 		= "userControlsModed" ;
		public static const STOPED:String 		= "userControlsStoped" ;
		public static const SHAKED:String 		= "userControlsShaked" ;
		public static const CONFIGURED:String 	= "userControlsConfigured" ;
		
		public var position:Rectangle ;
		public var direction:DirectionsPoint ;
		public var controle:UserControls ;
		
		public function UserControlsEvent(type:String, position:Rectangle = null, direction:DirectionsPoint = null, control:UserControls = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			this.position = position ;
			this.direction = direction ;
			this.controle = control ;
		} 
		
		public override function clone():Event 
		{ 
			return new UserControlsEvent(type, position, direction, controle, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("UserControlsEvent", "type", "position", "direction", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}