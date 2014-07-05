package com.erp.core.service.impl;


import java.util.List;

import com.erp.core.dao.UserDao;
import com.erp.core.model.AgentsUserTbl;
import com.erp.core.service.UserService;


public class UserServiceImpl implements UserService{
	private UserDao userDao;

	public void add(AgentsUserTbl user) {
		userDao.add(user);
	}

	public boolean exist(AgentsUserTbl user) {
		return userDao.findUser(user);
	}

	public List<AgentsUserTbl> login(AgentsUserTbl user) {
		return userDao.userLogin(user);
	}
}
