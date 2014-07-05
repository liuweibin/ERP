<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<script type="text/javascript">
$().ready(function () {
	var Verification_Code = ${Verification_Code}; 
	if(Verification_Code==0){//验证吗
		$(".kl").hide();
		$("#thispwdForm").validate( {
			rules : {
				oldpwd : {
					required:true,
					minlength:6
				},
				newpwd : {
					required : true,
					rangelength : [ 6, 20 ]
				},
				chknewpwd : {
					required : true,
					equalTo:"#newpwd"
				} 
			},
			messages : {
				oldpwd : {
					required:"密码至少是6位字符",
					minlength:"密码至少是6位字符"
				},
				newpwd : {
					required : "密码必须在6~20个字符之间，建议数字和字母组合",
					rangelength : jQuery.format("密码必须在6~20个字符之间，建议数字和字母组合")
				},
				chknewpwd : {
					required:"再输入一次密码",
					equalTo:"两次输入的密码不同"
				} 
			}
		});
	}else{
		$("#thispwdForm").validate( {
			rules : {
				oldpwd : {
					required:true,
					minlength:6
				},
				newpwd : {
					required : true,
					rangelength : [ 6, 20 ]
				},
				chknewpwd : {
					required : true,
					equalTo:"#newpwd"
				},
				sOTP : {
					required : true,
					minlength : 6
				}
			},
			messages : {
				oldpwd : {
					required:"密码至少是6位字符",
					minlength:"密码至少是6位字符"
				},
				newpwd : {
					required : "密码必须在6~20个字符之间，建议数字和字母组合",
					rangelength : jQuery.format("密码必须在6~20个字符之间，建议数字和字母组合")
				},
				chknewpwd : {
					required:"再输入一次密码",
					equalTo:"两次输入的密码不同"
				},
				sOTP : {
					required : "口令为6位动态数字组合",
					minlength:"口令必须为6个数字"
				}
			}
		});
	}
});

$(document).ready(function() {
	
	$("#sumbitpwd").click(function(){
		if($("#thispwdForm").valid()){
			processData();
		}

	});
});

function ecode(value){
	return encodeURI(encodeURI(value));
}
function hidebox(){
	$("#message").hide();
	document.location.href = "<%=basePath%>jsp/securitySet.jsp";
}

function showbox(){
	$("#message").hide().fadeIn("slow");
	setTimeout("hidebox()",3000);
}


function processData(){ 
	var newpwd = $("#newpwd").val();
	if ( newpwd.length < 6 || newpwd.length > 15 ) {
		alert("密码必须在6~20个字符之间，建议数字和字母组合");
		return;
	}
 
	
	var loginpwd = document.getElementById("oldpwd").value;
	var newpwd = document.getElementById("newpwd").value;
	var chknewpwd = document.getElementById("chknewpwd").value;
	var sOTP = document.getElementById("sOTP").value;
	var queryString = "oldPwd="+$.md5(escape(encodeURIComponent(loginpwd)))+"&newPwd="+$.md5(escape(encodeURIComponent(newpwd)))+"&sOTP="+sOTP;
	 
	$.ajax({    
		type: "POST",
		url: "<%=basePath%>user/updateTradePwd.do",
		cache: false,
		timeout: 15000,
		data: queryString,
		dataType : 'json',
		success: function(json) {
			var result = "";
			if(json.retcode=="0"){
				alert( "交易密码修改成功！" );
			}else{
				result = "<img src='<%=basePath%>images/bg_btn3.gif'>"+json.message;
			}
				showbox();
			$("#message").html(result);
		},
		error: function(){
			$("#message").html("<img src='./images/bg_btn3.gif'>交易密码修改失败 ！");
			showbox();
		}
	});
}

</script>
</head>
<body>
<div class="main">


<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
        <div class="nyRight">
          <div class="nyTit">安全设置</div>
          <div class="gamenamebox">
              <jsp:include page="securitySetTitle.jsp" >
			 		 <jsp:param name="num" value="0" /> 
				</jsp:include>
            <div class="gamename">
            <div class="blockremarknone" id="message"></div>
	               <div class="spcxtj" id="con_subpcx_1">
	                	<form id="thispwdForm" >
	                		<table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
							  <tr>
							    <td class="wz">原交易密码：</td>
			    			    <td><input name="oldpwd" type="password" class="input5" id="oldpwd" /></td>
							  </tr>
							  <tr>
							    <td class="wz">新交易密码：</td>
			    			    <td><input name="newpwd" type="password" class="input5" id="newpwd" /></td>
							  </tr>
							  <tr>
							    <td class="wz">确认新交易密码：</td>
			    			    <td><input name="chknewpwd" type="password" class="input5" id="chknewpwd" /></td>
							  </tr>
						  	 <tr class="kl">
							    <td class="wz">口令：</td>
			    			    <td><input name="sOTP" type="text" class="input5" id="sOTP" maxlength="6"/></td>
							  </tr>
							    <td colspan="8" align="center"><input name="button" type="button" class="an_input2" id="sumbitpwd" value="保存" /></td>
							    </tr>
							</table>
						</form>
	              </div>
   
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
