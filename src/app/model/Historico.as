package app.model
{
	[Bindable]
	[Table(name="HISTORICOS")]
	public class Historico
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var ativo:Boolean;
		
		public function Historico(){}
	}
}