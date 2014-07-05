package com.erp.core.service;

import java.util.List;
import java.util.Map;

import com.erp.core.model.AgentsResourceTbl;
public interface AgentsResourceTblService  {
	/**
	 * 获取可用资源列表
	 * @return
	 */
	public List<AgentsResourceTbl> getResource();
	
	/**
	 * 获取指定资源
	 * @return
	 */
	public List<AgentsResourceTbl> getResourceByIds(Map<Integer, String> resourceId_map);
	
	
	/**
	 * 获取可用资源树形列表
	 * groupId 当前组所在的id  可以为null 
	 * @return
	 */
	public String getResourceTree(String groupId);
	
}