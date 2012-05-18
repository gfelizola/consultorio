package as3.sound 
{
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class SoundControlVars
	{
		private var propertiesNames:Array = ["withFade", "delay", "startAt", "loops", "onComplete", "onCompleteParams", "volume"] ;
		
		/**
		 * Inicia o som com um fade no volume de 0 para 1
		 */
		private var _withFade:Boolean = false ;
		
		/**
		 * Volume do som. Se iniciar com fade, será o volume final
		 */
		private var _volume:Number = 1;
		
		/**
		 * Tempo de espera para iniciar o som
		 */
		private var _delay:Number = 0 ;
		
		/**
		 * Tempo em milisegundos que o som deve iniciar
		 */
		private var _startAt:Number = 0 ;
		
		/**
		 * Quantas vezes o som pode repetir
		 */
		private var _loops:Number = 0 ;
		
		/**
		 * Função chamada quando o som acabar
		 */
		private var _onComplete:Function;
		
		/**
		 * Parâmetros da função chamadao quando o som acabar
		 */
		private var _onCompleteParams:Array;
		
		
		public function SoundControlVars( vars:* = null ) {
			if ( vars != null ) {
				copyFrom( vars );
			}
		}
		
		public function copyFrom( vars:* ):void 
		{
			var i:int = 0 ;
			var t:int = propertiesNames.length ;
			for ( i = 0 ; i < t; i++) 
			{
				if ( vars[propertiesNames[i]] != null ) {
					this[propertiesNames[i]] = vars[propertiesNames[i]] ;
				}
			}
		}
		
		public function get withFade():Boolean { return _withFade; }
		public function set withFade(value:Boolean):void 
		{
			_withFade = value;
		}
		
		public function get volume():Number { return _volume; }
		public function set volume(value:Number):void 
		{
			_volume = value;
		}
		
		public function get delay():Number { return _delay; }
		public function set delay(value:Number):void 
		{
			_delay = value;
		}
		
		public function get startAt():Number { return _startAt; }
		public function set startAt(value:Number):void 
		{
			_startAt = value;
		}
		
		public function get loops():Number { return _loops; }
		public function set loops(value:Number):void 
		{
			_loops = value;
		}
		
		public function get onComplete():Function { return _onComplete; }
		public function set onComplete(value:Function):void 
		{
			_onComplete = value;
		}
		
		public function get onCompleteParams():Array { return _onCompleteParams; }
		public function set onCompleteParams(value:Array):void 
		{
			_onCompleteParams = value;
		}
	}

}