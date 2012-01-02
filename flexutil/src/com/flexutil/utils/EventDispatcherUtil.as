package com.flexutil.utils
{
	import flash.events.IEventDispatcher;

	public class EventDispatcherUtil
	{
		// ========================================
		// Public methods
		// ========================================
		
		/**
		 * Applies the specified styles to the specified style client.
		 */
		public static function addEventListeners( eventDispatcher:IEventDispatcher, eventListeners:Object, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true ):void
		{
			if ( eventDispatcher == null ) return;
			
			if ( eventListeners != null ) 
			{
				for ( var eventType:String in eventListeners )
				{
					eventDispatcher.addEventListener( eventType, eventListeners[ eventType ], useCapture, priority, useWeakReference );
				}
			}
		}		
		/**
		 * Applies the specified styles to the specified style client.
		 */
		public static function removeEventListeners( eventDispatcher:IEventDispatcher, eventListeners:Object):void
		{
			if ( eventDispatcher == null ) return;
			
			if ( eventListeners != null ) 
			{
				for ( var eventType:String in eventListeners )
				{
					eventDispatcher.removeEventListener(eventType, eventListeners[ eventType ]);//
				}
			}
		}		
	}
}