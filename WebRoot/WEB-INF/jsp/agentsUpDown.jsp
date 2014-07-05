<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'agentsUpDown.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script type="text/javascript" src="${path}js/common/jquery-1.8.0.min.js"></script>
<script type="text/javascript" language="JavaScript"	src="${path}js/thickbox.js"></script>
   <SCRIPT LANGUAGE="JavaScript">
   $("document").ready(function(){
    $('input[name="radio"]').click(function(){
   		var agentsCode= $('input[name="radio"]:checked').val(); 
   		closeWinNoLoad();
   		refresh(agentsCode);
    });
   });
  
function closeWinNoLoad(hasFlush, timeout) {
	if (hasFlush) {
		if (!timeout) {
			var timeout = 2000;
		}
		setTimeout(function() {
			try {
				tb_remove();
			} catch (e) {
			}
		}, timeout);
	} else {
		tb_remove();
	}
}
  function refresh(agentsCode){
  main.location.href="<%=basePath%>account.do?type=transferPoint&agentsCode="+agentsCode;

}
  </SCRIPT>
  <style type="text/css">
  body { margin:0px; padding:0px;margin-top:10px;   font-family: "微软雅黑","Arial Narrow";font-size: 14px;}
  
  .table tr th { 
  background-color: #87CEFA;padding: 0;
  
  
  }
  .table tr td { 
   font-size: 12px;
  
  
  }
  .table{
  BORDER-RIGHT: #ff6600 2px dotted; 
  BORDER-TOP: #ff6600 2px dotted; 
  BORDER-LEFT: #ff6600 2px dotted; 
  BORDER-BOTTOM: #ff6600 2px dotted; 
  BORDER-COLLAPSE: collapse
  }
  </style>
 </HEAD>
 <BODY>
 <table  class="table"   style="" borderColor=#ff6600 height=40 cellPadding=1 width=550  border=2>
 <form id="form">
 <tr>
 <th>选择代理商</th>
<th>代理商编码</th>
<th>代理商名称</th>
<th>联系人</th>
<th>联系电话</th>
 </tr>
 <c:forEach items="${agentsUpDownList}" var="agentsUpDownList" >
 <tr>
	<td>
	   <input type="radio"  name="radio" value="${agentsUpDownList.agentsCode}">
	</td>
	<td><c:out value="${agentsUpDownList.agentsCode}"></c:out>	</td>
	<td><c:out value="${agentsUpDownList.name}"></c:out></td>
	<td><c:out value="${agentsUpDownList.linkman}"></c:out></td>
	<td><c:out value="${agentsUpDownList.mobilePhone}"></c:out></td>
 </tr>
		</c:forEach>	
 </table>
 </form>
 </BODY></html>
