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
		
		[ManyToOne( cascade="none" )]
		public var paciente:Paciente;

		public var dataConsulta:Date;
		
		public var antropometria:Antropometria;
		
		public var man:MAN;
		
		public var dadosAlimentares:DadosAlimentares;
		
		public var atividadeFisica:AtividadeFisica;
		
		public var exameBioquimico:ExameBioquimico;
		
		public var resumo:ResumoConsulta;
		
		public var observacao:String;
		
		public var semanaGestacional:Number;
		
		public function setSemanaGestacional():void { 
			
			semanaGestacional = 0 ;
			
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
		
		public function setResumo():void
		{
			resumo = new ResumoConsulta();
			
			if( paciente ){
				var tmb:Number = 0 ;
				var eer:Number = 0 ;
				var eerg:Number = 0 ;
				var coeficiente:Number = 0 ;
				var idade:Number = idadeNaConsulta() / 12 ;
				
				if( antropometria ){
					if( paciente.sexo == 'M' ) {
						tmb = 66.47 + (13.75 * antropometria.peso ) + ( 5 * antropometria.estatura ) - ( 6,76 * idade ) ;
					} else {
						tmb = 655.1 + (9.56 * antropometria.peso ) + ( 1.85 * antropometria.estatura ) - ( 4.68 * idade );
					}
					
					resumo.metabolismoBasal = tmb ;
					
					if( atividadeFisica ){
						if( paciente.sexo == 'M' )
						{
							switch(atividadeFisica.nivel)
							{
								case AtividadeFisica.MUITO_ATIVO: 	coeficiente = 1.48 ;  	break;
								case AtividadeFisica.ATIVO:  		coeficiente = 1.25 ;  	break;
								case AtividadeFisica.POUCO_ATIVO:  	coeficiente = 1.11 ;   	break;
								case AtividadeFisica.SEDENTARIO: 	coeficiente = 1 ;   	break;
							}
							
							eer = 662 - ( 9.53 * idade ) ;
							eer += ( coeficiente * (15.91 * antropometria.peso ) ) ;
							eer -= ( 539.6 * ( antropometria.estatura / 100 ) ) ;
							
						} else {
							switch(atividadeFisica.nivel)
							{
								case AtividadeFisica.MUITO_ATIVO: 	coeficiente = 1.45 ;  	break;
								case AtividadeFisica.ATIVO: 		coeficiente = 1.27 ;  	break;
								case AtividadeFisica.POUCO_ATIVO: 	coeficiente = 1.12 ;  	break;
								case AtividadeFisica.SEDENTARIO: 	coeficiente = 1 ;  		break;
							}
							
							eer = 354 - ( 6.91 * idade ) + coeficiente * ( (9.36 * antropometria.peso ) + ( 726 * ( antropometria.estatura / 100 ) ) ) ;
							
							if( paciente.gestante ){
								setSemanaGestacional();
								if( semanaGestacional > 12 ) {
									eerg += eer + ( 8 * semanaGestacional ) + 180 ;
								} else {
									eerg = eer ;
								}
							}
						}
						resumo.necessidadeEnergetica = eer ;
						resumo.necessidadeEnergeticaGestacional = eerg ;
					}
				}
			}
		}
		
		[Transient]
		public function idadeNaConsulta():Number
		{
			var idade:Number = 0;
			
			if( paciente ){
				var diasDeIdade:Number = TimeSpan.fromDates(paciente.dataNascimento, dataConsulta).totalDays;
				var meses:Number = diasDeIdade / 365 * 12 ;
				idade = Math.round( meses );
			}
			
			return idade ;
		}
		
		public function Consulta(){
			this.id = 0 ;
		}
	}
}