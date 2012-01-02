package com.flexutil.shell.entity.common;


/**
 * Java VO with XDOclet2 annotation for AS3 codegen.
 * 
 * @actionscript.class
 * 		bindable = true
 */ 

public class SelectionOptionsVO {
	
	private long   	epANum;
	private String 	wellName;
	private String	wellId;
	private int     deepeningNo;
	
	private int     shiftId;
	private String  selectionDate;
	
	private int 	depth;
	
	
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public long getEpANum() {
		return epANum;
	}
	public void setEpANum(long epANum) {
		this.epANum = epANum;
	}
	public String getWellName() {
		return wellName;
	}
	public void setWellName(String wellName) {
		this.wellName = wellName;
	}
	public String getWellId() {
		return wellId;
	}
	public void setWellId(String wellId) {
		this.wellId = wellId;
	}
	public int getDeepeningNo() {
		return deepeningNo;
	}
	public void setDeepeningNo(int deepeningNo) {
		this.deepeningNo = deepeningNo;
	}
	public int getShiftId() {
		return shiftId;
	}
	public void setShiftId(int shiftId) {
		this.shiftId = shiftId;
	}
	public String getSelectionDate() {
		return selectionDate;
	}
	public void setSelectionDate(String selectionDate) {
		this.selectionDate = selectionDate;
	}
	
	
	
}
