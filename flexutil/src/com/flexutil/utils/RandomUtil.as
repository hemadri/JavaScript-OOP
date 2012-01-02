package com.flexutil.utils
{
	public class RandomUtil
	{
		/**
		 * Returns a random number between the two numbers specified.
		 * 
		 * NOTE: The difference between 'a' and 'b' must be less than or equal to Math.MAX_VALUE.
		 */
		public static function between( a:Number, b:Number ):Number
		{
			return ( a + ( Math.random() * ( b - a ) ) );
		}
	}
}