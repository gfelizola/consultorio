package app.model
{
	[Bindable]
	[Table(name="CONSULTAS")]
	public class Consulta
	{
		[Id]
		public var id:int;
		
		[ManyToOne( cascade="none" )]
		public var paciente:Paciente;

		public var dataConsulta:Date;
		
		public var antropometria:Antropometria;
		
		public var man:MAN;
		
		public var dadosAlimentares:DadosAlimentares;
		
		public var atividadeFisica:AtividadeFisica;
		
		public var exameBioquimico:ExameBioquimico;
		
		public var observacao:String;
		
		public function Consulta(){}
	}
}