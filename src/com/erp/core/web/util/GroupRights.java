package com.erp.core.web.util;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class GroupRights {/*
	*//**
	 * 得到权限组权限点
	 * @param GroupId :权限组编号
	 * @return  List
	 *//*
	public static List getList(String GroupId){
		List groupRightsList=null;
		Session session;
		try {
			session = SessionFactory.currentSession();
			String sql="from PGroupPrv a,PPrivilege b,PGroup c where a.id.groupid=c.groupid and b.prvid=a.id.privilege and b.status=1 and c.groupid='"+GroupId+"' order by b.vieworder";
			Query query=session.createQuery(sql);
			//String sql="select {a.*},{b.*},{c.*} from p_group_prv a,p_privilege b,p_group c where a.groupid=c.groupid and b.prvid=a.privilege and b.status=1 and c.status=1 and c.groupid='"+GroupId+"' order by b.vieworder";
			//Query query=session.createSQLQuery(sql,new String[]{"a","b","c"},new Class[]{PGroupPrv.class,PPrivilege.class,PGroup.class});
			groupRightsList=query.list();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			try {
				SessionFactory.closeSession();
			} catch (HibernateException e1) {
				e1.printStackTrace();
			}
		}
		return groupRightsList;
	}
	
	*//**
	 * 得到权限组权限点
	 * @param GroupId :权限组编号
	 * @param splitChar :分隔字符
	 * @return String
	 *//*
	public static String getString(String GroupId,String splitChar){
		String groupRights=null;
		List list=getList(GroupId);
		
		if(!list.isEmpty() && list.size()>0){
			//把对象转换出来
			Object[] objArr=null;
			PPrivilege privilege=null;
			groupRights=splitChar;
			for(int i=0;i<list.size();i++){
				objArr=(Object[])list.get(i);
				privilege=(PPrivilege)objArr[1];
				groupRights+=privilege.getPrvid()+splitChar;
			}
			privilege=null;
			objArr=null;
		}
		return groupRights;
	}
	
	*//**
	 * 得到权限组菜单
	 * @param GroupId
	 * @return
	 *//*
	public static List getGroupMenu(String GroupId){
		List returnList = new ArrayList();

		List groupRightsFirst = new ArrayList(); //权限第一层
		List groupRightsSecond = new ArrayList(); //权限第二层
		String parentprvid=null; //父权限点
		
		Hashtable userHash=null;
		Hashtable usersubHash=null;
		List usersubList = new ArrayList();
		int i=0,j=0;
		Session session;
		try {
			session = SessionFactory.currentSession();
			String sql="from PGroupPrv a,PPrivilege b,PGroup c where a.id.groupid=c.groupid and b.prvid=a.id.privilege and b.status=1 and c.status=1 and c.groupid='"+GroupId+"' and b.parentprvid='0' order by b.vieworder";
			Query query=session.createQuery(sql);
			groupRightsFirst=query.list();
			Object[] objArr=null;
			PPrivilege privilege=null;
			for(i=0;i<groupRightsFirst.size();i++){
				userHash=new Hashtable();
				objArr=(Object[])groupRightsFirst.get(i);
				privilege=(PPrivilege)objArr[1];
				parentprvid=privilege.getPrvid();
				
				userHash.put("name",privilege.getName());
				
				sql="from PGroupPrv a,PPrivilege b,PGroup c where a.id.groupid=c.groupid and b.prvid=a.id.privilege and b.status=1 and c.status=1 and c.groupid='"+GroupId+"' and b.parentprvid='"+parentprvid+"' order by b.vieworder";
				Query query2=session.createQuery(sql);
				groupRightsSecond=query2.list();
				usersubList=new ArrayList();
				for(j=0;j<groupRightsSecond.size();j++){
					usersubHash=new Hashtable();
					objArr=null;
					objArr=(Object[])groupRightsSecond.get(j);
					privilege=(PPrivilege)objArr[1];
					usersubHash.put("name",privilege.getName());
					usersubHash.put("url",privilege.getUrl());
					usersubList.add(usersubHash);
				}
				userHash.put("PrivilegeSub",usersubList);
				returnList.add(userHash);
			}
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			usersubHash=null;
			userHash=null;
			groupRightsFirst=null;
			groupRightsSecond=null;
			try {
				SessionFactory.closeSession();
			} catch (HibernateException e1) {
				e1.printStackTrace();
			}
		}
		return returnList;
	}
	
	*//**
	 * 得到权限菜单对象
	 * @return
	 *//*
	public RightsMenu getTree(){
		RightsMenu menu=new RightsMenu(); //保存一级菜单
		GroupSecond second=new GroupSecond(); //保存二级菜单
		ComParam param=new ComParam(); //二级里具体的信息
		
		int i=0,j=0;
		String prvid=""; //权限点
		List groupRightsFirst=null;
		List groupRightsSecond=null;
		List retlist1=new ArrayList();
		List retlist2=new ArrayList();
		Session session;
		try {
			session = SessionFactory.currentSession();
			String sql="from PPrivilege a where a.parentprvid='0' and a.status=1 order by a.vieworder";
			groupRightsFirst=session.createQuery(sql).list();
			PPrivilege privilege=null;
			for(i=0;i<groupRightsFirst.size();i++){
				privilege=(PPrivilege)groupRightsFirst.get(i);
				prvid=privilege.getPrvid();
				second=new GroupSecond();
				second.setPrvid(prvid);
				second.setRightsname(privilege.getName());
				//查询子类
				sql="from PPrivilege a where a.parentprvid='"+prvid+"' and a.status=1 order by a.vieworder";
				groupRightsSecond=session.createQuery(sql).list();
				retlist2=new ArrayList();
				for(j=0;j<groupRightsSecond.size();j++){
					param=new ComParam();
					privilege=(PPrivilege)groupRightsSecond.get(j);
					param.setParam0(privilege.getName());
					param.setParam1(privilege.getPrvid());
					retlist2.add(param);
				}
				second.setRightsMenu(retlist2);
				retlist1.add(second);
			}
			menu.setRightstop(retlist1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			groupRightsFirst=null;
			try {
				SessionFactory.closeSession();
			} catch (HibernateException e1) {
				e1.printStackTrace();
			}
		}
		return menu;
	}
	
	*//**
	 * 得到权限菜单对象,带checked验证的
	 * @param groupid 权限组id
	 * @return
	 *//*
	public RightsMenu getTree(String groupid){
		String groupStr=getString(groupid,",");
		String checkstatus="";
		
		RightsMenu menu=new RightsMenu(); //保存一级菜单
		GroupSecond second=new GroupSecond(); //保存二级菜单
		ComParam param=new ComParam(); //二级里具体的信息
		
		int i=0,j=0;
		String prvid=""; //权限点
		List groupRightsFirst=null;
		List groupRightsSecond=null;
		List retlist1=new ArrayList();
		List retlist2=new ArrayList();
		Session session;
		try {
			session = SessionFactory.currentSession();
			String sql="from PPrivilege a where a.parentprvid='0' and a.status=1 order by a.vieworder";
			groupRightsFirst=session.createQuery(sql).list();
			PPrivilege privilege=null;
			for(i=0;i<groupRightsFirst.size();i++){
				privilege=(PPrivilege)groupRightsFirst.get(i);
				prvid=privilege.getPrvid();
				second=new GroupSecond();
				second.setPrvid(prvid); 
				second.setRightsname(privilege.getName());
				if(groupStr.indexOf(","+prvid+",")>=0){
					checkstatus="checked";
				}else{
					checkstatus="";
				}
				second.setCheckstatus(checkstatus);
				//查询子类
				sql="from PPrivilege a where a.parentprvid='"+prvid+"' and a.status=1 order by a.vieworder";
				groupRightsSecond=session.createQuery(sql).list();
				retlist2=new ArrayList();
				for(j=0;j<groupRightsSecond.size();j++){
					param=new ComParam();
					privilege=(PPrivilege)groupRightsSecond.get(j);
					param.setParam0(privilege.getName());
					param.setParam1(privilege.getPrvid());
					if(groupStr.indexOf(","+privilege.getPrvid()+",")>=0){
						checkstatus="checked";
					}else{
						checkstatus="";
					}
					param.setParam2(checkstatus);
					retlist2.add(param);
				}
				second.setRightsMenu(retlist2);
				retlist1.add(second);
			}
			menu.setRightstop(retlist1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			groupRightsFirst=null;
			try {
				//SessionFactory.closeSession();
			} catch (HibernateException e1) {
				e1.printStackTrace();
			}
		}
		return menu;
	}

*/}
