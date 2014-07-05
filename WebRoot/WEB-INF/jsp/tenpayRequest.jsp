<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
	<head>
	</head>
	<body>
		<form method="post" name="tenpaySubmit" id="tenpaySubmit" target="_self" action="${requestUrl}">
		  <input type="submit" value="submit"></input>
		</form>
		<script>document.forms['tenpaySubmit'].submit();</script>
	</body>
</html>