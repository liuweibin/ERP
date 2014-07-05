package com.erp.core.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.dao.DataAccessException;

import com.erp.core.dao.AgentsUserTblDao;
import com.erp.core.dao.HibernateEntityDao;
import com.erp.core.model.AgentsTbl;
import com.erp.core.model.AgentsUserGroupRoleTbl;
import com.erp.core.model.AgentsUserTbl;
import com.erp.core.util.Page;
import com.erp.core.util.StringUtil;

public class AgentsUserTblDaoImpl extends HibernateEntityDao<AgentsUserTbl> implements AgentsUserTblDao {

	public List<AgentsUserGroupRoleTbl> getRoleList(int groupid) {
		List<AgentsUserGroupRoleTbl> list = new ArrayList<AgentsUserGroupRoleTbl>();
		try {
			list = this.getHibernateTemplate().find("select ur.agentsUserGroupRoleTbl from AgentsGroupRoleResourceTbl ur where ur.agentsUserGroupRoleTbl.id = ?", groupid);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public AgentsUserTbl getAgentsUserUniqueBy(String agentsCode, String username) {
		StringBuffer sb = new StringBuffer();
		sb.append("from AgentsUserTbl a where 1=1 ");
		if(!StringUtil.isNullOrEmpty(agentsCode)){
			sb.append("  and a.agents.agentsCode = '"+ agentsCode+"'");
		}
		if(!StringUtil.isNullOrEmpty(username)){
			sb.append(" and a.username = '"+username+"'");
		}

		Query query = this.getSession().createQuery(sb.toString());
		
		List list = query.list();
		if (list.size() == 1) {
			return (AgentsUserTbl) list.get(0);
		} else {
			return null;
		}
	}

	@Override
	public Page selectEmpByCode(int pageNo, int pageSize, int agentsId) {
		// TODO Auto-generated method stub
		String hql = "from AgentsUserTbl as s where s.agents.id=" + agentsId + " and s.userType=1 order by s.createTime desc";
		Page page = super.pagedQuery(hql, pageNo, pageSize);
		return page;
	}

	@Override
	public AgentsUserTbl getAgentsUserMaster(AgentsTbl agentsTbl) {
		// TODO Auto-generated method stub
		String hql = "from AgentsUserTbl as s where s.agents.id=" + agentsTbl.getId() + " and s.userType=0";
		Query query = this.getSession().createQuery(hql);
		return (AgentsUserTbl) query.list().get(0);
	}
	@Override
	public AgentsUserTbl find(String name) {
		String hql = "from AgentsUserTbl as obj1 where obj1.username='"+name+"'";
		Query query = this.createQuery(hql);
		List<AgentsUserTbl> list = query.list();
		return list.get(0);
	}

}