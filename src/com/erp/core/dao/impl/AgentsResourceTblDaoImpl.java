package com.erp.core.dao.impl;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.erp.core.dao.AgentsResourceTblDao;
import com.erp.core.dao.HibernateEntityDao;
import com.erp.core.model.AgentsResourceTbl;
import com.erp.core.util.StringUtil;
public class AgentsResourceTblDaoImpl extends HibernateEntityDao<AgentsResourceTbl> implements AgentsResourceTblDao {

	@Override
	public List<AgentsResourceTbl> getResourceByIds(Map<Integer, String> resourceIdMap) {
		List<AgentsResourceTbl> list = new ArrayList<AgentsResourceTbl>();
		for(Map.Entry<Integer, String> entry: resourceIdMap.entrySet()) {
			if(!StringUtil.isNullOrEmpty(entry.getValue())){
				AgentsResourceTbl agentsResourceTbl = new AgentsResourceTbl();
				agentsResourceTbl = this.findUniqueBy("id", entry.getKey());
				list.add(agentsResourceTbl);
			}
		}
		list.addAll( this.findBy("pid", "0"));
		return list;
	}
}