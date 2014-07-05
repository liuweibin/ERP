<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
    <title>import.htm</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

      <link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/of.global.100518.css">
        <link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.style.css">
		<link href="<%=basePath%>themes/sales/home/WdatePicker.css" rel="stylesheet" type="text/css">
  </head>
  <body>
			<ul id="tab">
		<li class="current">
			<a href="account.do?type=accountRecords&current=buyCreditQuery" target="_parent"><span>购买信用点查询</span> </a>
		</li>
			<li>
				<a href="account.do?type=accountRecords&current=accountListQuery" target="_parent"><span>帐务流水查询</span> </a>
			</li>
		
			<li>
				<a href="account.do?type=accountRecords&current=changeCreditQuery" target="_parent"><span>转出/转出 信用点查询</span> </a>
			</li>
</ul>
  </body>
</html>
