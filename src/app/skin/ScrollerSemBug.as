package app.skin
{
	import flash.events.FocusEvent;
	
	import spark.components.Scroller;
	
	public class ScrollerSemBug extends Scroller
	{
		public function ScrollerSemBug()
		{
			super();
			
			this.setStyle('skinClass', app.skin.Scroller);
		}
		
		override protected function focusInHandler(event:FocusEvent):void
		{
			if(focusManager != null) {
				super.focusInHandler(event);
			}
		}
	}
}