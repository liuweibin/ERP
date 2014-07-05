package com.erp.core.web.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.erp.core.model.AgentsUserTbl;
import com.erp.core.util.StringUtil;
import com.erp.core.web.util.SysContent;


/**
 * 登录过滤
 * 
 */
public class SessionFilter implements HandlerInterceptor {
	private Logger log = Logger.getLogger(SessionFilter.class);
	private static Boolean bo = false; 
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.springframework.web.filter.OncePerRequestFilter#doFilterInternal(
	 * javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, javax.servlet.FilterChain)
	 */
	protected void doFilterInternal(HttpServletRequest request,
			HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
	}

	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	       SysContent.setRequest((HttpServletRequest) arg0);  
	       SysContent.setResponse((HttpServletResponse) arg1);  
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handle) throws Exception {
	       SysContent.setRequest((HttpServletRequest) request);  
	       SysContent.setResponse((HttpServletResponse) response);
	      
		// 不过滤的uri
	String[] notFilter = new String[] {"j_spring_security_check", "checkCode/service.do", "/index.jsp"  };
	String url =request.getContextPath();
		// 请求的uri
		String uri = request.getRequestURI();
		log.info("preHandle--+"+uri);
		// uri中包含background时才进行过滤
		if (true) {
			// 是否过滤
			boolean doFilter = true;
			for (String s : notFilter) {
				if (uri.indexOf(s) != -1) {
					// 如果uri中包含不过滤的uri，则不进行过滤
					doFilter = false;
					break;
				}
			}
			if (doFilter) {
				// 执行过滤
				// 从session中获取登录者实体
				AgentsUserTbl user = (AgentsUserTbl) request.getSession().getAttribute("session_user_data");
				if (user == null || StringUtil.isNullOrEmpty(user.getUsername())) {
					
					if (request.getHeader("x-requested-with") != null      && request.getHeader("x-requested-with")   .equalsIgnoreCase("XMLHttpRequest")){  
					    //在响应头设置session状态   
					    response.setHeader("sessionstatus", "sessionOut");  
					    response.getWriter().print("sessionOut");  return false;
					}  
					// 如果session中不存在登录者实体，则弹出框提示重新登录
					// 设置request和response的字符集，防止乱码
				//	String loginPage = url+"/jsp/login.jsp";
				//	response.sendRedirect(loginPage);
					
					String webName = request.getContextPath();
					response.setContentType("text/html;charset=UTF-8");
					StringBuilder builder = new StringBuilder();
					builder.append("<script type=\"text/javascript\">");
				//	builder.append("alert('session过期!');");
					builder.append("window.top.location.href='");
					builder.append(webName+"/jsp/login.jsp");
					builder.append("';");
					builder.append("</script>");
					PrintWriter out = null;
					try {
						out = response.getWriter();
					} catch (IOException e) {
						e.printStackTrace();
					}
					out.print(builder.toString());
					out.flush();
					out.close();
					return false;
				}
			}
		} 
			return true;
	}
}
