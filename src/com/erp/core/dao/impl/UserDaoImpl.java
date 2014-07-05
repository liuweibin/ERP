package com.erp.core.dao.impl;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.erp.core.common.BaseHibernateDaoSupport;
import com.erp.core.dao.UserDao;
import com.erp.core.model.AgentsUserTbl;

public class UserDaoImpl  extends BaseHibernateDaoSupport implements UserDao {

	public void add(AgentsUserTbl u) {
		this.getHibernateTemplate().save(u);
	}
	public boolean findUser(AgentsUserTbl u) {
		List<?> list = this.getHibernateTemplate().find("from AgentsUserTbl u where u.username=?",
				u.getUsername());
		if (list.size() > 0) {
			return true;
		}
		return false;
	}

	@SuppressWarnings("unchecked")
	public List<AgentsUserTbl> userLogin(AgentsUserTbl u) {
		List<AgentsUserTbl> list = null;
		try {
			list = this.getHibernateTemplate().find(
					"from AgentsUserTbl u where u.username=? and u.password=? and u.agents.agentsCode=?", u.getUsername(),
					u.getPassword(),u.getAgents().getAgentsCode());
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public AgentsUserTbl find(String username) {
		List<AgentsUserTbl> list = null;
		try {
			list = this.getHibernateTemplate().find(
					"from AgentsUserTbl u where u.username=?",username);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return list.get(0);
	}
}
