package com.flexutil.utils
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class BitmapDataUtil
	{
		/**
		 * Convert the  BitmapData to grayscale.
		 */
		public static function grayscale( bitmapData:BitmapData ):BitmapData
		{
			var rLum:Number = 0.3086;
			var gLum:Number = 0.6094;
			var bLum:Number = 0.082; 
			
			var matrix:Array = 
				[ 
					rLum, gLum, bLum, 0,    0,
					rLum, gLum, bLum, 0,    0,
					rLum, gLum, bLum, 0,    0,
					0,    0,    0,    1,    0 
				];
			 
			var bitmapBounds:Rectangle = new Rectangle( 0, 0, bitmapData.width, bitmapData.height );
			var filter:ColorMatrixFilter = new ColorMatrixFilter( matrix );

			bitmapData.applyFilter( bitmapData, bitmapBounds, new Point( 0, 0 ), filter );
			
			return bitmapData;
		}
		
		/**
		 * Tint the BitmapData with the specified color.
		 */
		public static function tint( bitmapData:BitmapData, color:uint ):BitmapData
		{
			var r:int = ( ( color >> 16 ) & 0xFF );
			var g:int = ( ( color >> 8 )  & 0xFF );
			var b:int = ( ( color )       & 0xFF );
			
			var bitmapBounds:Rectangle = new Rectangle( 0, 0, bitmapData.width, bitmapData.height );
			var colorTransform:ColorTransform = new ColorTransform( 1.0, 1.0, 1.0, 1.0, r, g, b );
			
			bitmapData.colorTransform( bitmapBounds, colorTransform );
			
			return bitmapData;
		}
		
		/**
		 * Adjust the brightness of the BitmapData by the percentage.
		 */
		public static function brightness( bitmapData:BitmapData, percentage:Number ):BitmapData
		{
			percentage = Math.max( -1.0, Math.min( 1.0, percentage ) ) * 255;
			
			if ( percentage != 0 )
			{
				var matrix:Array = 
					[ 
						1, 0, 0, 0, percentage,
						0, 1, 0, 0, percentage,
						0, 0, 1, 0, percentage,
						0, 0, 0, 1, 0
					];
			 
				var bitmapBounds:Rectangle = new Rectangle( 0, 0, bitmapData.width, bitmapData.height );
				var filter:ColorMatrixFilter = new ColorMatrixFilter( matrix );
				
				bitmapData.applyFilter( bitmapData, bitmapBounds, new Point( 0, 0 ), filter );
			}
			
			return bitmapData;
		}
		
		/**
		 * Adjust the transparency of the BitmapData by the percentage.
		 */
		public static function transparency( bitmapData:BitmapData, percentage:Number ):BitmapData
		{
			percentage = Math.max( 0.0, Math.min( 1.0, percentage ) );
			
			var matrix:Array = 
				[ 
					1, 0, 0, 0,          0,
					0, 1, 0, 0,          0,
					0, 0, 1, 0,          0,
					0, 0, 0, percentage, 0
				];
				 
			var bitmapBounds:Rectangle = new Rectangle( 0, 0, bitmapData.width, bitmapData.height );
			var filter:ColorMatrixFilter = new ColorMatrixFilter( matrix );
			
			bitmapData.applyFilter( bitmapData, bitmapBounds, new Point( 0, 0 ), filter );
			
			return bitmapData;
		}
	}
}