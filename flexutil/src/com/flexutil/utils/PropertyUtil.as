package com.flexutil.utils
{
	import com.flexutil.data.Property;
	
	import mx.styles.IStyleClient;
	
	public class PropertyUtil
	{
		// ========================================
		// Public methods
		// ========================================

		/**
		 * Apply the specified property key / value pairs to the specified object instance.
		 * 
		 * @param instance          Target object instance.
		 * @param properties        Property key / value pairs.
		 * @param fallbackToStyles  Indicates whether to fallback to setting styles when the specified property key does not exist.
		 * @param evaluate          Indicates whether to evaluate the values against the instance.
		 */
		public static function applyProperties( instance:Object, properties:Object, fallbackToStyles:Boolean = false, evaluate:Boolean = false, callbackField:String = null ):void
		{
			if ( properties == null ) return;
			
			fallbackToStyles = fallbackToStyles && ( instance is IStyleClient );

			for ( var key:String in properties )
			{
				var value:* = properties[ key ];

				if ( evaluate )
				{
					value = RuntimeEvaluationUtil.evaluate( instance, value, callbackField );
				}
				
				var targetProperty:Property = new Property( key );
				if ( targetProperty.exists( instance ) )
				{
					targetProperty.setValue( instance, value );
				}
				else 
				{
					if ( fallbackToStyles )
					{
						( instance as IStyleClient ).setStyle( key, value );					
					}
					else 
					{
						throw new ReferenceError( "Specified property '" + key + "' does not exist." );
					}
				}
			}
		}
		
		/**
		 * Traverse a 'dot notation' style property path for the specified object instance and return the corresponding value.
		 */
		public static function getObjectPropertyValue( object:Object, propertyPath:String ):Object
		{
			try
			{
				return traversePropertyPath( object, propertyPath );
			}
			catch ( error:ReferenceError )
			{
				// return null;
			}
			
			return null;
		}
		
		/**
		 * Traverse a 'dot notation' style property path for the specified object instance and return a Boolean indicating whether the property exists.
		 */
		public static function hasProperty( object:Object, propertyPath:String ):Boolean
		{
			try
			{
				traversePropertyPath( object, propertyPath );
				
				return true;
			}
			catch ( error:ReferenceError )
			{
				// return false;
			}
			
			return false;
		}
		
		// ========================================
		// Protected methods
		// ========================================
		
		/**
		 * Traverse a 'dot notation' style property path for the specified object instance and return the corresponding value.
		 */
		protected static function traversePropertyPath( object:Object, propertyPath:String ):*	
		{
			// Split the 'dot notation' path into segments
			
			var path:Array = propertyPath.split( "." );
			
			// Traverse the path segments to the matching property value
			
			var node:* = object;
			for each ( var segment:String in path )
			{
				// Set the new parent for traversal
				
				node = node[ segment ];
			}
			
			return node;			
		}
	}
}