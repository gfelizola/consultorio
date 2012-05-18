package app.model
{
	[Bindable]
	[Table(name="TIPO_ATENDIMENTO")]
	public class TipoAtendimento
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var ativo:Boolean;
		
		public function TipoAtendimento(){}
	}
}