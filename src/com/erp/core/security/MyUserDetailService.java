package com.erp.core.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.erp.core.dao.AgentsUserTblDao;
import com.erp.core.model.AgentsUserGroupRoleTbl;
import com.erp.core.model.AgentsUserTbl;

public class MyUserDetailService implements UserDetailsService{
	private Logger log = Logger.getLogger(MyUserDetailService.class);
	@Autowired
	private AgentsUserTblDao agentsUserTblDao;
	
	public AgentsUserTblDao getAgentsUserTblDao() {
		return agentsUserTblDao;
	}

	public void setAgentsUserTblDao(AgentsUserTblDao agentsUserTblDao) {
		this.agentsUserTblDao = agentsUserTblDao;
	}
//	private HibernateTemplate hibernateTemplate;
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException, DataAccessException {
		log.info("---------MyUserDetailService:loadUserByUsername------Being loaded user name and password, username:"+username);
		UserDetails user = null;
		AgentsUserTbl  agentsUser = agentsUserTblDao.find(username);
		boolean enables = true;
		boolean accountNonExpired = true;
		boolean credentialsNonExpired = true;
		boolean accountNonLocked = true;
		try {//用户名、密码、是否启用、是否被锁定、是否过期、权限  
			log.info( username+"----"+agentsUser.getPassword());
			user = new User(username, agentsUser.getPassword(),
					enables, accountNonExpired, credentialsNonExpired,
					accountNonLocked, getAuthorities(agentsUser.getAgentsUserGroupRoleTbl().getId()));
		} catch (Exception e) {
			log.info("Without this user\r\n");
			throw new AccessDeniedException("没有此用户\r\n" + e);
		}
		return user;
	}

/**
 * 获得访问角色权限列表 
 * @param groupid
 * @return
 */
	@SuppressWarnings("deprecation")
	public Collection<GrantedAuthority> getAuthorities(int groupid) {
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
 	 List<AgentsUserGroupRoleTbl> list = agentsUserTblDao.getRoleList(groupid);
		for (AgentsUserGroupRoleTbl r : list) {
			authList.add(new GrantedAuthorityImpl(r.getGroupName()));
		} 
		return authList;
	}
	
}
