package com.flexutil.utils
{
	public class LogicUtil
	{
		/**
		 * Useful for Boolean operations in MXML tags.
		 */
		public static function and( ... args ):Boolean
		{
			var result:Boolean = true;
			
			for each ( var arg:* in args )
			{
				result &&= arg;
			}
			
			return result;
		}
		
		/**
		 * Useful for Boolean operations in MXML tags.
		 */
		public static function or( ... args ):Boolean
		{
			var result:Boolean = false;
			
			for each ( var arg:* in args )
			{
				result ||= arg;
			}
			
			return result;
		}
	}
}