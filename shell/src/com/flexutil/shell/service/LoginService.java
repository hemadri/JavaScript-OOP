package com.flexutil.shell.service;

import java.sql.Connection;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.flexutil.shell.dao.factory.AuthenticateFactory;
import com.flexutil.shell.database.DBConnector;
import com.flexutil.shell.entity.common.LoginUser;
import com.flexutil.shell.entity.common.LogonUser;


public class LoginService extends BaseService{
	private static final long serialVersionUID = -8735671855764393214L;
	
	@Autowired
//	private DCTMConnector dCTMConnector;
	private DBConnector dbConnector;
	private LoginUser	loginUser;	
	@Autowired
	private LogonUser	logonUser;
	@Autowired
	private AuthenticateFactory authenticateFactory;
	
	public void logoutUser() throws Exception {
		SpringApplicationContext.getSession().invalidate();
	}
	
	public LogonUser validateLogin(String user,String orclPassword,String docPassword) throws Exception {
		Connection connection = null;
		try {
			connection = this.getDbConnector().getOrclConnection(user, orclPassword);
			this.getLoginUser().setOrclConnection(connection);	
			//Check if the user Authentication privileges....
				if (!authenticateFactory.isUserHasPrivilege())
					throw new Exception("Oracle Role have not been granted...");
				
				//get user Authorization Privileges 
				LogonUser authUser = authenticateFactory.getUser();
					if (authUser == null) 
						throw new Exception ("Unauthorized User...");
					BeanUtils.copyProperties(authUser, logonUser);
					
			//validate the Documentum Access
//					IDfSessionManager sMgr = dCTMConnector.getSessionManager(user, docPassword);	//
//					this.getLoginUser().setDocSessionManager(sMgr);
					
		}
		catch(Exception ex) {
			this.getLoginUser().destroy();
			ex.printStackTrace();
			throw ex;
		}
		return logonUser;
	}
	public LogonUser validateLogin(String user,String orclPassword) throws Exception {
		return validateLogin(user, orclPassword, orclPassword);
	}
	
	public LoginUser getLoginUser() {
		return loginUser;
	}

	@Autowired	
	public void setLoginUser(LoginUser loginUser) {
		this.loginUser = loginUser;
	}
	public DBConnector getDbConnector() {
		return dbConnector;
	}
	@Autowired	
	public void setDbConnector(DBConnector dbConnector) {
		this.dbConnector = dbConnector;
	}
}
