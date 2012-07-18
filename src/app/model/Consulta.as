package app.model
{
	import app.enums.EIdades;
	import app.util.General;
	import app.util.Helpers;
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
		
		public var recomendacoes:String;
		
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
				
				if( paciente.gestante ) setSemanaGestacional();
				
				if( antropometria ){
					resumo.metabolismoBasal = getTMB() ;
					
					if( atividadeFisica ){
						eer = getEER();
						
						if( paciente.sexo == 'F' ){
							if( paciente.gestante ){
								if( semanaGestacional > 12 ) {
									eerg += eer + ( 8 * semanaGestacional ) + 180 ;
								} else {
									eerg = eer ;
								}
							} else if( paciente.nutriz ) {
								if (paciente.idadeBebe <= 6) { // 1o semestre: EER = EER + 500 – 170 (Energia da secreção do leite – perda de peso)
									eer = eer + 500 - 170;
								} else if (paciente.idadeBebe <= 12) { // 2o semestre: EER = EER + 400 – 0 (Energia da secreção do leite – perda de peso)
									eer = eer + 400;
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
			if( paciente ) idade = Helpers.idade(paciente.dataNascimento, dataConsulta);
			return idade ;
		}
		
		public function Consulta(){
			this.id = 0 ;
		}
		
		private function getTMB():Number
		{
			var idade:Number = Math.floor( idadeNaConsulta() / 12 );
			var tmb:Number = 0 ;
			var formula:String = '' ;
			
			if( paciente.sexo == 'M' ) {
				formula = '66.47 + (13.75 * ' + antropometria.peso + ' ) + ( 5 * ' + antropometria.estatura + ' ) - ( 6.76 * ' + idade + ' )' ;
				tmb = 66.47 + (13.75 * antropometria.peso ) + ( 5 * antropometria.estatura ) - ( 6.76 * idade );
			} else {
				formula = '655.1 + (9.56 * ' + antropometria.peso + ' ) + ( 1.85 * ' + antropometria.estatura + ' ) - ( 4.68 * ' + idade + ' )';
				tmb = 655.1 + (9.56 * antropometria.peso ) + ( 1.85 * antropometria.estatura ) - ( 4.68 * idade );
			}
			
			trace("Consulta.getTMB()", paciente.sexo, idade, tmb, formula);
			
			return tmb ;
		}
		
		private function getEER():Number
		{
			var eer:Number = 0 ;
			var idade:Number = idadeNaConsulta() ;
			var anos:Number = Math.floor( idade / 12 );
			var formula:String = '' ;
			
			//FORMULAS HOMEM
			//88,5 –(61,9 x idade [anos]) + PA x(26,7 x peso [kg] + 903 x altura[m]) + 20 kcal -> 3 >= anos <= 8
			//88,5 –(61.9 x idade [anos]) + PA x(26,7 x peso [kg] + 903 x altura[m]) + 25 kcal -> 9 >= anos <= 18
			//662 –(9,53 x idade [anos]) + PA x (15,91 x peso [kg] + 539,6 x altura [m]) -> 19 >= anos <= 59
			//662 –(9,53 x idade [anos]) + PA x (15,91 x peso [kg] + 539,6 x altura [m]) -> anos >= 60
			
			//FORMULAS MULHER
			//135,3 –(30,8 x idade [anos]) + PA x(10,0 x peso [kg] + 934 x altura[m]) + 20 kcal -> 3 >= anos <= 8
			//135,3 –(30,8 x idade [anos]) + PA ×(10,0 x peso [kg] + 934 x altura [m]) + 25 kcal -> 9 >= anos <= 18
			//354 –(6,91 x idade [anos]) + PA x (9,36 x peso [kg] + 726 x altura [m]) -> 19 >= anos <= 59
			//354 –(6,91 x idade [anos]) + PA x (9,36 x peso [kg] + 726 x altura [m]) -> anos >= 60
			
			if( idade <= 35 ){
				if( idade <= 3 ){
					eer = (89 * antropometria.peso - 100) + 175 ;
				} else if( idade > 3 && idade <= 6 ){
					eer = (89 * antropometria.peso - 100) + 56 ;
				} else if( idade > 6 && idade <= 12 ){
					eer = (89 * antropometria.peso - 100) + 22 ;
				} else {
					eer = (89 * antropometria.peso - 100) + 20 ;
				}
			} else {
				var coeficiente:Number = getEERCoeficiente();
				if( paciente.sexo == 'M' ){
					if( anos < EIdades.CRIANCA ){
						formula = '( 88.5 - ( 61.9 * ' + anos + ' ) + ( ' + coeficiente + ' * ( ( 26.7 * ' + antropometria.peso + ' ) + ( 903 * ( ' + antropometria.estatura + ' / 100 ) ) ) ) ) + ';
						eer = ( 88.5 - ( 61.9 * anos ) + ( coeficiente * ( ( 26.7 * antropometria.peso ) + ( 903 * ( antropometria.estatura / 100 ) ) ) ) ) ;
						formula += anos <= 8 ? '20' : '25' ;
						eer += anos <= 8 ? 20 : 25 ;
					} else {
						formula = '( 662 - ( 9.53 * ' + anos + ' ) + ( + ' + coeficiente + ' * ( ( 15.91 * ' + antropometria.peso + ' ) + ( 539.6 * ( ' + antropometria.estatura + ' / 100 ) ) ) ) )';
						eer = ( 662 - ( 9.53 * anos ) + ( coeficiente * ( ( 15.91 * antropometria.peso ) + ( 539.6 * ( antropometria.estatura / 100 ) ) ) ) );
					}
				} else {
					if( anos < EIdades.CRIANCA ){
						formula = '( 135.3 - ( 30.8 * ' + anos + ' ) + ' + coeficiente + ' * ( ( 10 * ' + antropometria.peso + ' ) + ( 934 * ( ' + antropometria.estatura + ' / 100 ) ) ) ) + ';
						eer = ( 135.3 - ( 30.8 * anos ) + coeficiente * ( ( 10 * antropometria.peso ) + ( 934 * ( antropometria.estatura / 100 ) ) ) ) ;
						formula += anos <= 8 ? '20' : '25' ;
						eer += anos <= 8 ? 20 : 25 ;
					} else {
						//eer = 354 - ( 6.91 * anos ) + coeficiente * ( (9.36 * antropometria.peso ) + ( 726 * ( antropometria.estatura / 100 ) ) ) ;
						formula = '354 - (6.91 * ' + anos + ') + ' + coeficiente + ' * (9.36 * ' + antropometria.peso + ' + 726 * ( ' + antropometria.estatura + ' / 100 ) ) ;' ;
						eer = 354 - (6.91 * anos) + coeficiente * (9.36 * antropometria.peso + 726 * ( antropometria.estatura / 100 ) ) ;
					}
				}
			}
			
			trace("Consulta.getEER()", paciente.sexo, idade, anos, coeficiente, eer, formula );
			
			
			
			return eer ;
		}
		
		private function getEERCoeficiente():Number
		{
			var coeficiente:Number = 0 ;
			var idade:Number = Math.floor( idadeNaConsulta() / 12 );
			
			//[ sedentario, pouco ativo, ativo, muito ativo ]
			
			var coeficientesM03a18:Array = [ 1, 1.13, 1.26, 1.42 ]; //-> M && anos <= 18 
			var coeficientesM19:Array 	 = [ 1, 1.11, 1.25, 1.48 ]; //-> M && anos >= 19
			
			var coeficientesF03a18:Array = [ 1, 1.16, 1.31, 1.56 ]; //-> F && anos <= 18
			var coeficientesF19:Array 	 = [ 1, 1.12, 1.27, 1.45 ]; //-> F && anos >= 19
			
			var coeficientesDict:Array = [];
			coeficientesDict['coeficientesM03a18'] = coeficientesM03a18 ;
			coeficientesDict['coeficientesM19'] = coeficientesM19 ;
			coeficientesDict['coeficientesF03a18'] = coeficientesF03a18 ;
			coeficientesDict['coeficientesF19'] = coeficientesF19 ;
			
			if( idade >= 3 && idade <= 18 ){
				coeficiente = coeficientesDict['coeficientes' + paciente.sexo + '03a18'][ 5 - atividadeFisica.nivel - 1];
			} else {
				coeficiente = coeficientesDict['coeficientes' + paciente.sexo + '19'][ 5 - atividadeFisica.nivel - 1];
			}
			
			return coeficiente;
		}
	}
}