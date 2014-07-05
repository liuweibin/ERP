<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String tabNum= request.getParameter("num");
String subTab= request.getParameter("subTab");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title> 
<style type="text/css">
 
 </style>
<script type="text/javascript">
var cursel = '<%=tabNum%>'; 
function setTab3(name,cursel,n){ 
	var menu=document.getElementById(name+cursel);
	$(menu).addClass("over").parent().siblings().find("a").removeAttr("class");
}
$(function(){
	setTab3("title",cursel,3); 
});
 </script>
</head>

<body>
  <div class="order_big_title_bg">
     		 <ul>
			  <li><a href="./jsp/myAccountBasicInfo.jsp?num=0" class="over"  id="title0" onclick="setTab3('title',0,3)">基本资料</a></li>
			  <li><a href="./jsp/myAccountChangePWD.jsp?num=1" id="title1" onclick="setTab3('title',1,3)">修改密码</a></li>
			  <li><a href="./jsp/myAccountLoginLog.jsp?num=2" id="title2" onclick="setTab3('title',1,3)">登录日志</a></li>
			</ul>
		  </div>
		  
 </body></html>