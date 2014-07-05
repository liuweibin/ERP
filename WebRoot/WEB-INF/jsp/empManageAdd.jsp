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

		<title>My JSP 'empManageAdd.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/common/jquery.multiSelect.css" />	
		<link href="${ctx}/themes/common/button.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">
			<script type="text/javascript" language="javascript"			src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/thickbox.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.metadata.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.form.js"></script>
		<script src="${ctx}/js/jquery.bgiframe.min.js" type="text/javascript"></script>
		<script src="${ctx}/js/jquery.multiselect.js" type="text/javascript"></script>	
		<script type="text/javascript">
jQuery.validator.addMethod("isMobile", function(value, element) {   
  var length = value.length;   
  return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\d{8})$/.test(value));   
}, "请正确填写您的手机号码");   
  
$().ready(function() {
	$("#signupForm").validate( {
		rules : {
			firstname : "required",
			password : {
				required : true,
				rangelength : [ 6, 20 ]
			},
			rightpassword : {
				required : true,
				rangelength : [ 6, 20 ],
				equalTo:"#password"
			},
			rightname : "required",
			phone : {
				required : true,
				isMobile: true
			}
		},
		messages : {
			firstname : "登录名不能为空",
			password : {
				required : "请输入密码",
				rangelength : jQuery.format("密码必须在6~20个字符之间,建议数字和字母组合")
			},
			rightpassword : {
				required:"再输入一次登录密码",
				rangelength: jQuery.format("密码必须在6~20个字符之间,建议数字和字母组合"),
				equalTo:"两次输入的密码不一致"
			},
			rightname : "请输入姓名",
			phone : {
				required : "请输入手机号码"
			}
		}
	});
});

function grouptypechange() {
	var selectvalue = document.getElementById("group").value;
	if (selectvalue != "") {
		$.ajax( {
			type : "POST",
			async : false,
			url : "empManage.do?type=grouppermission&selectvalue="+ selectvalue,
			dataType : "json",
			success : function(data) {
				var selectAddGroup = document.getElementById("userpermission");
			$("#userpermission").empty();
			for ( var i = 0; i < data.length; i++) {
				var op = document.createElement("OPTION");
				op.value = data[i].id;
				op.innerHTML = data[i].roleName;
				selectAddGroup.appendChild(op);
			}

		}

		});
	}
}

$(document).ready(function() {
	grouptypechange();
});

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

 $(document).ready(function(){ 
$('#submitbtn').click(function() {
   if($("#signupForm").valid()&&empsoles){
    var selectvalue = document.getElementById("group").value;
   // var usertype = document.getElementById("usertype").value;
   $.ajax({ 
                cache: true, 
                type: "POST",
                async: false,
                url:"empManage.do?type=empManageSave&groupid="+selectvalue, 
                data:$('#signupForm').serialize(),// 你的formid 
                dataType:'text',
                error: function(request) { 
                		var result="";
                  		result = "<img src='./images/bg_btn3.gif'>保存失败！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200);
                }, 
                success: function(data) { 
					var result="";
					 if(jQuery.trim(data)=="101"){
						 result = "<img src='./images/button/ok.gif'>保存成功！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200);
					 }else{
						 result = "<img src='./images/bg_btn3.gif'>保存失败！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200);
					 }                	
					 closeWinNoLoad();
                } 
            });
   }
  }); 
});
 
 var empsoles=false;
 function usersoles(){
	 var user_name=encodeURI($.trim($("#firstname").val()));
	  $.ajax({ 
                cache: true, 
                type: "POST",
                async: false,
                url:"empManage.do?type=empSole&username="+user_name, 
                dataType : 'text',
                error: function(request) { 
                    alert("Connection error"); 
                }, 
                success: function(data) {
                	//refresh();
                	if(jQuery.trim(data)=="101"){
                		$("#username").css("display","block");
                		var emp_name=$.trim($("#firstname").val());
                		document.getElementById("username").innerHTML = '<font color="orange">不好意思,用户名'+emp_name+'已被注册,请更换！</font>'; 
                	}else if(jQuery.trim(data)=="202"){
                		empsoles=true;
                		$("#username").css("display","none");
                	}
                } 
            });
 }

function refresh(){
   main.location.href="<%=basePath%>empManage.do?type=empManage";
}
 

</script>
	</head>
	<body>
		<div class="blockremarknone" id="message" style="text-align: center;"></div>
		<form id="signupForm" method="post" action="" >
			<table width="100%">
				<tr>
					<td align="right">
						<label for="firstname">
							员工登录名 ：
						</label>
					</td>
					<td style="width:95%">
						<input id="firstname" name="firstname" onblur="usersoles();"/><span id="username" style="display: none;margin:5px,10px,0px,0px;"></span>
					</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
			<tr>
					<td align="right">
						<label for="password">
							密码：
						</label>
					</td>
					<td style="width:95%">
						<input type="password" id="password" name="password" />
					</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label for="rightpassword">
							确认密码：
						</label>
					</td>
					<td style="width:95%">
						<input type="password" id="rightpassword" name="rightpassword" />
					</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label for="rightname">
							真实姓名 ：
						</label>
					</td>
					<td>
						<input id="rightname" name="rightname" />
					</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label for="phone">
							手机号码 ：
						</label>
					</td>
					<td>
						<input id="phone" name="phone" />
					</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label for="usertype">
							员工类型 ：
						</label>
					</td>
					<td>
					<input id="usertype" name="usertype" value="普通操作员工" disabled="disabled" />
						<%--<select id="usertypt" name="usertype">
						<option value="0">代理商</option>
						<option value="1" selected="selected">普通操作员工</option>
						</select>--%>
					</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
				<tr>
				<tr>
					<td>
						选择权限组 :
					</td>
				</tr>
				<tr>
					<td>
						<select name="group" id="group" style="width: 150px;"
							onchange="grouptypechange();">
							<c:forEach items="${agentsUserGroupTbl}" var="agentsUserGroupTbl">
								<option value="${agentsUserGroupTbl.id}">
									${agentsUserGroupTbl.groupName}
								</option>
								<%--<c:if test="${reportPerformanceTableInfo.id != tableidString}">
									<option value="${reportPerformanceTableInfo.id}">
										${reportPerformanceTableInfo.tableCnName}(${reportPerformanceTableInfo.tableEnName})
									</option>
								</c:if>
							--%>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<select name="userpermission" id="userpermission"
							multiple="multiple" style="width: 350px; height: 120px"></select>
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
					<a href="javascript:void(0)" onClick="javascript:closeWinNoLoad();"><span>关闭</span></a>	
				</li>
			</ul>
		</form>
	</body>
</html>
