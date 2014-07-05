<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'login_top.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/slider.css" media="screen"/>
<style type="text/css">
#slider-index {	WIDTH: 504px; HEIGHT: 180px; OVERFLOW: hidden;}
#slider-index UL.f-slider-list LI {	WIDTH: 504px; HEIGHT: 180px;}
</style>

<script type="text/javascript" src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
  </head>
  <body>
  <div id="slider-index" class="f-slider">
  <ul style="padding: 0px; margin: 0px; height: 180px;" class="f-slider-list">

	<li style="display: block; position: absolute; top: 0px; left: 0px; z-index: 1; width: 504px; height: 180px; opacity: 1;">
		<a href="#" target="_blank">
		<img border="0" src="<%=basePath%>images/top504-180_001.jpg" width="504" height="200"/>
		</a>
	</li>


	<li style="display: none; position: absolute; top: 0px; left: 0px; z-index: 1; width: 504px; height: 180px; opacity: 1;">
		<a href="#" target="_blank">
		<img border="0" src="<%=basePath%>images/tbzs-504-200.jpg" width="504" height="180"/>
		</a>
	</li>
  </ul>
<ul class="f-slider-triggers"><li class="current">1</li><li class="">2</li></ul></div>
</body>
</html>
