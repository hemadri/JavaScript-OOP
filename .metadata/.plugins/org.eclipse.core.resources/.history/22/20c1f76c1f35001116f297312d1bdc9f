package com.aramco.rcd.service;

import com.aramco.rcd.entity.common.LogonUser;



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
