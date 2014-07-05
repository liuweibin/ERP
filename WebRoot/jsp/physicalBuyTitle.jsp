<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String tabNum= request.getParameter("num");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title> 
<style type="text/css">
.gamenamebox ul li{ width:100px; height:38px; float:left; font-family:"微软雅黑"; font-size:16px; text-align:center; line-height:38px;} 
.gamenamebox ul li a{color:#185895;display:block;}
.gamenamebox ul li a:active{color:#185895;}
.gamenamebox ul li a:hover{background:none repeat scroll 0 0 #2180D4; color:#FFFFFF;}
.gamenamebox ul li a.over{background:none repeat scroll 0 0 #2180D4; color:#FFFFFF;}

#tit  li{padding: 0 0;}
 </style>
<script type="text/javascript">

	 var cursel = '<%=tabNum%>'; 
	 $(function(){
	  setTab3("spcx",cursel,3);
	 });
	 function setTab4(name,cursel,n){
		 var m='';
		 var bo =false;
			for(i=1;i<=n;i++){
				var menu=document.getElementById(name+i);
				if(menu.className=="hover"&&i!=cursel){
					m = i;
					bo =true;
				}
			}
			if(bo){
				var menu=document.getElementById(name+m);
				menu.className = "";
			}
		}
	 
 </script>
</head>

<body>
 <div class="gamenamebox">
     <ul class="tit" id="tit">
              <li    id="spcx1" onclick="setTab3('spcx',1,3)" ><a   href="./jsp/physicalBuyOperation.jsp?num=1">采购</a></li>
              <li id="spcx2" onclick="setTab3('spcx',2,3)" ><a href="./jsp/physicalAcceptedOperation.jsp?num=2">供货/退货受理</a></li>
              <li id="spcx3" onclick="setTab3('spcx',3,3)" ><a href="./jsp/physicalOperationQuery.jsp?num=3">供货/退货查询</a></li>
            </ul>
  </div>
 </body></html>