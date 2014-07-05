package com.erp.core.dao;

import java.util.List;

import com.erp.core.model.AgentsUserTbl;




public interface UserDao {

	public void add(AgentsUserTbl u) ;
	
	public boolean findUser(AgentsUserTbl u);

	public List<AgentsUserTbl>  userLogin(AgentsUserTbl u) ;
	
	public AgentsUserTbl  find(String username) ;
}
