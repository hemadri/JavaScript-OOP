package com.aramco.rcd.modules.paramselection.events
{
	import flash.events.Event;
	
	public class ParamSelectionEvent extends Event
	{

		
		/**
		 * Use this for getting header selection values 
		 */
		public static const HEADER:String 	= "headerParamEvent";
		/**
		 * Use this for retrieving the data from the selection header 
		 */		
		public static const WORKSHEET:String 	= "worksheetParamEvent";
		
		
		public var menuOperation:String;
		
		public var division:String;
		public var team:String;
		public var shift:String;
		public var date:String; //mm/dd/yyyy
		
		
		/**
		 * 
		 * @param opertaionType - retrieve or header
		 * @param menuOperation - menu label name
		 * 
		 */
		public function ParamSelectionEvent(opertaionType:String, menuOperation:String )
		{
			super(opertaionType, true);
			this.menuOperation = menuOperation;
		}
	}
}