package com.erp.core.web;

import java.util.TimeZone;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.commons.lang.StringUtils;

import com.erp.core.util.DateFormatter;


/**
 * 
 * @version: 2007-7-23<br>
 * @author <a href="mailto:kenny319@gmail.com">Kenny Wang </a>
 */
public class OmsLoaderListener implements ServletContextListener {
	
	
	public void contextInitialized(ServletContextEvent event) {
		String remoteTimeZoneId = event.getServletContext().getInitParameter(
				"remoteTimeZoneId");
		String localTimeZoneId = event.getServletContext().getInitParameter(
				"localTimeZoneId");
		if (StringUtils.isEmpty(localTimeZoneId)) {
			localTimeZoneId="PRC";
		}
		if (StringUtils.isEmpty(remoteTimeZoneId)) {
			remoteTimeZoneId = "UTC";
		}

		/**
		 *	<!-- web.xml中的参数配置 -->
		 *	<context-param>
		 *		<param-name>web_xml_parameter</param-name>
		 *		<param-value>MyParamValue</param-value>
		 *	</context-param>
		 */
		// 读取web.xml配置文件中的参数 参数名 web_xml_parameter
		String web_xml_parameter = event.getServletContext().getInitParameter("web_xml_parameter");
		if(StringUtils.isNotEmpty(web_xml_parameter)){
			// 设置参数的代码
		}
		
		DateFormatter.CUSTOM_TIMEZONE = TimeZone.getTimeZone(localTimeZoneId);
		TimeZone.setDefault(TimeZone.getTimeZone(remoteTimeZoneId));

	}

	public void contextDestroyed(ServletContextEvent arg0) {

	}
}
