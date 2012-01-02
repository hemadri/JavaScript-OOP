package com.aramco.rcd.modules.reports.pm
{
	import com.aramco.rcd.modules.reports.model.IReportMenu;
	import com.aramco.rcd.modules.reports.views.ReportsHeader;
	import com.aramco.rcd.modules.reports.vo.ReportsPackage;
	import com.aramco.rcd.pm.BaseBusiness;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class ReportsPMBusiness extends BaseBusiness
	{ 
		
		public var reportHeader:ReportsHeader;
		[Bindable] public var reportsPkg:ReportsPackage;
		[Bindable] public var years:ArrayCollection;
		
		
		[Bindable] public var headerVisible:Boolean;
		[Bindable] public var gfcdWeeklyVisible:Boolean;
		[Bindable] public var allDrillingVisible:Boolean;
		[Bindable] public var vpReportVisible:Boolean;
		
		
//		GFCD Well List
		[Bindable] public var includedWells:ArrayCollection;
		[Bindable] public var excludedWells:ArrayCollection;
		
		[Dispatcher] public var dispatcher:IEventDispatcher;
		
		protected var currentDivision:String;
		
	}
}