package com.aramco.rcd.entity.common;

import java.io.Serializable;
import java.sql.Connection;

/**
 * Java VO with XDOclet2 annotation for AS3 codegen.
 * 
 * @actionscript.class
 * 		bindable = true
 */

@SuppressWarnings("serial")
public class LoginUser implements Serializable{
	
	private String userName;
	private String orclPassword;
	private String docPassword;
	private Connection orclConnection;
	
	public void destroy() throws Exception {
		try {
			if (this.getOrclConnection() != null) {
				this.getOrclConnection().rollback();
				this.getOrclConnection().close();
				this.setOrclConnection(null);
			}
		}
		catch(Exception ex) {}
	}
	
	
	public Connection getOrclConnection() {
		return orclConnection;
	}
	public void setOrclConnection(Connection orclConnection) {
		this.orclConnection = orclConnection;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getOrclPassword() {
		return orclPassword;
	}
	public void setOrclPassword(String orclPassword) {
		this.orclPassword = orclPassword;
	}
	public String getDocPassword() {
		return docPassword;
	}
	public void setDocPassword(String docPassword) {
		this.docPassword = docPassword;
	}
	
	
}
