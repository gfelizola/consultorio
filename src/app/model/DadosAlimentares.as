package app.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[Table(name="DADOS_ALIMENTARES")]
	public class DadosAlimentares
	{
		[Id]
		public var id:int;
		
		public var qtdeAgua:String;
		
		public var funcionamentoIntestinal:String;
		
		public var preferenciasAlimentares:String;
		
		public var aversoesAlimentares:String;
		
		public var observacoes:String;
		
		[OneToMany(type="app.model.Refeicao", lazy="false", cascade="all")]
		public var refeicoes:ArrayCollection = new ArrayCollection();
		
		public function DadosAlimentares()
		{
		}
	}
}