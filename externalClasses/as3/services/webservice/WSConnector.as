package as3.services.webservice
{
	
	import flash.events.EventDispatcher;
	import flash.events.Event;

	public dynamic class  WSConnector extends EventDispatcher
	{
		private var __wsdl:WSDL;
		private var __availableMethods:Array;
		private var __proxy:WSProxy;
		private var debug:Boolean = false;
		
		public function WSConnector()
		{
			__proxy = WSProxy.getInstance();
		};
			
		private function WsdlComplete(methods:Array):void
		{
			__availableMethods = methods;
			
			if (debug)
			{
				trace(":::::::::::::::::::::::::::::::::::::::::::::");
				trace(":::: AVAILABLE METHODS IN ["+__wsdl._wsName+"] :");
			}
			
			var a:Number;
			for (a = 0; a < __availableMethods.length; a++)
			{
				var method:WSMethod = new WSMethod();
				method.debug = debug;
				method._wsName = __wsdl._wsName;
				
				this[__availableMethods[a].name] = method.createMethod(__availableMethods[a].name, __availableMethods[a].param, __availableMethods[a].targetNS, __availableMethods[a].servicePath, __availableMethods[a].soapAction);
				
				if (debug)
				{
					trace(__availableMethods[a].name);
				}
			}
			dispatchEvent(new EvtWSConnector(EvtWSConnector.CONNECT , __availableMethods ));
		}
		
		public function Connect(wsdl:String):void
		{
			__wsdl = new WSDL(wsdl);	
			__wsdl.addEventListener(EvtWSConnector.IOERROR , IOError);
			__wsdl.getWSDL(WsdlComplete);
		}
		
		private function IOError(e:EvtWSConnector):void 
		{
			if (!hasEventListener(EvtWSConnector.IOERROR))
			{
				throw new Error("URI Invalida!");
			}
			dispatchEvent(new EvtWSConnector(EvtWSConnector.IOERROR));
		}
		
		public function ClearCache():void{
			__proxy.clearCache();
		}
		
		public function get AvailableMethods():Array{
			return __availableMethods;
		}
		
		public function set CacheResults(cache:Boolean):void{
			__proxy.cacheResults = cache;
		}
		
		public function set Debug(value:Boolean):void 
		{
			debug = value;
		}
	}
	
}