package com.erp.core.web.util;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;

@SuppressWarnings("deprecation")
public class HibernateUtils {

	private static SessionFactory factory;
	
	static {
		try {
			//读取hibernate.cfg.xml文件
			Configuration cfg = new AnnotationConfiguration().configure();
			
			//建立SessionFactory
			factory = cfg.buildSessionFactory();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Session getSession() {
		return factory.openSession();
	} 
	
	public static void closeSession(Session session) {
		if (session != null) {
			if (session.isOpen()) {
				session.close();
			}
		}
	}
	
	public static SessionFactory getSessionFactory() {
		return factory;
	}
	public static void main(String[] args) {
		//读取hibernate.cfg.xml文件
		Configuration cfg = new AnnotationConfiguration().configure();
		//建立SessionFactory
		SessionFactory factory = cfg.buildSessionFactory();
		
		//取得session
		Session session = null;
		try {
			session = factory.openSession();
			session.beginTransaction();
			//开启事务
			Query query = session.createSQLQuery("INSERT INTO user(id, username, password, age) " +
					"VALUES('004', 'mwh', '123456', 0)");
			  query.executeUpdate();
			//System.out.println(user.getUsername());
			//提交事务
			session.getTransaction().commit();
		}catch(Exception e) {
			e.printStackTrace();
			//回滚事务
			session.getTransaction().rollback();
		}finally {
			if (session != null) {
				if (session.isOpen()) {
					//关闭session
					session.close();
				}
			}
		}
	}
}
