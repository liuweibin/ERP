<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/commons/taglibs.jsp"%>
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

		<title>My JSP 'receiveMessageQuery.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link href="${path}themes/common/button.css" rel="stylesheet" />
		<%--<script type="text/javascript" language="javascript"
			src="${path}js/common/jquery-1.8.0.min.js">
</script>
		--%>
		<script type="text/javascript" language="javascript"
			src="${path}js/jquery.min.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${path}js/thickbox.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${path}js/jquery.validate.min.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${path}js/jquery.metadata.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${path}js/jquery.form.js">
</script>
		<script type="text/javascript">

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

$(document).ready(function() {
	$('#receivebtn').click(function() {
		// $('#signupForm').submit();
		var sendagent=$("#sendagent").val();
		var sendagentcode=$("#sendagentcode").val();
		replymessages(sendagent,sendagentcode);
		});
});
function closeWinNoLoadReply(hasFlush, timeout) { 
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
	replymessages();
}
function replymessages(sendagent,sendagentcode) {
	$("#receiveMessageQueryForm").css("display","none");
	var url = "<%=basePath%>informationManage.do?type=replyMessage&sendagent="+encodeURI(sendagent)+"&sendagentcode="+ sendagentcode;
	var title = "回复消息";
	var width = 450;
	var height = 250;
	parent.LightBox(url, title, width, height);
}

function reply(){
   main.location.href="<%=basePath%>informationManage.do?type=replyMessage";
}

function refresh(){
    location.href="<%=basePath%>jsp/newsManage.jsp";
}
function ecode(value) {
	return encodeURI(encodeURI(value));
}

function tb_remove() {  
	notReadMessage();
 	$("#TB_imageOff").unbind("click");
	$("#TB_closeWindowButton").unbind("click");
	$("#TB_window").fadeOut("fast",function(){$('#TB_window,#TB_overlay,#TB_HideSelect').trigger("unload").unbind().remove();});
	$("#TB_load").remove();
	if (typeof document.body.style.maxHeight == "undefined") {//if IE 6
		$("body","html").css({height: "auto", width: "auto"});
		$("html").css("overflow","");
	}
	document.onkeydown = "";
	document.onkeyup = "";
	return false;
}
</script>
	</head>
	<body>
			<form id="receiveMessageQueryForm" method="post" action="" >
			<input type="hidden" id="querymessageid" name="querymessageid" value="${id}"/>
			<input type="hidden" id="sendagent" name="sendagent" value="${sendAgents}"/>
			<input type="hidden" id="sendagentcode" name="sendagentcode" value="${sendAgentsCode}"/>
				<table width="100%">
					<tr>
						<td align="right">
							<label for="customName">
								消息标题 <em>*</em>：
							</label>
						</td>
						<td style="width: 70%">
							${title}
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="fixedPhone">
								发送代理商<em>*</em>：
							</label>
						</td>
						<td style="width: 70%">
							${sendAgents}
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="mobilePhone">
								消息内容<em>*</em>：
							</label>
						</td>
						<td style="width: 70%">
							${content}
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="qq">
								发送时间<em>*</em>：
							</label>
						</td>
						<td>
							${createTime}
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
				</table>
				<ul style="margin:10px,0px,0px,60px;">
					<li class="btnarea">
					<input style="color: green;width: 40px;" class="small" type="button" id="receivebtn" value="回复" />
									<a href="javascript:void(0)"
										onClick="javascript:closeWinNoLoad();"><span>关闭</span> </a>
					</li>
				</ul>
			</form>
	</body>
</html>
