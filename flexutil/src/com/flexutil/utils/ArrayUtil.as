package com.flexutil.utils
{
	public class ArrayUtil
	{
		// ========================================
		// Public methods
		// ========================================
		
		/**
		 * Returns a shallow clone of the specified Array.
		 */
		public static function clone( array:Array ):Array
		{
			return ( array != null ) ? array.concat() : null;
		}
		
		/**
		 * Returns a Boolean indicating whether the specified Arrays are identical (i.e. contain exactly the same content in the same order).
		 */
		public static function equals( array1:Array, array2:Array, sort:Boolean = false ):Boolean
		{
			if ( ( array1 == null ) && ( array2 == null ) )
			{
				return true;
			}
			else if ( ( array1 != null ) && ( array2 != null ) && ( array1.length == array2.length ) )
			{
				if ( sort )
				{
					// NOTE: Both Arrays are cloned before sorting to ensure the original Array is not altered.
					
					array1 = ArrayUtil.clone( array1 )
					array1.sort();
					
					array2 = ArrayUtil.clone( array2 )
					array2.sort();
				}
				
				var length:int = array1.length;
				for ( var index:int = 0; index < length; index++ )
				{
					if ( array1[ index ] != array2[ index ] )
						return false;
				}
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * Returns a Boolean indicating whether the specified Array contains the specified item.
		 */
		public static function contains( array:Array, item:Object ):Boolean
		{
			return ( array != null ) ? ( array.indexOf( item ) != -1 ) : false;
		}
		
		/**
		 * Returns a Boolean indicating whether the specified Array contains the specified items.
		 */
		public static function containing( array:Array, ...items ):Boolean
		{
			var result:Boolean = true;
			
			for each ( var item:Object in items )
				result &&= contains( array, item );
			
			return result;
		}
		
		/**
		 * Creates a new Array by combining the unique items in the specified arrays (i.e. no duplicates in resulting Array).
		 */
		public static function merge( ...arrays ):Array
		{
			var result:Array = new Array();
		
			for each ( var array:Array in arrays )
			{
				for each ( var item:* in array )
				{
					if ( result.indexOf( item ) == -1 )
							result.push( item );
				}
			}
			
			return result;
		}
		
		/**
		 * Creates a new Array by combining the unique specified items into the specified Array (i.e. no duplicates in resulting Array).
		 */
		public static function merging( array:Array, ...items ):Array
		{
			return merge( array, items );
		}
		
		/**
		 * Returns a shallow clone of the specified target Array, excluding the specified items.
		 */
		public static function exclude( array:Array, items:Array):Array
		{
			var result:Array = clone( array ) || new Array();
			
			for each ( var item:Object in items )
			{
				var itemIndex:int = result.indexOf( item );
				
				while (itemIndex != -1) {
					result.splice(itemIndex, 1);
					
					itemIndex = result.indexOf (item);
				}
			}
			
			return result;
		}
		
		/**
		 * Returns a shallow clone of the specified target Array, excluding the specified items.
		 */
		public static function excluding( array:Array, ...items ):Array
		{
			return exclude( array, items );
		}
		
		/**
		 * Returns the items that are not in both of the specified Arrays.
		 */
		public static function difference( array1:Array, array2:Array ):Array
		{
			return merge( exclude( array1, array2 ), exclude( array2, array1 ) );
		}
	}
}