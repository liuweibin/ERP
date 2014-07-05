package com.erp.core.common.manager;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.Assert;
import org.springframework.util.ReflectionUtils;

import com.erp.core.dao.EntityDao;
import com.erp.core.util.BeanUtils;
import com.erp.core.util.GenericsUtils;
import com.erp.core.util.Page;
import com.erp.core.util.ParameterBean;
import com.erp.core.util.ParameterBeanSupport;

/**
 * 
 * @version: 2007-4-26<br>
 * @author <a href="mailto:kenny319@gmail.com">Kenny Wang </a>
 */
@SuppressWarnings("unchecked")
public class BaseManager<T extends Object, D extends EntityDao<T>> implements Manager<T>, InitializingBean {

	protected Log logger = LogFactory.getLog(getClass());

	private D dao;

	public T get(Serializable id) {
		return dao.get(id);
	}

	public List<T> getAll() {
		return dao.getAll();
	}

	public void save(Object o) {
		dao.save(o);
	}

	public void removeById(Serializable id) {
		dao.removeById(id);
	}

	public void remove(Object o) {
		dao.remove(o);
	}

	public String getIdName() {
		return dao.getIdName();
	}

	public void afterPropertiesSet() throws Exception {
		// 根据M,反射获得符合M类型的manager
		List<Field> fields = BeanUtils.getFieldsByType(this, GenericsUtils.getSuperClassGenricType(getClass(), 1));
		Assert.isTrue(fields.size() == 1, "subclass's has not only one dao property.");
		try {
			dao = (D) BeanUtils.forceGetProperty(this, fields.get(0).getName());
			Assert.notNull(dao, "subclass not inject dao to manager sucessful.");
		} catch (Exception e) {
			ReflectionUtils.handleReflectionException(e);
		}
	}

	public Page getPageList(List<ParameterBean> parameterList, int page,
			int currentRowsDisplayed) {
		return dao.getPageList(parameterList, page, currentRowsDisplayed);
	}
	

	public List getAllBySql(String columnName,String tableName){
		return dao.getAllBySql(columnName, tableName);
	}
	
	
	public List getAllBySql(String sql){
		return dao.getAllBySql(sql);
	}
	
	public  int updateBySQL(String sql){
		return dao.updateBySQL(sql);
	}

	@Override
	public Page getPage(List<ParameterBeanSupport> parameterList, int page, int currentRowsDisplayed) {
		return dao.getPage(parameterList, page, currentRowsDisplayed);
	}
}
