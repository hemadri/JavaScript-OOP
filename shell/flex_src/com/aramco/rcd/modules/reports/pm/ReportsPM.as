package com.aramco.rcd.modules.reports.pm
{
	import com.aramco.rcd.modules.paramselection.model.IParamMenu;
	import com.aramco.rcd.modules.reports.events.ReportEvent;
	import com.aramco.rcd.modules.reports.model.IReportMenu;
	import com.aramco.rcd.modules.reports.views.ReportsHeader;
	import com.aramco.rcd.modules.reports.views.ReportsView;
	import com.aramco.rcd.modules.reports.vo.ReportSelectionVO;
	import com.aramco.rcd.modules.reports.vo.ReportsPackage;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Alert;
	
	
	public class ReportsPM extends ReportsPMHelper
	{
		
		
		public function headerAdded(view:ReportsHeader):void {
			reportHeader = view;
			if(reportsPkg)
				initHeaderData();
		}
		
		/**
		 * receieved header data 
		 * 
		 */
		public function initPM(result:ReportsPackage):void {
			reportsPkg = result;
			
			if(reportHeader)
				initHeaderData();
			
		}
		
		
		public function retrieve():void
		{
			var reportSelection:ReportSelectionVO = new ReportSelectionVO();
			var incorrectParameters:Boolean;
			/*switch(reportsPkg.menuOperation)
			{
				case IReportMenu.SHIFT_HANDOVER_NOTES: 
					if(reportHeader.wellCbo.selectedValue != null)
					{
						var wellIdSet:Array= reportHeader.wellCbo.selectedValue.split('_'); 
						reportSelection.wellId = wellIdSet[0];
						reportSelection.deepeningNo = wellIdSet[1];
						reportSelection.reportDate = reportHeader.reportDate.selectedDate;
					}
					else
						incorrectParameters = true;
					break;          			
			}*/
			if(incorrectParameters)
				Alert.show('Please select a well','Error');
			else
			{
				var rEvent:ReportEvent = new ReportEvent(ReportEvent.RETRIEVE, reportsPkg.menuOperation, reportsPkg.reportCategory);
				rEvent.reportVO = reportSelection;
				dispatcher.dispatchEvent(rEvent);
			}
			
		}
		
		public function retrieveSuccess(result:String):void
		{
			if(result && result!='')
				navigateToURL(new URLRequest(result),'_blank');
			else
				Alert.show('Unable to generate the report','Error');
		}
	}
}