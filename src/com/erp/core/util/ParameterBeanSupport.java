package com.erp.core.util;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

/******
 * 
 * @author Administrator 保持参数信息的Bean
 */
public class ParameterBeanSupport extends ParameterBean {
	public final static String CASCADE="cascade";

	private String type;
	private String alias;
    private String flag;
    
	public ParameterBeanSupport(String parameterName, String alias, String type, String flag) {
		super(parameterName);
		this.alias = alias;
		this.type = type;
		this.flag = flag;
	}
	
	/***
	 * 查询条件的信息配置
	 * @param parameterName 	要筛寻的条件
	 * @param conditional		控制的条件
	 * @param parameterValue	条件值是多少
	 */
	public ParameterBeanSupport(String parameterName,String conditional,Object parameterValue){
		super(parameterName, conditional, parameterValue);
	}

	/**
	 * 查询条件的 排序的构造方法
	 * 
	 * @param parameterName
	 *            要排序的属性名
	 * @param conditional
	 *            按什么顺序排序 (倒序,顺序)
	 */
	public ParameterBeanSupport(String parameterName, String conditional) {
		super(parameterName, conditional);
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}

}
