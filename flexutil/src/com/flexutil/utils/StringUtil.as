package com.flexutil.utils
{
	import mx.utils.StringUtil;

	public class StringUtil
	{
		public function StringUtil()
		{
		}
		
		/**
		 * Compares two strings and returns true if same, else false
		 * Also checks the null conditions
		 * @param string1
		 * @param string2
		 * @return 
		 * 
		 */		
		public static function compareStrings(string1:String, string2:String):Boolean
		{
			if((string1== null && string2 == null) || 
				(string1 == null && mx.utils.StringUtil.trim(string2)=='') ||
				(string1 == '' && string2==null))
			return true;
				
				
			if(string1!=null && string2!=null)
				return string1 == string2;
			else  
				return (string1==null && string2==null)
		}
		
		/**
		 * validates the string for null and empty string
		 * @param str
		 * @return 
		 */		
		public static function validateString(str:String):Boolean
		{
			if(str != null)
				if(mx.utils.StringUtil.trim(str) != '')
					return true
			return false;
		}
		/**
		 * validates an array of strings for null and empty string
		 * @param str
		 * @return 
		 */		
		public static function validateStrings(arr:Array):Array
		{
			var errors:Array=[];
			for each(var str:String in arr)
			{
				if(str)
				if(mx.utils.StringUtil.trim(str) != '')
					errors.push(arr);
			}
			return errors;
		}
	}
}