package app.model
{
	[Bindable]
	[Table(name="REFEICOES")]
	public class Refeicao
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var alimentos:String;
		
		public var quantidades:String;
		
		public function Refeicao()
		{
		}
	}
}