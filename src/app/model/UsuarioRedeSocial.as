package app.model
{
	[Bindable]
	[Table(name="USUARIOS_REDES_SOCIAIS")]
	public class UsuarioRedeSocial
	{
		[Id]
		public var id:int;
		
		public var endereco:String;
		
		[ManyToOne(inverse="true")]
		public var usuario:Usuario;
		
		[ManyToOne(inverse="true")]
		public var rede:RedeSocial;
		
		public function UsuarioRedeSocial()
		{
		}
	}
}