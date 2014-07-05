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
function changeSubTab(elementId,cursel){
	 var liList = document.getElementById(elementId).getElementsByTagName("li");
    for(var i =0; i < liList.length; i ++)
    {
   	 liList[i].getElementsByTagName("a")[0].className=i==cursel?"over":"";
   }
}
var cursel = '<%=tabNum%>'; 
$(function(){
		setTab2("title",cursel,3);  
});
 </script>
</head>

<body>
  <div class="order_big_title_bg">
		    <ul>
			  <li><a href="./jsp/newsManage.jsp" class="over"  id="title0" onclick="setTab2('title',0,3)">收件箱</a></li>
			  <li><a href="./jsp/newsOutbox.jsp"  id="title1" onclick="setTab2('title',1,3)">发件箱</a></li>
			  <li><a href="./jsp/newsSendMessage.jsp"  id="title2" onclick="setTab2('title',2,3)">发消息</a></li>
			</ul>
  </div>
		  
	   <div class="order_big_title_bg2" style="display:none;">
	      <ul class="title" id="con_title_0"  style="display:block"></ul>
	      <ul class="title" id="con_title_1" style="display:block"></ul>
	      <ul class="title" id="con_title_2"  style="display:block">  </ul>
   </div>
 </body>
 </html>