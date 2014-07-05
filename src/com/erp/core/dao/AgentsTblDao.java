package com.erp.core.dao;

import java.util.List;
import java.util.Map;

import com.erp.core.model.AgentsTbl;
import com.erp.core.util.Page;

public interface AgentsTblDao extends EntityDao<AgentsTbl> {
	/**
	 * 
	 * @param agentsTbl
	 * @author zl 可以根据代理商的 编号、批价级别、类别、余额区间、注册时间范围进行查询， 查询出的代理商以列表呈现，显示的基本内容包括
	 *         代理商类别、代理商名称、代理商店铺名称、代理商所在区域，批价级别和注册时间等， 每条记录提供修改、删除操作。
	 * @return
	 */
	public Page getAllAgentsTbl(int pageNo, int pageSize, AgentsTbl agentsTbl, String minRegistTime, String maxRegistTime, String minBalance, String maxBalance,
			String loginAgentsCode, String parameter);

	/**
	 * !!!!下级代理商（不包含孙子节点）
	 * 
	 * @return
	 */
	public Page getSonAgentsTbl(int pageNo, int pageSize, AgentsTbl agentsTbl, String minRegistTime, String maxRegistTime, String minBalance, String maxBalance,
			String loginAgentsCode, String parameter);

	/**
	 * 查找代理商的最大编号
	 * 
	 * @author hwg
	 * @return agentsCode
	 */
	String findMaxAgentsCode();

	/**
	 * 查找总代理
	 */
	public AgentsTbl getMaster();

	/**
	 * 通过代理商编号查找代理商
	 */
	public AgentsTbl getAgents(String agentsCode);

	/**
	 * 修改代理商信息
	 * 
	 * @param agentsTbl
	 */
	public void update(AgentsTbl agentsTbl);

	public AgentsTbl saveAgentsTbl(AgentsTbl agentsTbl);

	/**
	 * 得到代理商所有子孙级
	 */
	public List<AgentsTbl> getAllChilds(Integer id);

	/**
	 * 得到所有待审核代理商分页
	 */
	public Page getPageCheckAgents(int pageNo, int pageSize, String status, String minTime, String maxTime);

	/**
	 * 得到登录进来的代理商
	 */
	/**
	 * 根据代理商一批编号，得到所有代理商
	 */
	public List<AgentsTbl> getListAgents(String[] code);

	/**
	 * 查询当前所有代理商数
	 */
	public Integer getAllChildsCount();

	/**
	 * 查询所有子孙集已通过的代理商数
	 */
	public Integer getAllPassChild(AgentsTbl agents);

	/**
	 * 查找所有有子集的代理商
	 */
	public List<AgentsTbl> getHasChildAgents();

	

	public AgentsTbl findGeneralAgents();

	public void updateAgents(String agentsCode, Map<String, String> map);

	public List findForRebate(String nodekeys, String goodsCode);

/*	public void updateAgentsPoint(Integer id, Integer point);

	public void updateAgentsBail(Integer id, Integer bail);

	void unlockAgentsTable();
	
	*//**
	 * 通过代理商编号查找代理商(行加锁)
	 *//*
	public AgentsTbl getAgentsForUpdate(Integer agentsCode);*/

}