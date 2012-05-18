package app.model
{
	[Bindable]
	[Table(name="ESTADO_CIVIL")]
	public class EstadoCivil
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var ativo:Boolean;
		
		public function EstadoCivil(){}
	}
}