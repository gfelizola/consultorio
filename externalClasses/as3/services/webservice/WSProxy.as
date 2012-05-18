package as3.services.webservice {
	
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	
	public class WSProxy {
		
		private static var __instance:WSProxy;
		private var __cache:WSCache;
		private var __urlLoader:URLLoader;
		private var __completeEvent:Function;
		private var __callQueue:Array = new Array();
		private var __busyOnCall:Boolean = false;
		private var __cacheResults:Boolean = false;
		private var __request:XML;
		private var __servicePath:String;
		private var xmlSoapList:XMLList;
		
		public function WSProxy(){
			__cache = WSCache.getInstance();
		}
		
		public static function getInstance():WSProxy{
			if(__instance == null){
				__instance = new WSProxy();
			}
			return __instance;
		}
		
		private function CastResult(rsXML:XML):*
		{
			var OWSRetorno:WSRetorno = new WSRetorno();
			OWSRetorno.Retorno   = rsXML.Retorno;
			OWSRetorno.Mensagem  = rsXML.Mensagem;
			
			if (String(rsXML.Retorno).length>0 || String(rsXML.Mensagem).length>0 || String(rsXML.Resultado).length>0)
			{
				if (new XMLList(rsXML.Resultado.*[0]).hasComplexContent())
				{
					OWSRetorno.Resultado = new XMLList(rsXML.Resultado.*);
				}
				else
				{
					OWSRetorno.Resultado = new XMLList(rsXML.Resultado);
				}
				return  OWSRetorno;
			}
			return rsXML;
		}
		
		private function callService(onLoad:Function, request:XML, servicePath:String, action:String):void{
			__request = request;
			__servicePath = servicePath;
			__completeEvent = onLoad;
			
			
			if(__cacheResults){	
				if(__cache.checkCache(servicePath, request)){
					var response:XML = __cache.getCachedResult(servicePath, request);
					
					__completeEvent(CastResult(response));
					//__completeEvent(response);
					return;
				}
			}
			
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.contentType = "text/xml; charset=utf-8";
			urlRequest.method = "POST";
			//trace("servicePath",servicePath)
			urlRequest.url = servicePath;
			var soapAction:URLRequestHeader = new URLRequestHeader("SOAPAction", action);
			urlRequest.requestHeaders.push(soapAction);
			urlRequest.data = request;
			__urlLoader = new URLLoader();
			__urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			__urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			__urlLoader.addEventListener(Event.COMPLETE, onComplete);
			__urlLoader.load(urlRequest);
			__cache.flushCache();
		}
		
		private function onHTTPStatus(e:HTTPStatusEvent):void 
		{
			//trace(e.toString());
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			//trace( e.toString());
		}
		
		private function onComplete(evt:Event):void
		{			
			var response:XML = new XML(__urlLoader.data);
			var str:String = String(response.children().children().children());
			
			//trace("onComplete", str)
			
			var arr:Array = str.split("xmlns"); var newstr:String = "";
			
			
			for(var i:Number=0; i < arr.length ; i++)
			{
				if(i<arr.length-1)
				{
					newstr+= arr[i]+ "xmlns:temp";
				}
				else
				{
					newstr+= arr[i]
				}
			}
			
			var result:XML = new XML(newstr);
			
			__completeEvent(CastResult(result));
			
			if(__cacheResults){
				__cache.setCachedResult(__servicePath, __request, response);
			}
			__busyOnCall = false;
			if(__callQueue.length > 0){
				callService(__callQueue[0].load, __callQueue[0].req, __callQueue[0].path, __callQueue[0].soapAction);
				__callQueue.splice(0,1);
			}
		}
		
		public function callMethod(onLoad:Function, request:XML, servicePath:String, action:String):void{
			if(!__busyOnCall){
				__busyOnCall = true;
				callService(onLoad, request, servicePath, action);
			} else {
				__callQueue.push({load: onLoad, req: request, path: servicePath, soapAction: action});
			}
		}
		
		public function set cacheResults(cache:Boolean):void{
			__cacheResults = cache;
		}
		
		public function clearCache():void{
			__cache.flushCache();
		}
		
	}
	
}