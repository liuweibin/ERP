<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'validate.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script src="<%=basePath%>js/common/jquery-1.8.0.min.js"
			type="text/javascript">
</script>
		<script src="<%=basePath%>js/jquery.validate.min.js"
			type="text/javascript">
</script>
		<script src="<%=basePath%>js/jquery.metadata.js"
			type="text/javascript">
</script>
		<script type="text/javascript">
$().ready(function() {
	$("#signupForm").validate( {
		rules : {
			firstname : "required",
			email : {
				required : true,
				email : true
			},
			password : {
				required : true,
				minlength : 5
			},
			confirm_password : {
				required : true,
				minlength : 5,
				equalTo : "#password"
			}
		},
		messages : {
			firstname : "请输入姓名",
			email : {
				required : "请输入Email地址",
				email : "请输入正确的email地址"
			},
			password : {
				required : "请输入密码",
				minlength : jQuery.format("密码不能小于{0}个字符")
			},
			confirm_password : {
				required : "请输入确认密码",
				minlength : "确认密码不能小于5个字符",
				equalTo : "两次输入密码不一致不一致"
			}
		}
	});
});
</script>
	</head>

	<body style="text-align: center;">
		<form id="signupForm" method="get" action="">
			<p>
				<label for="firstname">
					Firstname
				</label>
				<input id="firstname" name="firstname" />
			</p>
			<p>
				<label for="email">
					E-Mail
				</label>
				<input id="email" name="email" />
			</p>
			<p>
				<label for="password">
					Password
				</label>
				<input id="password" name="password" type="password" />
			</p>
			<p>
				<label for="confirm_password">
					确认密码
				</label>
				<input id="confirm_password" name="confirm_password" type="password" />
			</p>
			<p>
				<input class="submit" type="submit" value="Submit" />
			</p>
		</form>
	</body>
</html>
