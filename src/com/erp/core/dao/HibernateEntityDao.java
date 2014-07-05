package com.erp.core.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;

import com.erp.core.util.CriteriaUtil;
import com.erp.core.util.GenericsUtils;
import com.erp.core.util.Page;
import com.erp.core.util.ParameterBean;
import com.erp.core.util.ParameterBeanSupport;

/**
 * 负责为单个Entity对象提供CRUD操作的Hibernate DAO基类. 
 * <p/>
 * 子类只要在类定义时指定所管理Entity的Class, 即拥有对单个Entity对象的CRUD操作.
 * 
 * <pre>
 * public class UserManager extends HibernateEntityDao&lt;User&gt; {
 * }
 * </pre>
 * 
 * @see HibernateGenericDao
 */
@SuppressWarnings("unchecked")
public abstract class HibernateEntityDao<T> extends HibernateGenericDao<T> implements EntityDao<T> {

	protected Class<T> entityClass;// DAO所管理的Entity类型

	/**
	 * 在构造函数中将泛型T.class赋给entityClass.
	 */
	public HibernateEntityDao() {
		entityClass = GenericsUtils.getSuperClassGenricType(getClass());
	}

	/**
	 * 取得entityClass.JDK1.4不支持泛型的子类可以抛开Class<T> entityClass,重载此函数达到相同效果。
	 */
	protected Class<T> getEntityClass() {
		return entityClass;
	}

	/**
	 * 根据ID获取对象.
	 * 
	 * @see HibernateGenericDao#getId(Class,Object)
	 */
	public T load(Serializable id) {
		return load(getEntityClass(), id);
	}
	
	/**
	 * 根据ID获取对象.
	 * 
	 * @see HibernateGenericDao#getId(Class,Object)
	 */
	public T get(Serializable id) {
		return get(getEntityClass(), id);
	}

	/**
	 * 获取全部对象
	 * 
	 * @see HibernateGenericDao#getAll(Class)
	 */
	public List<T> getAll() {
		return getAll(getEntityClass());
	}

	/**
	 * 获取全部对象,带排序参数.
	 * 
	 * @see HibernateGenericDao#getAll(Class,String,boolean)
	 */
	public List<T> getAll(String orderBy, boolean isAsc) {
		return getAll(getEntityClass(), orderBy, isAsc);
	}

	/**
	 * 根据ID移除对象.
	 * 
	 * @see HibernateGenericDao#removeById(Class,Serializable)
	 */
	public void removeById(Serializable id) {
		removeById(getEntityClass(), id);
	}

	/**
	 * 取得Entity的Criteria.
	 * 
	 * @see HibernateGenericDao#createCriteria(Class,Criterion[])
	 */
	public Criteria createCriteria(Criterion... criterions) {
		return createCriteria(getEntityClass(), criterions);
	}

	/**
	 * 取得Entity的Criteria,带排序参数.
	 * 
	 * @see HibernateGenericDao#createCriteria(Class,String,boolean,Criterion[])
	 */
	public Criteria createCriteria(String orderBy, boolean isAsc,
			Criterion... criterions) {
		return createCriteria(getEntityClass(), orderBy, isAsc, criterions);
	}

	/**
	 * 根据属性名和属性值查询对象.
	 * 
	 * @return 符合条件的对象列表
	 * @see HibernateGenericDao#findBy(Class,String,Object)
	 */
	public List<T> findBy(String propertyName, Object value) {
		return findBy(getEntityClass(), propertyName, value);
	}

	/**
	 * 根据属性名和属性值查询对象,带排序参数.
	 * 
	 * @return 符合条件的对象列表
	 * @see HibernateGenericDao#findBy(Class,String,Object,String,boolean)
	 */
	public List<T> findBy(String propertyName, Object value, String orderBy,
			boolean isAsc) {
		return findBy(getEntityClass(), propertyName, value, orderBy, isAsc);
	}

	/**
	 * 根据属性名和属性值查询单个对象.
	 * 
	 * @return 符合条件的唯一对象 or null
	 * @see HibernateGenericDao#findUniqueBy(Class,String,Object)
	 */
	public T findUniqueBy(String propertyName, Object value) {
		return findUniqueBy(getEntityClass(), propertyName, value);
	}

	/**
	 * 判断对象某些属性的值在数据库中唯一.
	 * 
	 * @param uniquePropertyNames
	 *            在POJO里不能重复的属性列表,以逗号分割 如"name,loginid,password"
	 * @see HibernateGenericDao#isUnique(Class,Object,String)
	 */
	public boolean isUnique(Object entity, String uniquePropertyNames) {
		return isUnique(getEntityClass(), entity, uniquePropertyNames);
	}

	/**
	 * 取得对象的主键名,辅助函数.
	 */
	public String getIdName() {
		return getIdName(entityClass);
	}
	
	/**
	 * 得到分页List信息, 如果要特殊的业务        则自己在子类中重写方法
	 * @param parameterList  要筛选的属性集合
	 * @param page			 page 分页信息
	 * @param currentRowsDisplayed 要显示的行数
	 * @return 返回相应的分页page信息
	 */
	public Page getPageList(List<ParameterBean> parameterList, int page,int currentRowsDisplayed) {
		Criteria criteria = this.getSession().createCriteria(getEntityClass());
		CriteriaUtil.dealCriteriaMeth(parameterList, criteria);//把参数信息加入到Criteria
		return this.pagedQuery(criteria,page , currentRowsDisplayed);
	}
	
	/**
	 * 得到分页List信息, 如果要特殊的业务        则自己在子类中重写方法
	 * @param parameterList  要筛选的属性集合
	 * @param page			 page 分页信息
	 * @param currentRowsDisplayed 要显示的行数
	 * @return 返回相应的分页page信息
	 */
	public Page getPage(List<ParameterBeanSupport> parameterList, int page,int currentRowsDisplayed) {
		Criteria criteria = this.getSession().createCriteria(getEntityClass());
		CriteriaUtil.doCriteriaMeth(parameterList, criteria);//把参数信息加入到Criteria
		return this.pagedQuery(criteria,page , currentRowsDisplayed);
	}
	
	
	/* 按 数据库的字段   得到去重复的   列值。   sql 表名
	 * @see com.oms.core.dao.EntityDao#getAllBySql(java.lang.String, java.lang.String)
	 */
	public  List getAllBySql(String columnName,String tableName){
		String sql=" select distinct "+columnName+" from  "+tableName+" where "+columnName +" is not null and "+columnName+"!=''";
	    Query query=getSession().createSQLQuery(sql);
		return query.list();
	}
	
	/***
	 * 按照原生态sql 查询 数据
	 * @param sql
	 * @return
	 */
	public  List getAllBySql(String sql){
	    Query query=getSession().createSQLQuery(sql);
		return query.list();
	}
	
	/**
	 * 执行sql 修改语句  可以是 insert 可以是 update  也可以是  delete  也可以是 truncate 
	 * @param sql
	 * @return
	 */
	public  int updateBySQL(String sql){
	   Query query=getSession().createSQLQuery(sql);
	   return query.executeUpdate();
	}
	
	/**
	 * 保存或更新对象.
	 */
	public void saveOrUpdate(Object o) {
		saveOrUpdateObj(o);
	}
	/**
	 * 保存对象.
	 */
	public void update(Object o) {
		saveOrUpdateObj(o);
	}
	/**
	 * 更新对象.按字段
	 */
	public void updateObj(String pkName,String tblName,String idValue, Map<String, String> values) {
		updateObjs(pkName,tblName,idValue,values);
	}
}
