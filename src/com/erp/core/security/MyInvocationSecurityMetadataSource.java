package com.erp.core.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.util.AntPathMatcher;

import com.erp.core.model.AgentsResourceTbl;
import com.erp.core.model.AgentsUserGroupRoleTbl;
import com.erp.core.service.AgentsUserTblService;


public class MyInvocationSecurityMetadataSource implements
		FilterInvocationSecurityMetadataSource {
	private Logger log = Logger.getLogger(MyInvocationSecurityMetadataSource.class);
	private AntPathMatcher urlMatcher = new AntPathMatcher();
	private static Map<String, Collection<ConfigAttribute>> resourceMap = null;
	@Resource
	private AgentsUserTblService agentsUserTblService;

	public Collection<ConfigAttribute> getAllConfigAttributes() {
		return null;
	}


	public AgentsUserTblService getAgentsUserTblService() {
		return agentsUserTblService;
	}


	public void setAgentsUserTblService(AgentsUserTblService agentsUserTblService) {
		this.agentsUserTblService = agentsUserTblService;
	}


	/**
	 * 从加载的角色-资源MAP里面，查看该url是否需要角色权限，返回需要的角色权限或返回null
	 * */
	public Collection<ConfigAttribute> getAttributes(Object object)
			throws IllegalArgumentException {
		
		String url = ((FilterInvocation) object).getRequestUrl();
		log.debug("MySecurityMetadataSource:getAttributes()---------------request url is:"+url);
		Iterator<String> ite = resourceMap.keySet().iterator();
		while (ite.hasNext()) {
			String resURL = ite.next();
			if (urlMatcher.match(resURL, url)) {
				log.debug("match---"+resURL);
				return resourceMap.get(resURL);
			}
		}
		log.debug("no match--"+url);
		return null;
	}


	public boolean supports(Class<?> arg0) {
		return true;
	}

	public MyInvocationSecurityMetadataSource(AgentsUserTblService agentsUserTblService) {
		this.agentsUserTblService = agentsUserTblService;
		loadResourceDefine();
	}

	/**
	 * 这里应该是从数据库里面加载所有资源与角色权限的关系列表。 security的xml文件中加载的只是一种简要规则，是与的关系。
	 * */
	@SuppressWarnings("unchecked")
	public void loadResourceDefine() {
		resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
		
		log.info("MySecurityMetadataSource.loadResourcesDefine()--------------Start loading data resource list--------");
		
		List<AgentsResourceTbl> resourceList   = agentsUserTblService.getAllResource();
		Collection<ConfigAttribute> atts = null;
		for (AgentsResourceTbl res : resourceList) {
			atts = new ArrayList<ConfigAttribute>();
			List<AgentsUserGroupRoleTbl> roleList = agentsUserTblService.findRoleByResourceId(res.getId());
			ConfigAttribute ca = null;
			for (AgentsUserGroupRoleTbl r : roleList) {
				ca = new SecurityConfig(r.getGroupName());
				log.debug("groupRole name is"+r.getGroupName());
				atts.add(ca);
			}
			resourceMap.put(res.getUrl(), atts);//资源所拥有是角色
		}
	}

}
