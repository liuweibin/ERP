<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<script type="text/javascript">
$().ready(function () {
	$("#thisForm").validate( {
		rules : {
			brand_no : {
				required:true,
				minlength:6
			},
			authkey : {
				required : true,
				rangelength : [45,55]
			} 
		},
		messages : {
			brand_no : {
				required:"令牌号至少是6位字符",
				minlength:"令牌号至少是6位字符"
			},
			authkey : {
				required : "密钥必须在50个数字和字母组合",
				rangelength : jQuery.format("密钥必须50字符")
			} 
		}
	});
	
	$.ajax({    
		type: "POST",
		url: "<%=basePath%>user/getOTP.do",
		cache: false,
		timeout: 15000,
		dataType : 'json',
		success: function(json) {
			if(json.retcode=="0"){
			 var data = json.data;
			var brand_no= data.brand_no;
			 var authkey  = data.authkey;
			 $("#brand_no").val(brand_no);
			 $("#authkey").val(authkey);
			 if(authkey){
				 $(".test").show();
			 } 
			}
		},
		error: function(e){
			alert(e.status);
		}
	});
	
});

$(document).ready(function() {
	
	$("#sumbitpwd").click(function(){
		if($("#thisForm").valid()){
			processData();
		}
	});
	$("#sumbitTest").click(function(){
		if($("#sOTP").val()){
			testOTP();
		}
	});
});

function ecode(value){
	return encodeURI(encodeURI(value));
}
function hidebox(){
	$("#message").hide();
	document.location.href = "<%=basePath%>jsp/securityETOTP.jsp";
}

function showbox(){
	$("#message").hide().fadeIn("slow");
	setTimeout("hidebox()",3000);
}


function processData(){ 
	var authkey = $("#authkey").val();
	if ( authkey.length != 50 ) {
		alert("密码必须为在50个数字和字母组合");
		return;
	}
	var brand_no = document.getElementById("brand_no").value;
	var queryString = "authkey="+authkey+"&brand_no="+brand_no;
	 
	$.ajax({    
		type: "POST",
		url: "<%=basePath%>user/bingOTP.do",
		cache: false,
		timeout: 15000,
		data: queryString,
		dataType : 'json',
		success: function(json) {
			var result = "";
			if(json.retcode=="0"){
				alert( "动态令牌修改成功,请重新登录！" );
			}else{
				result = "<img src='<%=basePath%>images/bg_btn3.gif'>"+json.message;
			}
				showbox();
			$("#message").html(result);
		},
		error: function(){
			$("#message").html("<img src='./images/bg_btn3.gif'>动态令牌修改失败 ！");
			showbox();
		}
	});
}
function testOTP(){
	 var sOTP = $("#sOTP").val();
		$.ajax({    
			type: "POST",
			url: "<%=basePath%>user/testCheckPwdz201.do",
			cache: false,
			timeout: 15000,
			data: {"agentsCode":"${agentsCode}","sOTP":sOTP},
			dataType : 'json',
			success: function(json) {
				var result = "";
				if(json.retcode=="0"){
					alert( "动态令牌测试通过" );
				}else{
					result = "<img src='<%=basePath%>images/bg_btn3.gif'>"+json.message;
				}
				$("#message").html(result);
			},
			error: function(){
				$("#message").html("<img src='./images/bg_btn3.gif'>动态令牌测试失败 ！");
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
			 		 <jsp:param name="num" value="1" /> 
				</jsp:include>
            <div class="gamename">
            <div class="blockremarknone" id="message"></div>
	               <div class="spcxtj" id="con_subpcx_1">
	                	<form id="thisForm" >
	                		<table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
							  <tr>
							    <td class="wz" width="30%">令牌号：</td>
			    			    <td><input name="brand_no" type="text" class="input5" style="width: 350px" id="brand_no" /></td>
							  </tr>
							  <tr>
							    <td class="wz">密钥：</td>
			    			    <td><input name="authkey" type="text" class="input5" maxlength="50" style="width: 350px;font-size: 11px;" id="authkey" /></td>
							  </tr>
						 
							    <td colspan="8" align="center"><input name="button" type="button" class="an_input2" id="sumbitpwd" value="绑定" /></td>
							    </tr>
							    
							    <tr class="test" style="display: none;" >
							 		<td class="wz">口令:</td>
							 		<td  ><input type="text" id="sOTP" class="input5" value="" maxlength="8"  > </td>
							 		</tr>
							 		<tr class="test" style="display: none;" >
							 			<td style="text-align: center;" colspan="2"><input type="button" class="an_input2" id="sumbitTest" value="测试"> </td>
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
