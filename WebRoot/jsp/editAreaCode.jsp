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
    
    <title>编辑代理商默认地区</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/common/button.css" 	media="screen">
<script type="text/javascript" src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/thickbox.js"></script>
   <SCRIPT LANGUAGE="JavaScript">
   $("document").ready(function(){
    $('input[name="radio"]').click(function(){
   		var agentsCode= $('input[name="radio"]:checked').val(); 
   		closeWinNoLoad();
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
	refresh();
}
  function refresh(){
  location.href='<%=basePath%>jsp/ghcz.jsp';
}
  function showCode(value){
	  var code = value.split(",")[0];
	  var id = value.split(",")[1];
	  $("#newAreaCode").html(code);
	  $("#id").val(id);
	  
	  $("#areaCodeShow").html(code);
	  $("#areaCode").val(code);
  }
  
	function update() {
		var id = $("#id").val();
		$.ajax({
			url : '<%=basePath%>account.do?type=updInfo',
			type : 'post',
			dataType : 'json',
			data : {
				"id" : id
			},
			success : function(data) {
				if(data.retcode==0){
					//closeWinNoLoad();
					tb_remove();
					alert("修改默认地区成功");		
				}
			},
			error : function(error) {
				alert(alert(error.status));
			}
		});
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
  margin-top:20px;
  BORDER-RIGHT: #ff6600 2px dotted; 
  BORDER-TOP: #ff6600 2px dotted; 
  BORDER-LEFT: #ff6600 2px dotted; 
  BORDER-BOTTOM: #ff6600 2px dotted; 
  BORDER-COLLAPSE: collapse
  }
  </style>
 </HEAD>
 <BODY>
 <table  class="table"   style="" borderColor=#ff6600 height=40 cellPadding=1 width=450  border=2>
 <form id="form">
 <input type="hidden" value="" id="id">
 <input type="hidden" value="${nowAreaCode}" id="nowAreaCode">
 <tr>
 <td>当前区号为：</td>
	<td><c:out value="${nowAreaCode}"></c:out>	</td>
 </tr>
 <tr>
	 <td>选择地区：</td>
	 <td>
		 <select id="areaCode" name="areaCode" onchange="showCode(this.value)" style="width: 143px;height: 25px;line-height: 25px;">
				<c:forEach items="${areaList}" var="data">
				<c:if test="${data.code==nowAreaCode}">
					<option selected="selected" value="${data.code},${data.id}"><c:out value="${data.name}"></c:out></option> 
				</c:if>
				<c:if test="${data.code!=nowAreaCode}">
					<option value="${data.code},${data.id}"><c:out value="${data.name}"></c:out></option> 
				</c:if>
			 </c:forEach>
		</select>
	</td>
 </tr>
  <tr>
	 <td>修改地区：</td>
	 <td>
		 <SPAN ID="newAreaCode">${nowAreaCode}</SPAN>
	</td>
 </tr>
  <tr>
	 <td colspan="2" style="float: none;text-align: center;"><input type="button" class="Partorange" onclick="update()" value="保存"/></td>
 </tr>
 </form>
 </table>
 </BODY></html>
