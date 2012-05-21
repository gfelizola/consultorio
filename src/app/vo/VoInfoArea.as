package app.vo
{
	import flash.display.MovieClip;
	
	import mx.core.UIComponent;

	public class VoInfoArea
	{
		private var _nome:String;
		
		public function get nome():String { return _nome; }
		public function set nome(value:String):void { _nome = value; }
		
		private var _className:Class;
		
		public function get className():Class { return _className; }
		public function set className(value:Class):void { _className = value; }
		
		private var _usaBg:Boolean;
		
		public function get usaBg():Boolean { return _usaBg; }
		public function set usaBg(value:Boolean):void { _usaBg = value; }
		
		
		private var _areaInstance:UIComponent;
		
		public function get areaInstance():UIComponent { return _areaInstance; }
		public function set areaInstance(value:UIComponent):void { _areaInstance = value; }
		
		public function VoInfoArea( nome:String, className:Class, usaBg:Boolean = true )
		{
			this.nome = nome ;
			this.className = className ;
			this.usaBg = usaBg ;
		}
	}
}