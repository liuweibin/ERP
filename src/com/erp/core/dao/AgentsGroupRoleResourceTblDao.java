package com.erp.core.dao;

import java.util.List;

import com.erp.core.model.AgentsGroupRoleResourceTbl;
import com.erp.core.model.AgentsUserGroupRoleTbl;


public interface AgentsGroupRoleResourceTblDao extends EntityDao<AgentsGroupRoleResourceTbl> {
List<AgentsUserGroupRoleTbl> findByResourceId(int resourceIs);

}