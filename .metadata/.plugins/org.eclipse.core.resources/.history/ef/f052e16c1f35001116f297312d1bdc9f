package com.aramco.rcd.dao.factory;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;

import com.aramco.rcd.dao.lookup.IEPMapper;
import com.aramco.rcd.entity.common.LoginUser;
import com.aramco.rcd.entity.common.LogonUser;

public abstract class BaseFactory {

	private static SqlSessionFactory orclSessionFactory;
	
	@Autowired
	private LogonUser	logonUser;
	
	@Autowired
	private LoginUser loginUser;
	private String iBatisConfigFileLocation;
	private SqlSession orclSqlSession;
	
	
	public String getiBatisConfigFileLocation() {
		return iBatisConfigFileLocation;
	}
	public void setiBatisConfigFileLocation(String iBatisConfigFileLocation) {
		if (BaseFactory.orclSessionFactory == null) {
			this.iBatisConfigFileLocation = iBatisConfigFileLocation;
			
			try {
				Reader reader = Resources.getResourceAsReader(this.iBatisConfigFileLocation);
				BaseFactory.orclSessionFactory = new SqlSessionFactoryBuilder().build(reader);
				reader.close();		
				
				//Later Move the below lines of configuration outside....
//				BaseFactory.orclSessionFactory.getConfiguration().addMapper(ILookupMapper.class);
				BaseFactory.orclSessionFactory.getConfiguration().addMapper(IEPMapper.class);
			}
			catch (IOException ioe) {
				ioe.printStackTrace();
				
			}
			catch(Exception ex) {
				ex.printStackTrace();
			}
		}
	}
	
	public String dateToString(Date date) {
		try {
			return dateFormatStr.format(date);
		}
		catch(Exception ex) {}
		return null;
	}
	public String dateToString(Object ObjDate) {
		try {
			return dateFormatStr.format((Date)ObjDate);
		}
		catch(Exception ex) {}
		return null;
	}
	public String dateTimeToString(Object ObjDate) {
		try {
			return dateTimeFormatObj.format((Date)ObjDate);
		}
		catch(Exception ex) {}
		return null;
	}
	
	protected SimpleDateFormat dateTimeFormatObj = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	protected SimpleDateFormat dateFormatObj = new SimpleDateFormat("yyyy-MM-dd");
	private SimpleDateFormat dateFormatStr = new SimpleDateFormat("MM/dd/yyyy", new Locale("en","US"));
	
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
	public SqlSession getOrclSqlSession() throws SQLException {
		if (this.orclSqlSession == null || this.orclSqlSession.getConnection().isClosed()) {
			this.orclSqlSession = orclSessionFactory.openSession(loginUser.getOrclConnection());
		}
		return orclSqlSession;
	}
	public void setOrclSqlSession(SqlSession orclSqlSession) {
		this.orclSqlSession = orclSqlSession;
	}
}
