package com.flexutil.shell.service;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

import com.flexutil.shell.entity.common.LoginUser;
import com.flexutil.shell.entity.common.LogonUser;


public class BaseService implements Serializable{
	private static final long serialVersionUID = -2931903074916054471L;
	@Autowired
	private LoginUser loginUser;
	@Autowired
	private LogonUser logonUser;
	
	public LogonUser getLogonUser() {
		return logonUser;
	}
	public void setLogonUser(LogonUser logonUser) {
		this.logonUser = logonUser;
	}
	public LoginUser getLoginUser() {
		return loginUser;
	}
	public void setLoginUser(LoginUser loginUser) {
		this.loginUser = loginUser;
	}
	
	
	protected Date parseDate(String strDate) throws Exception {
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		return (Date)formatter.parse(strDate);  
	}
}
