<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String tabNum= request.getParameter("num");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title><%--
<%@include file="./include/common.jsp" %>
 --%><script type="text/javascript">
 function changeSubTab(elementId,cursel){
 	 var liList = document.getElementById(elementId).getElementsByTagName("li");
     for(var i =0; i < liList.length; i ++)
     {
    	 liList[i].getElementsByTagName("a")[0].className=i==cursel?"over":"";
    }
 }
 var cursel = '<%=tabNum%>'; 
 
 $(function(){
 setTab2("title",cursel,5);
 });
 </script>
</head>

<body>
<div class="order_big_title_bg">
    <ul>
	  <li><a href="./jsp/sjcz.jsp?num=0" class="over" id="title0" onclick="setTab2('title',0,5)">本省充值</a></li>
	  <li><a href="./jsp/sjcz.jsp?num=1" id="title1" onclick="setTab2('title',1,5)" >全国充值</a></li>
	  <li><a href="./jsp/ghcz.jsp" id="title2" onclick="setTab2('title',2,5)" >固话充值</a></li>
	  <li><a href="./jsp/gameCzForm.jsp?goodsCode=qq"  id="title3" onclick="setTab2('title',3,5)">Q币充值</a></li>
	  <li><a href="./jsp/gamecz.jsp"  id="title4" onclick="setTab2('title',4,5)">游戏币充值</a></li>
	</ul>
  </div>
   <div class="order_big_title_bg2">
      <ul class="title" id="con_title_0"  style="display:block">
		  <li><a href="./jsp/sjcz.jsp?num=0" class="over"  onclick="changeSubTab('con_title_0',0)">充&nbsp;&nbsp;值</a></li>
		  <li><a href="./jsp/sjCorrect.jsp?num=0" onclick="changeSubTab('con_title_0',1)">冲&nbsp;&nbsp;正</a></li>
	  </ul>
      <ul class="title" id="con_title_1" style="display:block"></ul>
      
      <ul class="title" id="con_title_2"  style="display:block">   
        	<li><a href="./jsp/ghcz.jsp?num=0" class="over"  onclick="changeSubTab('con_title_2',0)">充&nbsp;&nbsp;值</a></li>
		    <li><a href="./jsp/sjCorrect.jsp?num=2" onclick="changeSubTab('con_title_2',1)">冲&nbsp;&nbsp;正</a></li>
       </ul>
	  
      <ul class="title" id="con_title_3" ></ul>
      <ul class="title" id="con_title_4" ></ul>
	  <div class="order_big_title_right_word">可用额度:<span id="useable_banlance">${useableBalance}</span>元</div>
   </div>
 </body></html>