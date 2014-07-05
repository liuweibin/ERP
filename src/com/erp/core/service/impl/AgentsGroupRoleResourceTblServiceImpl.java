package com.erp.core.service.impl;

import java.util.List;

import com.erp.core.model.AgentsUserGroupRoleTbl;
import com.erp.core.service.AgentsGroupRoleResourceTblService;

public class AgentsGroupRoleResourceTblServiceImpl extends BaseService implements AgentsGroupRoleResourceTblService {

	@Override
	public List<AgentsUserGroupRoleTbl> findByResourceId(int resourceIs) {
		return this.agentsGroupRoleResourceTblDao.findByResourceId(resourceIs);
	}
	
	
	

}