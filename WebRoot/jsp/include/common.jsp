<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<link href="<%=basePath%>css/css.css" rel="stylesheet" type="text/css">


<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.md5.js"></script>
<script type="text/javascript" src="<%=basePath%>js/md5.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.validate.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.metadata.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/tab.js"></script>
<script type="text/javascript" src="<%=basePath%>js/left_nav.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bank.js"></script>
<script type="text/javascript" src="<%=basePath%>js/mainForm.js"></script>
<script type="text/javascript" src="<%=basePath%>js/hm/common.js"></script>


<script type="text/javascript" language="JavaScript" src="<%=basePath%>js/jquery.pagination.js"></script>
<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidatorRegex.js"></script>
<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidator-4.1.3.js"></script>
<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/thickbox.js"></script>
<script src="<%=basePath%>js/My97DatePicker/namespace.js"			type="text/javascript"></script>
<script src="<%=basePath%>js/My97DatePicker/datePicker_AutoSetDay.js"			type="text/javascript"></script>
<script src="<%=basePath%>js/My97DatePicker/WdatePicker.js"			type="text/javascript"></script>
<base href="<%=basePath%>">