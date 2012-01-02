package com.aramco.rcd.modules.reports.events
{
	import com.aramco.rcd.modules.reports.vo.ReportSelectionVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class ReportEvent extends Event
	{
		
		public static const HEADER:String = 'ReportsMenuClick';
		public static const RETRIEVE:String = 'ReportsRetrieve';
		
		public var worksheetChanges:Array;
		public var reportDate:Date;
		
		public var reportCategory:String;
		public var menuOperation:String;
		public var reportVO:ReportSelectionVO;
		
		public function ReportEvent(type:String, menuOperation:String="", reportCategory:String="")
		{
			super(type, true);
			this.menuOperation = menuOperation;
			this.reportCategory = reportCategory;
		}
	}
}