package com.erp.core.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.erp.core.util.Page;
import com.erp.core.util.ParameterBean;
import com.erp.core.util.ParameterBeanSupport;

/**
 * 通用DAO层基本接口
 * <p/>
 * CRUD等基本数据库操作方法的定义
 * <p/>
 * 子类只要在类定义时指定所管理的Entity类, 即拥有对单个Entity对象的CRUD操作
 * @author libo
 *
 * @param <T> 实体类
 */
public interface EntityDao<T> {
    T merge(T o);
    
	T get(Serializable id);

	String getIdName();

	List<T> getAll();

	void save(Object o);

	void remove(Object o);

	void removeById(Serializable id);
	
	Page getPageList(List<ParameterBean> parameterList, int page,int currentRowsDisplayed);
	
	Page getPage(List<ParameterBeanSupport> parameterList, int page,int currentRowsDisplayed);
	
	List getAllBySql(String columnName,String tableName);

	List getAllBySql(String sql);
	
	int updateBySQL(String sql);
	
	/**
	 * 根据属性名和属性值查询对象.
	 * 
	 * @return 符合条件的对象列表
	 * @see HibernateGenericDao#findBy(Class,String,Object)
	 */
	public List<T> findBy(String propertyName, Object value);

	/**
	 * 根据属性名和属性值查询对象,带排序参数.
	 * 
	 * @return 符合条件的对象列表
	 * @see HibernateGenericDao#findBy(Class,String,Object,String,boolean)
	 */
	public List<T> findBy(String propertyName, Object value, String orderBy,boolean isAsc);

	/**
	 * 根据属性名和属性值查询单个对象.
	 * 
	 * @return 符合条件的唯一对象 or null
	 * @see HibernateGenericDao#findUniqueBy(Class,String,Object)
	 */
	public T findUniqueBy(String propertyName, Object value);

	/**
	 * 保存/更新对象.
	 */
	void saveOrUpdate(Object o);
	/**
	 * 保存对象.
	 */
	void update(Object o);
	/**
	 * 更新对象.按字段
	 * @param pkName  主键name
	 * @param tblName 表明
	 * @param idValue 主键value
	 * @param values  更新参数
	 */
	void updateObj(String pkName,String tblName,String idValue, Map<String, String> values);
	
	void truncate(String table);
}
