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
		
		[OneToMany(type="app.model.Exame", lazy="false", cascade="all")]
		public var atividades:ArrayCollection = new ArrayCollection();
		
		public function ExameBioquimico()
		{
		}
	}
}