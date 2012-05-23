package app.util
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import app.model.Consulta;
	import app.model.DB;
	import app.model.Paciente;
	import app.model.Usuario;
	
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;

	public class General
	{
		
		public static var stage:Stage ;
		
		public static var usuario:Usuario;
		
		public static var pacienteAtual:Paciente;
		
		public static var consultaAtual:Consulta;
		
		public static var buscaAtual:String = '' ;
		
		public static const APLICACAO_CARREGADA:String = "AplicacaoCarregada" ;

		private static var appUpdater:ApplicationUpdaterUI;
		
		public function General()
		{
			
		}
		
		public static function salvaConsulta():void
		{
			if( consultaAtual != null ){
				consultaAtual.dataConsulta = new Date();
				pacienteAtual.dataUltimaConsulta = new Date();
				consultaAtual.paciente = pacienteAtual ;
				
//				DB.em.save(consultaAtual);
//				DB.em.save(pacienteAtual)
				
				Alert.show("Consulta salva com dados atuais");
			}
		}
		
		public static function getAppVersion():String 
		{
			var appXml:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXml.namespace();
			var appVersion:String = appXml.ns::versionNumber[0];
			return appVersion;
		}
		
		public static function getFormattedDate( d:String ):String
		{
			var df:DateFormatter = new DateFormatter();
			df.formatString = "DD/MM/YYYY" ;
			return df.format(d);
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