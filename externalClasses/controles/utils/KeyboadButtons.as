package controles.utils 
{
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class KeyboadButtons 
	{
		public static const DEFAULTS:Object 	= { up: Keyboard.UP,	 	down:Keyboard.DOWN, 	left:Keyboard.LEFT, 	right:Keyboard.RIGHT 	} ;
		public static const WASD:Object 		= { up:87, 					down:83, 				left:65, 				right:68 				} ;
		public static const NUMPAD:Object 		= { up:Keyboard.NUMPAD_8, 	down:Keyboard.NUMPAD_2, left:Keyboard.NUMPAD_4, right:Keyboard.NUMPAD_6	} ;
		
	}

}