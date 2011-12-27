package com.flexutil.utils
{
	import flash.utils.ByteArray;
	import flash.utils.describeType;

	public class ObjectUtil
	{
		public function ObjectUtil()
		{
		}
		
		/**  * copies a source object to a destination object  
		 	 * @param sourceObject the source object  
			 * @param destinationObject the destination object  
			 * 
		*/
		public static function copyObject(sourceObject:Object, destinationObject:Object):void 
		{     
			
			// check if the objects are not null     
			if((sourceObject) && (destinationObject)) {         
				try {             
					//retrive information about the source object via XML             
					var sourceInfo:XML = describeType(sourceObject);             
					var objectProperty:XML;             
					var propertyName:String;              
					
					// loop through the properties             
					for each(objectProperty in sourceInfo.variable){                 
						propertyName = objectProperty.@name;                 
						if(sourceObject[objectProperty.@name] != null){                     
							if(destinationObject.hasOwnProperty(objectProperty.@name)){                         
								destinationObject[objectProperty.@name] = sourceObject[objectProperty.@name];                     
							}                 
						}             
					}             
					
					//loop through the accessors             
					for each(objectProperty in sourceInfo.accessor) {                 
						if(objectProperty.@access == "readwrite") {                     
							propertyName = objectProperty.@name;                     
							if(sourceObject[objectProperty.@name] != null) {                         
								if(destinationObject.hasOwnProperty(objectProperty.@name)) {                             
									destinationObject[objectProperty.@name] = sourceObject[objectProperty.@name];                         
								}                     
							}                 
						}             
					}         
				}         
				catch (err:*) {    
					;
				}         
			}
		}
		
		/**  * creates a new object from the source Object  
		 * @param 	sourceObject
		 * @return 	copy of object   
		 * 
		 */
		public static function getCopy(value:Object):Object {
			var buffer:ByteArray = new ByteArray();
			buffer.writeObject(value);
			buffer.position = 0;
			return buffer.readObject();
		}
	}
}