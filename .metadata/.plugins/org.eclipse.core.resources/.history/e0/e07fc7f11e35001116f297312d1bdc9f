package com.aramco.rcd.modules.reports.pm
{
	import com.aramco.rcd.events.ViewStackEvent;
	import com.aramco.rcd.modules.paramselection.model.IParamMenu;
	import com.aramco.rcd.modules.reports.model.IReportMenu;
//	import com.aramco.rcd.modules.sysadmin.vo.TeamVO;
//	import com.aramco.rcd.modules.sysadmin.vo.WellTypeVO;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.collections.ArrayCollection;
	
	public class ReportsPMHelper extends ReportsPMBusiness
	{ 
		
		
		/**
		 * shows the header with initial settings if any 
		 */
		protected function initHeaderData():void
		{
			/*/*switch(reportsPkg.menuOperation)
			{
				case IReportMenu.EOWR_QC_REPORT:
						var allTeams:TeamVO = new TeamVO();
						allTeams.code = 'A';
						allTeams.description = 'All Teams';
						//allTeams.divisionCode = currentDivision;
						reportsPkg.teams.addItemAt(allTeams,0);
					filterTeams();
					break;
			}*/
			
		}
		

		
		
		
		/*	public function generateYears():void
		{
			years= new ArrayCollection();
			var dt:Date = new Date();
			var currentYear:int = dt.getFullYear();
			for(var i:int=0; i<7; i++)
				years.addItem({code:currentYear-i});
		}
		
		
		public function filterTeams():void
		{
			if(reportsPkg && reportsPkg.teams)
			{
				if(reportHeader.divisionCbo)
					currentDivision = reportHeader.divisionCbo.selectedValue
				else
					currentDivision = 'GFCD';
				
				reportsPkg.teams.filterFunction = filterByDivision;
				reportsPkg.teams.refresh();
				
				if(reportHeader && reportHeader.teamNameCbo && reportsPkg.teams.length>0)
					reportHeader.teamNameCbo.selectedValue = reportsPkg.teams.getItemAt(0).code;
			}
		}
		
		private function filterByDivision(team:TeamVO):Boolean
		{
			if(team.divisionCode == currentDivision || team.divisionCode == null)
				return true;
			else
				return false;
		}*/
	}
}