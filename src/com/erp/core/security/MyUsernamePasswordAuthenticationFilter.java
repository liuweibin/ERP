package com.erp.core.security;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.erp.core.dao.AgentsUserTblDao;
import com.erp.core.model.AgentsUserTbl;
import com.erp.core.util.StringUtil;


/*
 * 
 * UsernamePasswordAuthenticationFilter源码
	attemptAuthentication
		this.getAuthenticationManager()
			ProviderManager.java
				authenticate(UsernamePasswordAuthenticationToken authRequest)
					AbstractUserDetailsAuthenticationProvider.java
						authenticate(Authentication authentication)
							P155 user = retrieveUser(username, (UsernamePasswordAuthenticationToken) authentication);
								DaoAuthenticationProvider.java
									P86 loadUserByUsername
 */
public class MyUsernamePasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter{
	private Logger log = Logger.getLogger(MyUsernamePasswordAuthenticationFilter.class);
	public static final String VALIDATE_CODE = "validateCode";
	public static final String USERNAME = "username";
	public static final String PASSWORD = "password";
	public static String MESSAGE = "";
	private AgentsUserTblDao agentsUserTblDao;
	
	@Autowired
	protected Md5PasswordEncoder passwordEncoder;
	
	 
	public AgentsUserTblDao getAgentsUserTblDao() {
		return agentsUserTblDao;
	}

	public void setAgentsUserTblDao(AgentsUserTblDao agentsUserTblDao) {
		this.agentsUserTblDao = agentsUserTblDao;
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
		if (!request.getMethod().equals("POST")) {
			throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());
		}
		log.info("---------MyUsernamePasswordAuthenticationFilter:attemptAuthentication------");
		
		//检测验证码
				Boolean bo = checkValidateCode(request);
				if(!bo){
					throw new AuthenticationServiceException("验证码错误！");  
				}
		String username = obtainUsername(request);
		String password = obtainPassword(request);
		passwordEncoder.setEncodeHashAsBase64(false);
			password=passwordEncoder.encodePassword(password,null);
			System.out.println(password);
		 if(username == null)
	            username = "";
	        if(password == null)
	            password = "";
	        username = username.trim();
	     log.info(""+password);
	        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(username, password);
	        setDetails(request, authRequest);
	        return getAuthenticationManager().authenticate(authRequest);
	}
	
	protected Boolean checkValidateCode(HttpServletRequest request) { 
		HttpSession session = request.getSession();
		
	    String sessionValidateCode = obtainSessionValidateCode(session); 
	    //让上一次的验证码失效
	    session.setAttribute(VALIDATE_CODE, null);
	    String validateCodeParameter = obtainValidateCodeParameter(request);  
	   if (StringUtil.isEmpty(validateCodeParameter) || !sessionValidateCode.equalsIgnoreCase(validateCodeParameter)) { 
		   return false;
	    }
	   return true;
	}
	
	private String obtainValidateCodeParameter(HttpServletRequest request) {
		Object obj = request.getParameter(VALIDATE_CODE);
		return null == obj ? "" : obj.toString();
	}

	protected String obtainSessionValidateCode(HttpSession session) {
		Object obj = session.getAttribute(VALIDATE_CODE);
		return null == obj ? "" : obj.toString();
	}

	@Override
	protected String obtainUsername(HttpServletRequest request) {
		Object obj = request.getParameter(USERNAME);
		return null == obj ? "" : obj.toString();
	}

	@Override
	protected String obtainPassword(HttpServletRequest request) {
		Object obj = request.getParameter(PASSWORD);
		return null == obj ? "" : obj.toString();
	}
	 

	public void outPrintln(HttpServletResponse response, Object o) {
		response.setContentType("text/xml;charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.println(o);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	

}
