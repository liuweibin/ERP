package com.erp.core.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/*
 * hibernate 分页查询语句 条件的处理类
 * email: tanwenkai@qq.com
 * */
public class CriteriaUtil {
	
	private static Logger looger=Logger.getLogger(CriteriaUtil.class);
	/******
	 * 
	 * @param parameterBeanList  参数的集合
	 * @param criteria           要处理的 criteria
	 * @return  返回处理后的 criteria
	 */
	public static void dealCriteriaMeth(List<ParameterBean> parameterList,Criteria criteria ){
		for (ParameterBean parameterBean : parameterList) {
			Object value=parameterBean.getParameterValue();
			String name=parameterBean.getParameterName();
			String conditional= parameterBean.getConditional();
			//如果bean的属性都不为空
			if(value!=null && StringUtils.isNotBlank(value+"") && StringUtils.isNotBlank(name) && StringUtils.isNotBlank(conditional)){
				if(ParameterBean.Equal.equals(conditional)){
					criteria.add(Restrictions.eq(name, value));
				}else if(ParameterBean.Greate.equals(conditional)){
					criteria.add(Restrictions.gt(name, value));
				}else if(ParameterBean.GreaterOrEqual.equals(conditional)){
					criteria.add(Restrictions.ge(name, value));
				}else if(ParameterBean.Less.equals(conditional)){
					criteria.add(Restrictions.lt(name, value));
				}else if(ParameterBean.LessOrEqual.equals(conditional)){
					criteria.add(Restrictions.le(name, value));
				}else if(ParameterBean.Like.equals(conditional)){
					criteria.add(Restrictions.like(name, value.toString().trim(), MatchMode.ANYWHERE));
				}else if(ParameterBean.In.equals(conditional)){
					criteria.add(Restrictions.in(name, (Object[])value));
				}
				looger.info("select parameter all value:"+parameterBean.toString());
			}else if(value==null && StringUtils.isNotBlank(name) && StringUtils.isNotBlank(conditional)){ //说明只有值为null
				if(parameterBean.Desc.equals(conditional)){//倒序
						criteria.addOrder(Order.desc(name));
				}else if(parameterBean.Asc.equals(conditional)){//顺序
						criteria.addOrder(Order.asc(name));
				}
			}
		}
	}
	
	public static void doCriteriaMeth(List<ParameterBeanSupport> parameterList, Criteria criteria) {
		List<ParameterBean> list = new ArrayList<ParameterBean>();
		for (ParameterBeanSupport parameterBean : parameterList) {
		    if("cascade".equals(parameterBean.getType())){
		    	criteria.createAlias(parameterBean.getParameterName(), parameterBean.getAlias());
		    	continue;
		    }
		    list.add(parameterBean);
		}
		dealCriteriaMeth(list, criteria);
	}
	
}
