package com.erp.core.service;

import java.util.List;

import com.erp.core.model.AgentsUserGroupRoleTbl;

public interface AgentsGroupRoleResourceTblService  {
	
	List<AgentsUserGroupRoleTbl> findByResourceId(int resourceIs);

}