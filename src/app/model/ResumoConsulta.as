package app.model
{
	[Bindable]
	[Table(name="RESUMOS")]
	public class ResumoConsulta
	{
		[Id]
		public var id:int;
		
		public var idade:Number;
		
		public var semanaGestacional:Number;
		
		public var metabolismoBasal:Number;
		
		public var necessidadeEnergetica:Number;
		
		public function ResumoConsulta()
		{
		}
	}
}