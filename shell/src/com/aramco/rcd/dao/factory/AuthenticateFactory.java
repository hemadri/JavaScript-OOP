package com.aramco.rcd.dao.factory;

import java.util.List;

import com.aramco.rcd.dao.lookup.IEPMapper;
import com.aramco.rcd.entity.common.LogonUser;

public class AuthenticateFactory extends BaseFactory {
	
	public boolean isUserHasPrivilege() throws Exception {
		
		boolean userRoles = false;
		try {
			IEPMapper mapper = this.getOrclSqlSession().getMapper(IEPMapper.class);
			List<String> userRolesList = mapper.selectUserRoles();
			if (userRolesList.size() > 0)
				userRoles = true;
		}
		catch(Exception ex) {
			throw ex;
		}
		
		return userRoles;
	}
	
	public LogonUser getUser() throws Exception {
		IEPMapper mapper = this.getOrclSqlSession().getMapper(IEPMapper.class);
		return mapper.getUser();
	}
	
}
