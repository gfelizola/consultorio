package app.util
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import app.events.Dispatcher;
	import app.model.Consulta;
	import app.model.DB;
	import app.model.Paciente;
	import app.model.Usuario;
	import app.util.Helpers;
	
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.ReturnKeyLabel;
	
	import mx.controls.Alert;

	public class General
	{
		
		public static var stage:Stage ;
		
		public static var dispatcher:Dispatcher = new Dispatcher();
		
		public static var salvaFinaliza:Boolean = false;
		
		public static var usuario:Usuario;
		
		public static var pacienteAtual:Paciente;
		
		public static var consultaAtual:Consulta;
		
		public static var consultaSalva:Boolean;
		
		public static var editandoConsulta:Boolean;
		
		public static var buscaAtual:String = '' ;
		
		public static const APLICACAO_CARREGADA:String = "AplicacaoCarregada" ;

		private static var appUpdater:ApplicationUpdaterUI;
		
		public function General()
		{
			
		}
		
		public static function salvaConsulta( callback:Function = null, showSaveAlert:Boolean = true ):Boolean
		{
			if( consultaAtual != null ){
				consultaAtual.paciente = pacienteAtual ;
				
				if( ! consultaAtual.dataConsulta )
				{
					consultaAtual.dataConsulta = new Date();
					pacienteAtual.dataUltimaConsulta = new Date();
					DB.em.save(pacienteAtual);
				}
				
				if( ! consultaAtual.resumo ) consultaAtual.setResumo();
				
				DB.em.save(consultaAtual);
				
				consultaSalva = true ;
				if( showSaveAlert ) Alert.show("Consulta salva com dados atuais");
				
				return true ;
			}
			return false ;
		}
		
		public static function getAppVersion():String 
		{
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXml.namespace();
			var appVersion:String = appXml.ns::versionNumber[0];
			return appVersion;
		}
		
		public static function getFormattedDate( d:* ):String
		{
			return Helpers.dateFormat(d);
		}
		
		public static function verificaAtualizacao():void 
		{
			appUpdater = new ApplicationUpdaterUI();
			appUpdater.updateURL = "http://www.myappurl.com/update.xml";
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate);
			appUpdater.addEventListener(ErrorEvent.ERROR, onUpdaterError);
			appUpdater.isCheckForUpdateVisible = false;
			appUpdater.initialize();
		}
		
		private static function onUpdate(event:UpdateEvent):void 
		{
			appUpdater.checkNow();
		}
		
		private static function onUpdaterError(event:ErrorEvent):void
		{
			Alert.show(event.toString());
		}
	}
}