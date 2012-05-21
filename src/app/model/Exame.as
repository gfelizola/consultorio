package app.model
{
	[Bindable]
	[Table(name="EXAMES")]
	public class Exame
	{
		[Id]
		public var id:int;
		
		public var slug:String;
		
		public var nome:String;
		
		public var referencia:String;
		
		public var ativo:Boolean;
		
		public function Exame()
		{
		}
	}
}