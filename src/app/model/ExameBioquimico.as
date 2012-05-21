package app.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[Table(name="EXAMES_BIOQUIMICOS")]
	public class ExameBioquimico
	{
		[Id]
		public var id:int;
		
		public var dataDoExame:Date;
		
		[OneToMany(type="app.model.ExameAdicional", lazy="false", cascade="all")]
		public var exames:ArrayCollection = new ArrayCollection();
		
		public function ExameBioquimico()
		{
		}
	}
}