<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>My JSP 'customUserIntegration.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link href="${ctx}/themes/common/button.css" rel="stylesheet" />
		<script type="text/javascript" language="javascript"
			src="${ctx}/js/jquery.min.js">
</script>
		
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.validate.min.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.metadata.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.form.js">
</script>
		<script type="text/javascript">
$().ready(function() {
	$("#customForm").validate( {
		rules : {
			integrationConvert :{
				required : true,
				digits:true
			}
		},
		messages : {
			integrationConvert : {
				required :"请输入兑换积分",
				digits:	"输入格式不正确"
			}
		}
	});
});

//关闭不刷新
			function closeWinNoLoad(hasFlush,timeout){
				
				if(hasFlush){
					if(!timeout){
						var timeout=2000;
					}
					setTimeout(function(){try{tb_remove();}catch(e){}},timeout);
				}else{
					tb_remove();
				}
				
				refresh();
			}

$(document).ready(function() {
	$('#submitbtn').click(function() {
		if($("#customForm").valid()){
		var customid=document.getElementById("customid").value;
			$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : "customUser.do?type=customUserIntegrationUpdate&customid="+customid,
				data : $('#customForm').serialize(),// 你的formid 
				error : function(request) {
					alert("Connection error");
				},
				success : function(data) {
					//refresh();
				closeWinNoLoad();
			}
			});
			}
		});
});

function refresh(){
   main.location.href="<%=basePath%>customUser.do?type=customUser";
}

</script>
	</head>
	<body>
	<input style="display: none" id="customid" name="customid" value="${customid}"/>
	<form id="customForm" method="post" action="">
				<table width="100%">
					<tr>
						<td align="right">
							<label for="agrentsCode">
								代理商编号：
							</label>
						</td>
						<td>
							${agentsCode}
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="customname">
								客户名称：
							</label>
						</td>
						<td>
							${customName}
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
					
					<tr>
						<td align="right">
							<label for="integrationConvert">
								积分兑换：
							</label>
						</td>
						<td>
							<input id="integrationConvert" name="integrationConvert" value="" />
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="remark" >
								备注：
							</label>
						</td>
						<td>
							<input id="remark" name="remark"  value=""/>
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
					
				</table>
				<ul>
					<li class="btnarea">
						<input style="color: green;width: 40px;" class="small" type="button" id="submitbtn" value="保存" />
									<a href="javascript:void(0)"
										onClick="javascript:closeWinNoLoad();"><span>关闭</span> </a>
					</li>
				</ul>
			</form>
	</body>
</html>
