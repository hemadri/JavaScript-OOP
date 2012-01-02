package com.flexutil.utils
{
	public class NumberUtil
	{
		public static function format(value:Number, decimals:Number=2):Number
		{
			var power:int = Math.pow(10, decimals);
			return Math.round(value *= power) / power;
		}
		
		/**
		 * validates the int value, with minimum 0 and maximum 9999 
		 * @param value
		 */		
		public static function validateInt(value:int, min:int=1, max:int=9999):Boolean
		{
			return (value >= min && value <= max);
				
		}
		
		/**
		 * validates if Number is valid.
		 * results false if NaN  
		 * @param value
		 */		
		public static function validateNumber(value:Number):Boolean
		{
			return !isNaN(value) && value > 0;
		}
		
		/**
		 * Comparator function for two Numbers.
		 */
		public static function compare( a:Number, b:Number ):int
		{
			if ( a < b )
			{
				return -1;
			}
			else if ( b < a )
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		
		/**
		 * Returns a Boolean indicating whether the specified value is a whole number (ex. 1, 2, 3, etc.).
		 */
		public static function isWholeNumber( value:* ):Boolean
		{
			var number:Number = Number( value );
			
			return ( Math.floor( Math.abs( number ) ) == value );
		}
		
		/**
		 * Returns the first parameter if it is a valid Number, otherwise returns the second parameter.
		 */
		public static function sanitizeNumber( value:*, otherwise:Number ):Number
		{
			var number:Number = Number( value );
			
			return ( ( value == null ) || isNaN( number ) ) ? otherwise : number;
		}
	}
}