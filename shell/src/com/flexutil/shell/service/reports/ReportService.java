package com.flexutil.shell.service.reports;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;


import com.flexutil.shell.entity.reports.ReportSelectionVO;
import com.flexutil.shell.entity.reports.ReportsPackage;

public class ReportService { //extends LookupFactoryServiceHelper{
	private static final long serialVersionUID = -8213548726829794321L;
	private ReportsPackage reportsPackage;
	
	public ReportsPackage getHeaderData(String menuOperation,String reportCategory) throws Exception {
		reportsPackage = new ReportsPackage();
		reportsPackage.setMenuOperation(menuOperation);
		reportsPackage.setReportCategory(reportCategory);
		
		Map<String, String> reportParam = new HashMap<String, String>();
		reportParam.put("REPORT_FORMAT","PDF");	
		
		//No Parameter Selection is Required......
		//**************** SET the URL directly **************************
//			if (menuOperation.equalsIgnoreCase(IReportMenu.GFCD_WELLLIST)) {
//				reportParam.put("REPORT_NAME", "gfcd_well_list"); 
//				reportsPackage.setUrl(getCrystalURL(reportParam));
//			}
//			else
//			{	
//				if (menuOperation.equalsIgnoreCase(IReportMenu.SHIFT_OPERATIONS_SUMMARY)) {
//				reportsPackage.setTeams(this.getTeamFactory().retrieveAll());
//		    }
		return reportsPackage;
	}
	
	public String retrieve(ReportSelectionVO report, String menuOperation,String reportCategory) throws Exception {
		Map<String, String> reportParam = new HashMap<String, String>();
		reportParam.put("REPORT_FORMAT","PDF");	
//		if (menuOperation.equalsIgnoreCase(IReportMenu.IR_REPORT)) {
//			reportParam.put("REPORT_NAME", "IntegratedRequirements"); 
//			reportParam.put("P_EP_A_NUM", String.valueOf(report.getEpANum()));
//		}
		
		return this.getCrystalURL(reportParam);
	}
	
	private String getCrystalURL(Map<String, String> reportParam) throws Exception {
		
//		CrystalDocument document = new CrystalDocument(reportParam.get("REPORT_NAME"));
//		document.setNullEmpty(true);
//		document.setEmbedOutput(false);
//		document.setEnvironment(Document.Environment.DEVL);
//		
//		
//		if (reportParam.get("REPORT_FORMAT") == null )
//			document.setFormat(Document.OutputFormat.PDF);
//		else if (reportParam.get("REPORT_FORMAT").equals("PDF"))
//			document.setFormat(Document.OutputFormat.PDF);
//		else
//			document.setFormat(Document.OutputFormat.WORD);
//		
//		
//		Iterator<String> paramNames= reportParam.keySet().iterator();
//		while (paramNames.hasNext()) {
//			String PARAM_NAME = paramNames.next();
//			if (PARAM_NAME.equals("REPORT_NAME") || PARAM_NAME.equals("REPORT_FORMAT")) {
//				//don't do anything....
//			}
//			else
//				document.addParameter(new SingleValueParameter(PARAM_NAME,reportParam.get(PARAM_NAME)));
//		}
//		System.out.println(document.getDocumentUrl());
//		return document.getDocumentUrl();
		return "";
	}
}