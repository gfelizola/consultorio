package app.model
{
	[Bindable]
	[Table(name="EXAMES_ADICIONAIS")]
	public class ExameAdicional
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var referencia:String;
		
		public var valor:String;
		
		public var exame:Exame;
		
		public function ExameAdicional()
		{
		}
	}
}