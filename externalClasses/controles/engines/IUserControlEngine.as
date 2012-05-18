package controles.engines 
{
	import controles.UserControls;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public interface IUserControlEngine extends IEventDispatcher
	{
		function init():void 
		function stop():void 
		
		function get control():UserControls
	}
	
}