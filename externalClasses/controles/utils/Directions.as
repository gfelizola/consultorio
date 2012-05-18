package controles.utils 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class Directions 
	{
		public static const NORTH:DirectionsPoint 		= new DirectionsPoint(  0, -1, "norte" );
		public static const NORTHEAST:DirectionsPoint 	= new DirectionsPoint(  1, -1, "nordeste" );
		public static const EAST:DirectionsPoint 		= new DirectionsPoint(  1,  0, "leste" );
		public static const SOUTHEAST:DirectionsPoint 	= new DirectionsPoint(  1,  1, "sudeste" );
		public static const SOUTH:DirectionsPoint 		= new DirectionsPoint(  0,  1, "sul" );
		public static const SOUTHWEST:DirectionsPoint 	= new DirectionsPoint( -1,  1, "sudoeste" );
		public static const WEST:DirectionsPoint 		= new DirectionsPoint( -1,  0, "oeste" );
		public static const NORTHWEST:DirectionsPoint 	= new DirectionsPoint( -1, -1, "noroeste" );
		public static const CENTER:DirectionsPoint 		= new DirectionsPoint(  0,  0, "centro" );
	}

}