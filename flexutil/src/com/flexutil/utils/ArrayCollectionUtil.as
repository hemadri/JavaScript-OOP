package com.flexutil.utils
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;

	public class ArrayCollectionUtil
	{
		public static function generateCSV(collection:ArrayCollection, propertyName:String="", seperator:String=","):String
		{
			var csvStr:String = "";
			for each(var obj:Object in collection)
			{
				if(obj is String)
					csvStr += obj.toString()+seperator;
				else
					csvStr += obj[propertyName].toString()+seperator;
			}	
			return csvStr.substring(0,csvStr.length-1);
		}
		
		public static function generateCSVObject(collection:ArrayCollection, propertyNames:Array, propertySeperator:String=",", objectSeperator:String=";"):String
		{
			var csvStr:String = "";
			for each(var obj:Object in collection)
			{
				if(obj is String)
					csvStr += obj.toString()+propertySeperator;
				else
				{
					for each(var propertyName:String in propertyNames)
						csvStr += obj[propertyName].toString()+propertySeperator;
					
					csvStr= csvStr.substring(0,csvStr.length-1)+objectSeperator;		
				}
			}	
			return csvStr.substring(0,csvStr.length-1);
		}
		
		public static function moveObjects(fromCollection:ArrayCollection, toCollection:ArrayCollection, objects:Array):void
		{
			removeObjects(fromCollection, objects);		
				
			toCollection.addAll(new ArrayCollection(objects));
		}
		
		public static function removeObjects(collection:ArrayCollection, objects:Array):void
		{
			for each(var object:Object in objects)
				collection.removeItemAt(collection.getItemIndex(object));
		}
		public static function removeObjectsById(collection:ArrayCollection, objects:ArrayCollection, collectionField:String='code', objectField:String=null):void
		{
			for each(var obj:Object in objects)
			{
				var value:Object = obj;
				if(objectField) value = obj[objectField];
				
				if(value)
				for (var i:int=0; i<collection.length; i++)
				{
					if(collection[i][collectionField] == value)
					{
						collection.removeItemAt(i);
						break;
					}
				}
			}
		}
		
		public static function getObjectByValue(collection:ArrayCollection, value:Object, idField:String='code'):Object
		{
			for each(var obj:Object in collection)
				if(obj[idField] == value)
					return obj;
				
			return null;
		}
		
		public static function getIndexByValue(collection:ArrayCollection, value:Object, idField:String):int
		{
			for (var i:int=0;i <collection.length; i++)
				if(collection.getItemAt(i)[idField] == value)
					return i;
			
			return -1;
		}
		
		public static function fillDescription(toCollection:ArrayCollection, fromCollection:ArrayCollection, toProperty:String='description', fromProperty:String='code'):void
		{
			for each(var toObj:Object in toCollection)
				for each (var fromObj:Object in fromCollection)
					if(toObj[fromProperty] == fromObj[fromProperty])
					{
						toObj[toProperty] = fromObj[toProperty];
						break;
					}
		}
		
//		TODO: Add one more condition to ignore nulls
		public static function checkDuplicates(collection:ArrayCollection, property:String = 'code'):Boolean
		{
//			TODO: change the below code with index based searching for duplication, which reduces the loop
			var valueExists:Boolean;
			for each(var outerRecord:Object in collection)
			{
				valueExists = false;
				for each(var innerRecord:Object in collection)
				{
					if(outerRecord[property] && innerRecord[property])
						if(outerRecord[property] == innerRecord[property])
						{
							if(!valueExists)
								valueExists = true;
							else
								return true; //		duplicate exists
						}
				}
			}
			return false;
		}
		
		
		public static function checkNull(collection:ArrayCollection, property:String = 'code'):Boolean
		{
			for each(var record:Object in collection)
			{
				if (record.hasOwnProperty(property) && (record[property] == null || record[property] == ''))
					return true;
			}
			return false;
		}
		public static function checkNulls(collection:ArrayCollection, properties:Array):Boolean
		{
			for each(var record:Object in collection)
			{
				for each(var property:String in properties)
				{
					if (record.hasOwnProperty(property) && (record[property] == null || record[property] == ''))
						return true;
				}
			}
			return false;
		}
		
		public static function checkAllNulls(collection:ArrayCollection, property1:String, property2:String):Boolean
		{
			for each(var record:Object in collection)
			{
				if (record.hasOwnProperty(property1) &&  record.hasOwnProperty(property2))
					if((record[property1] == null || record[property1] == '') && (record[property2] == null || record[property2] == ''))
						return true;
			}
			return false;
		}
		
		public static function getUniqueObjects (collection : ArrayCollection) : ArrayCollection {
			var length : Number = collection.length;
			var dic : Dictionary = new Dictionary();
			var unique:ArrayCollection = new ArrayCollection();
			
			//this should be whatever type of object you have inside your AC
			var value : Object;
			for(var i : Number = 0; i < length; i++){
				value = collection.getItemAt(i);
				dic[value] = value;
			}
			
			//this bit goes through the dictionary and puts data into a new AC
			for(var prop :String in dic){
				unique.addItem(dic[prop]);
			}
			return unique;
		}
		
		private function getDistinctPropertyValues1(collection:ArrayCollection, propertyName:String='label'):ArrayCollection {
			//prepare result array
			var distinctValuesCollection:ArrayCollection = new ArrayCollection();
			
			//loop over all the objects in the collection
			for each (var object:Object in collection){
				//get the property value from the object
				var propertyValue:Object = object[propertyName];
				
				//if the value is not in the distinct value collection ....
				if (distinctValuesCollection.getItemIndex(propertyValue) == -1){
					//add the value to the collection
					distinctValuesCollection.addItem(propertyValue);
				}
			}
			
			//return the collection of distinct values
			return distinctValuesCollection;
		}
		
		private function getDistinctPropertyValues2(collection:ArrayCollection, propertyName:String):ArrayCollection {
			//prepare result array
			var distinctValuesCollection:ArrayCollection = new ArrayCollection();
			
			//prepare a temp working array
			var tempPropertyArray:Array = [];
			
			//loop over all the objects in the collection
			for each (var object:Object in collection) {
				//get the property value from the object
				var propertyValue:Object = object[propertyName];
				
				//write the value as a property
				tempPropertyArray[propertyValue] = object;
			}
			
			//loop over all the properties in the tempPropertyArray
			for (var propertyName:String in tempPropertyArray) {
				//add the propertyName (which is actually a distinct property value)
				//to the distinct values collection
				distinctValuesCollection.addItem(tempPropertyArray[propertyName]);
			}
			
			//return the collection of distinct values
			return distinctValuesCollection;
		}
		
		
		
		
	}
}