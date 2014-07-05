<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打印交易订单</title>
<%@include file="./include/common.jsp" %>
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
<body>
<div class="main">
 
<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
       
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
           <div style="height: 30px;"></div>
       <div id='page1'  style='width:400px;height:300px;margin: 30px auto;border: 2px dashed yellow;'>
		     <table border="1" style="margin: 10px 52px;">
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
     </div>    <div style="text-align: center;">
     <tr>
	     <td>
	       <input type="button" value="打印" class="an_input1"  onClick='doPrint()'>    
	     </td>
	     <td>
	      <input type="button" value="打印预览..." class="an_input1" onClick="doPrint('打印预览...')">
       <a href="${ctx}/jsp/czTradeRecordQuery.jsp"  class="an_input1">返回</a>
	     </td>
     </tr>
           </div>
           
           
      </div>
        
    </div>
   <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
