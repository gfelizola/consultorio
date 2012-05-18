package controles.utils 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class Oposities 
	{
		/*
		public static const NORTH:Array 		= [ Directions.EAST, 		Directions.SOUTHEAST, 	Directions.SOUTH, 		Directions.SOUTHWEST, 	Directions.WEST 		] ;
		public static const NORTHEAST:Array 	= [ Directions.SOUTHEAST, 	Directions.SOUTH, 		Directions.SOUTHWEST, 	Directions.WEST, 		Directions.NORTHWEST 	] ;
		public static const EAST:Array 			= [ Directions.SOUTH, 		Directions.SOUTHWEST, 	Directions.WEST, 		Directions.NORTHWEST, 	Directions.NORTH 		] ;
		public static const SOUTHEAST:Array 	= [ Directions.SOUTHWEST, 	Directions.WEST, 		Directions.NORTHWEST, 	Directions.NORTH, 		Directions.NORTHEAST 	] ;
		public static const SOUTH:Array 		= [ Directions.WEST, 		Directions.NORTHWEST, 	Directions.NORTH, 		Directions.NORTHEAST,	Directions.EAST		 	] ;
		public static const SOUTHWEST:Array 	= [ Directions.NORTHWEST, 	Directions.NORTH, 		Directions.NORTHEAST, 	Directions.EAST, 		Directions.SOUTHEAST 	] ;
		public static const WEST:Array 			= [ Directions.NORTH, 		Directions.NORTHEAST, 	Directions.EAST, 		Directions.SOUTHEAST, 	Directions.SOUTH 		] ;
		public static const NORTHWEST:Array 	= [ Directions.NORTHEAST, 	Directions.EAST, 		Directions.SOUTHEAST, 	Directions.SOUTH, 		Directions.SOUTHWEST 	] ;
		*/
		
		public static const NORTH:Array 		= [ Directions.SOUTHEAST, 	Directions.SOUTH, 		Directions.SOUTHWEST	] ;
		public static const NORTHEAST:Array 	= [ Directions.SOUTH, 		Directions.SOUTHWEST, 	Directions.WEST 		] ;
		public static const EAST:Array 			= [ Directions.SOUTHWEST, 	Directions.WEST, 		Directions.NORTHWEST	] ;
		public static const SOUTHEAST:Array 	= [ Directions.WEST, 		Directions.NORTHWEST, 	Directions.NORTH 		] ;
		public static const SOUTH:Array 		= [ Directions.NORTHWEST, 	Directions.NORTH, 		Directions.NORTHEAST	] ;
		public static const SOUTHWEST:Array 	= [ Directions.NORTH, 		Directions.NORTHEAST, 	Directions.EAST			] ;
		public static const WEST:Array 			= [ Directions.NORTHEAST, 	Directions.EAST, 		Directions.SOUTHEAST	] ;
		public static const NORTHWEST:Array 	= [ Directions.EAST, 		Directions.SOUTHEAST, 	Directions.SOUTH		] ;
		
		public static function GetOposities( direction:DirectionsPoint ):Array 
		{
			var oposities:Array ;
			var directions:Array = [ 'NORTH', 'NORTHEAST', 'EAST', 'SOUTHEAST', 'SOUTH', 'SOUTHWEST', 'WEST', 'NORTHWEST' ] ;
			var i:int = 0 ;
			var iT:int = directions.length ;
			for (i; i < iT; i++) 
			{
				if( direction == Directions[ directions[i] ] ) oposities = Oposities[ directions[i] ] ;
			}
			
			return oposities ;
		}
		
		public static function IsOposite( point1:DirectionsPoint, point2:DirectionsPoint ):Boolean 
		{
			var retorno:Boolean = false ;
			var opostos:Array = Oposities.GetOposities( point1 );
			
			if ( opostos == null ) return false ;
			
			var j:int = 0 ;
			var jT:int = opostos.length ;
			for (j; j < jT; j++) 
			{
				if ( point2 == opostos[j] ) retorno = true ;
			}
			
			return retorno ;
		}
		
	}

}