package com.flexutil.effects
{
//	import com.visualcondition.twease.Twease;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class GenieEffect extends Bitmap
	{
		public var goFrom:Number;
		public var bounce:Number;
		
		private var lastFilters:Array;
		private var blurSet:Boolean;
		
		private var _blur:Number;
		private var _bf:BlurFilter;
		private var _src:IBitmapDrawable;
		private var _factor:Number;
		private var _realHeight:Number;
		
		public function GenieEffect( src:IBitmapDrawable , goFrom:Number = 200 , startFactor:Number = 0.0 , bounce:Number = 0.0 , blur:Number = 0.0 )
		{
			super( );
			_src = src;
			this.goFrom = goFrom;
			_blur = blur;
			this.bounce = bounce;
			if( blur > .0 ){
				_bf = new BlurFilter( .0,blur );
				blurSet = false;
			}
			factor = _factor = startFactor;
			_realHeight = (src is BitmapData)?BitmapData(src).height:DisplayObject(src).height;
			bitmapData = new BitmapData( (src is BitmapData)?BitmapData(src).width:DisplayObject(src).width , (_realHeight-1)*(1.0+bounce) , true , 0 );
		}
		
		public function set factor( f:Number ):void{
			if( _factor == f ) return;
			if( f < 0 ) f = 0;
			else if( f > 1.0 ) f = 1.0;
			_factor = f;
			
			var rect:Rectangle = new Rectangle( 0,0,bitmapData.width,1);
			var mtx:Matrix = new Matrix();
			var y:uint;
			bitmapData.fillRect( bitmapData.rect , 0xff0000 );
			var newf:Number;
			var func:Number;
			var localFactor:Number;
			var oneTan:Number = Math.atan( 2 ) + Math.PI/4;
			
			if( _factor > 0.5 ){
				newf = 2*(_factor-0.5);				
				if( bounce > 0.0 ){
					mtx.d = 1.0 + bounce*Math.sin( Math.PI*newf );
					mtx.ty = (1.0-mtx.d)*(_realHeight - 1 );
				}
				mtx.ty += (bitmapData.height - _realHeight);
				for( y = 0; y < bitmapData.height; y++ ){
					rect.y = y;
					
					localFactor = 3*(1.0 - Number(y)/bitmapData.height);
					func = (Math.atan( localFactor-1 ) + Math.PI/4)/oneTan;
					func = (1.0-newf)*func + newf;
					mtx.a = func;
					mtx.tx = (1.0-func)*goFrom;
					
					bitmapData.draw( _src , mtx , null , null , rect );
				}
				
				if( ( _blur > 0.0 ) && blurSet ){
					filters = lastFilters;
					blurSet = false;
				}
				
			}else{
				// less factor = smaller
				newf = _factor*2;
				mtx.d = newf;
				mtx.ty = (1.0-newf)*(bitmapData.height-1) + (bitmapData.height - _realHeight);
				
				for( y = mtx.ty; y < bitmapData.height; y++ ){
					rect.y = y;
					
					localFactor = 3*(1.0 - Number(y)/bitmapData.height);
					func = (Math.atan( localFactor-1 ) + Math.PI/4)/oneTan;
					mtx.a = func;
					mtx.tx = (1.0-func)*goFrom;
					
					bitmapData.draw( _src , mtx , null , null , rect );
				}
				
				if( ( _blur > .0 ) && !blurSet ){
					lastFilters = filters;
					if( filters.length ) filters = filters.concat( _bf );
					else filters = [ _bf ];
					blurSet = true;
				}
			}
		}
		
		public function get factor():Number{
			return _factor;
		}
		
		public function animate( dest:Number = 0, time:Number = 1.5 ):void{
//			Twease.tween( 
//				{ target:this , time:time , ease:inout , fac2:dest  } 
//			);
		}
		
		
		
		public function contanim( a:Object , b:Object , c:Object ):void{
//			delete Twease.tweens[ this ];
			factor = 0.5;
//			Twease.tween( { target:this , time:2 , ease:sine , fac2:0  } );
		}
		
		public function set fac2( val:Number ):void{
			factor = val;
		}
		
		public function get fac2(  ):Number{
			return _factor;
		}
		
		public static function sine(t:Number, b:Number, c:Number, d:Number):Number {
			return -c/2*(Math.cos(Math.PI*t/d)-1)+b;
		}
		
		public static function inout(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t /= d/2)<1) {
				return c/2*t*t*t*t+b;
			}
				return -c/2*((t -= 2)*t*t*t-2)+b;
		}
	}
}