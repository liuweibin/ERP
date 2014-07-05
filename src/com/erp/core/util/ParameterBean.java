package com.erp.core.util;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

/******
 * 
 * @author Administrator
 * 保持参数信息的Bean
 */
public class ParameterBean {
	
	
	//参数名
	private String parameterName;
	//条件式
	private String conditional;//条件式有: like   =   >=  <=  >  <  	

	//参数值
	private Object parameterValue;
	
	//这是条件式的全部值
	public final static String Like="like";
	public final static String Equal="=";
	public final static String GreaterOrEqual=">=";
	public final static String LessOrEqual="<=";
	public final static String Greate=">";
	public final static String Less="<";
	public final static String Desc="desc";//倒序
	public final static String Asc="asc";  //顺序
	public final static String In="in";
	
	public ParameterBean(){
	}
	
	
	public ParameterBean(String parameterName) {
		super();
		this.parameterName = parameterName;
	}


	/***
	 * 查询条件的信息配置
	 * @param parameterName 	要筛寻的条件
	 * @param conditional		控制的条件
	 * @param parameterValue	条件值是多少
	 */
	public ParameterBean(String parameterName,String conditional,Object parameterValue){
		this.parameterName=parameterName;
		this.conditional=conditional;
		this.parameterValue=parameterValue;
	}
	/**
	 * 查询条件的    排序的构造方法
	 * @param parameterName  要排序的属性名 
	 * @param conditional	  按什么顺序排序  (倒序,顺序)
	 */
	public ParameterBean(String parameterName,String conditional){
		this.parameterName=parameterName;
		this.conditional=conditional;
	}
	
	
	public String getParameterName() {
		return parameterName;
	}

	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}

	public String getConditional() {
		return conditional;
	}

	public void setConditional(String conditional) {
		this.conditional = conditional;
	}

	public Object getParameterValue() {
		return parameterValue;
	}

	public void setParameterValue(Object parameterValue) {
		this.parameterValue = parameterValue;
	}
	public String toString(){
		return ReflectionToStringBuilder.toString( this );
	}
	
	
}
