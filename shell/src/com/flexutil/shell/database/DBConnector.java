package com.flexutil.shell.database;

import java.sql.Connection;
import java.sql.DriverManager;


public class DBConnector {
	private String dbURL;
	ConnectionProperties cp = new ConnectionProperties();
	
	public Connection getOrclConnection(String user,String password) throws Exception {
		Class.forName("oracle.jdbc.OracleDriver").newInstance();
		
		String dbInstanceURL = dbURL+cp.getOracleInstance();
		Connection appConnection = DriverManager.getConnection(dbInstanceURL, user, password);
		appConnection.setAutoCommit(false);		
		return appConnection;
	}


	public String getDbURL() {
		return dbURL;
	}
	public void setDbURL(String dbURL) {
		this.dbURL = dbURL;
	}
}
