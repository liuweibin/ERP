package com.erp.core.common;

import javax.inject.Inject;

import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;

@Component
public class BaseHibernateDaoSupport extends HibernateDaoSupport {

	@Inject
	public void setSuperSessionFactory(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
}
