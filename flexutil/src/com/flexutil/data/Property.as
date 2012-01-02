package com.flexutil.data
{
	import com.flexutil.utils.PropertyUtil;

	public class Property
	{
		// ========================================
		// Protected properties
		// ========================================
		
		/**
		 * Backing variable for <code>path</code> property.
		 */
		protected var _path:String;
		
		// ========================================
		// Public properties
		// ========================================
		
		/**
		 * Returns the path for this property, using 'dot notation' (ex. 'a.b.c').
		 */
		public function get path():String
		{
			return _path;
		}
		
		// ========================================
		// Constructor
		// ========================================
		
		/**
		 * Constructor
		 */
		public function Property( path:String, parent:Property = null )
		{
			_path = ( parent != null ) ? parent.path + "." + path : path;
		}
		
		// ========================================
		// Public methods
		// ========================================
		
		/**
		 * Gets the value for a property of this type for a given object instance.
		 */
		public function getValue( object:Object ):*
		{
			return PropertyUtil.getObjectPropertyValue( object, path );
		}
		
		/**
		 * Sets the value for a property of this type for a given object instance.
		 */
		public function setValue( object:Object, value:* ):void
		{
			object[ path ] = value;
		}
		
		/**
		 * Returns a Boolean indicating whether the specified object instance has this property.
		 */
		public function exists( object:Object ):Boolean
		{
			return PropertyUtil.hasProperty( object, path );
		}
		
		/**
		 * @inheritDoc
		 */
		public function toString():String
		{
			return path;
		}
	}
}