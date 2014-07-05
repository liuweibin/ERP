package com.erp.core.web.util;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class main {
	 static Logger logger = Logger.getLogger(main.class.getName());
	/**
	 * @param args
	 */
	public static void main(String[] args) {  
		ApplicationContext content =new  ClassPathXmlApplicationContext( "/applicationContext.xml");
		
		
	}

}
