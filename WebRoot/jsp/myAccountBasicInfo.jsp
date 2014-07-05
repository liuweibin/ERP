<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String tabNum= request.getParameter("num");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
.input4{height: 25px;line-height: 25px;width: 200px;}
.input5{height: 25px;line-height: 25px;width: 200px;background-color: white;}
#cx  tr td{padding-bottom: 2px;height: 25px;line-height: 25px;}
</style>
<script type="text/javascript">
jQuery.validator.addMethod("isMobile", function(value, element) {   
	  var length = value.length;   
	  return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\d{8})$/.test(value));   
	}, "请正确填写您的手机号码");   
	  
	jQuery.validator.addMethod("isPhone", function(value, element) {   
	  var tel = /^(\d{3,4}-?)?\d{7,9}$/g;   
	  return this.optional(element) || (tel.test(value));   
	}, "请正确填写您的电话号码"); 

	jQuery.validator.addMethod("lrunlv", function(value, element) {         
	    return this.optional(element) || /^\d+(\.\d{1,2})?$/.test(value);         
	}, "输入格式不正确,小数位不能超过两位");  
	
 
	$().ready(function() {
		$("#thisFrm").validate( {
			rules : {
			balanceAlarm : {
					required:true,
					lrunlv:true
				},email : {
					required:true,
					email:true
				},
				phoneNumber : {
					required : true,
					isMobile: true
				}
			},
			messages : {
				balanceAlarm :{
					required:"请输入告警余额"
				},email : {
					required:"用于收货和找回密码,请认真填写",
					email:"邮箱格式不正确"
				},
				phoneNumber : {
					required : "请输入手机号码"
				}
			},submitHandler:function(form) { 
				processData();
			}
		});
	});
	
 
$(function(){
	init();
});
 
function init(){
	$.ajax({
		url:'<%=basePath%>account.do?type=baseInfo',
		type:'post',
		dataType:'json',
		cache : true,
		async : false,
		success:function(datas){
			if(datas.retcode==-1){
				alert(datas.message);
			}else{
				var data = datas.data;
					$(".balance").val(data.balance);
					$(".bail").val(data.bail);
					$(".balanceAlarm").val(data.balanceAlarm);
					$(".loginName").val(data.loginName);
					$(".realName").val(data.realName);
					$(".cardNumber").val(data.cardNumber);
					$(".areaName").val(data.areaName);
					$(".phoneNumber").val(data.phoneNumber);
					$(".email").val(data.email);
					$(".telNumber").val(data.telNumber);
					$(".qqNumber").val(data.qqNumber);
			}
		},error:function(e){alert(e.status)}
	});
}

 


function ecode(value){
	return encodeURI(encodeURI(value));
}

function processData(){ 
	var queryString = "&phoneNumber="+ecode($(".phoneNumber").val())+"&email="+ecode($(".email").val())+"&telNumber="+ecode($(".telNumber").val())+"&qqNumber="+ecode($(".qqNumber").val())+"&balanceAlarm="+ecode($(".balanceAlarm").val());
	$.ajax({    
		url:'<%=basePath%>account.do?type=updInfo',
		type:'post',
		timeout: 15000,
		dataType:'json',
		cache : true,
		async : false,
		data: queryString,
		success: function(datas) { 
			if(datas.retcode=="1"){
				alert(datas.message);
			}else{
				var result = "<img src='<%=basePath%>images/button/ok.gif'>个人资料修改成功！";
				$("input[type=text]").val("");
				$("#message").html(result);
				$("#message").show(200).delay(1000).hide(200);
			}
			init();
		},
		error: function(e){
			$("#message").html("<img src='<%=basePath%>images/bg_btn3.gif'>个人资料修改失败！"+e.status);
			$("#message").show(200).delay(1000).hide(200);
			init();
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
          <div class="nyTit">我的账户</div>
          <div class="gamenamebox">
              <jsp:include page="myAccountTitle.jsp" >
			 		 <jsp:param name="num" value="0" /> 
				</jsp:include>
            <div class="gamename">
              <div class="blockremarknone" id="message"></div>
	               <div class="spcxtj" id="con_subpcx_1">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx" id="cx">
	               <form  id="thisFrm" action="">
	                <tr><td colspan="4" style="font-weight: 700">基本资料</td></tr>
						  <tr>
						    <td class="wz">登录账号：</td>
						      <td><input name="loginName" type="text"  class="input4 loginName"  readonly="readonly" /></td>
				      		    <td class="wz">真实姓名：</td>
						      <td><input name="realName" type="text" class="input5 realName"    /></td>
						  </tr>
						 <tr>
						    <td class="wz">证件号码：</td>
						      <td><input name="cardNumber" type="text" class="input4 cardNumber"  readonly="readonly" /></td>
						       <td class="wz">所在地区：</td>
						      <td><input name="areaName" type="text" class="input4 areaName"   readonly="readonly" /></td>
						  </tr>
						 <tr>
						    <td class="wz">余额(元)</td>
						      <td><input name="balance" type="text" class="input4 balance"   readonly="readonly" /></td>
						      <td class="wz">保证金(元)：</td>
						      <td><input name="bail" type="text" class="input4 bail"   readonly="readonly" /></td>
						  </tr>
						 <tr>
						    <td class="wz">告警余额(元)：</td>
						      <td>	<input type="text" name="balanceAlarm"  class="input5 balanceAlarm"  /></td>
						  </tr>
						  
      <tr><td colspan="4" style="font-weight: 700">联系方式</td></tr>
       <tr>
						    <td class="wz">手机号码：</td>
						      <td>	<input type="text" name="phoneNumber" class="input5 phoneNumber"  /></td>
						    <td class="wz">E-Mail：</td>
						      <td>	<input type="text" name="email"  class="input5 email"  /></td>
				  </tr>
       <tr>
						    <td class="wz">联系电话：</td>
						      <td>	<input type="text" name="telNumber" class="input5 telNumber" /></td>
						    <td class="wz">QQ号码：</td>
						      <td>	<input type="text" name="qqNumber"  class="input5 qqNumber" /></td>
				  </tr>
						  <tr>
						    <td colspan="8" align="center">
						    <input   type="submit" class="an_input2" value="保存" /></td>
						    </tr>
	                </form>
						</table>
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
