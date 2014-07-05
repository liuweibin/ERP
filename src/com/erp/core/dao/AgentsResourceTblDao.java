package com.erp.core.dao;
import java.util.List;
import java.util.Map;

import com.erp.core.model.AgentsResourceTbl;
public interface AgentsResourceTblDao extends EntityDao<AgentsResourceTbl> {
	
	/**
	 * 获取指定资源
	 * @return
	 */
	public List<AgentsResourceTbl> getResourceByIds(Map<Integer, String> resourceId_map);
}