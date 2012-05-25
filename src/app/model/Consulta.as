package app.model
{
	import app.util.General;
	import app.util.TimeSpan;

	[Bindable]
	[Table(name="CONSULTAS")]
	public class Consulta
	{
		[Id]
		public var id:int;
		
		[ManyToOne( cascade="none", inverse="true" )]
		public var paciente:Paciente;

		public var dataConsulta:Date;
		
		public var antropometria:Antropometria;
		
		public var man:MAN;
		
		public var dadosAlimentares:DadosAlimentares;
		
		public var atividadeFisica:AtividadeFisica;
		
		public var exameBioquimico:ExameBioquimico;
		
		public var observacao:String;
		
		public var semanaGestacional:Number;
		
		public function setSemanaGestacional():void { 
			if( paciente ){
				if( paciente.dataUltimaMenstruacao != null )
				{
					var hoje:Date = new Date();
					var mest:Date = paciente.dataUltimaMenstruacao ;
					var diferenca:Number = hoje.time - mest.time ;
					
					if (diferenca> 0)
					{
						var seconds:Number = diferenca / 1000;
						var minutes:Number = seconds / 60;
						var hours:Number = minutes / 60;
						var days:Number = Math.floor(hours / 24);
						semanaGestacional = Math.floor( days / 7 ) ;
					}
				}
			}
		}
		
		[Transient]
		public function idadeNaConsulta():Number
		{
			var idade:Number;
			
			if( paciente ){
				var diasDeIdade:Number = TimeSpan.fromDates(paciente.dataNascimento, dataConsulta).totalDays;
				var meses:Number = diasDeIdade / 365 * 12 ;
				idade = Math.round( meses );
			}
			
			return idade ;
		}
		
		public function Consulta(){}
	}
}