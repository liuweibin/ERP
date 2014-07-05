package com.erp.core.dao.impl;

import java.util.List;

import com.erp.core.dao.AgentsGroupRoleResourceTblDao;
import com.erp.core.dao.HibernateEntityDao;
import com.erp.core.model.AgentsGroupRoleResourceTbl;
import com.erp.core.model.AgentsUserGroupRoleTbl;
public class AgentsGroupRoleResourceTblDaoImpl extends HibernateEntityDao<AgentsGroupRoleResourceTbl> implements AgentsGroupRoleResourceTblDao {

	@Override
	public List<AgentsUserGroupRoleTbl> findByResourceId(int resourceIs) {
		return (List<AgentsUserGroupRoleTbl>) this.getSession().createQuery("select rr.agentsUserGroupRoleTbl from AgentsGroupRoleResourceTbl rr where rr.agentsResourceTbl.id = "+resourceIs);
	}
	
	
	
}