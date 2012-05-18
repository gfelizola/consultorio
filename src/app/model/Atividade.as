package app.model
{
	[Bindable]
	[Table(name="ATIVIDADES")]
	public class Atividade
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var dias:String;
		
		public var horario:String;
		
		public function Atividade()
		{
		}
	}
}