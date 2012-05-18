package app.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[Table(name="ATIVIDADES_FISICAS")]
	public class AtividadeFisica
	{
		public static const MUITO_ATIVO:int = 1 ;
		public static const ATIVO:int = 2 ;
		public static const POUCO_ATIVO:int = 3 ;
		public static const SEDENTARIO:int = 4 ;
		
		[Id]
		public var id:int;
		
		public var nivel:int;
		
		[OneToMany(type="app.model.Atividade", lazy="false", cascade="all")]
		public var atividades:ArrayCollection = new ArrayCollection();
		
		public function AtividadeFisica()
		{
		}
	}
}