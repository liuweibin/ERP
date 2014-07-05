package com.erp.core.common.manager;

import java.io.Serializable;
import java.util.List;

import com.erp.core.util.Page;
import com.erp.core.util.ParameterBean;
import com.erp.core.util.ParameterBeanSupport;

/**
 * 通用Manager层基本接口
 * <p/>
 * CRUD等基本数据库操作方法的Manager定义
 * <p/>
 * 子类只要在类定义时指定所管理的Entity类, 即拥有对单个Entity对象的CRUD操作
 * @author libo
 *
 * @param <T> 实体类
 */
public interface Manager<T> {

	public abstract T get(Serializable id);

	public abstract String getIdName();

	public abstract List<T> getAll();

	public abstract void save(Object o);

	public abstract void removeById(Serializable id);

	public abstract void remove(Object o);
	
	public abstract Page getPageList(List<ParameterBean> parameterList, int page,int currentRowsDisplayed);
	
	public abstract Page getPage(List<ParameterBeanSupport> parameterList, int page,int currentRowsDisplayed);
	
	public abstract List getAllBySql(String columnName,String tableName);
	
	public abstract List getAllBySql(String sql);
	
	public abstract int updateBySQL(String sql);

}
