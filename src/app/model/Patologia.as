package app.model
{
	[Bindable]
	[Table(name="PATOLOGIAS")]
	public class Patologia
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var ativo:Boolean;
		
		public function Patologia(){}
	}
}