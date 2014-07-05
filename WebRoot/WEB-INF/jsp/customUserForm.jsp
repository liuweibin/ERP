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

		<title>My JSP 'customUserForm.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${ctx}/themes/common/button.css" rel="stylesheet" />
		<script type="text/javascript" language="javascript"			src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/thickbox.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.metadata.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.form.js"></script>
		<script type="text/javascript">
jQuery.validator.addMethod("isMobile", function(value, element) {   
  var length = value.length;   
  return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\d{8})$/.test(value));   
}, "请正确填写您的手机号码");   
  
jQuery.validator.addMethod("isPhone", function(value, element) {   
  var tel = /^(\d{3,4}-?)?\d{7,9}$/g;   
  return this.optional(element) || (tel.test(value));   
}, "请正确填写您的电话号码");
$().ready(function() {
	$("#customForm").validate( {
		rules : {
			customName : "required",
			address : "required",
			fixedPhone :{
				isPhone:true
			},
			qq :{
				required : true,
				digits:true
			},
			mobilePhone: {
				required : true,
				isMobile: true
			},
			email : {
				required : true,
				email : true
			}
		},
		messages : {
			customName : "请输入姓名",
			qq :{
				required : "请输入qq号码",
				digits : "输入格式不正确"
			},
			address : "请输入详细地址", 
			mobilePhone : {
				required : "请输入手机号码"
			},
			email : {
				required : "请输入email地址",
				email : "请输入正确的email地址"
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
	$('#submitbtn').click(function() {
		// $('#signupForm').submit();
		if($("#customForm").valid()){
		var customid=document.getElementById("customid").value;
		var user_Integration=document.getElementById("user_Integration").value;
			$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : "customUser.do?type=customUserSave&customid="+customid+"&user_Integration="+user_Integration,
				data : $('#customForm').serialize(),// 你的formid 
				dataType:'text',
				error : function(request) {
						var result="";
						result = "<img src='./images/bg_btn3.gif'>操作失败！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200);
				},
				success : function(data) {
					var result="";
					 if(jQuery.trim(data)=="101"){
						 result = "<img src='./images/button/ok.gif'>保存成功！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200);
					 }else if(jQuery.trim(data)=="202"){
						 result = "<img src='./images/button/ok.gif'>修改信息成功！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200);
					 }else{
						 result = "<img src='./images/bg_btn3.gif'>操作失败！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200);
					 }
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
<style type="text/css">
		
body { margin:0px; padding:0px;margin-top:10px;   font-family: "微软雅黑","Arial Narrow";font-size: 12px;}
		ul{list-style-type: none ;}
table tr td label{
display:block;

margin-bottom: 4px;}		
</style>
	</head>
	<body>
	<input style="display: none" id="customid" name="customid" value="${customid}"/>
	<input style="display: none" id="user_Integration" name="user_Integration" value="${customuserIntegration}"/>
	<div class="blockremarknone" id="message" style="text-align: center;"></div>
			<form id="customForm" method="post" action="">
				<table width="100%">
					<tr>
						<td align="right">
							<label for="customName">
								客户名称 ：
							</label>
						</td>
						<td style="width: 70%">
							<input id="customName" name="customName" value="${customName}" />
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="fixedPhone">
								固定电话：
							</label>
						</td>
						<td style="width: 70%">
							<input id="fixedPhone" name="fixedPhone" value="${fixedPhone}" />
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="mobilePhone">
								手机 ：
							</label>
						</td>
						<td style="width: 70%">
							<input id="mobilePhone" name="mobilePhone" value="${mobilePhone}" />
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="qq">
								QQ：
							</label>
						</td>
						<td>
							<input id="qq" name="qq" value="${qq}" />
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="email" >
								邮件地址：
							</label>
						</td>
						<td style="width: 70%">
							<input id="email" name="email"  value="${email}"/>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="address">
								详细地址：
							</label>
						</td>
						<td>
							<input id="address" name="address" value="${address}" />
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="remark">
								描述：
							</label>
						</td>
						<td>
							<input id="remark" name="remark" value="${remark}"/>
						</td>
					</tr>
				</table>
				<ul>
					<li class="btnarea" style="text-align: center;">
					
						<input type="button"    id="submitbtn"  class="Partorange" value="保存" style="margin-top: 10px;">
						
						<input type="button"   onClick="javascript:closeWinNoLoad();" class="Partgreen" value="关闭" style="margin-top: 10px;">
						
					</li>
				</ul>
			</form>
	</body>
</html>
