package com.flexutil.shell.entity.reports;

import java.util.Date;
public class ReportSelectionVO {

	private Date   reportDate;
	
//	private List<WellNameVO>  wellList;
	
	private String url;
	
	private String wellId;
	private String deepeningNo;
	
	private long epANum;

	public Date getReportDate() {
		return reportDate;
	}

	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getWellId() {
		return wellId;
	}

	public void setWellId(String wellId) {
		this.wellId = wellId;
	}

	public String getDeepeningNo() {
		return deepeningNo;
	}

	public void setDeepeningNo(String deepeningNo) {
		this.deepeningNo = deepeningNo;
	}

	public long getEpANum() {
		return epANum;
	}

	public void setEpANum(long epANum) {
		this.epANum = epANum;
	}
	
	
}
