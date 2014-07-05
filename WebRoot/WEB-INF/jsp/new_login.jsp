<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'new_login.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.tablelist { background:#fef8e8; !margin-top:-2px; border:1px solid #FFFFFF;}
-->
</style>

<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.validate.min.js"></script>
<script type="text/javascript" charset="gb2312" src="http://counter.sina.com.cn/ip/"></script>
<script type="text/javascript">
$().ready(function(){
         	// getMac();
	$(".queryInfo :radio").change(function() {
         var isChecked = $("input[name='radiobutton']:checked").val();           // 获取当前选中radio的值
         if(isChecked=="isIp"){
         	$("#ip").val(ILData[0]);
         }else if(isChecked=="noIp"){
         	$("#ip").val('');
         }
     });
     
	$("#loginForm").validate( {
		rules : {
			username : "required",
			'agents.agentsCode' : "required",
			password : {
				required : true,
				minlength : 6
			}
		},
		messages : {
			username : "请输入账号",
			'agents.agentsCode' :  "请输入代理商编号",
			password : {
				required : "请输入密码",
				minlength : jQuery.format("密码不能小于{0}个字符")
			}
		}
	});
});
//----JS鼠标滑过文本框或按钮变颜色
function fEvent(sType,oInput){
   switch (sType){
    case "focus" :
     oInput.isfocus = true;
    case "mouseover" :
     oInput.style.borderColor = '#9ecc00';
     break;
    case "blur" :
     oInput.isfocus = false;
    case "mouseout" :
     if(!oInput.isfocus){
      oInput.style.borderColor='#84a1bd';
     }
     break;
   }
}
function changeValidateCode(obj){
	var timeNow = new Date().getTime();
	obj.src="checkCode/service.do?time="+timeNow;
}	

function getMac(){       
    var locator =new ActiveXObject ("WbemScripting.SWbemLocator");       
    var service = locator.ConnectServer(".");       
    var properties = service.ExecQuery("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled =True");       
    var e =new Enumerator (properties);
    var p = e.item();      
    //获取mac地址      
    var myMac = p.MACAddress;            
	 $("#mac").val(myMac);
} 

</script>
  </head>
  <body>
  <c:if test="${not empty param.login_error}">
      <font color="red">
        Your login attempt was not successful, try again.<br/><br/>
        Reason: <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>.
      </font>
    </c:if>
   <!-- action="user/login.do" --> 
  <form name='LoginForm' action="<c:url value='j_spring_security_check'/>" method="post" target="_parent" id="loginForm">
<table width="220" height="264"  border="0" align="left" style="font-size:12px;" class="tablelist">
    <tr height="10"><td>
  <input type="hidden" name="loginType" value="0">
    <input type="hidden" name="method"	value="log" /> 
    <input type="hidden" name="mac"	 id="mac" value="" /> 
    <input type="hidden" name="ip"	 id="ip" value="" /> 
    </td>
    </tr>
    <tr>
      <td width="80" align="right"><label for="agents.agentsCode">代理商编号：</label></td>
      <td width="140" align="left" colspan="2"><input type="text" name="agents.agentsCode"  value="" style="border-width:1px; border-color:#ccc; width:125px; height:18px; border-style:double;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold; color:#FF0000;" onmouseover="fEvent('mouseover',this)"  onmouseout="fEvent('mouseout',this)"  onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)" maxlength="20"/></td>
    </tr>
    <tr>
      <td  align="right" ><label for="username">账号：</label></td>
      <td  align="left" colspan="2"><input type="text" name="username"  autocomplete="off" id="username"  value="" style="border-width:1px; border-color:#ccc; width:125px; height:18px; border-style:double;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold; color:#FF0000;"  onmouseover="fEvent('mouseover',this)"  onmouseout="fEvent('mouseout',this)"  onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)" maxlength="20"/></td>
    </tr>
    <tr>
      <td align="right" ><label for="password">密　码：</label></td>
      <td colspan="2"><input name="password" type="password" value=''   style="border-width:1px; border-color:#ccc; width:125px; height:18px; border-style:double;"  onmouseover="fEvent('mouseover',this)"  onmouseout="fEvent('mouseout',this)"  onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)"/></td>
    </tr>
    
    
    <tr id="captcha" style="display:none">
      <td colspan="2" align="right" ><div align="center"><img id="mvpwdcaptcha" width="115" height="20" border="1" onclick="" style="cursor:hand;" title="看不清？点击更换另一个。" /></div>
          <div  align="center"><img src="<%=basePath%>images/data.jpg" /></div></td>
    </tr>
    	<tr>
      <td align="right" style="width: ">验证码：</td>
      <td style="width: 60px;">
	        <input name="validateCode" type="text"  autocomplete="off" tabindex="2" 
	        style="border-width:1px; border-color:#ccc; width:50px; height:18px; border-style:double;" 
	        onmouseover="" onfocus="fEvent('focus',this)" onblur="fEvent('blur',this)" onmouseout="" />
      </td>
      <td style="width: 80px;">
             <img  width="60" height="25" title="刷新验证码"  src= "<%=basePath%>checkCode/service.do" onclick="changeValidateCode(this)" /></span><span  value="<c:out value="${msg}"></c:out>">
      </td>
    </tr>
   	<tr class="queryInfo" style="text-align: center;">
	    <td   colspan="3">
	    <div  >
	     <input type="radio" name="radiobutton" value="isIp">:绑定ip 
	     <input type="radio" value="noIp" checked="checked" name="radiobutton">:不绑定ip 
	    </div>
	    </td>
    </tr>
	<tr><td colspan="3" align="center"><img src="<%=basePath%>images/tablemid_07.jpg" /></td></tr>
    <tr>
    <td height="30" colspan="3" align="center" >
    <input name="image" type="image" src="<%=basePath%>images/login.jpg" width="67" height="25" border="0" />
      </td>
    </tr>
</table>
  </form>
  </body>
</html>
