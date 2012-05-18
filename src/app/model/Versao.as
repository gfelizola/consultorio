package app.model
{
	[Bindable]
	[Table(name="VERSOES")]
	public class Versao
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var dataAtualizacao:Date;
		
		public function Versao()
		{
		}
	}
}