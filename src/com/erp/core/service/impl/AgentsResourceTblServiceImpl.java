package com.erp.core.service.impl;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.erp.core.model.AgentsGroupRoleResourceTbl;
import com.erp.core.model.AgentsResourceTbl;
import com.erp.core.service.AgentsResourceTblService;


public class AgentsResourceTblServiceImpl extends BaseService implements AgentsResourceTblService {
	public List<AgentsResourceTbl> getResource(){
		List<AgentsResourceTbl> list = agentsResourceTblDao.getAll();
		List<AgentsResourceTbl> list_temp = new ArrayList<AgentsResourceTbl>();
		for(AgentsResourceTbl agentsResource:list){
			AgentsResourceTbl temp = new AgentsResourceTbl();
			temp.setCreateTime(agentsResource.getCreateTime());
			temp.setEnabled(agentsResource.getEnabled());
			temp.setId(agentsResource.getId());
			temp.setName(agentsResource.getName());
			temp.setUrl(agentsResource.getUrl());
			temp.setRemark(agentsResource.getRemark());
			list_temp.add(temp);
		}
		return list_temp;
	}

	@Override
	public List<AgentsResourceTbl> getResourceByIds(
			Map<Integer, String> resourceIdMap) {
		return agentsResourceTblDao.getResourceByIds(resourceIdMap);
	}

	 
	public Map<String,Object> changeToMap(AgentsResourceTbl agentsResourceTbl, boolean showcheck, boolean bool,String groupId) {
		Map<String,Object> map = new HashMap<String, Object>();
		List<Map> listChild = new ArrayList<Map>();
		if(agentsResourceTbl.getIsNode()==1){//有子节点
			List<AgentsResourceTbl> listTemp = agentsResourceTblDao.findBy("pid", agentsResourceTbl.getId()+"");
			for(AgentsResourceTbl child :listTemp){
				listChild.add(changeToMap(child,true,false,groupId));
			}
		} 
		
		if (agentsResourceTbl.getIsNode()==0) {
			map.put("hasChildren", false);
		} else {
			map.put("hasChildren", true);
		}
		map.put("checkstate", "0");
		if(agentsResourceTbl.getIsNode()==0){
			if(!groupId.equals("no")){
				 List<AgentsGroupRoleResourceTbl> 	list = 	agentsGroupRoleResourceTblDao.findBy("agentsUserGroupRoleTbl.id", Integer.parseInt(groupId));
				for(AgentsGroupRoleResourceTbl a : list){
					System.out.println(a.getAgentsResourceTbl().getId());
					System.out.println(agentsResourceTbl.getId()+"----");
					if(a.getAgentsResourceTbl().getId()==agentsResourceTbl.getId()){
						map.put("checkstate", "1");
					}
				}
			}
		}
		map.put("complete", true);
		map.put("id", String.valueOf(agentsResourceTbl.getId()));
		map.put("isexpand", true);
		map.put("parentId", agentsResourceTbl.getPid());
		map.put("showcheck", showcheck);
		map.put("text", agentsResourceTbl.getRemark());
		map.put("value", agentsResourceTbl.getId()+"");
		map.put("childNodes", listChild);

		return map;
	}

	@Override
	public String getResourceTree(String groupId) {
		// TODO Auto-generated method stub
		return null;
	}

}