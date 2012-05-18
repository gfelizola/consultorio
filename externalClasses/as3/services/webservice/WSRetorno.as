package as3.services.webservice 
{
	
	/**
	* ...
	* @author Segundo
	*/
	public class WSRetorno 
	{
		private var retorno:Number;
		private var mensagem:String;
		private var resultado:*;
		
		public function get Retorno():Number { return retorno; }
		
		public function set Retorno(value:Number):void 
		{
			retorno = value;
		}
		
		public function get Mensagem():String { return mensagem; }
		
		public function set Mensagem(value:String):void 
		{
			mensagem = value;
		}
		
		public function get Resultado():* { return resultado; }
		
		public function set Resultado(value:*):void 
		{
			resultado = value;
		}
		
		public function toString():String 
		{
			var str:String = "::: WSRETORNO ::: \nRetorno:" + retorno +"\nResultado:"+ resultado+ "\nMensagem:" + mensagem;
			return str;
		}
	}
}