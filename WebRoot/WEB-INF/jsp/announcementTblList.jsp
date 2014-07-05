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
    
    <title>My JSP 'transferPoint.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	   <link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/base-e.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.style.css"/>


 <style type="text/css">
 .num_red{border-style:dotted; border-width:1px; border-color:#F5AC69; font-size:18px; font-weight:bold; font-family:Verdana, Arial, Helvetica, sans-serif; color:#FF6600; width:35px; height:25px; background-color:#FDEDDF;}
 .text_red{font-size:14px; font-weight:bold; color:#FF6600;}
 .num_gray{border-style:dotted; border-width:1px; border-color:#666666; font-size:18px; font-weight:bold; font-family:Verdana, Arial, Helvetica, sans-serif; color:#969696;width:35px; height:25px; background-color:#f7f7f7}
 .text_gray{font-size:14px; font-weight:bold; color:#969696;}
 .input_gray{border-style:none;  font-size:18px;  color:#969696;width:200px; background-color:#f7f7f7;}
 </style>


	<script type="text/javascript" src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/common/jquery.paginate.js"></script>
	<script type="text/javascript" language="javascript" src="<%=basePath%>js/jquery.tableui.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/members.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/thickbox.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.form.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.metadata.js"></script>
		
<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidatorRegex.js"></script>
<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidator-4.0.1.js"></script>
<script type="text/javascript" src="<%=basePath%>js/thickbox.js"></script>
 <script type="text/javascript">

 </script>
 <link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/base-e.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.style.css"/>
<style type="text/css">
<!--
.border_line{ border-style:double; border-width:1px; border-color:#CCCCCC;padding:4px;}
-->
.pusht{margin-top:10px;}
.pushr{margin-right:10px;}
.pushb{margin-bottom:10px;}
.pushl{margin-left:10px;}
</style>
  </head>
  <body style="background-color:transparent;" >
<div class="head">
			<h2 class="clearfix push-top"><span>公告列表</span></h2>
		</div>
	
		<div class="news-list">
			<ul>

			<c:forEach items="${announcementTbls}" var="announcement">
			<li><cite>${announcement.createTime}</cite><a href="announcementTbl/getDetail.do?id=${announcement.id}" target="_blanck">${announcement.title}</a></li>
			</c:forEach>
		
			</ul>
		</div><!-- news-list end -->

</body></html>
