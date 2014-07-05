<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String tabNum= request.getParameter("num");
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
	 $(function(){ 
			 setTab3("title",cursel,5);
	 });
 
	 function setTab3(name,cursel,n){ 
			var menu=document.getElementById(name+cursel);
			$(menu).addClass("over").parent().siblings().find("a").removeAttr("class");
		}
 </script>
</head>

<body>
 <div class="order_big_title_bg">
            <ul>
              <li><a id="title0" onclick="setTab3('title',0,5)"    href="./jsp/memberManager.jsp"   >下级基本信息</a></li>
              <li><a id="title1" onclick="setTab3('title',1,5)" class="over" href="./jsp/memberFinance.jsp">查询下级账务</a></li>
              <li><a id="title2" onclick="setTab3('title',2,5)"   href="./jsp/memberGoods.jsp">查询下级商品</a></li>
              <li><a id="title3" onclick="setTab3('title',3,5)"   href="./jsp/memberOrder.jsp">查询下级订单</a></li>
              <li><a id="title4" onclick="setTab3('title',4,5)"    href="./jsp/memberRegister.jsp">下级代理商注册</a></li>
            </ul>
  </div>
 </body></html>