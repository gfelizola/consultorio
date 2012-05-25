package app.model
{
	import mx.collections.IList;

	[Bindable]
	[Table(name="PACIENTES")]
	public class Paciente
	{
		[Id]
		public var id:int;
		
		public var nome:String;
		
		public var sobrenome:String;
		
		public var sexo:String;
		
		public var estadoCivil:EstadoCivil;
		
		public var profissao:String;
		
		public var endereco:String;
		
		public var complemento:String;
		
		public var cidade:String;
		
		public var estado:String;
		
		public var CEP:String ;
		
		public var telefone:String;
		
		public var comercial:String;
		
		public var celular:String;
		
		public var email:String;
		
		public var gestante:Boolean;
		
		public var nutriz:Boolean;
		
		public var historico:String;
		
		public var tipo:TipoAtendimento;
		
		public var objetivo:String;
		
		public var indicacao:String;
		
		public var convenio:String ;
		
		public var carteira:String ;
		
		[ManyToOne( cascade="none" )]
		public var usuario:Usuario;
		
		[OneToMany( type="app.model.Consulta", cascade="all", lazy="false" )]
		public var consultas:IList;
		
		[ManyToMany(type="app.model.Patologia", cascade="all")]
		public var patologias:IList;
		
		[ManyToMany(type="app.model.Historico", cascade="all")]
		public var historicos:IList;
		
		[Transient]
		private var _semanaGestacional:Number;
		
		public function get semanaGestacional():Number 
		{
			if( dataUltimaMenstruacao != null )
			{
				var hoje:Date = new Date();
				var mest:Date = dataUltimaMenstruacao ;
				var diferenca:Number = hoje.time - mest.time ;
				
				if (diferenca> 0)
				{
					var seconds:Number = diferenca / 1000;
					var minutes:Number = seconds / 60;
					var hours:Number = minutes / 60;
					var days:Number = Math.floor(hours / 24);
					_semanaGestacional = Math.floor( days / 7 ) ;
				}
				
			} else {
				_semanaGestacional = 0 ;
			}
			
			return _semanaGestacional; 
		}
		public function set semanaGestacional(value:Number):void { _semanaGestacional = value; }
		
		
		/*
		public var dataNascimento:Date;
		
		public var dataUltimaMenstruacao:Date;
		
		public var dataUltimaConsulta:Date;
		*/
		
		private var _dataNascimento:Date;
		
		public function get dataNascimento():Date { return _dataNascimento; }
		public function set dataNascimento(value:*):void { 
			if( value is Date ){
				_dataNascimento = value;
			} else if (value is String) {
				if( value != '' ) _dataNascimento = new Date(value);
			}
		}
		
		private var _dataUltimaMenstruacao:Date;
		
		public function get dataUltimaMenstruacao():Date { return _dataUltimaMenstruacao; }
		public function set dataUltimaMenstruacao(value:*):void { 
			if( value is Date ){
				_dataUltimaMenstruacao = value;
			} else if (value is String) {
				if( value != '' ) _dataUltimaMenstruacao = new Date(value);
			}
		}
		
		private var _dataUltimaConsulta:Date;
		
		public function get dataUltimaConsulta():Date { return _dataUltimaConsulta; }
		public function set dataUltimaConsulta(value:*):void { 
			if( value is Date ){
				_dataUltimaConsulta = value;
			} else if (value is String) {
				if( value != '' ) _dataUltimaConsulta = new Date(value);
			}
		}
		
		[Transient]
		public function get nomeCompleto():String
		{
			return nome + ' ' + sobrenome ;
		}
		
		[Transient]
		public function get idade():Number
		{
			if( dataNascimento ){
				return ( new Date().fullYear ) - dataNascimento.fullYear ;
			} 
			return 0;
		}
		
		public function Paciente(){}
	}
}