package com.flexutil.shell.dao.lookup;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.flexutil.shell.entity.common.LogonUser;

public interface IEPMapper {

	@Select("select granted_role from dba_role_privs where grantee = user")
	List<String> selectUserRoles();
	
	
	
	@Select("") 
    LogonUser getUser();
    
	
}

