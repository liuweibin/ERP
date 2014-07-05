package com.erp.core.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

import com.erp.core.model.AgentsResourceTbl;
import com.erp.core.model.AgentsUserGroupRoleTbl;
import com.erp.core.service.AgentsUserGroupRoleTblService;

public class AgentsUserGroupRoleTblServiceImpl extends BaseService implements AgentsUserGroupRoleTblService{
	private Logger log = Logger.getLogger(AgentsUserGroupRoleTblServiceImpl.class);
@Override
public List<AgentsUserGroupRoleTbl> selectAgentGroupName(String agentsCode) {
	 List<AgentsUserGroupRoleTbl>  list = agentsUserGroupRoleTblDao.selectAgentGroupName(agentsCode);
	 List<AgentsUserGroupRoleTbl>  res_list = new ArrayList<AgentsUserGroupRoleTbl>();
	for(AgentsUserGroupRoleTbl agentsUserGroupRole:list){
		AgentsUserGroupRoleTbl temp = new AgentsUserGroupRoleTbl();
		temp.setAgentsCode(agentsUserGroupRole.getAgentsCode());
		temp.setCreateTime(agentsUserGroupRole.getCreateTime());
		temp.setGroupCode(agentsUserGroupRole.getGroupCode());
		temp.setGroupName(agentsUserGroupRole.getGroupName());
		temp.setId(agentsUserGroupRole.getId());
		temp.setRemark(agentsUserGroupRole.getRemark());
		temp.setStatus(agentsUserGroupRole.getStatus());
		res_list.add(temp);
	}
	return res_list;
}

@Override
public AgentsUserGroupRoleTbl get(int id) {
	// TODO Auto-generated method stub
	return agentsUserGroupRoleTblDao.get(id);
}

@Override
public boolean saveAgentsUserGroupRoleTbl(AgentsUserGroupRoleTbl agentsUserGroupRoleTbl,Map<Integer, String> resourceIds) {
	Boolean bo = false;
	try {
		List<AgentsResourceTbl> list = agentsResourceTblDao.getResourceByIds(resourceIds);
		System.out.println(list.size()+"///");
		if(list.size()<0){
			log.info("资源加载失败");
			return bo;
		}
		  Iterator<AgentsResourceTbl> iter=list.iterator();
		  Set<AgentsResourceTbl> set = new HashSet<AgentsResourceTbl>();
		  while (iter.hasNext()) {
			  set.add(iter.next());
		}
		agentsUserGroupRoleTbl.setAgentsResourceTbl(set);
		agentsUserGroupRoleTblDao.save(agentsUserGroupRoleTbl);
		bo = true;
	} catch (Exception e) {
		e.printStackTrace();
	}
	return bo;
}

@Override
public boolean deleteAgentsUserGroupRoleTbl(int id,String groupId) throws Exception {
	Boolean bo = false;
	AgentsUserGroupRoleTbl agentsUserGroupRoleTbl = agentsUserGroupRoleTblDao.findUniqueBy("id", id);
	
	String group_grpupId = agentsUserGroupRoleTbl.getId().toString();
	String group_agentsCode = agentsUserGroupRoleTbl.getAgentsCode();
	if(group_agentsCode=="1"||group_grpupId.equals(groupId)){
		return bo;
	}
	try {
		agentsUserGroupRoleTblDao.removeById(id);
		bo = true;
	} catch (Exception e) {
		e.printStackTrace();
	}
	return bo;
}

}
