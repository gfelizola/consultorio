package app.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	
	import spark.components.Scroller;

	public class ScrollUtil
	{
		// this method is specifically written for the Scroller component
		// to use this on other scroller components will need modification or
		// another method
		public static function autoScroll(event:FocusEvent):void
		{
			var scroller:Scroller = event.currentTarget as Scroller;
			
			if( scroller.focusManager != null ){
				var focusItem:DisplayObject = DisplayObject(scroller.focusManager.getFocus());
				
				if (scroller.verticalScrollBar && focusItem)
				{
					if (focusItem == scroller || !scroller.contains(focusItem))
					{
						return;
					}
					ensureFocusItemIsVisible(focusItem, scroller);
				}
			}
		}
		
		public static function ensureFocusItemIsVisible(focusItem:DisplayObject, scroller:Scroller):void
		{
			var focusTopEdge:int = focusItem.y;
			var thisItem:DisplayObjectContainer = focusItem.parent;
			
			while (thisItem != scroller)
			{
				focusTopEdge += thisItem.y;
				thisItem = thisItem.parent;
			}
			
			var focusBottomEdge:int = focusTopEdge + focusItem.height;
			var scrollbarRange:int = scroller.verticalScrollBar.maxHeight;
			var visibleWindowHeight:int = scroller.height;
			var firstVisibleY:int = scroller.viewport.verticalScrollPosition;
			var lastVisibleY:int = visibleWindowHeight + scroller.viewport.verticalScrollPosition;
			var newPos:int;
			
			if (scroller.horizontalScrollBar)
			{
				// remove the horiz scrollbar height from lastVisibleY
				lastVisibleY -= scroller.horizontalScrollBar.height;
			}
			
			if (focusTopEdge == scroller.viewport.verticalScrollPosition)
			{
//				trace("Bar not moved, already at top edge of focus item.");
			}
			else if (focusTopEdge > lastVisibleY)
			{
				newPos = Math.min(scrollbarRange, scroller.viewport.verticalScrollPosition + (focusBottomEdge - lastVisibleY));
				scroller.viewport.verticalScrollPosition = newPos + 20;
//				trace("Moved bar down to " + newPos);
			}
			else if (focusTopEdge < firstVisibleY)
			{
				scroller.viewport.verticalScrollPosition = focusTopEdge;
//				trace("Moved bar up to " + focusTopEdge);
			}
			else
			{
//				trace("Bar not moved.");
			}
		}
	}
}