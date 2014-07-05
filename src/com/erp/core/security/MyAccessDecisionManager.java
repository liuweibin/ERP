package com.erp.core.security;

import java.util.Collection;
import java.util.Iterator;

import org.apache.log4j.Logger;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

public class MyAccessDecisionManager implements AccessDecisionManager {
	private Logger log = Logger.getLogger(MyAccessDecisionManager.class);

	@Override
	public void decide(Authentication authentication, Object object,
			Collection<ConfigAttribute> configAttributes)
			throws AccessDeniedException, InsufficientAuthenticationException {
		log.debug("MyAccessDescisionManager.decide()------------------validate user is have same role--------");
		
		// 如果这个url不需要角色权限保护，就放行
		if (configAttributes == null) {
			return;
		}
		Iterator<ConfigAttribute> iter = configAttributes.iterator();
		while (iter.hasNext()) {
			ConfigAttribute ca = iter.next();
			String needRole = ((SecurityConfig) ca).getAttribute();
			for (GrantedAuthority ga : authentication.getAuthorities()) {
				// 如果当前用户含有所需要的角色权限，放行
				if (needRole.equals(ga.getAuthority())) {
					return;
				}
			}
		}
		// 没权访问
		throw new AccessDeniedException("--------MyAccessDescisionManager：decide-------Access authentication failed！");

	}

	@Override
	public boolean supports(ConfigAttribute arg0) {
		return true;
	}

	@Override
	public boolean supports(Class<?> arg0) {
		return true;
	}

}
