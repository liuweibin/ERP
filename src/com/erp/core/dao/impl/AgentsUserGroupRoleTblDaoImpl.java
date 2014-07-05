package com.erp.core.dao.impl;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;

import com.erp.core.dao.AgentsUserGroupRoleTblDao;
import com.erp.core.dao.HibernateEntityDao;
import com.erp.core.model.AgentsUserGroupRoleTbl;
public class AgentsUserGroupRoleTblDaoImpl extends HibernateEntityDao<AgentsUserGroupRoleTbl> implements AgentsUserGroupRoleTblDao {

	private Logger log = Logger.getLogger(AgentsUserGroupRoleTblDaoImpl.class);
	@Override
	public List<AgentsUserGroupRoleTbl> selectAgentGroupName(String agentsCode) {
		long start = System.currentTimeMillis();
		String hql="from AgentsUserGroupRoleTbl a where a.agentsCode in (-1,-2,'"+agentsCode+"')";
		Query query=getSession().createQuery(hql);
		List<AgentsUserGroupRoleTbl> agentsUserGroupTblList=query.list();
		long end  = System.currentTimeMillis();
		log.info(end-start);
		return agentsUserGroupTblList;
	}

	@Override
	public AgentsUserGroupRoleTbl getDefaultGroup() {
		// TODO Auto-generated method stub
		String hql="from AgentsUserGroupRoleTbl a where a.agentsCode=-1";
		Query query=getSession().createQuery(hql);
		return (AgentsUserGroupRoleTbl)query.list().get(0);
	}

	@Override
	public String findMaxGroupCode() {
		String hql = "select max(a.groupCode) as groupCode from AgentsUserGroupRoleTbl  a";
		Query query = this.getSession().createQuery(hql);
		return  (String)query.list().get(0);
	}

	@Override
	public List<AgentsUserGroupRoleTbl> findRoleByResourceId(int resourceId) {
		String hql = "select rr.agentsUserGroupRoleTbl from AgentsGroupRoleResourceTbl rr where rr.agentsResourceTbl.id = "+ resourceId;
		Query query = this.getSession().createQuery(hql);
		return  (List<AgentsUserGroupRoleTbl>)query.list();
	}
}