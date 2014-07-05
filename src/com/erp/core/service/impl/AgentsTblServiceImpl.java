package com.erp.core.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.erp.core.model.AgentsTbl;
import com.erp.core.model.AgentsUserGroupRoleTbl;
import com.erp.core.model.AgentsUserTbl;
import com.erp.core.service.AgentsTblService;
import com.erp.core.util.DateFormatter;
import com.erp.core.util.Page;
import com.erp.core.util.Parameter;
import com.erp.core.util.ParameterBean;
import com.erp.core.util.ParameterBeanSupport;

public class AgentsTblServiceImpl extends  BaseService  implements AgentsTblService{


	@Override
	public Page getAllAgentsTbl(int pageNo, int pageSize, AgentsTbl agentsTbl,
			String minRegistTime, String maxRegistTime, String minBalance,
			String maxBalance,String loginAgentsCode,String parameter) {
		// TODO Auto-generated method stub
		return agentsTblDao.getAllAgentsTbl(pageNo, pageSize, agentsTbl, minRegistTime, maxRegistTime, minBalance, maxBalance, loginAgentsCode, parameter);
	}
	@Override
	public Page getSonAgentsTbl(int pageNo, int pageSize, AgentsTbl agentsTbl,
			String minRegistTime, String maxRegistTime, String minBalance,
			String maxBalance,String loginAgentsCode,String parameter) {
		// TODO Auto-generated method stub
		return agentsTblDao.getSonAgentsTbl(pageNo, pageSize, agentsTbl, minRegistTime, maxRegistTime, minBalance, maxBalance, loginAgentsCode, parameter);
	}

	@Override
	public String findMaxAgentsCode() {
		// TODO Auto-generated method stub
		return agentsTblDao.findMaxAgentsCode();
	}

	@Override
	public AgentsTbl getMaster() {
		// TODO Auto-generated method stub
		return agentsTblDao.getMaster();
	}
/**
 * 总代添加直属代理商
 */
	public String addAgents(AgentsTbl agentsTbl){
		return null; }

 

	@Override
	public AgentsTbl getAgents(String agentsCode) {
		// TODO Auto-generated method stub
		return agentsTblDao.getAgents(agentsCode);
	}

	@Override
	public void update(AgentsTbl agentsTbl) {
		// TODO Auto-generated method stub
		agentsTblDao.update(agentsTbl);
	}

	@Override
	public List<AgentsTbl> getAllChilds(Integer id) {
		// TODO Auto-generated method stub
		return agentsTblDao.getAllChilds(id);
	}

	@Override
	public void deleteAgents(Integer id,HttpServletRequest request) { }

	@Override
	public Page getPageCheckAgents(int pageNo, int pageSize, String status,
			String minTime, String maxTime) {
		// TODO Auto-generated method stub
		return agentsTblDao.getPageCheckAgents(pageNo, pageSize, status, minTime, maxTime);
	}
/**
 * status 1 通过 2未通过 3已满 
 */
	@Override
	public String updateAndSendMessage(AgentsTbl agentsTbl, String passOrNot,String extendGoods) {
		return extendGoods; }


	/**
	 * 
	 * 生成编号
	 * @author 
	 * @return orderCode
	 * 0添加成功 
	 * 1 代表已满，代理商数额已超
	 */
	private String updatePassAgents(AgentsTbl agents) {
		return null; }
	
	@Override
	public void saveOrUpdate(AgentsTbl AgentsTbl) {
		// TODO Auto-generated method stub
		agentsTblDao.saveOrUpdate(AgentsTbl);
	}

	@Override
	public AgentsTbl saveAgentsTbl(AgentsTbl agentsTbl) {
		// TODO Auto-generated method stub
		return agentsTblDao.saveAgentsTbl(agentsTbl);
	}

	@Override
	public List<AgentsTbl> getListAgents(String[] code) {
		// TODO Auto-generated method stub
		return agentsTblDao.getListAgents(code);
	}

	@Override
	public AgentsTbl getAgentsById(int id) {
		// TODO Auto-generated method stub
		return agentsTblDao.get(id);
	}

	@Override
	public AgentsTbl get(Serializable id) {
		// TODO Auto-generated method stub
		return agentsTblDao.get(id);
	}

	@Override
	public List<AgentsTbl> getAll() {
		// TODO Auto-generated method stub
		return agentsTblDao.getAll();
	}

	@Override
	public List getAllBySql(String columnName, String tableName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List getAllBySql(String sql) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getIdName() {
		// TODO Auto-generated method stub
		return agentsTblDao.getIdName();
	}

	@Override
	public Page getPage(List<ParameterBeanSupport> parameterList, int page,
			int currentRowsDisplayed) {
		// TODO Auto-generated method stub
		return agentsTblDao.getPage(parameterList, page, currentRowsDisplayed);
	}

	@Override
	public Page getPageList(List<ParameterBean> parameterList, int page,
			int currentRowsDisplayed) {
		// TODO Auto-generated method stub
		return agentsTblDao.getPageList(parameterList, page, currentRowsDisplayed);
	}

	@Override
	public void remove(Object o) {
		// TODO Auto-generated method stub
		agentsTblDao.remove(o);
	}

	@Override
	public void removeById(Serializable id) {
		// TODO Auto-generated method stub
		agentsTblDao.removeById(id);
	}

	@Override
	public void save(Object o) {
		// TODO Auto-generated method stub
		agentsTblDao.save(o);
	}

	@Override
	public int updateBySQL(String sql) {
		// TODO Auto-generated method stub
		return agentsTblDao.updateBySQL(sql);
	}

	@Override
	public Integer getAllChildsCount() {
		return agentsTblDao.getAllChildsCount();
	}

	@Override
	public Integer getAllPassChild(AgentsTbl agents) {
		return agentsTblDao.getAllPassChild(agents);
	}
	@Override
	public List<Parameter> getFields(String module) {
		// TODO Auto-generated method stub
		return null;
	}

}
