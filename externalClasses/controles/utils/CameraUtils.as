package controles.utils 
{
	import flash.media.Camera;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class CameraUtils 
	{
		private static var camRef:Camera = null ;
		
		public static function getCamera():Camera 
		{
			if ( camRef != null ) return camRef ;
			
			var MAC_CAMERA:String = "USB Video Class Video";
			var AdobeVersion:String = Capabilities.manufacturer;
			var idCam:*;
			var realCam:* = null;
			var cam:Camera;
			 
			if (AdobeVersion == "Adobe Macintosh") {
				for (idCam in Camera.names) {
					if (Camera.names[idCam] == MAC_CAMERA) {
						realCam = idCam.toString();
						break;
					}
				}
				camRef = Camera.getCamera(realCam);
			} else {
				camRef = Camera.getCamera();
			}
			
			return camRef;
		}
		
	}

}