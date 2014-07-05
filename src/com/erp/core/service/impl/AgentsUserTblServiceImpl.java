package com.erp.core.service.impl;
import java.util.List;

import com.erp.core.model.AgentsResourceTbl;
import com.erp.core.model.AgentsTbl;
import com.erp.core.model.AgentsUserGroupRoleTbl;
import com.erp.core.model.AgentsUserTbl;
import com.erp.core.service.AgentsUserTblService;
import com.erp.core.util.Page;

public class AgentsUserTblServiceImpl extends BaseService implements AgentsUserTblService{

	public void saveOrUpdate(AgentsUserTbl agentsUserTbl) {
		agentsUserTblDao.saveOrUpdate(agentsUserTbl);
	}

	@Override
	public void deleteCustomUserTbl(int id) {
		// TODO Auto-generated method stub
		agentsUserTblDao.removeById(id);
	}
	
	public List<AgentsUserTbl> getAll(){
		return agentsUserTblDao.getAll();
	}

	@Override
	public AgentsUserTbl get(int id) {
		// TODO Auto-generated method stub
		try {
			agentsUserTblDao.get(id);
		} catch (Exception e) {
			e.fillInStackTrace();
		}
		return agentsUserTblDao.get(id);
	}

	@Override
	public void save(AgentsUserTbl agentsUserTbl) {
		agentsUserTblDao.save(agentsUserTbl);
	}

	@Override
	public AgentsUserTbl findUniqueBy(String propertyName, String value) {
		// TODO Auto-generated method stub
		return agentsUserTblDao.findUniqueBy(propertyName, value);
	}

	@Override
	public AgentsUserTbl getAgentsUserUniqueBy(String agentsCode,
			String username) {
			return agentsUserTblDao.getAgentsUserUniqueBy(agentsCode, username);
		}

	@Override
	public List<AgentsResourceTbl> getAllResource() {
		return agentsResourceTblDao.getAll();
	}

	@Override
	public List<AgentsUserGroupRoleTbl> findRoleByResourceId(int resourceId) {
		return agentsUserGroupRoleTblDao.findRoleByResourceId(resourceId);
	}

	@Override
	public Page selectEmpByCode(int pageNo, int pageSize, int agentsId) {
		// TODO Auto-generated method stub
		return agentsUserTblDao.selectEmpByCode(pageNo, pageSize, agentsId);
	}

	@Override
	public AgentsUserTbl getAgentsUserMaster(AgentsTbl agentsTbl) {
		// TODO Auto-generated method stub
		return agentsUserTblDao.getAgentsUserMaster(agentsTbl);
	}
}
