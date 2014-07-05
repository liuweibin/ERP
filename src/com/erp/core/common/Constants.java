package com.erp.core.common;

import javax.persistence.Entity;

/**
 * @author mwh
 * 本类为通常申明类
 */
@Entity
public final class Constants {
	//handle state
	public static final String PROCESS_OK					= "OK";
	public static final String PROCESS_DATABASE_ADD_OK	= "添加成功!";
	public static final String PROCESS_DATABASE_ADD_ERR	= "添加失败!";
	public static final String PROCESS_DATABASE_EDIT_OK	= "编辑成功!";
	public static final String PROCESS_DATABASE_EDIT_ERR	= "编辑失败!";
	public static final String PROCESS_DATABASE_del_OK	= "删除成功!";
	public static final String PROCESS_DATABASE_del_ERR	= "删除失败!";
	//session
	public static final String SESSION_USER_DATA			= "用户登录数据"; //用户登录数据
	public static final String SESSION_USER_RIGHTSPOINT	= "用户权限数据"; //用户权限数据
	
	//login
	public static final String MSG_LOGIN_FAILED			= "用户登录失败!";
	public static final String MSG_LOGIN_FAILED_CAUSE		= "用户名或密码错误!";
	
	//tips
	public static final String TIPS_LOGIN_NONE			= "NO Deng Lu!";
	public static final String TIPS_RIGHTS_ERROR			= "您没有操作此页面的权限!";
	
	//view
	public static final int PAGE_SIZE						= 10;
	public static final int PAGE_SIZE12						= 12;
	
	//sys privelege tips
	public static final String TIPS_SYS_PRIVE_ERROR		= "系统固定权限菜单，不能修改、停用、删除！";
	public static final String TIPS_USER_SELF_ERROR		= "不能修改、停用、删除用户自己！";
	public static final String TIPS_GROUP_SELF_ERROR		= "不能修改、停用、删除用户自己所属用户组！";
	public static final String TIPS_GROUP_USER_ERROR		= "要删除的用户组下有用户，不能删除！";
	public static final String TIPS_GROUP_RIGHT_ERROR		= "要删除的权限点隶属于一个权限组，不能删除！";
	//积分兑换比例
	public static final int jifen						= 1000;
	//数据库和前台金额比例
	public static final int  dataBase_proportion					= 100;
	
}
