<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'printerOrder.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/common/button.css" 	media="screen">
	<style type="text/css">
  tr td:first-child{width: 150px;font-size: 12;text-align: right;}
 tr td:second-child{width: 200px;font-size: 12;text-align: left;}
	table {margin: auto;padding-top: 5px;}
	</style>
 <!-- 插入打印控件 --> 
 <OBJECT  ID="jatoolsPrinter" CLASSID="CLSID:B43D3361-D075-4BE2-87FE-057188254255"   style="float: left;"               codebase="jatoolsPrinter.cab#version=5,7,0,0"></OBJECT>
         <script>       
         function doPrint(how) {
          	myDoc = {
          		documents: document,
          		
          		copyrights: '杰创软件拥有版权  www.jatools.com'    
          	};
          	if(how == '打印预览...')
            			jatoolsPrinter.printPreview(myDoc );   // 打印预览
           	else if(how == '打印...')
           	        jatoolsPrinter.print(myDoc ,true);   // 打印前弹出打印设置对话框
             else 
           	        jatoolsPrinter.print(myDoc ,false);       // 不弹出对话框打印
          }
   </script>
  </head>
  
 <body style="TEXT-ALIGN: center;padding:10px;">  
     <div id='page1'  style='width:400px;height:300px;margin: 30px auto;border: 2px dashed yellow;'>
     <table >
     <tr>
       <td ><strong>订单号:</strong>	</td><td ><c:out value="${orderInfo.orderCode}"/></td>
     </tr>
     <tr>
         <td><strong>商品名称:</strong></td><td><c:out value="${orderInfo.goodName}"/></td>
     </tr>
     <tr>
         <td><strong>商品价格:</strong></td><td> <c:out value="${orderInfo.parValue}"/>元</td>
     </tr>
   	<c:if test="${orderInfo.categoryId==2}">
	<tr>
       <td><strong>充值账号:</strong></td><td>	<c:out value="${orderInfo.rechargeAccount}"/></td>
	</tr>
	</c:if>
	<tr>
        <td><strong>订单生成时间:</strong></td><td>	<c:out value="${orderInfo.createTime}"/></td>
	</tr>
	<tr>
        <td><strong>订单处理时间:</strong></td><td>	<c:out value="${orderInfo.handleTime}"/></td>
	</tr>
	<tr>
      <td><strong>充值数量:</strong></td><td>	<c:out value="${orderInfo.rechargeNumber}"/>个</td>
	</tr>
	<tr>
     <td><strong>订单状态:</strong></td><td>	<c:out value="${orderInfo.orderStatusString}"/></td>
	</tr>
     </table>
    
     </div>    
     <tr>
	     <td>
	       <input type="button" value="打印" class="Partorange"  onClick=' doPrint()'>    
	     </td>
	     <td>
	      <input type="button" value="打印预览..." class="Partorange"  onClick="doPrint('打印预览...')">
	     </td>
     </tr>
       <a href="${ctx}/tradingRecord.do?queryTime=all" style="text-decoration:none;">返回</a>
   </body>
</html>
