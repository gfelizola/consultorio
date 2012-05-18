package as3.utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Luiz Segundo
	 */
	public class OnMovieClipStop
	{
		private var mcTarg:MovieClip;
		private var fFunction:Function;
		private var arrargs:Array;
		private var currentframe:uint = 0;
		
		public function OnMovieClipStop(pMcTarg:MovieClip , pFFunction:Function , autoPlay:Boolean = true , ...arguments)
		{
			mcTarg    = pMcTarg;
			fFunction = pFFunction;
			arrargs   = arguments;
			
			if (autoPlay)
				Play();
		}
		
		public function Play():void
		{
			mcTarg.play();
			try 
			{
				CreateEvent();
			}
			catch (err:Error)
			{
				trace("OnMovieClipStop Error",mcTarg.name,MovieClip(mcTarg.parent).name, err.getStackTrace());
			}
			
		}
		
		/**
		 * 
		 * @param	frame - Number or Label
		 */
		public function GotoAndPlay(frame:*):void
		{
			mcTarg.gotoAndPlay(frame);
			try 
			{
				CreateEvent();
			}
			catch (err:Error)
			{
				trace("OnMovieClipStop Error",mcTarg.name,MovieClip(mcTarg.parent).name, err.getStackTrace());
			}

		}
		
		/**
		 * 
		 * @param	frame - Number or Label
		 */
		public function GotoAndStop(frame:*):void
		{
			mcTarg.gotoAndStop(frame);
			try 
			{
				CreateEvent();
			}
			catch (err:Error)
			{
				trace("OnMovieClipStop Error",mcTarg.name,MovieClip(mcTarg.parent).name, err.getStackTrace());
			}

		}
		
		private function CreateEvent():void
		{
			if (!mcTarg.hasEventListener(Event.ENTER_FRAME))
			{
				mcTarg.addEventListener(Event.ENTER_FRAME , VerifyStop);
			}
			else
			{
				throw new Error("OnMovieClipStop : Já existe um processo em andamento para este MovieClip")
			}
		}
		
		private function VerifyStop(e:Event):void
		{
			if (mcTarg.currentFrame == currentframe)
			{
				if (mcTarg.hasEventListener(Event.ENTER_FRAME))
				{
					mcTarg.removeEventListener(Event.ENTER_FRAME , VerifyStop);
					fFunction.apply(null , arrargs);
				}
			}
			currentframe = mcTarg.currentFrame;
		}
	}
}