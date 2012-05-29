package app.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	[Table(name="USUARIOS")]
	public class Usuario
	{
		
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var sobrenome:String;
		
		public var login:String;
		
		public var senha:String;
		
		public var sexo:String;
		
		public var CRN:String;
		
		public var regional:String;
		
		public var endereco:String;
		
		public var complemento:String;
		
		public var bairro:String;
		
		public var cidade:String;
		
		public var estado:String;
		
		public var CEP:String;
		
		public var telefone:String;
		
		public var logo:String;
		
		public var site:String;
		
		public var email:String;
		
		[OneToMany(type="app.model.UsuarioRedeSocial", cascade="all")]
		public var redesSociais:ArrayCollection = new ArrayCollection();
		
		public function Usuario(){
			this.id = 0 ;
		}
		
	}
}