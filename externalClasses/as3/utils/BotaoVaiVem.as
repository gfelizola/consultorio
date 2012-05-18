package as3.utils
{
	import com.greensock.TweenMax;
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	
	public dynamic class BotaoVaiVem extends MovieClip
	{
		
		private var mcMain:MovieClip;

		public var ativo:Boolean;
		
		public function BotaoVaiVem ()
		{
			this.gotoAndStop(1)

			var hit:MovieClip = MovieClip(this.getChildByName("hit"));
			
			if(hit==null)
			{
				mcMain = this
			}
			else
			{
				mcMain = hit;				
			}
			
			mcMain.buttonMode = true
			mcMain.addEventListener(MouseEvent.ROLL_OVER, over);
			mcMain.addEventListener(MouseEvent.ROLL_OUT, out);
		}
		
		public function lock(enable:Boolean):void
		{
			ativo = ! enable;
			
			if (!enable)
			{
				TweenMax.to( this, this.totalFrames / this.stage.frameRate , { frame:this.totalFrames } );
				mcMain.removeEventListener(MouseEvent.ROLL_OVER, over);
				mcMain.removeEventListener(MouseEvent.ROLL_OUT, out);
			}
			else
			{
				TweenMax.to( this, this.currentFrame / this.stage.frameRate , { frame:1 } );
				mcMain.addEventListener(MouseEvent.ROLL_OVER, over);
				mcMain.addEventListener(MouseEvent.ROLL_OUT, out);
			}
		}
		
		public function disable():void 
		{
			mcMain.removeEventListener(MouseEvent.ROLL_OVER, over);
			mcMain.removeEventListener(MouseEvent.ROLL_OUT, out);
			mcMain.buttonMode = false ;
		}
		
		
		public function over(event:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME, volta)
			this.addEventListener(Event.ENTER_FRAME, vai)
		}
		
		public function out(event:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME, vai)
			this.addEventListener(Event.ENTER_FRAME, volta)
		}
		
		public function vai(event:Event):void
		{
			this.nextFrame()
			if(this.currentFrame >= this.totalFrames)
			{
				this.removeEventListener(Event.ENTER_FRAME, vai)
			}
		}
		
		public function volta(event:Event):void
		{
			this.prevFrame()
			if(this.currentFrame == 1)
			{
				this.removeEventListener(Event.ENTER_FRAME, volta)
			}
		}
	}
}