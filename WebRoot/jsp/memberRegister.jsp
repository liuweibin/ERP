<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
#agentRegisterform TABLE   TR TD {height: 20px;line-height: 20px;padding-bottom: 0px;}
.input5,.input9{height: 25px;line-height: 25px;}
</style>
<script type="text/javascript">
$().ready(function() {
	init();
	$(".input5").focus(function () { 
		$(this).css("background-color", "#FFFFCC").blur(function () {  
		    $(this).css("background-color", "#FBFBFB");  
		});  
	});
	
	   $.formValidator.initConfig({
			 formID:"agentRegisterform",
			 submitOnce:true,
			 onSuccess:function(){
					//alert("校验组1通过验证，不过我不给它提交");
					tj();
			 },onError:function(){
				 alert("具体错误，请看网页上的提示");
			 }
		 });
	 
		
			$("#agentsName").formValidator({onShow:"",onFocus:"不能为空",onCorrect:"代理商名称格式正确"}).
			inputValidator({min:1,max:20,onError:"代理商名称不能为空"});
		 
			 $("#username").formValidator({empty:false,onShow:"必须为手机号",onFocus:"必须为手机号",onCorrect:"登录名可是使用",onEmpty:"登录名不能为空"})
			 .inputValidator({min:11,max:11,onError:"手机号码必须是11位的,请确认"}).regexValidator({regExp:"mobile",dataType:"enum",onError:"你输入的手机号码格式不正确"})
			  .ajaxValidator({
					dataType : "json",
					async : true,
					url : "<%=basePath%>empManage.do?type=empSole",
					success : function(data){
			            if( data=='202' ) return true;
			            if(  data=='101') return false;
						return false;
					},
					buttons: $("#button"),
					error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
					onError : "该用户名不可用，请更换用户名",
					onWait : "正在对用户名进行合法性校验，请稍候..."
				});
				
	 
			 
			 
			 $("#loginPwd").formValidator({onShow:"",onFocus:"至少6位字符或数字",onCorrect:"密码合法"}).inputValidator({min:6,empty:{leftEmpty:false,rightEmpty:false,emptyError:"密码两边不能有空符号"},onError:"密码不能为空,请确认"});
			$("#loginPwd2").formValidator({onShow:"",onFocus:"至少6位字符或数字",onCorrect:"密码一致"}).inputValidator({min:6,empty:{leftEmpty:false,rightEmpty:false,emptyError:"重复密码两边不能有空符号"},onError:"重复密码不能为空,请确认"}).compareValidator({desID:"loginPwd",operateor:"=",onError:"2次密码不一致,请确认"});

			$("#IDCard").formValidator({onShow:"",onFocus:"输入15或18位的身份证",onCorrect:"输入正确"}).functionValidator({fun:isCardID});
			 $("#max_sub_agents").formValidator({onShow:"",onFocus:"只能输入0-500之间的数字哦",oncorrect:"",defaultValue:"0"}).inputValidator({min:0,max:500,type:"value",onError:"数字必须在0-500之间，请确认"});
			 $("#balanceAlarm").formValidator({onShow:"",onFocus:"只能输入数字",oncorrect:"",defaultValue:"1000"}).inputValidator({min:0,max:9000000,type:"value",onError:"数字必须在0-500之间，请确认"});
			 $("#tradePwd").formValidator({onShow:"",onFocus:"至少8位字符或数字",onCorrect:"交易密码合法"}).inputValidator({min:8,empty:{leftEmpty:false,rightEmpty:false,emptyError:"交易密码两边不能有空符号"},onError:"交易密码不能为空,请确认"});
				$("#tradePwd2").formValidator({onShow:"",onFocus:"至少8位字符或数字",onCorrect:"密码一致"}).inputValidator({min:8,empty:{leftEmpty:false,rightEmpty:false,emptyError:"重复交易密码两边不能有空符号"},onError:"重复交易密码不能为空,请确认"}).compareValidator({desID:"tradePwd",operateor:"=",onError:"2次密码不一致,请确认"});
					
				 $("#mobilePhone").formValidator({empty:false,onShow:"",onFocus:"",onCorrect:"",onEmpty:"手机号不能为空"}).inputValidator({min:11,max:11,onError:"手机号码必须是11位的,请确认"}).regexValidator({regExp:"mobile",dataType:"enum",onError:"你输入的手机号码格式不正确"});;
				 $("#email").formValidator({empty:true,onShow:"",onFocus:"邮箱6-100个字符",onCorrect:""}).inputValidator({min:6,max:100,onError:"你输入的邮箱长度非法,请确认"}).regexValidator({regExp:"^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$",onError:"你输入的邮箱格式不正确"});
});
 
function tj(){
	var form = $("#agentRegisterform");
var areavalue = document.getElementById("area").value;
var agent_type = document.getElementById("agent_type").value;
var batch_level = document.getElementById("batch_level").value;
var shop_type = document.getElementById("shop_type").value;
	$ .ajax( {
				cache : true,
				type : "POST",
				async : false,
				dataType : 'json',
				url : "<%=basePath%>agentsManage.do?type=agentRegister&areaId="
						+ areavalue
						+ "&batchLevel="
						+ batch_level
						+ "&shopType="
						+ shop_type,
				data : $('#agentRegisterform').serialize(),// 你的formid 
				error : function(err) {
					var result = "<img src='${ctx}/images/bg_btn3.gif'>给下级代理商注册失败！"+err.status;
					$("#registermessage") .html(result);
					$("#registermessage") .show(200) .delay(3000) .hide(200);
				},
				success : function(json) {
					if (json.retcode == "0") {
						var result = "<img src='${ctx}/images/button/ok.gif'>给下级代理商注册成功！";
					} else {
						result = "<img src='${ctx}/images/bg_btn3.gif'>"+json.message;
					}
					$("#registermessage") .html(result);
					$("#registermessage") .show(200) .delay(3000);
				}
			});
}
function init(){
	$.ajax({
		url : '<%=basePath%>agentsManage.do?type=memberManagerInit',
		type : 'post',
		dataType : 'json',
		async:false,
		success : function(data) {
			if(data.retcode==0){ 
				data = data.data[0];
				var map  = data.childsAgentsMap;
				var shopTypeTblListMap  = data.shopTypeTblList;
				var agent_type  = data.agent_type;
				var batchLevelTblMap  = data.batchLevelMap;
				var areaSetMap  = data.areaMap;
				var agentsid  = data.agentsid;
				var agentName  = data.agentName;
				
				$("#area").empty();
				$.each(areaSetMap, function(i, attr) {
					var key = i;
					var value = attr;
					var select ="";
					if(i==agentsid) select = "selected='selected'";
						$("#area").prepend("<option '"+select+"' value='"+key+"'>" +value + "</option>");
				});
				$("#shop_type").empty();
				$.each(shopTypeTblListMap, function(i, attr) {
					var key = i;
					var value = attr;
					$("#shop_type").prepend("<option value='"+key+"'>" +value + "</option>");
				});
	 
					if(agent_type=='3'){
							$(".batch").show();
							$("#agent_type").val(agent_type);
							$("#agentstype").val('直属经销商');
							
							$.each(batchLevelTblMap, function(i, attr) {
								var key = i;
								var value = attr;
								if(i==1)return true;
								$("#batch_level").prepend("<option value='"+key+"'>" +value + "</option>");
							});
					}else{
							$("#agentstype").val('非直属经销商');
					}
			
				
				$("#supername").val(agentName);
			}
		},
		error : function(error) {
		 alert(error.status);
		}
	});
}
 
</script>

<style type="text/css">
.td1 {
	text-align: right;
}

.td2 {
	padding-left: 15px;
	font-size: 13px;
	font-family: Tahoma;
}

.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}

#tabCot_product_5 {
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
</style>
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
          <div class="nyTit">下级</div>
          <div class="gamenamebox">
           <jsp:include page="memberManagerTitle.jsp" >
			  <jsp:param name="num" value="4" /> 
			</jsp:include>
            <div class="gamename">
	             <div class="spcxtj" id="con_spcx_5">
	                	<div class="blockremarknone" id="registermessage"></div>
				<form id="agentRegisterform" name="agentRegisterform" method="post" action="" >
				<input type="hidden" id="agent_type"/>
					<div class="block" style="text-align: center;">
						<table  class="cx" border="0" width="80%">
							<tr>
								<td class="wz" width="30%" >
									上级代理商名称：
								</td>
								<td  width="30%">
									<input class="input9" name="supername" id="supername"	value=""  readonly="readonly"/>
								</td>
								<td  width="30%"></td>
							</tr>
							<tr>
								<td class="wz">
									<span style="color: red">*&nbsp;</span>代理商名称：
								</td>
								<td>
									<input class="input5" name="agentsName" id="agentsName" />
								</td>
								  <td><span id="agentsNameTip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									<span style="color: red">*&nbsp;</span>代理商登录名（手机号）：
								</td>
								<td>
									<input class="input5" name="username"	id="username"    AUTOCOMPLETE="off" /></br>
									<span style="color:Red;font-size:10px;"></span>
								</td> 
								<td><span id="usernameTip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									<span style="color: red">*&nbsp;</span>登录密码：
								</td>
								<td>
									<input type="password" class="input5" AUTOCOMPLETE="off"  name="loginPwd" id="loginPwd" /></br>
									<span style="color:Red;font-size:10px;"></span>
								</td><td><span id="loginPwdTip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									<span style="color: red">*&nbsp;</span>确认登录密码：
								</td>
								<td>
									<input type="password" class="input5" 	name="loginPwd2" id="loginPwd2" /></br>
										<span style="color:Red;font-size:10px;"></span>
								</td><td><span id="loginPwd2Tip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									<span style="color: red">*&nbsp;</span>身份证号码：
								</td>
								<td>
									<input class="input5" name="IDCard" id="IDCard" class="input5" style="width: 230px;text-indent: 0" /></br>
									<span style="color:Red;font-size:10px;"></span>
								</td><td><span id="IDCardTip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									代理商类别：
								</td>

									<td>
										<input class="input9" name="agentstype" id="agentstype"  readonly="readonly"/></br>
									</td>
							<td> </td>
								
							</tr>
								<tr>
									<td class="wz">
										<span style="color: red">*&nbsp;</span>可发展下家数：
									</td>
									<td>
										<input class="input5" name="max_sub_agents"  id="max_sub_agents" /></br>
										<span style="color:Red;font-size:10px;"></span>
									</td><td><span id="max_sub_agentsTip" class="" ></span></td>
								</tr>
							<tr>
								<td class="wz">
									<span style="color: red">*&nbsp;</span>告警余额(元)：
								</td>
								<td>
									<input class="input5" name="balanceAlarm" value="0"  id="balanceAlarm" /></br>
									<span style="color:Red;font-size:10px;"></span>
								</td> <td><span id="balanceAlarmTip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									<span style="color: red">*&nbsp;</span>交易密码：
								</td>
								<td >
									<input type="password" class="input5" name="tradePwd" id="tradePwd" /></br>
									<span style="color:Red;font-size:10px;"></span>
								</td>
								  <td><span id="tradePwdTip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									<span style="color: red">*&nbsp;</span>确认交易密码：
								</td>
								<td >
									<input type="password" class="input5" name="tradePwd2" id="tradePwd2" /></br>
									<span style="color:Red;font-size:10px;"></span>
								</td>
								 <td><span id="tradePwd2Tip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									<span style="color: red">*&nbsp;</span>手机：
								</td>
								<td  >
									<input class="input5" name="mobilePhone" id="mobilePhone" /></br>
									<span style="color:Red;font-size:10px;"></span>
								</td>
								 <td><span id="mobilePhoneTip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									所属地区：
								</td>
								<td>
									<select id="area" name="area" class="input5" style="font-size: 13px;">
									</select>
								</td><td> </td>
							</tr>

							
								<tr style="display: none;" class="batch">
									<td class="wz">
										批价级别：
									</td>
									<td>
										<select id="batch_level" name="batch_level" class="input5"  style="font-size: 13px;">
									
										</select>
									</td><td> </td>
								</tr>
							
							<tr>
								<td class="wz">
									店铺类型：
								</td>
								<td>
									<select id="shop_type" name="shop_type"   class="input5"  style="font-size: 13px;">
										
									</select>
								</td><td> </td>
							</tr>
							<tr>
								<td class="wz">
									联系人：
								</td>
								<td >
									<input class="input5" name="linkman" id="linkman" />
								</td><td> </td>
							</tr>
							<tr>
								<td class="wz">
									固定电话：
								</td>
								<td  >
									<input class="input5" name="fixedPhone" id="fixed_phone" />
								</td><td> </td>
							</tr>
					
							<tr>
								<td class="wz">
									QQ：
								</td>
								<td>
									<input class="input5" class="qq" name="qq" id="qq" />
								</td><td> </td>
							</tr>
							<tr>
								<td class="wz">
									邮件地址：
								</td>
								<td >
									<input class="input5" name="email" id="email" />
								</td> <td><span id="emailTip" class="" ></span></td>
							</tr>
							<tr>
								<td class="wz">
									 详细地址：
								</td>
								<td >
									<input class="input5" name="address" id="address" />
								</td><td> </td>
							</tr>
							<tr>
								<td colspan="2">
								<input   type="submit" class="an_input2" id="submit"  value="注册" />
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
	              </div>
	              
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@include file="./bottom.jsp" %>
  </div>

</body>
</html>
