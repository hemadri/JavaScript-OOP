package com.flexutil.utils
{
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;

	public class SortUtil
	{
		public function SortUtil()
		{
		}
		
		public static function sortByField(fieldName:String, numeric:Boolean=false, descending:Boolean=false):Sort
		{
			var sortField:SortField = new SortField(fieldName);
			sortField.numeric = numeric;
			sortField.descending = descending;
			var sort:Sort = new Sort();
			sort.fields = [sortField];
			return sort;
		}
		
		public static function sortByFields(fieldNames:Array):Sort
		{
			var sortFields:Array = [];
			for each(var fieldName:String in fieldNames)
			{
				var sortField:SortField = new SortField(fieldName);
				sortFields.push(sortField);
			}
			
			var sort:Sort = new Sort();
			sort.fields = sortFields;
			return sort;
		}
		/**
		 * @param data - arraycollection to be sorted
		 * @param sortFields - array of strings (fieldnames/attributes of the objects)
		 * @param removeAfterSort - applied/removes the sort instance after sorting
		 */		
		public static function sortAC(data:ArrayCollection, sortFields:Array, removeAfterSort:Boolean=false):void
		{
			data.sort = sortByFields(sortFields);
			data.refresh();
			
			if(removeAfterSort)
				data.sort = null
					
		}
	}
}