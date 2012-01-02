package com.flexutil.shell.entity.common;

import com.flexutil.shell.entity.BaseVO;
/**
 * Java VO with XDOclet2 annotation for AS3 codegen.
 * 
 * @actionscript.class
 * 		bindable = true
 */
@SuppressWarnings("serial")
public class LogonUser extends BaseVO {
    private String userDivision;
    private String appAdmin;
    private String gocMember;
    private String userFullName;
    private String userCategory;
    private String userBadgeNo;
    private String userTeam;
    
	public String getUserDivision() {
		return userDivision;
	}
	public void setUserDivision(String userDivision) {
		this.userDivision = userDivision;
	}
	public String getAppAdmin() {
		return appAdmin;
	}
	public void setAppAdmin(String appAdmin) {
		this.appAdmin = appAdmin;
	}
	public String getGocMember() {
		return gocMember;
	}
	public void setGocMember(String gocMember) {
		this.gocMember = gocMember;
	}
	public String getUserFullName() {
		return userFullName;
	}
	public void setUserFullName(String userFullName) {
		this.userFullName = userFullName;
	}
	public String getUserCategory() {
		return userCategory;
	}
	public void setUserCategory(String userCategory) {
		this.userCategory = userCategory;
	}
	public String getUserBadgeNo() {
		return userBadgeNo;
	}
	public void setUserBadgeNo(String userBadgeNo) {
		this.userBadgeNo = userBadgeNo;
	}
	public String getUserTeam() {
		return userTeam;
	}
	public void setUserTeam(String userTeam) {
		this.userTeam = userTeam;
	}
}
