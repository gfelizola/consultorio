package app.skin
{
	import app.util.ScrollUtil;
	
	import flash.events.FocusEvent;
	
	import spark.components.Scroller;
	import spark.skins.spark.ScrollerSkin;
	
	public class ScrollerSemBug extends Scroller
	{
		public function ScrollerSemBug()
		{
			super();
			
			this.setStyle('skinClass', spark.skins.spark.ScrollerSkin);
		}
		
		override protected function focusInHandler(event:FocusEvent):void
		{
			if(focusManager != null) {
				super.focusInHandler(event);
			}
			
			ScrollUtil.autoScroll(event)
		}
	}
}