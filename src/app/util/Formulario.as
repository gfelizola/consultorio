package app.util
{
	import flash.text.TextField;
	
	import mx.controls.TextInput;

	public class Formulario
	{
		private var fields:Array;
		
		public function Formulario()
		{
		}
		
		public function addField( txt:TextField ):void
		{
			if( fields == null ) fields = new Array();
			
			fields.push( txt );
		}
		
		public function create():void
		{
			for (var i:int = 0; i < fields.length; i++) 
			{
				var f:TextField = fields[i] ;
				var txt:TextInput = new TextInput();
				txt.x = f.x ;
				txt.y = f.y ;
				txt.width = f.width ;
				txt.height = f.height ;
				
				f.parent.addChild(txt);
			}
			
		}
	}
}