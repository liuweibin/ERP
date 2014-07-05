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
function changeSubTab(elementId,cursel){
	 var liList = document.getElementById(elementId).getElementsByTagName("li");
    for(var i =0; i < liList.length; i ++)
    {
   	 liList[i].getElementsByTagName("a")[0].className=i==cursel?"over":"";
   }
}

function setTab3(name,cursel,n){ 
			var menu=document.getElementById(name+cursel);
			$(menu).addClass("over").parent().siblings().find("a").removeAttr("class");
}
var cursel = '<%=tabNum%>'; 
$(function(){
setTab3("title",cursel,2); 
});
 </script>
</head>

<body>
  <div class="order_big_title_bg">
		    <ul>
			  <li><a href="./jsp/reconciliationGDCZ.jsp" class="over"  id="title0" onclick="setTab3('title',0,2)">广东充值统计</a></li>
			  <li><a href="./jsp/reconciliationDay.jsp" id="title1" onclick="setTab3('title',1,2)">日对账</a></li>
			</ul>
  </div>
 </body>
 </html>