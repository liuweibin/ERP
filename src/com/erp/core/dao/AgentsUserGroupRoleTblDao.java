package com.erp.core.dao;

import java.util.List;

import com.erp.core.model.AgentsUserGroupRoleTbl;

public interface AgentsUserGroupRoleTblDao extends EntityDao<AgentsUserGroupRoleTbl> {
	
	/**
	 * 查询代理商所拥有的组
	 * @param agentsCode
	 * @return
	 */
	List<AgentsUserGroupRoleTbl> selectAgentGroupName(String agentsCode);
	
	/**
	 * 查询代理商默认组
	 */
	public AgentsUserGroupRoleTbl getDefaultGroup();

	
	String findMaxGroupCode();
	
	public List<AgentsUserGroupRoleTbl> findRoleByResourceId(int resourceId);
}