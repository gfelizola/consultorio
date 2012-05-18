package as3.sound 
{
	import com.greensock.TweenMax;
	import flash.display.LoaderInfo;
	
	import flash.events.Event;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class SoundControl
	{
		static private var canal:SoundChannel;
		static private var playingSounds:Dictionary;
		static private var avaliable:Boolean = true ;
		static private var oloaderInfo:LoaderInfo;
		
		public function SoundControl() {}
		
		//{PUBLIC METHODS
		/**
		 * Método para tocar um som
		 * @param	sigla Sigla do som que deve tocar, que pode ser pega no ESons.
		 * @param	vars Objeto com informações para tocar o som
		 */
		static public function PlaySound( sigla:String, vars:* = null ):void 
		{
			if ( ! avaliable ) {
				//trace("SOM INDISPONÍVEL PARA TOCAR:", sigla );
				return ;
			}
			
			var completeVars:SoundControlVars = new SoundControlVars( vars );
			
			if ( completeVars.delay ) 
			{
				if ( completeVars.delay > 0 ) 
				{
					TweenMax.delayedCall( completeVars.delay, InitSound, [ sigla, completeVars ] );
				}
				else
				{
					InitSound( sigla, completeVars );
				}
			} 
			else 
			{
				InitSound( sigla, completeVars );
			}
		}
		
		static public function Dispose():void
		{			
			TweenMax.killDelayedCallsTo(InitSound);
			canal.removeEventListener(Event.SOUND_COMPLETE, complete );
		}
		
		/**
		 * Para de tocar o ultimo som que iniciou.
		 */
		static public function StopLastSound():void
		{
			if ( canal ) {
				canal.stop();
			}
		}
		
		/**
		 * Para de tocar todos os sons que estiverem tocando.
		 */
		static public function StopAllSounds():void 
		{
			for each (var obj:Object in playingSounds) {
				obj.canal.stop();
			}
		}
		
		/**
		 * Para de tocar todos os sons que estiverem tocando e tiverem a sigla fornecida.
		 * @param	sigla
		 */
		static public function StopSoundWithSigla( sigla:String ):void 
		{
			for each (var obj:Object in playingSounds) {
				if ( obj.sigla == sigla ) obj.canal.stop();
			}
		}
		//}
		
		//{ PRIVATE METHODS
		static private function InitSound( sigla:String, vars:* = null ):void
		{
			//PARA O SOM ATUAL QUE ESTIVER TOCANDO
			//if ( canal != null ) canal.stop();
			
			//BUSCA O LINKAGE NA ESTRUTURA
			var RefSom:Class = SoundControl.OloaderInfo.applicationDomain.getDefinition(sigla) as Class ;
			var somAtual:Sound = new RefSom();
			var st:SoundTransform = new SoundTransform();
			
			//SE TIVER FADE, INICIA COM VOLUME ZERO
			if ( vars.withFade ) {
				st.volume = 0 ;
			} else {
				st.volume = vars.volume ;
			}
			
			//TOCAR
			//vars.startAt = 0 ;
			//vars.loops = 0 ;
			canal = somAtual.play( vars.startAt, vars.loops, st );
			
			//SE TIVER FADE, AUMENTA O VOLUME COM TWEEN
			if ( vars.withFade ) TweenMax.to( canal, .5, { volume: vars.volume } );
			
			if ( playingSounds == null ) playingSounds = new Dictionary();
			playingSounds[canal] = { canal:canal, sigla:sigla, funcao: vars.onComplete, params: vars.onCompleteParams } ;
			canal.addEventListener(Event.SOUND_COMPLETE, complete );
		}
		
		static private function complete(e:Event):void 
		{
	
			var info:Object = playingSounds[e.currentTarget] ;
			if ( info.funcao != null ) info.funcao.apply( e.currentTarget, info.params );
			delete playingSounds[e.currentTarget] ;
		}
		
		static public function get OloaderInfo():LoaderInfo 
		{
			return oloaderInfo;
		}
		
		static public function set OloaderInfo(value:LoaderInfo):void 
		{
			oloaderInfo = value;
		}
		//}
	}

}