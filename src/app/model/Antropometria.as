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
		
		
		public function Antropometria(){}
	}
}