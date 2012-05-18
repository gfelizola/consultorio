package as3.services.webservice{
	

	public dynamic class WSMethod {
		
		private var __action:String;
		private var __servicePath:String;
		private var __methodName:String;
		private var __params:Array;
		private var __targetNamespace:String;
		private var __proxy:WSProxy;
		private var __debug:Boolean = false;
		private var __wsName:String;
		
		public function WSMethod()
		{
			__proxy = WSProxy.getInstance();
		};
		
		private function myMethod(loaded:Function, ...args):void{
			var params:String = new String();
			var a:Number;
			
			if (__debug)
			{
				trace("CALL > "+__wsName+"["+ __methodName + "]");
			}
			for(a=0;a<__params.length;a++){
				var argument:String = "";
				if(args[a] != undefined){
					argument = args[a];
					if (__debug)
					{
						trace(" - SEND PARAM > " + args[a]);
					}
				} else {
					if (__debug)
					{
						trace(" - PARAM NOT SEND > " + args[a]);
					}
				}
				params += '<' + __params[a] + '>' + argument + '</' + __params[a] + '>';
			}
	  
			var soapRequest:String = '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
			soapRequest += '<soap:Body>';
			soapRequest += '<' + __methodName + ' xmlns="' + __targetNamespace + '">';
			soapRequest += params;
			soapRequest += '</' + __methodName + '>';
			soapRequest += '</soap:Body>';
			soapRequest += '</soap:Envelope>';
			
			var request:XML = new XML(soapRequest);
			
			/**
			 * PUT SENDING ACTION HERE
			 */
			__proxy.callMethod(loaded, request, __servicePath, __action);
		}
		
		public function createMethod(name:String, param:Array, ns:String, service:String, action:String):Function{
			__servicePath = service;
			__methodName = name;
			__params = param;
			__targetNamespace = ns;
			__action = action;
			return myMethod;
		}
		
		public function set debug(value:Boolean):void 
		{
			__debug = value;
		}
		
		public function set _wsName(value:String):void 
		{
			__wsName = value;
		}
		
	}
	
}