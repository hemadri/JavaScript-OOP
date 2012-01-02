package com.aramco.rcd.entity.reports;

public class ReportsPackage {

//	private List<WellTypeVO>	 wellType;
	private String			 	 menuOperation;
	private String 				 reportCategory;
	private String 				 url;
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getMenuOperation() {
		return menuOperation;
	}
	public void setMenuOperation(String menuOperation) {
		this.menuOperation = menuOperation;
	}
	public String getReportCategory() {
		return reportCategory;
	}
	public void setReportCategory(String reportCategory) {
		this.reportCategory = reportCategory;
	}

}
