package controles.engines 
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public interface IUserControlMotionEngine extends IUserControlEngine
	{
		function getPoint():Point
	}
	
}