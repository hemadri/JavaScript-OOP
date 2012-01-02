package com.flexutil.shell.modules.reports.controller
{
	import com.flexutil.shell.modules.reports.pm.ReportsPM;
	import com.flexutil.shell.modules.reports.vo.ReportSelectionVO;
	import com.flexutil.shell.modules.reports.vo.ReportsPackage;
	
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.swizframework.controller.AbstractController;
	
	public class ReportsController extends AbstractController
	{
		public function ReportsController()
		{
			super();
		}
		
		[Inject("reportService")]
		public var reportsService:RemoteObject;
		
		[Inject("reportsPM")]
		public var reportsPM:ReportsPM;
		
		public var reportDate:Date;
		
		[EventHandler(event="ReportEvent.HEADER", properties="menuOperation,reportCategory" )]
		public function getHeaderData(menuOperation:String,reportCategory:String):void 
		{
			executeServiceCall(reportsService.getHeaderData(menuOperation,reportCategory), getHeaderData_success);
		}
		
		[EventHandler(event="ReportEvent.RETRIEVE", properties="menuOperation, reportVO,reportCategory" )]
		public function retrieveReport(menuOperation:String, reportVO:ReportSelectionVO,reportCategory:String):void 
		{
			executeServiceCall(reportsService.retrieve(reportVO,menuOperation, reportCategory), reportRetrieve_success);
		}
		
		private function getHeaderData_success(event:ResultEvent):void
		{
			reportsPM.initPM(event.result as ReportsPackage);
		}
		private function reportRetrieve_success(event:ResultEvent):void
		{
			reportsPM.retrieveSuccess(event.result as String);
		}
		
		private function reportError(e:Event):void
		{
			Alert.show(e.toString());	
		}
		
	}
}