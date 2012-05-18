package as3.services.webservice{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class WSDL  extends EventDispatcher{
		
		private var __portType:String = "";
		private var __wsdlPath:String;
		private var __servicePath:String;
		private var __rawWSDL:XML;
		private var __availableMethods:Array;
		private var __parseComplete:Function;
		private var __wsName:String;
		
		public function WSDL(path:String){
			__wsdlPath = path;
		};
		
		private function wsdlLoaded(evt:Event):void
		{
			__rawWSDL = new XML(evt.target.data);
			var portType:String = getPortType(__rawWSDL);
			_wsName = portType;
			var bindingType:String = getBinding(portType);
			var methodList:XMLList = getMethodList(bindingType);
			__availableMethods = getAvailableMethods(methodList);
			__parseComplete(__availableMethods);
		}
		
		private function getPortType(rawWSDL:XML):String{
			var wsdl:Namespace = rawWSDL.namespace();
			var portType:XMLList = rawWSDL.wsdl::portType;
			var portTypeAmount:Number = portType.length();
			if(portTypeAmount == 1){
				return (portType.@name);
			} else {
				if(__portType != ""){
					return __portType;
				} else {
					return portType[0].@name;
				}
			}
			endProcess();
			return "";
		}
		
		private function getBinding(portType:String):String{
			var wsdl:Namespace = __rawWSDL.namespace();
			var service:XMLList = __rawWSDL.wsdl::service;
			var binding:XMLList = __rawWSDL.wsdl::binding.(@type.substr(@type.indexOf(":")+1) == portType);
			var addressNS:Namespace = service.wsdl::port.children()[0].namespace();
			__servicePath = service.wsdl::port.addressNS::address.@location;
			var bindingAmount:Number = binding.length();
			if(bindingAmount == 1){
				return (binding.@name);
			} else if(bindingAmount >0 ) {
				return binding[0].@name;
			}
			return("");
		}
		
		private function getMethodList(bindingType:String):XMLList{
			var wsdl:Namespace = __rawWSDL.namespace();
			var binding:XMLList = __rawWSDL.wsdl::binding.(@name == bindingType);
			var methodList:XMLList = binding.wsdl::operation;
			return methodList;
		}
		
		private function getAvailableMethods(methodNames:XMLList):Array{
			var wsdl:Namespace = __rawWSDL.namespace();
			var s:Namespace = __rawWSDL.wsdl::types.children()[0].namespace();
			var schema:XMLList = __rawWSDL.wsdl::types.s::schema;
			var elements:XMLList = schema.s::element;
			return constructSchema(methodNames, elements);
		}
		
		private function constructSchema(methods:XMLList, schema:XMLList):Array{
			var names:XMLList = methods.@name;
			var wsdl:Namespace = __rawWSDL.namespace();
			var s:Namespace = __rawWSDL.wsdl::types.children()[0].namespace();
			var ns:String = __rawWSDL.@targetNamespace;
			var availableMethods:Array = new Array();
			var a:Number;
			for(a=0;a<names.length();a++){
				var tempMethod:XMLList = methods.(@name == names[a]);
				var tempNS:Namespace = tempMethod.children()[0].namespace();
				var action:String = tempMethod.tempNS::operation.@soapAction;
				var b:Number;
				for(b=0;b<schema.length();b++){
					if(names[a] == schema[b].@name){
						var params:XMLList = schema[b].s::complexType.s::sequence.s::element.@name;
						var parameters:Array = new Array();
						var c:Number;
						for(c=0;c<params.length();c++){
							parameters.push(params[c]);
						}
						var method:Object = {name: names[a], param: parameters, targetNS: ns, servicePath: __servicePath, soapAction: action};
						availableMethods.push(method);
					}
				}
			}
			return availableMethods;
		}
		
		public function getWSDL(complete:Function):void{
			__parseComplete = complete;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, wsdlLoaded);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, wsdlIOError);
			urlLoader.load(new URLRequest(__wsdlPath))
		}
		
		private function wsdlIOError(e:IOErrorEvent):void 
		{
			dispatchEvent(new EvtWSConnector(EvtWSConnector.IOERROR));
		}
		
		public function set portType(port:String):void{
			__portType = port;
		}
		
		public function get portType():String { return __portType; }
		
		public function get _wsName():String { return __wsName.split("Soap")[0]; }
		
		public function set _wsName(value:String):void 
		{
			__wsName = value;
		}
	}
	
}