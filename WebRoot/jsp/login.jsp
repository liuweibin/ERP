<%@ page language="java" import="java.util.*" pageEncoding="utf-8"  isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String verification_code = (String)application.getAttribute("verification_code");
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<link href="<%=basePath%>css/css.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/login/jquery.SuperSlide.js"></script>
<script type="text/javascript" src="<%=basePath%>js/login/Validform_v5.3.2_min.js"></script>
<style type="text/css">
.input8{text-indent: 20px;}
</style>
<script type="text/javascript">
$(document).ready(function(){
			$("#focus .input_txt").each(function(){
					var thisVal=$(this).val();
					//判断文本框的值是否为空，有值的情况就隐藏提示语，没有值就显示
					if(thisVal!=""){
							$(this).siblings("span").hide();
						}else{
							$(this).siblings("span").show();
						}
					//聚焦型输入框验证	
					$(this).focus(function(){
							$(this).siblings("span").hide();
						}).blur(function(){
								var val=$(this).val();
								if(val!=""){
									$(this).siblings("span").hide();
								}else{
									$(this).siblings("span").show();
								}	
						});
				})
				
		var demo=	$(".border_radius").Validform({
				tiptype:function(msg,o,cssctl){
					var objtip=$(".error-box");
					cssctl(objtip,o.type);
					objtip.text(msg);
				},
				ignoreHidden:true,
				ajaxPost:false
				 
			});

		 

})
		
function changeValidateCode(obj){
	var timeNow = new Date().getTime();
	obj.src="checkCode/service.do?time="+timeNow;
}	
function a(o){
	var val = $(o).val();
	 $(o).hide();
}

</script>
</head>

<body>
<div class="dl_head"><img src="<%=basePath%>images/images/logo.jpg" width="268" height="54" /></div>
<div class="mainbg">
  <div class="them">
    <div class="login_box">
      <form name='LoginForm' class="border_radius"  id="focus" action="<c:url value='j_spring_security_check'/>" method="post" target="_parent" id="loginForm">
      <input type="hidden" name="loginType" value="0">
       <input type="hidden" name="loginTypeNew"	value="true" /> 
    <input type="hidden" name="method"	value="log" /> 
    <input type="hidden" name="mac"	 id="mac" value="" /> 
    <input type="hidden" name="ip"	 id="ip" value="" /> 
    <div class="error-box">${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}</div>
    
      <div class="dlinput2"><label><span onclick=a(this) >请输入账号</span><input value="13751867590" name="username" type="text" maxlength="11" nullmsg="请填写账号"  datatype="*3-15" errormsg="账号至少3个字符,最多15个字符！"  class="input8 input_txt border_radius"  /></label></div>
      <div class="dlinput3"><label><span onclick=a(this) > 请输入密码</span><input   name="password" type="password" value="123456"  maxlength="20" class="input8 input_txt border_radius" datatype="*6-16" nullmsg="请填写登录密码" errormsg="密码范围在6~16位之间！"  /></label></div>
      <div class="yzm" >
	      <div class="dlinput4" >
		      <label>
		      <span onclick=a(this) >验证码</span> <input name="validateCode" id="validateCode" autocomplete="off" type="text" class="input9 input_txt border_radius" />
		      </label>
	      </div>
	      <div class="yamxs">
	           <img  width="60" height="20" title="刷新验证码"  src= "<%=basePath%>checkCode/service.do" onclick="changeValidateCode(this)" /></span><span  value="<c:out value="${msg}"></c:out>">
	      </div>
      </div>
      <div class="dlinput5"><input type="submit" name="button" id="button" value="登录" class="input10" /></div>
      </form>
    </div>
  </div>
</div>
<div class="dl_footer">上海大指头网络技术有限公司 版权所有 Copyright 2012-2013 dazhitou Corporation, All Rights Reserved</div>
</body>
</html>