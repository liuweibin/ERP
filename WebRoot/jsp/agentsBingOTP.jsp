<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String agentsCode= request.getParameter("agentsCode");
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
</style>
   <SCRIPT LANGUAGE="JavaScript">
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
			data:{'agentsCode':"<%=agentsCode%>"},
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
   $("document").ready(function(){
		$("#sumbit").click(function(){
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
 function testOTP(){
	 var sOTP = $("#sOTP").val();
		$.ajax({    
			type: "POST",
			url: "<%=basePath%>user/testCheckPwdz201.do",
			cache: false,
			timeout: 15000,
			data: {"agentsCode":"<%=agentsCode%>","sOTP":sOTP},
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

function processData(){ 
	var authkey = $("#authkey").val();
	authkey = authkey.trim();
	if ( authkey.length != 50) {
		alert("秘钥必须为50个数字和字母组合");
		return;
	}
	var brand_no = document.getElementById("brand_no").value;
	var queryString = "authkey="+authkey+"&brand_no="+brand_no+"&agentsCode=<%=agentsCode%>";
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
				alert( "动态令牌修改成功" );
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

function showbox(){
	$("#message").hide().fadeIn("slow");
	setTimeout("hidebox()",3000);
}
function hidebox(){
	$("#message").hide();
}
  </SCRIPT>
  <style type="text/css">
  body { margin:0px; padding:0px;margin-top:10px;   font-family: "微软雅黑","Arial Narrow";font-size: 14px;}
  
  .table tr td { 
   font-size: 12px;
  }
  .table{
  BORDER-RIGHT: #ff6600 2px dotted; 
  BORDER-TOP: #ff6600 2px dotted; 
  BORDER-LEFT: #ff6600 2px dotted; 
  BORDER-BOTTOM: #ff6600 2px dotted; 
  BORDER-COLLAPSE: collapse
  }
  </style>
 </HEAD>
 <BODY>
    <div class="blockremarknone" id="message"></div>
 <form id="thisForm">
 <table  class="table"  id="table" style="" borderColor=#ff6600 height=40 cellPadding=1 width=550  border=2>
 		<tr>
 		<td style="width: 100px;" >代理商:</td>
 		<td><%=agentsCode%></td>
 		</tr>
 		<tr>
 		<td style="width: 100px">令牌号:</td>
 		<td><input type="text"   id="brand_no" name="brand_no" class="input5"> </td>
 		</tr>
 		<tr>
 		<td>密钥:</td>
 		<td><input type="text"   id="authkey" name="authkey"  class="input3" style="width: 350px;font-size: 11px;"> </td>
 		</tr>
 		<tr>
 		<td style="text-align: center;" colspan="2"><input type="button" class="an_input2"  id="sumbit" value="绑定"> </td>
 		</tr>
 		<tr class="test" style="display: none;">
 		<td style="width: 100px">口令:</td>
 		<td  ><input type="text" id="sOTP" class="input5" maxlength="8"  > </td>
 		</tr>
 		<tr class="test" style="display: none;">
 		<td style="text-align: center;" colspan="2"><input type="button" class="an_input2" id="sumbitTest" value="测试"> </td>
 		</tr>
 </table>
 </form>
 </BODY></html>
