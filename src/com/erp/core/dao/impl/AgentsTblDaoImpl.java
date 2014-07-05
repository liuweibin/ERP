package com.erp.core.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;

import com.erp.core.dao.AgentsTblDao;
import com.erp.core.dao.HibernateEntityDao;
import com.erp.core.model.AgentsTbl;
import com.erp.core.util.Page;

public class AgentsTblDaoImpl extends HibernateEntityDao<AgentsTbl> implements AgentsTblDao {
	/**
	 * 查找代理商的最大编号
	 * 
	 * @author hwg
	 * @return agentsCode
	 */
	@Override
	public String findMaxAgentsCode() {
		String hql = "select max(agents.agentsCode) as agentsCode from AgentsTbl as agents";
		Query query = this.getSession().createQuery(hql);
		return (String) query.list().get(0);

	}

	public Page getAllAgentsTbl(AgentsTbl agentsTbl) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Page getAllAgentsTbl(int pageNo, int pageSize, AgentsTbl agentsTbl, String minRegistTime, String maxRegistTime, String minBalance, String maxBalance,
			String loginAgentsCode, String parameter) {
				return null; }

	@Override
	public AgentsTbl getMaster() {
		// // TODO Auto-generated method stub
		AgentsTbl agentsTbl = null;
		String hql = "from AgentsTbl as agents where agents.upperAgents.id=-1 and agents.id<>-1";
		Query query = this.createQuery(hql);
		List<AgentsTbl> list = query.list();
		if (list.size() != 0) {
			agentsTbl = list.get(0);
		} else {
			agentsTbl = null;
		}

		return agentsTbl;
	}

	@Override
	public AgentsTbl getAgents(String agentsCode) {
		// TODO Auto-generated method stub
		AgentsTbl agentsTbl = null;
		String hql = "from AgentsTbl as agents where agents.agentsCode='" + agentsCode + "'";
		Query query = this.createQuery(hql);
		List<AgentsTbl> list = query.list();
		if (list.size() != 0) {
			agentsTbl = list.get(0);
		}
		return agentsTbl;
	}

	@Override
	public void update(AgentsTbl agentsTbl) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().update(agentsTbl);
	}

	@Override
	public AgentsTbl saveAgentsTbl(AgentsTbl agentsTbl) {
		// TODO Auto-generated method stub
		Integer id = (Integer) this.getHibernateTemplate().save(agentsTbl);
		AgentsTbl agents = this.get(id);
		return agents;
	}

	@Override
	public List<AgentsTbl> getAllChilds(Integer id) {
		AgentsTbl agentsTbl = (AgentsTbl) this.getHibernateTemplate().get(AgentsTbl.class, id);
		String hql = "from AgentsTbl as a where a.nodeKey like '" + agentsTbl.getNodeKey() + "%' and a.id<>" + id;
		Query query = this.createQuery(hql);
		List<AgentsTbl> list = (List<AgentsTbl>) query.list();
		if (list != null) {
			return list;
		} else {
			return null;
		}
	}

	@Override
	public Page getPageCheckAgents(int pageNo, int pageSize, String status, String minTime, String maxTime) {
		// TODO Auto-generated method stub
		String hql = "from AgentsTbl where 1=1";
		if (!StringUtils.isEmpty(status)) {
			hql += " and auditStatus=" + Integer.parseInt(status);
		} else {
			hql += " and (auditStatus=0 or auditStatus=2)";
		}
		if (!StringUtils.isEmpty(minTime)) {
			hql += " and registeredTime>='" + minTime + "'";
		}
		if (!StringUtils.isEmpty(maxTime)) {
			hql += " and registeredTime<='" + maxTime + "'";
		}
		Page page = super.pagedQuery(hql, pageNo, pageSize);
		return page;
	}

	@Override
	public List<AgentsTbl> getListAgents(String[] code) {
		// TODO Auto-generated method stub
		List<AgentsTbl> list = new ArrayList<AgentsTbl>();
		if (code.length > 0) {
			for (String str : code) {
				AgentsTbl agents = this.getAgents(str);
				list.add(agents);
			}
		}
		return list;
	}

	@Override
	public Integer getAllChildsCount() {
		// TODO Auto-generated method stub
		String hql = "select count(*) as count from AgentsTbl as agents where agents.auditStatus=1 and agents.id<>-1";
		Query query = this.getSession().createQuery(hql);
		String count = (String) query.list().get(0).toString();
		return Integer.parseInt(count);
	}

	@Override
	public Integer getAllPassChild(AgentsTbl agents) {
		// TODO Auto-generated method stub
		int size = 0;
		for (AgentsTbl a : agents.getChildsAgents()) {
			if (a.getAuditStatus() == 1) {
				size++;
			}
		}
		return size;

	}

	/*	*//**
	 * 使用悲观锁加载代理商
	 */
	/*
	 * @Override public AgentsTbl getAgentsForUpdate(Integer id) { String
	 * lockTable = "LOCK TABLE agents_tbl WRITE"; logger.info(lockTable); String
	 * sql = "select * from agents_tbl where id=:id"; this.getSession().flush();
	 * this.getSession().clear();
	 * 
	 * //先锁agents_tbl表 Query query =
	 * this.getSession().createSQLQuery(lockTable); query.executeUpdate();
	 * 
	 * query = this.getSession().createSQLQuery(sql).addEntity(AgentsTbl.class);
	 * query.setInteger("id", id); return (AgentsTbl) query.uniqueResult(); }
	 */

	@Override
	public List<AgentsTbl> getHasChildAgents() {
		// TODO Auto-generated method stub

		return null;
	}

	@Override
	public AgentsTbl findGeneralAgents() {
		String sql = "select * from agents_tbl as agents where agents.id !=-1 and agents.parent_id = -1";
		this.getSession().flush();
		this.getSession().clear();
		Query query = this.getSession().createSQLQuery(sql).addEntity(AgentsTbl.class);
		return (AgentsTbl) query.uniqueResult();
	}

	@Override
	public Page getSonAgentsTbl(int pageNo, int pageSize, AgentsTbl agentsTbl, String minRegistTime, String maxRegistTime, String minBalance, String maxBalance,
			String loginAgentsCode, String parameter) {
				return null; }

	@Override
	public void updateAgents(String agentsCode, Map<String, String> map) {
		String sql = "";
		for (String key : map.keySet()) {
			sql += "," + key + "=" + map.get(key);
		}

		sql = sql.substring(1, sql.length());
		sql = "update agents_tbl set " + sql + " where agents_code=:agentsCode";

		Query query = this.getSession().createSQLQuery(sql);
		query.setString("agentsCode", agentsCode);
		query.executeUpdate();
	}

	@Override
	public List findForRebate(String nodekeys, String goodsCode) {
		String sql = "SELECT ";
		sql += "agents.agents_code, ";
		sql += "bp.price, ";
		sql += "agents.balance, ";
		sql += "agents.bail ";
		sql += "FROM  ";
		sql += "agents_tbl AS agents, ";
		sql += "batch_price_tbl AS bp, ";
		sql += "batch_level_tbl as bl  ";
		sql += "WHERE  ";
		sql += "agents.node_key in(" + nodekeys + ") ";
		sql += "AND agents.batch_level_id = bl.id ";
		sql += "AND bl.batch_level = bp.batch_level ";
		sql += "AND bp.goods_code = '" + goodsCode + "' ";
		sql += "ORDER BY agents.node_key DESC ";
		Query query = this.getSession().createSQLQuery(sql);
		return query.list();
	}

}