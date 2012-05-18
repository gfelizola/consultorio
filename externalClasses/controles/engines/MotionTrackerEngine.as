package controles.engines 
{
	import com.gskinner.geom.ColorMatrix;
	import controles.events.UserControlsEvent;
	import controles.UserControls;
	import controles.utils.CameraUtils;
	import controles.utils.Directions;
	import controles.utils.DirectionsPoint;
	import controles.utils.Oposities;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	import uk.co.soulwire.cv.MotionTracker;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class MotionTrackerEngine extends MotionEngine
	{
		private var _motionTracker:MotionTracker ;
		
		private var _matrix:ColorMatrix;
		private var _video:BitmapData;
		private var _source:Bitmap;
		private var _output:Bitmap;
		private var _target:Shape;
		private var _bounds:Shape;
		
		public function MotionTrackerEngine( stage:Stage, controle:UserControls ) 
		{
			super( stage, controle );
		}
		
		override public function init():void 
		{
			var camW:int = 420;
			var camH:int = 320;
			var cam:Camera = CameraUtils.getCamera();
			if ( cam == null ) {
				trace( "SEM CAMERA" );
				return ;
			}
			cam.setMode(camW, camH, _stage.frameRate);
			
			var vid:Video = new Video(camW, camH);
			vid.attachCamera(cam);
			
			_motionTracker = new MotionTracker(vid);
			_motionTracker.flipInput = true ;
			
			_matrix = new ColorMatrix();
			_matrix.brightness = _motionTracker.brightness;
			_matrix.contrast = _motionTracker.contrast;
			
			_video = new BitmapData(camW, camH, false, 0);
			_source = new Bitmap(_video);
			_source.scaleX = -1;
			_source.x = 10 + camW;
			_source.y = 10;
			_source.filters = [new ColorMatrixFilter(_matrix.toArray())];
			_stage.addChild(_source);
			
			// Show the image the MotionTracker is processing and using to track
			_output = new Bitmap(_motionTracker.trackingImage);
			_output.x = camW + 20;
			_output.y = 10;
			_stage.addChild(_output);
			
			// A shape to represent the tracking point
			_target = new Shape();
			_target.graphics.lineStyle(0, 0xFFFFFF);
			_target.graphics.drawCircle(0, 0, 10);
			_stage.addChild(_target);
			
			// A box to represent the activity area
			_bounds = new Shape();
			_bounds.x = _output.x;
			_bounds.y = _output.y;
			_stage.addChild(_bounds);
			
			super.init();
		}
		
		override public function getPoint():Point 
		{
			_motionTracker.track();
			
			_target.x += ((_motionTracker.x + _bounds.x) - _target.x) / 10;
			_target.y += ((_motionTracker.y + _bounds.y) - _target.y) / 10;
			
			_video.draw(_motionTracker.input);
			
			if ( _motionTracker.hasMovement ) {
				_bounds.graphics.clear();
				_bounds.graphics.lineStyle(0, 0xFFFFFF);
				_bounds.graphics.drawRect(_motionTracker.motionArea.x, _motionTracker.motionArea.y, _motionTracker.motionArea.width, _motionTracker.motionArea.height);
			}
			
			return new Point( _motionTracker.x, _motionTracker.y );
		}
	}

}