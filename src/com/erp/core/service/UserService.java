package com.erp.core.service;
import java.util.List;

import com.erp.core.model.AgentsUserTbl;


public interface UserService {

	public void add(AgentsUserTbl user) ;

	public boolean exist(AgentsUserTbl user);

	public List<AgentsUserTbl>  login(AgentsUserTbl user) ;
}
