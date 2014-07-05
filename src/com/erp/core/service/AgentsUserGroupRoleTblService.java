package com.erp.core.service;

import java.util.List;
import java.util.Map;

import com.erp.core.model.AgentsUserGroupRoleTbl;

public interface AgentsUserGroupRoleTblService {
	/**
	 * 查询代理商所拥有的组
	 * @param agentsCode
	 * @return
	 */
	public List<AgentsUserGroupRoleTbl> selectAgentGroupName(String agentsCode);
	
	public AgentsUserGroupRoleTbl get(int id);
	
	
	public boolean saveAgentsUserGroupRoleTbl(AgentsUserGroupRoleTbl agentsUserGroupRoleTbl,Map<Integer, String> resourceIds) throws Exception;
	
	/**
	 *删除代理商组  （当改组为默认组或者自身组是不能删除）
	 * @param id
	 * @param groupId
	 * @return
	 */
	public boolean deleteAgentsUserGroupRoleTbl(int  id,String groupId) throws Exception;
}