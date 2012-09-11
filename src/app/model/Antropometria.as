package app.model
{
	import app.enums.EDadosGraficos;
	import app.enums.EIdades;

	[Bindable]
	[Table(name="ANTROPROMETRIAS")]
	public class Antropometria
	{
		[Id]
		public var id:int;
		
		public var peso:Number;
		
		public var pesoPreGestacional:Number;
		
		public var estatura:Number;
		
		public var circunferenciaCintura:Number;
		
		public var circunferenciaQuadril:Number;
		
		public var circunferenciaTriceps:Number;
		
		public var circunferenciaCoxa:Number;
		
		public var circunferenciaPanturrilha:Number;
		
		public var dobraCutaneaBiciptal:Number;
		
		public var dobraCutaneaTriciptal:Number;
		
		public var dobraCutaneaSubescapular:Number;
		
		public var dobraCutaneaAxilarMedia:Number;
		
		public var dobraCutaneaToracica:Number;
		
		public var dobraCutaneaSupraIliaca:Number;
		
		public var dobraCutaneaAbdominal:Number;
		
		public var dobraCutaneaCoxa:Number;
		
		public var dobraCutaneaPanturrilhaMedial:Number;
		
		[Transient]
		private var _imc:Number;
		
		[Transient]
		public function get imc():Number {
			if( ! isNaN(peso) && ! isNaN(estatura) )
			{
				_imc = peso / ( ( estatura / 100 ) * ( estatura / 100 ) );
			}
			
			return _imc; 
		}
		public function set imc(value:Number):void { _imc = value; }
		
		[Transient]
		private var _rcq:Number;
		
		[Transient]
		public function get rcq():Number { 
//			trace("Antropometria.rcq()", circunferenciaCintura, circunferenciaQuadril, circunferenciaCintura / circunferenciaQuadril);
			
			if( ! isNaN(circunferenciaCintura) && ! isNaN(circunferenciaQuadril) )
			{
				if( circunferenciaCintura > 0 && circunferenciaQuadril > 0 ){
					_rcq = circunferenciaCintura / circunferenciaQuadril;
				}
			}
			return _rcq; 
		}
		
		public function set rcq(value:Number):void { _rcq = value; }
		
		
		[Transient]
		public function getCircunferenciaCinturaDescription(paciente:Paciente):String
		{
			if( paciente.gestante ) return '';
			
			if( paciente.sexo == 'M' ){
				if( circunferenciaCintura > 94 ){
					return " > 94 cm - Risco elevado de complicações metabólicas" ;
				} else if( circunferenciaCintura > 102 ){
					return " > 102 cm - Risco muito elevado de complicações metabólicas" ;
				} else {
					return " < 94 cm  - Sem riscos"
				}
			} else {
				if( circunferenciaCintura > 80 ){
					return " > 80 cm - Risco elevado de complicações metabólicas" ;
				} else if( circunferenciaCintura > 88 ){
					return " > 88 cm - Risco muito elevado de complicações metabólicas" ;
				} else {
					return " < 80 cm  - Sem riscos"
				}
			}
			
			return "";
		}
		
		[Transient]
		public function getRCQDescription(paciente:Paciente):String
		{
			if( paciente.gestante ) return '';
			
			if( paciente.sexo == 'M' ){
				if( _rcq > 1 ) return " > 1 - Risco para desenvolvimento de doenças" ;
				else return " < 1 - Sem riscos"
			} else {
				if( _rcq > 0.85 ) return " > 0.85 - Risco para desenvolvimento de doenças." ;
				else return " < 0.85 - Sem riscos"
			}
			
			return "" ;
		}
		
		[Transient]
		public function getIMCDescription(c:Consulta):String
		{
			var imcDescricao:String = '' ;
			var idade:Number = 0;
			var dados:Array;
			var i:int = 0;
			
			if( c.idadeNaConsulta() / 12 >= EIdades.IDOSO ){
				if( imc < 22 ){
					imcDescricao = 'Desnutrição' ;
				} else if( imc >= 22 && imc < 27 ){
					imcDescricao = 'Eutrofia' ;
				} else {
					imcDescricao = 'Obesidade' ;
				}
			} else if( c.idadeNaConsulta() / 12 <= EIdades.CRIANCA ){
				idade = c.idadeNaConsulta() ;
				dados = c.paciente.sexo == 'M' ? EDadosGraficos.CRESCIMENTO_MASCULINO_IMC_IDADE : EDadosGraficos.CRESCIMENTO_FEMININO_IMC_IDADE ;
				
				for (i = 0; i < dados.length; i++) {
					if( dados[i][0] == idade ) {
						var p03:Number = dados[i][2] ; 
						var p15:Number = dados[i][3] ; 
						var p85:Number = dados[i][7] ; 
						var p97:Number = dados[i][8] ;
						
						if( imc < p03 ){
							imcDescricao = 'Baixo peso extremo' ;
						} else if( imc >= p03 && imc < p15 ){
							imcDescricao = 'Baixo peso' ;
						} else if( imc >= p15 && imc < p85 ){
							imcDescricao = 'Eutrofia' ;
						} else if( imc >= p85 && imc < p97 ){
							imcDescricao = 'Sobrepeso' ;
						} else {
							imcDescricao = 'Obesidade' ;
						}
					}
				}
			} else if( c.paciente.gestante ){
				idade = c.semanaGestacional ;
				dados = EDadosGraficos.ATALAH ;
				
				for (i = 0; i < dados.length; i++) {
					if( dados[i][0] == idade ) {
						var fraca:Number = dados[i][1] ; 
						var normal:Number = dados[i][3] ; 
						var sobrepeso:Number = dados[i][5] ; 
						
						if( imc < fraca ){
							imcDescricao = 'Enfraquecida' ;
						} else if( imc >= fraca && imc < normal ){
							imcDescricao = 'Eutrofia' ;
						} else if( imc >= normal && imc < sobrepeso ){
							imcDescricao = 'Sobrepeso' ;
						} else {
							imcDescricao = 'Obesidade' ;
						}
					}
				}
				
			} else {
				if( imc < 18.5 ){
					imcDescricao = 'Baixo Peso' ;
				} else if( imc >= 18.5 && imc < 25 ){
					imcDescricao = 'Adequado ou Eutrófico' ;
				} else if( imc >= 25 && imc < 30 ){
					imcDescricao = 'Sobrepeso' ;
				} else if( imc >= 30 && imc < 35 ){
					imcDescricao = 'Obesidade grau I' ;
				} else if( imc >= 35 && imc < 40 ){
					imcDescricao = 'Obesidade grau II' ;
				} else {
					imcDescricao = 'Obesidade grau III' ;
				}
			}
			
			return imcDescricao ;
		}
		
		
		public function Antropometria(){}
	}
}