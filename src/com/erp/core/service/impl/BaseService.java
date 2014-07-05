package com.erp.core.service.impl;

import com.erp.core.dao.AgentsGroupRoleResourceTblDao;
import com.erp.core.dao.AgentsResourceTblDao;
import com.erp.core.dao.AgentsTblDao;
import com.erp.core.dao.AgentsUserGroupRoleTblDao;
import com.erp.core.dao.AgentsUserTblDao;

public class BaseService {

	public AgentsTblDao agentsTblDao;

	public AgentsUserGroupRoleTblDao agentsUserGroupRoleTblDao;

 
	public AgentsGroupRoleResourceTblDao agentsGroupRoleResourceTblDao;

	public AgentsResourceTblDao agentsResourceTblDao;
	public AgentsUserTblDao agentsUserTblDao;

	public AgentsTblDao getAgentsTblDao() {
		return agentsTblDao;
	}

	public void setAgentsTblDao(AgentsTblDao agentsTblDao) {
		this.agentsTblDao = agentsTblDao;
	}

	public AgentsUserGroupRoleTblDao getAgentsUserGroupRoleTblDao() {
		return agentsUserGroupRoleTblDao;
	}

	public void setAgentsUserGroupRoleTblDao(
			AgentsUserGroupRoleTblDao agentsUserGroupRoleTblDao) {
		this.agentsUserGroupRoleTblDao = agentsUserGroupRoleTblDao;
	}

	public AgentsGroupRoleResourceTblDao getAgentsGroupRoleResourceTblDao() {
		return agentsGroupRoleResourceTblDao;
	}

	public void setAgentsGroupRoleResourceTblDao(
			AgentsGroupRoleResourceTblDao agentsGroupRoleResourceTblDao) {
		this.agentsGroupRoleResourceTblDao = agentsGroupRoleResourceTblDao;
	}

	public AgentsResourceTblDao getAgentsResourceTblDao() {
		return agentsResourceTblDao;
	}

	public void setAgentsResourceTblDao(AgentsResourceTblDao agentsResourceTblDao) {
		this.agentsResourceTblDao = agentsResourceTblDao;
	}

	public AgentsUserTblDao getAgentsUserTblDao() {
		return agentsUserTblDao;
	}

	public void setAgentsUserTblDao(AgentsUserTblDao agentsUserTblDao) {
		this.agentsUserTblDao = agentsUserTblDao;
	}

       

}