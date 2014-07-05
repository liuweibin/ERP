<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
$().ready(function () {
	$("#receiveMessageQueryForm").validate( {
		rules : {
			title : {
				required:true
			},
			messagecontent : {
				required : true
			}
		},
		messages : {
			title : {
				required:"请输入消息标题"
			},
			messagecontent : {
				required : "请输入消息内容"
			}
		}
	});
});

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
	$('#replyebtn').click(function() {
		if($("#receiveMessageQueryForm").valid()){
		replyeMessage();
		closeWinNoLoad();
		}
		});
});

function replyeMessage(){ 
		var url_ = "<%=basePath%>informationManage.do?type=saveReplyMessage&";
		var data = buyStreamData();
	 $.ajax({
		 type: "POST",
		 url:url_,
		 cache: false,
		 timeout: 15000,
		 data:data,
		 dataType:"text",
		 success:function(data){
		 },error:function(e){
			 alert(e.status);
		 }
	 })
}
 
function buyStreamData() {
	var conditions = "&title="+encodeURI($("#title").val());
	conditions += "&receiveagent=" +  $("#receiveagent").val();
	var messagecontent = $("#messagecontent").val();
	conditions += "&messagecontent=" + encodeURI(messagecontent);
	return conditions;
}


function refresh(){
    location.href="<%=basePath%>jsp/newsManage.jsp";
}

</script>
	</head>
	<body>
			<form id="receiveMessageQueryForm" method="post" action="">
			<input type="hidden"  id="receiveagent" name="receiveagent" value="${sendagentcode }"/>
				<table width="100%">
					<tr>
						<td align="right">
							<label for="customName">
								消息标题 <em>*</em>：
							</label>
						</td>
						<td style="width: 70%">
							<input type="text" id="title" name="title"/>
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
								接收代理商<em>*</em>：
							</label>
						</td>
						<td style="width: 70%">
							${sendagent}
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
						<textarea rows="5" cols="30" id="messagecontent" name="messagecontent">
						</textarea>
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
					<input style="color: green;width: 40px;" class="small" type="button" id="replyebtn" value="回复" />
									<a href="javascript:void(0)"
										onClick="javascript:closeWinNoLoad();"><span>关闭</span> </a>
					</li>
				</ul>
			</form>
	</body>
</html>
