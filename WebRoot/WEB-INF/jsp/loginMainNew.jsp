<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>1+分销系统登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<link href="<%=basePath%>themes/css/login.css" rel="stylesheet" rev="stylesheet" type="text/css" media="all" />
<link href="<%=basePath%>themes/css/demo.css" rel="stylesheet" rev="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/login/jquery.SuperSlide.js"></script>
<script type="text/javascript" src="<%=basePath%>js/login/Validform_v5.3.2_min.js"></script>
<script>
$(function(){

	$(".i-text").focus(function(){
		$(this).addClass('h-light');
	});
	
	$(".i-text").focusout(function(){
		$(this).removeClass('h-light');
	});
	




$(".registerform").Validform({
	tiptype:function(msg,o,cssctl){
		var objtip=$(".error-box");
		cssctl(objtip,o.type);
		objtip.text(msg);
	},
	ajaxPost:false
});

});

function changeValidateCode(obj){
	var timeNow = new Date().getTime();
	obj.src="checkCode/service.do?time="+timeNow;
}	



</script>
  </head>
	<p id="hid_message" style="display: none; text-align: center;"></p>
		<div   class='apk'>
			<label>扫描下载手机客户端</label>
		</div>
<div class="header" >
  <h1 class="headerLogo" style="display: none;"><a title="后台管理系统" target="_blank" href="${sys_url}"><img alt="logo" src="<%=basePath%>images/login/logo.gif"></a></h1>
	<div class="headerNav" style="display: none;">
		<a target="_blank" href="${sys_url}">关于上海大指头网络技术有限公司</a>
	</div>
</div>

<div class="banner">

<div class="login-aside">
  <div id="o-box-up"></div>
  <div id="o-box-down"  style="table-layout:fixed;">
   <div class="error-box"></div>
   
  <form   class="registerform" action="<c:url value='j_spring_security_check'/>" method="post"  autocomplete="off" target="_self" id="loginForm">
    <input type="hidden" name="loginType" value="0">
    <input type="hidden" name="method"	value="log" /> 
   <div class="fm-item">
	   <label for="logonId" class="form-label">代理商编号：</label>
	   <input type="text" value=""   maxlength="10"  id="agents.agentsCode" name="agents.agentsCode" nullmsg="请填写代理商编号"  class="i-text"  datatype="s8-8" errormsg="代理商编号至少8个字符,最多8个字符！"  ><!-- ajaxurl=""  -->    
  </div>
   <div class="fm-item">
	   <label for="loginName" class="form-label">账号：</label>
	   <input type="text" value=""   autocomplete="off"      maxlength="20" id="username" name="username" class="i-text" nullmsg="请填写账号"  datatype="*3-15" errormsg="账号至少3个字符,最多15个字符！"  >    
  </div>
  
  <div class="fm-item">
	   <label for="logonPassWord" class="form-label">登录密码：</label>
	   <input type="password" value=""   autocomplete="off"    maxlength="16" id="password" name="password" class="i-text" datatype="*6-16" nullmsg="请填写登录密码" errormsg="密码范围在6~16位之间！">    
  </div>
  
  <div class="fm-item pos-r">
	   <label for="logonId" class="form-label">验证码</label>
	   <input type="text" value=""   maxlength="4"  id="validateCode" name="validateCode" nullmsg="请输入验证码！"  class="i-text yzm"   
	    datatype="n4-6" errormsg="验证码错误" >    <!--  ajaxurl="<%=basePath%>user/checkValidateCode.do" -->
       <div class="ui-form-explain">
        	<img  class="yzm-img" height="37px;" title="刷新验证码"  src= "<%=basePath%>checkCode/service.do" onclick="changeValidateCode(this)" style="margin-bottom: 10px;"/></span>
        </div>
  </div>
  
  <div class="fm-item">
	   <label for="logonId" class="form-label"></label>
	   <input type="submit" value="" tabindex="4" id="send-btn" class="btn-login"> 
  </div>
  
  </form>
  
  </div>

</div>

	<div class="bd">
		<ul>
			<li style="background:url(<%=basePath%>images/login/theme-pic1.jpg) #CCE1F3 center 0 no-repeat;"><a target="_blank" href="${sys_url}"></a></li>
			<li style="background:url(<%=basePath%>images/login/theme-pic2.jpg) #BCE0FF center 0 no-repeat;"><a target="_blank" href="${sys_url}"></a></li>
		</ul>
	</div>

	<div class="hd"><ul></ul></div>
</div>




<div class="footer">
   <p> 上海大指头网络技术有限公司  版权所有    Copyright 2012-2013 dazhitou Corporation, All Rights Reserved</p>
</div>



</body>
</html>
