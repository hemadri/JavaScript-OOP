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
	}
}