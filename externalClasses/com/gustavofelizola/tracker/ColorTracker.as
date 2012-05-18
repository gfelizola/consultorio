package com.gustavofelizola.tracker 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Video;
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class ColorTracker 
	{
		private var _source:Video ;
		private var _output:Bitmap ;
		private var _outputData:BitmapData ;
		
		private var _colorArea:Rectangle ;
		private var _colorToTrack:uint ;
		private var _bmd:BitmapData;
		
		private var _aRed:Array;
		private var _aGreen:Array;
		private var _aBlue:Array;
		
		public function ColorTracker( input:Video ) 
		{
			_source = input ;
			_bmd = new BitmapData( _source.width, _source.height, false );
			_output = new Bitmap( _bmd );
			
			makePaletteArrays();
		}
		
		public function track( regulador:uint = 1 ):void 
		{
			if ( isNaN( _colorToTrack ) )
				throw new Error("You need to set the colorToTrack first");
			
			_bmd.draw( _source, new Matrix(-1, 0, 0, 1, _bmd.width, 0 ) );
			_bmd.paletteMap( _bmd, _bmd.rect, new Point(), _aRed, _aGreen, _aBlue );
			
			_colorArea 			= _bmd.getColorBoundsRect( 0xffffff, _colorToTrack );
			_colorArea.x 		*= regulador ;
			_colorArea.y 		*= regulador ;
			_colorArea.width 	*= regulador ;
			_colorArea.height 	*= regulador ;
		}
		
		private function makePaletteArrays():void {
			_aRed = [];
			_aGreen = [];
			_aBlue = [];
			var levels:Number = 8;
			var div:Number = 512 / levels;
			for(var i:Number = 0 ; i < 256 ; i++ ){
				var value:Number = Math.floor(i/div) * div;
				_aRed[i] = value << 16;
				_aGreen[i] = value << 8;
				_aBlue[i] = value;
			}
		}
		
		public function get colorArea():Rectangle { return _colorArea; }
		public function get output():Bitmap { return _output; }
		public function get colorToTrack():uint { return _colorToTrack; }
		public function set colorToTrack(value:uint):void 
		{
			_colorToTrack = value;
		}
		
		
	}

}