package com.flexutil.events
{
	import flash.events.Event;
	
	import mx.events.ListEvent;

	public class DynamicGridEvent extends Event
	{
		public static const ROW_CLICK:String = "rowClicked";
		public var listEvent:ListEvent;
		
		public function DynamicGridEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}