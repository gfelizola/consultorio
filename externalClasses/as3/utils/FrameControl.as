package as3.utils
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class FrameControl 
	{
		private var target:MovieClip;
		private var sentido:Number;
		private var destino:uint;
		private var delay:uint;
		private var fncCall:Function;
		private var args:Array;
		
		public function FrameControl(target:MovieClip, sentido:Number, destino:uint, fncCall:Function = null, delay:uint=uint.MIN_VALUE , ...arguments) 
		{
			//Obter dados.
			this.target = target
			this.sentido = sentido
			this.destino = destino
			this.fncCall = fncCall;
			this.delay = delay;
			this.args  = arguments;
			this.target.addEventListener(Event.ENTER_FRAME, controlador);
		}
		
		public function stop():void
		{
			if(this.target.hasEventListener(Event.ENTER_FRAME))
				this.target.removeEventListener(Event.ENTER_FRAME , controlador);
		}
		
		//Metodo Controlador
		public function controlador(event:Event):void
		{
			if (this.sentido > 0)
			{
				event.currentTarget.gotoAndStop(event.currentTarget.currentFrame + this.sentido);
				if (event.currentTarget.currentFrame == this.destino)
				{
					event.currentTarget.removeEventListener(Event.ENTER_FRAME, controlador);
					fncCallBack();
				}
				if (this.delay != 0)
				{
					if (event.currentTarget.currentFrame == this.destino - this.delay)
					{
						event.currentTarget.removeEventListener(Event.ENTER_FRAME, controlador);
						fncCallBack();
					}
				}
			}
			else if (this.sentido < 0)
			{
				event.currentTarget.gotoAndStop(event.currentTarget.currentFrame + this.sentido);
				if (event.currentTarget.currentFrame <= this.destino)
				{
					event.currentTarget.removeEventListener(Event.ENTER_FRAME, controlador);
					fncCallBack();
				}
				if (this.delay != 0)
				{
					if (event.currentTarget.currentFrame <= this.delay)
					{
						event.currentTarget.removeEventListener(Event.ENTER_FRAME, controlador);
						fncCallBack();
					}
				}
			}
		}
		
		//Metodo CallBack
		public function fncCallBack():void
		{
			if (this.fncCall != null)
			{
				this.fncCall.apply(this , this.args);
			}
		}
	}
	
}