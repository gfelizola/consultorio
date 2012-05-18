package as3.nestle.utils
{
	import as3.services.webservice.EvtWSConnector;
	import as3.services.webservice.WSConnector;	
	import as3.services.webservice.WSRetorno;	
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;	
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.system.System;
	
	
	/**
	 * ...
	 * @author Guilherme A. Sequeira
	 */
	
	public class GravaPontos extends MovieClip
	{
		private var OWs:WSConnector;		
		private var onCompleteCallBack:Function
		private var onConnectCallBack:Function;
		
		public function GravaPontos(path:String)
		{			
			var urlWs:String = "http://triboserverweb:81/md2010/";			
			OWs = new WSConnector();			
			OWs.Debug = true ;
			
			
			if (path.substr(0, 4) != "file")
			{
				urlWs = path.split("/")[0] +"//" +path.split("/")[2] + "/" + path.split("/")[3] + "/";					
			}
			
			OWs.Connect(urlWs + "wsmaisdivertido.asmx?WSDL")			
			OWs.addEventListener(EvtWSConnector.CONNECT, OnConnect);
			
		}
		
		private function OnConnect(e:EvtWSConnector):void 
		{
			onConnectCallBack(this);
		}
		
		public function AtividadeAtualizaPontosRanking(pIdRanking:String, pPontos:Number):void
		{			
			OWs.atividade_atualizaPontosRanking(rAtividade_atualizaPontosRanking, pIdRanking, pPontos);			
		}	
		
		private function rAtividade_atualizaPontosRanking(rs:WSRetorno):void
		{			
			trace("rAtividade_atualizaPontosRanking", rs.Retorno);
			onCompleteCallBack();
		}		

		
		public function get OnConnectCallBack():Function 
		{
			return onConnectCallBack;
		}
		
		public function set OnConnectCallBack(value:Function):void 
		{
			onConnectCallBack = value;
		}
		
		public function get OnCompleteCallBack():Function 
		{
			return onCompleteCallBack;
		}
		
		public function set OnCompleteCallBack(value:Function):void 
		{
			onCompleteCallBack = value;
		}

	}	
}