package com.flexutil.utils
{
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.formatters.DateFormatter;

	/**
	 * @author Hemadri (hemadri@hemadri.com)
	 * DateUtil, Static date utility methods for reusability
	 */
	public class DateUtil
	{
		public function DateUtil()
		{
		}
		
		/**
		 * Compares two dates with timestamps and returns true if same, else returns false 
		 * @param date1
		 * @param date2
		 * @return true if same, false if not same 
		 */		
		public static function compareDates(date1:Date, date2:Date):Boolean
		{
			if(date1 && date2)
				return date1.getTime() == date2.getTime();
			else  
				return (date1==null && date2==null)
		}
		
		public static const FULL_YEAR:String = 'fullyear';
		public static const MONTH:String = 'month';
		public static const DATE:String = 'date';
		public static const HOURS:String = 'hours';
		public static const MINUTES:String = 'minutes';
		public static const SECONDS:String = 'seconds';
		public static const MILLISECONDS:String = 'milliseconds';
		
		/**
		 * changesDate, adds/subtracts days/weeks/months 
		 * @param datepart  - "fullyear" or "month" or "date" or "hours" or "minutes" or "seconds" or "milliseconds"
		 * @param value - new value to change (incremental or decremental)
		 * @param date - for an existing Date or todays Date
		 * @return newChanged Date
		 */		
		public static function changeDate(datepart:String = "", value:int = 0, date:Date = null):Date
		{
			if (date == null) {
				date = new Date();
			}
			
			var newDate:Date = new Date(date.time);;
			
			switch (datepart.toLowerCase()) {
				case FULL_YEAR:
				case MONTH:
				case DATE:
				case HOURS:
				case MINUTES:
				case SECONDS:
				case MILLISECONDS:
					newDate[datepart] += value;
					break;
			}
			return newDate;
		}
	}
}