package app.model
{
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
		public function getCircunferenciaCinturaDescription(sexo:String):String
		{
			if( sexo == 'M' ){
				return "[Homem > 94 cm (elevado)\n> 102 cm (muito elevado)]" ;
			} else {
				return "[Mulher > 80 cm (elevado)\n> 88 cm (muito elevado)]" ;
			}
		}
		
		[Transient]
		public function getRCQDescription(sexo:String):String
		{
			if( sexo == 'M' ){
				return "RCQ > 1 para homens" ;
			} else {
				return "RCQ > 0,85 para mulheres" ;
			}
		}
		
		[Transient]
		public function getIMCDescription():String
		{
			var imcDescricao:String = '' ;
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
			
			return imcDescricao ;
		}
		
		
		public function Antropometria(){}
	}
}