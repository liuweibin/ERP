package com.erp.core.web.listener;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

public class SpingLoadListener implements ApplicationListener<ApplicationEvent> {
	private static Logger logger = Logger.getLogger(SpingLoadListener.class);
	
	private static boolean started = false;
	public static String POINT_COMMIT_INTERVAL = "5";
	@Override
	public void onApplicationEvent(ApplicationEvent event) {
		if (event instanceof ContextRefreshedEvent) {
			ContextRefreshedEvent contextRefreshedEvent = (ContextRefreshedEvent) event;

			try {
				if (!started) {
					//Object obj = contextRefreshedEvent.getApplicationContext().getBean("configManager");
				 
					started = true;
				}
			} catch (Exception e) {
				logger.error(e, e);
			}
		}
	}
	
 
}
