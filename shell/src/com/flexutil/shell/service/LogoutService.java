package com.flexutil.shell.service;

import com.flexutil.shell.entity.common.LogonUser;



public class LogoutService extends BaseService{
	private static final long serialVersionUID = -8735671855764393214L;
	
	public void logoutUser() throws Exception {
		LogonUser logonUser			= (LogonUser) SpringApplicationContext.getBean("logonUser");
		System.out.println(logonUser.getUserFullName());
		SpringApplicationContext.getSession().invalidate();
		logonUser			= (LogonUser) SpringApplicationContext.getBean("logonUser");
		System.out.println(logonUser.getUserFullName());
	}
	
}
