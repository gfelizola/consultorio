package app.events
{
	import flash.events.Event;
	
	public class AppEvent extends Event
	{
		public static const LOGIN_SUCESSO:String = "loginSucesso" ;
		public static const CADASTRAR_USUARIO_NOVO:String = "cadastrarUsuarioNovo" ;
		public static const CADASTRADO_COM_SUCESSO:String = "cadastradoComSucesso" ;
		
		public function AppEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}