package com.gustavofelizola.components
{
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class Scroll
	{
		// INTERFACE VARS --------
		private var _target:DisplayObject;
		private var _mask:Sprite;
		private var _arrowUp:MovieClip;
		private var _arrowDown:MovieClip;
		private var _scrollButton:MovieClip;
		private var _scrollBar:MovieClip;
		
		private var _lock:Boolean = false ;
		
		// CONTROL VARS --------
		private const verticalPosProp:String = "y" ;
		private const verticalSizeProp:String = "height" ;
		
		private const horizontalPosProp:String = "x" ;
		private const horizontalSizeProp:String = "width" ;
		
		private var posProp:String = "y" ;
		private var sizeProp:String = "height" ;
		
		private var _steps:int = 0 ;
		private var _gradient:Boolean ;
		private var _wheel:Boolean ;
		private var _wheelSpeed:Number = 50 ;
		private var _initPosTarget:Number = 0 ;
		private var _scrollAdjust:Boolean = false ;
		private var _horizontal:Boolean = false ;
		private var _useMousePosition:Boolean = false ;
		private var _mouseCalculator:Shape ;
		private var _actualPorc:Number;
		
		public function Scroll(useHorizontal:Boolean = false) {
			if ( useHorizontal ) {
				posProp = horizontalPosProp ;
				sizeProp = horizontalSizeProp ;
			}
		}
		
		// PUBLICS --------------
		
		public function setViewArea(area:Rectangle, dVisible:Boolean = false ):void 
		{
			var tAlpha:int = dVisible ? 1 : 0 ;
			var tCor:uint = dVisible ? 0xff0000 : 0 ;
			var tempMask:Sprite = new Sprite();
			tempMask.x = area.x ;
			tempMask.y = area.y ;
			tempMask.graphics.beginFill(tCor, tAlpha);
			tempMask.graphics.drawRect( 0, 0, area.width, area.height );
			tempMask.graphics.endFill();
			
			mask = tempMask ;
		}
		
		public function setViewMask( newMask:Sprite, useGradient:Boolean = false ):void 
		{
			mask = newMask ;
			gradient = useGradient ;
		}
		
		public function get target():DisplayObject { return _target; }
		public function set target(value:DisplayObject):void 
		{
			_target = value;
			initPosTarget = _target[posProp] ;
			reset();
		}
		
		public function get mask():Sprite { return _mask; }
		public function set mask(value:Sprite):void 
		{
			if ( _mask ) removeMask();
			_mask = value;
			_target.parent.addChild( _mask ) ;
			_target.mask = _mask ;
			reset();
		}
		
		private function removeMask():void
		{
			if ( _mask ) {
				if ( _target.mask ) _target.mask = null ;
				if ( _mask.parent ) _mask.parent.removeChild( _mask ) ;
			}
		}
		
		public function get arrowUp():MovieClip { return _arrowUp; }
		public function set arrowUp(value:MovieClip):void 
		{
			_arrowUp = value;
			_arrowUp.buttonMode = true ;
			_arrowUp.addEventListener(MouseEvent.CLICK, arrowClick );
		}
		
		public function get arrowDown():MovieClip { return _arrowDown; }
		public function set arrowDown(value:MovieClip):void 
		{
			_arrowDown = value;
			_arrowDown.buttonMode = true ;
			_arrowDown.addEventListener(MouseEvent.CLICK, arrowClick );
		}
		
		public function get scrollButton():MovieClip { return _scrollButton; }
		public function set scrollButton(value:MovieClip):void 
		{
			_scrollButton = value;
			_scrollButton.buttonMode = true ;
			_scrollButton.addEventListener(MouseEvent.MOUSE_DOWN, scrollButtonDown);
			reset();
		}
		
		
		public function get scrollBar():MovieClip { return _scrollBar; }
		public function set scrollBar(value:MovieClip):void 
		{
			_scrollBar = value;
			_scrollBar.buttonMode = true ;
			_scrollBar.addEventListener(MouseEvent.CLICK, scrollBarClick);
			reset();
		}
		
		public function get gradient():Boolean { return _gradient; }
		public function set gradient(value:Boolean):void 
		{
			_gradient = value;
			if ( _gradient ) {
				_target.cacheAsBitmap = true ;
				_mask.cacheAsBitmap = true ;
			}
		}
		
		public function get initPosTarget():Number { return _initPosTarget; }
		public function set initPosTarget(value:Number):void 
		{
			_initPosTarget = value;
		}
		
		public function get wheel():Boolean { return _wheel; }
		public function set wheel(value:Boolean):void 
		{
			_wheel = value;
			if ( _wheel ) {
				if ( _scrollButton ) 	_scrollButton.addEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
				if ( _scrollBar ) 		_scrollBar.addEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
				if ( _target ) 			_target.addEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
				
			} else {
				if ( _scrollButton ) {
					if( _scrollButton.hasEventListener(MouseEvent.MOUSE_WHEEL) ) _scrollButton.removeEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
				}
				if ( _scrollBar ) {
					if( _scrollBar.hasEventListener(MouseEvent.MOUSE_WHEEL) ) _scrollBar.removeEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
				}
				if( _target.hasEventListener(MouseEvent.MOUSE_WHEEL) ) _target.removeEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
			}
		}
		
		public function get wheelSpeed():Number { return _wheelSpeed; }
		public function set wheelSpeed(value:Number):void 
		{
			_wheelSpeed = value;
		}
		
		public function get scrollAdjust():Boolean { return _scrollAdjust; }
		public function set scrollAdjust(value:Boolean):void 
		{
			_scrollAdjust = value;
			if ( _scrollAdjust ) adjustScrollButtonSize();
		}
		
		public function get horizontal():Boolean { return _horizontal; }
		public function set horizontal(value:Boolean):void 
		{
			_horizontal = value;
			if ( _horizontal ) 
			{
				posProp = horizontalPosProp ;
				sizeProp = horizontalSizeProp ;
			} else {
				posProp = verticalPosProp ;
				sizeProp = verticalSizeProp ;
			}
			
		}
		
		public function get useMousePosition():Boolean { return _useMousePosition; }
		public function set useMousePosition(value:Boolean):void 
		{
			_useMousePosition = value;
			
			if( _mask ){
				_mouseCalculator = new Shape();
				_mouseCalculator.x = _mask.x ;
				_mouseCalculator.y = _mask.y ;
				_mouseCalculator.graphics.beginFill( 0 , 1 );
				_mouseCalculator.graphics.drawRect(0, 0, _mask.width, _mask.height);
				_mouseCalculator.graphics.endFill();
				_mouseCalculator.addEventListener(Event.ENTER_FRAME, mousePosFramer);
				_mask.parent.addChildAt(_mouseCalculator , 0);
			}
		}
		
		public function get lock():Boolean { return _lock; }
		public function set lock(value:Boolean):void 
		{
			_lock = value;
		}
		
		public function reset():void 
		{
			if ( _scrollButton && _target && _scrollBar )
			{
				var obj1:Object = { } ;
				var obj2:Object = { } ;
				obj1[posProp] = _scrollBar[posProp] ;
				obj2[posProp] = _initPosTarget
				
				TweenLite.killTweensOf( _scrollButton);
				TweenLite.killTweensOf( _target );
				
				//TweenLite.to( _scrollButton , .3 , obj1 );
				//TweenLite.to( _target , .3 , obj2 );
				_target.y = 0;
				_scrollButton.y = 0;
				if ( _scrollAdjust ) adjustScrollButtonSize() ;
				
				if ( _mask ) {
					_scrollButton.visible = _scrollBar.visible = _target[sizeProp] > _mask[sizeProp] ;
				}
			}
		}
		
		private function adjustScrollButtonSize():void 
		{
			if ( _scrollBar && _scrollButton && _target && _mask ) {
				var finalSize:Number = _mask[sizeProp] / _target[sizeProp] * _scrollBar[sizeProp] ;
				if ( _target[sizeProp] < _mask[sizeProp] ) finalSize = _scrollBar[sizeProp] ;
				var o:Object = { };
				o[sizeProp] = finalSize ;
				TweenLite.to( _scrollButton , .4 , o );
			}
		}
		
		// SCROLL METHODS
		
		private function scrollButtonDown(e:MouseEvent):void 
		{
			_target.stage.addEventListener(MouseEvent.MOUSE_MOVE, scrollButtonMove );
			_target.stage.addEventListener(MouseEvent.MOUSE_UP, scrollButtonUp );
			
			var l:Number = _horizontal ? _scrollBar.width - _scrollButton.width : 0 ;
			var a:Number = _horizontal ? 0 : _scrollBar.height - _scrollButton.height ;
			
			var area:Rectangle = new Rectangle( _scrollBar.x , _scrollBar.y , l , a );
			_scrollButton.startDrag( false, area );
		}
		
		private function scrollButtonUp(e:MouseEvent):void 
		{
			_target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, scrollButtonMove );
			_target.stage.removeEventListener(MouseEvent.MOUSE_UP, scrollButtonUp );
			_scrollButton.stopDrag();
		}
		
		private function scrollButtonMove(e:MouseEvent):void 
		{
			moveByScrollButton();
		}
		
		private function scrollBarClick(e:MouseEvent):void 
		{
			var mouseProp:String = _horizontal ? "mouseX" : "mouseY" ;
			var pos:Number = DisplayObject(e.currentTarget)[mouseProp] - ( _scrollButton[sizeProp] / 2 ) ;
			if ( _scrollButton ) {
				if ( ( pos + ( _scrollButton[sizeProp] / 2 ) ) > ( _scrollBar[posProp] + _scrollBar[sizeProp] - _scrollButton[sizeProp] ) ){ pos = _scrollBar[sizeProp] - _scrollButton[sizeProp] ; }
				else if ( ( pos - ( _scrollButton[sizeProp] / 2 ) ) < _scrollBar[posProp] ) { pos = _scrollBar[posProp] ; }
				
				var o:Object = { };
				o[posProp] = pos ;
				o.onUpdate = moveByScrollButton ;
				
				TweenLite.to( _scrollButton , .4 , o );
			}
		}
		
		private function arrowClick(e:MouseEvent):void 
		{
			if ( _scrollButton ) {
				var pos:Number = _scrollButton[posProp] ;
				pos += e.currentTarget == _arrowUp ? -_wheelSpeed : _wheelSpeed ;
				
				if ( ( pos + ( _scrollButton[sizeProp] / 2 ) ) > ( _scrollBar[posProp] + _scrollBar[sizeProp] - _scrollButton[sizeProp] ) ){ pos = _scrollBar[sizeProp] - _scrollButton[sizeProp] ; }
				else if ( ( pos - ( _scrollButton[sizeProp] / 2 ) ) < _scrollBar[posProp] ) { pos = _scrollBar[posProp] ; }
				
				var o:Object = { };
				o[posProp] = pos ;
				o.onUpdate = moveByScrollButton ;
				
				TweenLite.to( _scrollButton , .4 , o );
			}
		}
		
		private function scrollWheel(e:MouseEvent):void 
		{
			var pos:Number = _scrollButton[posProp] ;
			if ( e.delta > 0 ) {
				pos -= _wheelSpeed ;
				if ( pos < _scrollBar[posProp] ) pos = _scrollBar[posProp] ;
			} else {
				pos += _wheelSpeed ;
				if ( pos >= _scrollBar[posProp] + ( _scrollBar[sizeProp] - _scrollButton[sizeProp] ) ) pos = _scrollBar[posProp] + ( _scrollBar[sizeProp] - _scrollButton[sizeProp] ) ;
			}
			
			var o:Object = { };
			o[posProp] = pos ;
			o.onUpdate = moveByScrollButton ;
			TweenLite.to( _scrollButton , .4 , o );
		}
		
		
		
		private function mousePosFramer(e:Event):void 
		{
			var pos:Number = _mouseCalculator["mouse" + posProp.toUpperCase()] - 1 ;
			
			if ( _mouseCalculator.mouseX >= 0 && 
				_mouseCalculator.mouseX <= _mouseCalculator.width && 
				_mouseCalculator.mouseY >= 0 && 
				_mouseCalculator.mouseY <= _mouseCalculator.height ) {
					
				if ( _scrollBar && _scrollButton ) {
					if ( ( pos + ( _scrollButton[sizeProp] / 2 ) ) > ( _scrollBar[posProp] + _scrollBar[sizeProp] - _scrollButton[sizeProp] ) ){ pos = _scrollBar[sizeProp] - _scrollButton[sizeProp] ; }
					else if ( ( pos - ( _scrollButton[sizeProp] / 2 ) ) < _scrollBar[posProp] ) { pos = _scrollBar[posProp] ; }
					
					var o:Object = { };
					o[posProp] = pos ;
					o.onUpdate = moveByScrollButton ;
					
					TweenLite.to( _scrollButton , .4 , o );
				} else {
					_actualPorc = pos * 100 / _mouseCalculator[sizeProp] ;
					move();
				}
			}
		}
		
		private function moveByScrollButton():void 
		{
			if ( _scrollBar && _scrollButton && _target ) {
				var totalSize:Number = _scrollBar[sizeProp] - _scrollButton[sizeProp] ;
				_actualPorc = ( _scrollButton[posProp] - _scrollBar[posProp] ) * 100 / totalSize ;
				move();
			}
		}
		
		private function move():void 
		{
			var canMove:Boolean = true ;
			if ( _target[sizeProp] <= _mask[sizeProp] ) canMove = false ;
			
			if ( canMove && ! _lock ) {
				var maskSize:Number = _mask ? _mask[sizeProp] : 0 ;
				var pos:Number = ( ( ( _target[sizeProp] - maskSize )  * _actualPorc ) / 100 ) * -1 + _initPosTarget ;
				TweenLite.killTweensOf( _target ) ;
				
				var o:Object = { };
				o[posProp] = pos ;
				o.onUpdate = verificaLocked ;
				TweenLite.to( _target, .4 , o );
			}
		}
		
		private function verificaLocked():void 
		{
			if( _lock ) TweenLite.killTweensOf( _target ) ;
		}
	}
}