package com.erp.core.dao;

import java.util.List;

import com.erp.core.model.AgentsTbl;
import com.erp.core.model.AgentsUserGroupRoleTbl;
import com.erp.core.model.AgentsUserTbl;
import com.erp.core.util.Page;
public interface AgentsUserTblDao extends EntityDao<AgentsUserTbl> {
	public List<AgentsUserGroupRoleTbl> getRoleList(int groupid);
	
	public AgentsUserTbl getAgentsUserUniqueBy(String agentsCode,String username);
	
	public Page selectEmpByCode(int pageNo, int pageSize,int agentsId);
	//得到代理商权限的用户
	public AgentsUserTbl getAgentsUserMaster(AgentsTbl agentsTbl);
	AgentsUserTbl find(String name);
}