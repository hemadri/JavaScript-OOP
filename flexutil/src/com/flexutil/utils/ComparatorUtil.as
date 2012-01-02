package com.flexutil.utils
{
	import com.flexutil.data.Property;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.IList;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	import mx.utils.object_proxy;
	
	public class ComparatorUtil
	{
		// ========================================
		// Public methods
		// ========================================
		
		/**
		 * Traverses and compares the properties of two objects of the same type (with an optional property exclusion list) and
		 * returns a list of properties that don't match.
		 *
		 * @param object1             The first object to compare.
		 * @param object2             The second object to compare.
		 * @param excludedProperties  An array of Property instances indicating the properties to exclude / ignore. (Optional)
		 *
		 * @return Array of Property instances for the properties that do not match between the two object instances.
		 */
		public static function compare( object1:Object, object2:Object, excludedProperties:Array = null ):Array
		{
			// Generate a map for the excluded property list for faster lookup
			
			var excludedPropertyMap:Dictionary = new Dictionary();
			
			for each ( var excludedProperty:Property in excludedProperties )
			{
				excludedPropertyMap[ excludedProperty.path ] = excludedProperty;
			}
			
			// Call the internal recursive compare method to evaluate the two objects
			
			return _compare( object1, object2, excludedPropertyMap );
		}
		
		// ========================================
		// Protected methods
		// ========================================
		
		/**
		 * Internal recursive object / property comparison evaluation method.
		 *
		 * @param object1              The first object to compare.
		 * @param object2              The second object to compare.
		 * @param excludedPropertyMap  A Dictionary-based map of the Properties to exclude / ignore. (Optional)
		 * @param Property             The specific Property to evaluate (used for recursion).
		 */
		protected static function _compare( object1:Object, object2:Object, excludedPropertyMap:Dictionary, property:Property = null ):Array
		{
			// Get the property to compare (or use the original objects themselves if no property was specified)
			
			var value1:* = (property != null) ? property.getValue( object1 ) : object1;
			var value2:* = (property != null) ? property.getValue( object2 ) : object2;
			
			// Null checks
			
			if ( value1 == null && value2 == null )
				return [];
			if ( value1 == null )
				return [property ];
			if ( value2 == null )
				return [property ];
			
			// Use the actual object if a proxy is being used
			
			if ( value1 is ObjectProxy )
				value1 = ObjectProxy( value1 ).object_proxy::object;
			if ( value2 is ObjectProxy )
				value2 = ObjectProxy( value2 ).object_proxy::object;
			
			var typeOfValue1:String = typeof( value1 );
			var typeOfValue2:String = typeof( value2 );
			
			// Compare the values, 'flag' properties that don't match
			
			var flaggedProperties:Array = new Array();
			
			if( typeOfValue1 == typeOfValue2 )
			{
				var type:String = typeOfValue1;
				
				switch( type )
				{
					case "object":
						
						if ( ( ( value1 is Array     ) && ( value2 is Array     ) ) ||
						     ( ( value1 is Date      ) && ( value2 is Date      ) ) ||
						     ( ( value1 is IList     ) && ( value2 is IList     ) ) ||
							 ( ( value1 is ByteArray ) && ( value2 is ByteArray ) ) )
						{
							// Array, Date, IList or ByteArray
							
							// Use ObjectUtil to do a basic comparison
							
							if (mx.utils.ObjectUtil.compare( value1, value2 ) != 0 )
								flaggedProperties.push( property );
						}
						else if ( getQualifiedClassName( value1 ) == getQualifiedClassName( value2 ) )
						{
							// Class
							
							// Iterate and recursively compare all the (non-excluded) properties
							
							var properties:Array = mx.utils.ObjectUtil.getClassInfo( value1 ).properties;
							for ( var i:int = 0; i < properties.length; i++ )
							{
								var childProperty:Property = new Property( properties[ i ].localName, property );
								
								// If this property is not excluded, recursively compare
								
								if ( excludedPropertyMap[ childProperty.path ] == null )
								{
									// Recursive call to the compare method
									
									var differences:Array = _compare( object1, object2, excludedPropertyMap, childProperty );
									for each ( var difference:Property in differences )
									{
										flaggedProperties.push( difference );
									}
								}
							}
						}
						break;
					
					default:
					case "boolean":
					case "number":
					case "string":
						
						// Boolean, Number (int, etc.), String
						
						// Do a direct comparison
						
						if( value1 != value2 )
							flaggedProperties.push( property );
						break;
				}
			}
			else
			{
				// Types don't match
				
				flaggedProperties.push( property );
			}
			
			return flaggedProperties;
		}
	}
}