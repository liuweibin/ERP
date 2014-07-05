package com.erp.core.service;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.erp.core.common.manager.Manager;
import com.erp.core.model.AgentsTbl;
import com.erp.core.util.Page;
import com.erp.core.util.Parameter;

public interface AgentsTblService extends Manager<AgentsTbl> {
	/**
	 * 查找总代理
	 */
	public AgentsTbl  getMaster();
	/**
	 * 总代直接添加直属代理商
	 * @param agentsTbl
	 * @param request
	 */
	public String addAgents(AgentsTbl agentsTbl);
	
	String findMaxAgentsCode();
	/**
	 * 
	 * @param agentsTbl
	 * @author zl
	 * 可以根据代理商的
	 * 编号、批价级别、类别、余额区间、注册时间范围进行查询，
	 * 查询出的代理商以列表呈现，显示的基本内容包括
	 * 代理商类别、代理商名称、代理商店铺名称、代理商所在区域，批价级别和注册时间等，
	 * 每条记录提供修改、删除操作。
	 * @return
	 */
	public Page getAllAgentsTbl(int pageNo, int pageSize, AgentsTbl agentsTbl, String minRegistTime, String maxRegistTime, String minBalance, String maxBalance,String loginAgentsCode,String parameter);
	
	public Page getSonAgentsTbl(int pageNo, int pageSize, AgentsTbl agentsTbl, String minRegistTime, String maxRegistTime, String minBalance, String maxBalance,String loginAgentsCode,String parameter);
	
	public List<Parameter> getFields(String module);
	
	public AgentsTbl getAgents(String agentsCode);
	
	public AgentsTbl getAgentsById(int id);
	
	public void update(AgentsTbl agentsTbl);
	
	public AgentsTbl saveAgentsTbl(AgentsTbl agentsTbl);
	
	public List<AgentsTbl> getAllChilds(Integer id);
	
	public void deleteAgents(Integer id,HttpServletRequest request);
	
	public Page getPageCheckAgents(int pageNo, int pageSize,String status,String minTime,String maxTime);
	
	/**
	 * 
	 * @param AgentsTbl
	 * @param passOrNot  是否通过审批  pass  not
	 * @param extendGoods 是否继承上级商品    1表示继承
	 * @return
	 */
	public String updateAndSendMessage(AgentsTbl AgentsTbl,String passOrNot,String extendGoods);
	
	public void saveOrUpdate(AgentsTbl AgentsTbl);
	
	public List<AgentsTbl> getListAgents(String[] code);
	
	/**
	 * 查询当前所有代理商数
	 */
	public Integer getAllChildsCount();
	
	/**
	 * 查询所有子孙集已通过的代理商数
	 */
	public Integer getAllPassChild(AgentsTbl agents);
}