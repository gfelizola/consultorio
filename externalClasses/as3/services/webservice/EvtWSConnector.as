package as3.services.webservice 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author Segundo
	*/
	public class EvtWSConnector extends Event 
	{
		public static const CONNECT:String = "connect";
		public static const CALL_METHOD:String = "callmethod";
		public static const RESPONSE_METHOD:String = "responsemethod";
		public static const ERROR_METHOD:String = "error_method";
		public static const IOERROR:String = "ioerror";
		
		private var availableMethods:Array;
		
		public function EvtWSConnector(type:String, pAvailableMethods:Array=null , bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			availableMethods = new Array();
			availableMethods = pAvailableMethods;
		} 
		
		public override function clone():Event 
		{ 
			return new EvtWSConnector(type, availableMethods , bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EvtWSConnector", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get AvailableMethods():Array { return availableMethods; }
		
	}
	
}