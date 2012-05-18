package app.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[Table(name="REDES_SOCIAIS")]
	public class RedeSocial
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var icone:String;
		
		public var ativo:Boolean;
		
		[OneToMany(type="app.model.UsuarioRedeSocial", cascade="all")]
		public var usuarios:ArrayCollection = new ArrayCollection();
		
		public function RedeSocial(){}
	}
}