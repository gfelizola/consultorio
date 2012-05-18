package controles.utils 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class DirectionsPoint extends Point 
	{
		public var nome:String = "" ;
		
		public function DirectionsPoint( x:Number, y:Number, nome:String ) 
		{
			super( x, y );
			this.nome = nome ;
		}
		
	}

}