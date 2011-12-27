package com.flexutil.utils
{
	public class EPNumberFormatter
	{
		
		public static function format(value:Number, decimals:Number=2):Number
		{
			var power:int = Math.pow(10, decimals);
			return Math.round(value *= power) / power;
		}
		

	}
}