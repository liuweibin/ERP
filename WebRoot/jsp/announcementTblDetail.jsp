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
    
    <title>公告信息</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.style.css"/>
       <link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/base-e.css">
<style type="text/css">
 body {
 margin:0px;text-align: -moz-center !important;text-align: center;
 }
 </style>
  </head>
  <body style="background-color:transparent;" >
  		<div id="container" style="text-align: center;">
			<div class="topmain">
				<div class="top-left" style="float: left;">
					您好，欢迎来到1+分级销售平台
				</div>
				<div class="top-right" style="float: right;margin-top: 0px;">
					<a href="#" target="_blank">帮助中心</a>|
					<a href="#" target="_blank">1+分级销售平台网</a>
				</div>
			</div>
		</div>
		<div  style="text-align: center">
		<div id="toptitle">
			<div id="logo">
				<a	href="announcementTbl/getDetail.do?id=${announcementTbl.id}">经销商平台</a>
			</div>
			<div id="logotitle">
				<div id="logotitle1" align="left">
					<span>xx</span>经销商平台
				</div>
			</div>
		</div>
		</div>
	<div style="text-align: center;text-align: -moz-center !important;">
		<div id="container" style="width: 1000px; "><span style="font-size:14px; font-weight:bold;float: left;">
		 ·公告内容</span>
		</div>
	</div>
	<div style="min-height: 300px;height: auto;padding-bottom: 75px;">
		<p class=" " style="text-align:center;broder-bottom:1px solid #ccc; line-height:30px;color: red;width: 1000px;"> ${announcementTbl.title}</p>
		<hr align="center" width="900px;" style=" border-style:dotted; border-width:1px; height:1px; border-color:#CCCCCC;"/>
		<p style="text-align:center;broder-bottom:1px solid #ccc; line-height:30px;width: 1000px;"> 发布时间：${announcementTbl.createTime}</p>
			<div style="width:1000px; widows: 2; text-transform: none; text-indent: 0px; letter-spacing: normal; font: medium Tahoma; white-space: normal; orphans: 2; color: rgb(0,0,0); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px">尊敬的用户您好！</div>
			&nbsp; &nbsp; &nbsp; 
			<pre>${announcementTbl.content}</pre>
		
		
	
	</div>
 
	<div id="footer" style="position: absolute;left: 0px;bottom: 0px;position:fixed;z-index:9999; width: 100%;margin: 0;padding: 0;">
				<div class="bottommain" >
						<div class="bottomright" style="text-align: center">
							<a href="#" target="_blank">关于我们</a>
							<a href="#" target="_blank">联系我们</a>
							<a href="#" target="_blank">友情链接</a>
							<a href="#" target="_blank">ICP证：沪ICP备08108966号  </a>
							<br/>
							<div style="margin-top: 10px; line-height: 20px;">
								Copyright © 2013 - 2015  All Rights Reserved.推荐分辨率：1024*768以上
								<br/>
								<samp style="font-size: 14px;font-weight: bolder">1+</samp>分级销售系统 V1.0
								<samp style="padding-left: 10px;">
								上海大指头网络技术有限公司
								</samp>
							</div>
						</div>
					</div>
		</div>
</body>
</html>