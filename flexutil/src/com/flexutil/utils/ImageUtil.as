package com.flexutil.utils
{
	import flash.display.Bitmap;

	public class ImageUtil
	{
		// ========================================
		// Public methods
		// ========================================
		
		/**
		 * Return the specified image source converted to grayscale.
		 */
		public static function grayscale( source:Object ):Bitmap
		{
			var bitmap:Bitmap = createBitmap( source );
			
			BitmapDataUtil.grayscale( bitmap.bitmapData );
			
			return bitmap;
		}
		
		/**
		 * Return the specified image source tinted with the specified color.
		 */
		public static function tint( source:Object, color:uint ):Bitmap
		{
			var bitmap:Bitmap = createBitmap( source );
			
			BitmapDataUtil.tint( bitmap.bitmapData, color );
			
			return bitmap;
		}
		
		/**
		 * Return the specified image source with its brightness adjusted by the specified percentage.
		 */
		public static function brightness( source:Object, percentage:Number ):Bitmap
		{
			var bitmap:Bitmap = createBitmap( source );
			
			BitmapDataUtil.brightness( bitmap.bitmapData, percentage );
			
			return bitmap;
		}
		
		/**
		 * Return the specified image source with its brightness adjusted by the specified percentage.
		 */
		public static function transparency( source:Object, percentage:Number ):Bitmap
		{
			var bitmap:Bitmap = createBitmap( source );
			
			BitmapDataUtil.transparency( bitmap.bitmapData, percentage );
			
			return bitmap;
		}
		
		// ========================================
		// Protected methods
		// ========================================
		
		/**
		 * Create a Bitmap instance from the specified source.
		 */
		protected static function createBitmap( source:Object ):Bitmap
		{
			if ( source is Class )
			{
				return new source() as Bitmap;
			}
			else if ( source is Bitmap )
			{
				return source as Bitmap;
			}
			else
			{
				throw new Error( "Unsuported source specified." );
			}
		}
	}
}