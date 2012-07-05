package app.events
{
	import app.util.General;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Dispatcher extends EventDispatcher
	{
		public const RESET_FORM:String = "onResetForm";
		public const REBUILD:String = "onRebuild";
		
		public function Dispatcher()
		{
			// CONSTRUCTOR
		}
		
		protected function dispacha(e:String):void
		{
			dispatchEvent(new Event(e));
		}
		
		public function resetForm():void{dispacha(RESET_FORM);}
		public function rebuild():void{
			General.editandoConsulta = false ;
			dispacha(REBUILD);
		}
	}
}