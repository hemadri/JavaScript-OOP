package com.flexutil.shell.pm
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.setTimeout;
	
	public class BaseBusiness extends EventDispatcher
	{
		public function BaseBusiness(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		[Bindable] public var status:String;
		
		
//		[Inject] public var dispatcher:IEventDispatcher;
		
//		[EventHandler( event="StatusEvent.STATUS_CHANGE", properties="statusMessage" )]
		public function updateStatus(statusMessage:String):void
		{
			status = statusMessage; 
			
			setTimeout(removeStatus, 4000);
		}
		
		/**
		 *removes the status message from the panel 
		 */		
		public function removeStatus():void
		{
			status = "";
		}
		
//		TODO: Need to destroy the PM instances
		
	}
}