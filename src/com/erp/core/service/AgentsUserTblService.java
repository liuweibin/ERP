package com.erp.core.service;
import java.util.List;

import com.erp.core.model.AgentsResourceTbl;
import com.erp.core.model.AgentsTbl;
import com.erp.core.model.AgentsUserGroupRoleTbl;
import com.erp.core.model.AgentsUserTbl;
import com.erp.core.util.Page;
public interface AgentsUserTblService {
	
	public void saveOrUpdate(AgentsUserTbl agentsUserTbl);
	
	public void deleteCustomUserTbl(int id);
	
	public List<AgentsUserTbl> getAll();
	

	public AgentsUserTbl get(int id);
	
	public AgentsUserTbl findUniqueBy(String propertyName,String value);
	
	void save(AgentsUserTbl agentsUserTbl);	
	
	
	public AgentsUserTbl getAgentsUserUniqueBy(String agentsCode,String username);
	
	
	public List<AgentsResourceTbl>  getAllResource();
	
	public List<AgentsUserGroupRoleTbl> findRoleByResourceId(int resourceId);
	
	public Page selectEmpByCode(int pageNo, int pageSize,int agentsId);
	public AgentsUserTbl getAgentsUserMaster(AgentsTbl agentsTbl);
}