package app.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[Table(name="EXAMES_BIOQUIMICOS")]
	public class ExameBioquimico
	{
		[Id]
		public var id:int;
		
		private var _dataDoExame:Date;
		public function get dataDoExame():Date { return _dataDoExame; }
		public function set dataDoExame(value:*):void { 
			if( value is Date ){
				_dataDoExame = value;
			} else if (value is String) {
				if( value != '' ) _dataDoExame = new Date(value);
			}
		}
		
		[OneToMany(type="app.model.ExameAdicional", lazy="false", cascade="all")]
		public var exames:ArrayCollection = new ArrayCollection();
		
		public function ExameBioquimico()
		{
		}
	}
}