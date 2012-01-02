package com.flexutil.utils
{
	import com.flexutil.data.DateRange;
	
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
		public static const MONTHS:String = 'month';
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
				case MONTHS:
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
		
		/**
		 * Time expressed as milliseconds.
		 */
		public static const MILLISECOND:Number 	= 1;
		public static const SECOND:Number 		= MILLISECOND * 1000;
		public static const MINUTE:Number 		= SECOND * 60;
		public static const HOUR:Number 		= MINUTE * 60;
		public static const DAY:Number 			= HOUR * 24;
		public static const WEEK:Number 		= DAY * 7;
		public static const MONTH:Number 		= DAY * 30; 				// Imprecise.
		public static const QUARTER:Number		= MONTH * 3; 				// Imprecise.
		public static const YEAR:Number   		= DAY * 365; 				// Imprecise.
		
		/**
		 * Days of the week.
		 */
		public static const SUNDAY:Number 		= 0;
		public static const MONDAY:Number 		= 1;
		public static const TUESDAY:Number 		= 2;
		public static const WEDNESDAY:Number 	= 3;
		public static const THURSDAY:Number 	= 4;
		public static const FRIDAY:Number 		= 5;
		public static const SATURDAY:Number 	= 6;
		
		[ArrayElementType("String")]
		/**
		 * Month names (localized).
		 */
		public static function get MONTH_NAMES():Array
		{
			if ( _MONTH_NAMES == null )
			{
				_MONTH_NAMES = new Array();
				
				var dateFormatter:DateFormatter = new DateFormatter();
				dateFormatter.formatString = "MMMM";
				
				var date:Date = new Date( 2011, 0, 1 );
				for ( var month:int = 0; month < 12; month++ )
				{
					date.month = month;
					
					_MONTH_NAMES.push( dateFormatter.format( date ) );
				}
			}
			
			return _MONTH_NAMES;
		}
		
		/**
		 * @private
		 * 
		 * Backing variable for <code>MONTH_NAMES</code>.
		 * 
		 * @see #MONTH_NAMES
		 */
		protected static var _MONTH_NAMES:Array = null;
		
		/**
		 * Comparator function for two Dates.
		 */
		public static function compare( a:*, b:*, dateFieldName:String = null ):int
		{
			var dateA:Date = getDate( a, dateFieldName );
			var dateB:Date = getDate( b, dateFieldName );
			
			return NumberUtil.compare( dateA.time, dateB.time );
		}
		
		/**
		 * Calculates the duration in milliseconds between two dates.
		 */
		public static function duration( start:*, end:*, dateFieldName:String = null ):Number
		{
			var startDate:Date = getDate( start, dateFieldName );
			var endDate:Date = getDate( end, dateFieldName );
			
			return ( endDate.getTime() - startDate.getTime() );
		}
		
		/**
		 * Returns the minimum (i.e. earlier) date of the two specified dates.
		 */
		public static function min( a:*, b:*, dateFieldName:String = null ):Date
		{
			var dateA:Date = getDate( a, dateFieldName );
			var dateB:Date = getDate( b, dateFieldName );
			
			return ( dateA.getTime() <= dateB.getTime() ) ? dateA : dateB;
		}
		
		/**
		 * Returns the maximum (i.e. later) date of the two specified dates.
		 */
		public static function max( a:*, b:*, dateFieldName:String = null ):Date
		{
			var dateA:Date = getDate( a, dateFieldName );
			var dateB:Date = getDate( b, dateFieldName );
			
			return ( dateA.getTime() >= dateB.getTime() ) ? dateA : dateB;
		}
		
		/**
		 * Calculate the DateRange (min and max) for the specified Date field for an iterable set of items (Array, ArrayCollection, Proxy, etc.).
		 */
		public static function range( items:*, dateFieldName:String = null, isSorted:Boolean = false ):DateRange
		{
			var minDate:Date = null;
			var maxDate:Date = null;
			
			if ( isSorted )
			{
				minDate = getDate( IterableUtil.getFirstItem( items ), dateFieldName );
				maxDate = getDate( IterableUtil.getLastItem( items ), dateFieldName );
			}
			else
			{
				for each ( var item:Object in items )
				{
					var date:Date = getDate( item, dateFieldName );
					
					if ( date != null )
					{
						minDate = ( minDate != null ) ? min( minDate, date ) : date;
						maxDate = ( maxDate != null ) ? max( maxDate, date ) : date;
					}
				}
			}
			
			return new DateRange( 
				( minDate != null ) ? minDate.time : null, 
				( maxDate != null ) ? maxDate.time : null 
			);
		}
		
		/**
		 * Returns the 'floor' for the specified date - i.e. rounded down relative to the specified time unit.
		 */
		public static function floor( date:*, unit:Number, dateFieldName:String = null ):Date
		{
			var result:Date = new Date( getDate( date, dateFieldName ).time );
			
			switch ( unit )
			{
				case YEAR:
					result.month = 0;
					result.date = 1;
					result.hours = 0;
					result.minutes = 0;
					result.seconds = 0;
					result.milliseconds = 0;
					break;
				
				case QUARTER:
					result.month = calculateStartingMonthForQuarter( calculateQuarterForMonth( result.month ) );
					result.date = 1;
					result.hours = 0;
					result.minutes = 0;
					result.seconds = 0;
					result.milliseconds = 0;
					break;
				
				case MONTH:
					result.date = 1;
					result.hours = 0;
					result.minutes = 0;
					result.seconds = 0;
					result.milliseconds = 0;
					break;
				
				case DAY:
					result.hours = 0;
					result.minutes = 0;	
					result.seconds = 0;
					result.milliseconds = 0;
					break;
				
				case HOUR:
					result.minutes = 0;
					result.seconds = 0;
					result.milliseconds = 0;
					break;
				
				case MINUTE:
					result.seconds = 0;
					result.milliseconds = 0;
					break;
				
				case SECOND:
					result.milliseconds = 0;
					break;
				
				default:
					throw new Error( "Unsupported unit specified." );
			}
			
			return result;
		}
		
		/**
		 * Returns the 'ceiling' for the specified date - i.e. rounded up relative to the specified time unit.
		 */
		public static function ceil( date:*, unit:Number, dateFieldName:String = null ):Date
		{
			var result:Date = floor( date, unit, dateFieldName );
			
			// NOTE: This logic assumes Date's implementation properly handles overflow values.
			
			switch ( unit )
			{
				case YEAR:
					result.fullYear += 1;
					break;
				
				case QUARTER:
					result.month = calculateStartingMonthForQuarter( calculateQuarterForMonth( result.month ) + 1 );
					break;
				
				case MONTH:
					result.month += 1;
					break;
				
				case DAY:
					result.date += 1;
					break;
				
				case HOUR:
					result.hours += 1;
					break;
				
				case MINUTE:
					result.minutes += 1;
					break;
				
				case SECOND:
					result.seconds += 1;
					break;
				
				default:
					throw new Error( "Unsupported unit specified." );
			}
			
			return result;
		}
		
		/**
		 * Returns the 'floor' unit of time for the specified time interval.
		 */
		public static function floorUnit( interval:Number ):Number
		{
			if ( interval < SECOND )
				return MILLISECOND;
				
			else if ( interval < MINUTE )
				return SECOND;			
				
			else if ( interval < HOUR )
				return MINUTE;
				
			else if ( interval < DAY )
				return HOUR;
				
			else if ( interval < MONTH )
				return DAY;
				
			else if ( interval < QUARTER )
				return MONTH;
				
			else if ( interval < YEAR )
				return QUARTER;
				
			else
				return YEAR;
		}
		
		/**
		 * Returns the 'ceiling' unit of time for the specified time interval.
		 */
		public static function ceilUnit( interval:Number ):Number
		{
			if ( interval > QUARTER )
				return YEAR;
				
			else if ( interval > MONTH )
				return QUARTER;
				
			else if ( interval > DAY )
				return MONTH;
				
			else if ( interval > HOUR )
				return DAY;
				
			else if ( interval > MINUTE )
				return HOUR;
				
			else if ( interval > SECOND )
				return MINUTE;
				
			else if ( interval > MILLISECOND )
				return SECOND;
				
			else
				return MILLISECOND;
		}
		
		/**
		 * Returns the relative unit of time for the specified unit of time.
		 */
		public static function relativeUnit( unit:Number ):Number
		{
			switch ( unit )
			{
				case DateUtil.SECOND:
					return DateUtil.MINUTE;
					
				case DateUtil.MINUTE:
					return DateUtil.HOUR;
					
				case DateUtil.HOUR:
					return DateUtil.DAY;
					
				case DateUtil.DAY:
					return DateUtil.MONTH;
					
				case DateUtil.MONTH:
					return DateUtil.YEAR;
					
				case DateUtil.QUARTER:
					return DateUtil.YEAR;
					
				case DateUtil.YEAR:
					return DateUtil.YEAR;
					
				default:
					throw new Error( "Unsupported time unit specified." );
			}
		}
		
		/**
		 * Calculates the corresponding quarter for the specified month.
		 */
		public static function calculateQuarterForMonth( month:int ):int
		{
			return Math.ceil( ( month + 1 ) / 3 );
		}
		
		/**
		 * Calculates the corresponding starting month for the specified quarter.
		 */
		public static function calculateStartingMonthForQuarter( quarter:int ):int
		{
			return ( quarter - 1 ) * 3;
		}
		
		/**
		 * Returns the occurance of the day for the specified Date within the current month.
		 */
		public static function occurranceOfDayInMonth( date:Date ):int
		{
			var occurrance:int = 1;
			
			var previousWeek:Date = new Date( date.getTime() - WEEK );
			while ( previousWeek.month == date.month )
			{
				previousWeek.setTime( previousWeek.getTime() - WEEK );
				
				occurrance++;
			}
			
			return occurrance;
		}
		
		/**
		 * Returns a Boolean indicating whether the specified Date is the last occurance of the day within the current month.
		 */
		public static function isLastOccuranceOfDayInMonth( date:Date ):Boolean
		{
			var nextWeek:Date = new Date( date.getTime() + WEEK );
			
			return ( nextWeek.month != date.month );
		}
		
		// ========================================
		// Protected methods
		// ========================================
		
		/**
		 * Get a Date for the specified item and value field name.
		 */
		protected static function getDate( item:Object, dateFieldName:String ):Date
		{
			if ( ( dateFieldName != null )  && ( item != null ) )
			{
				return getValueAsDate( PropertyUtil.getObjectPropertyValue( item, dateFieldName ) );
			}
			else
			{
				return getValueAsDate( item );
			}
			
			return null;
		}
		
		/**
		 * Returns the specified Date or Date time value as a Date.
		 */
		protected static function getValueAsDate( value:* ):Date
		{
			if ( value is Date )
				return value;
			
			if ( value is Number )
				return new Date( value as Number );
			
			if ( value is String )
				return new Date( Date.parse( value as String ) );
			
			return null;
		}
	}
}