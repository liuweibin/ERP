<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<script type="text/javascript" language="JavaScript" src="${path}js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${path}js/hm/common.js"></script>

<script>
function checkidcard(num) {
	var len = num.length, re;
	if (len == 15)
		re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{3})$/);
	else if (len == 18)
		re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\d)$/);
	else {
		//alert("请输入15或18位身份证号,您输入的是 "+len+ "位");   
		return false;
	}
	var a = num.match(re);
	if (a != null) {
		if (len == 15) {
			var D = new Date("19" + a[3] + "/" + a[4] + "/" + a[5]);
			var B = D.getYear() == a[3] && (D.getMonth() + 1) == a[4]
					&& D.getDate() == a[5];
		} else {
			var D = new Date(a[3] + "/" + a[4] + "/" + a[5]);
			var B = D.getFullYear() == a[3] && (D.getMonth() + 1) == a[4]
					&& D.getDate() == a[5];
		}
		if (!B) {
			//alert("输入的身份证号 "+ a[0] +" 里出生日期不对！");   
			return false;
		}
	}

	return true;
}
</script>
<script type="text/javascript">
jQuery.validator.addMethod("isIdCardNo", function(value, element) {
	return this.optional(element) || checkidcard(value);
}, "请正确输入您的身份证号码");
// 手机号码验证   
jQuery.validator.addMethod(
				"isMobile",
				function(value, element) {
					var length = value.length;
					return this.optional(element)
							|| (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\d{8})$/
									.test(value));
				}, "请正确填写您的手机号码");
//字母数字 
jQuery.validator.addMethod("alnum", function (value, element) {  
    return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);  
}, "只能包括英文字母和数字"); 
// 电话号码验证   
jQuery.validator.addMethod("isPhone", function(value, element) {
	var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
	return this.optional(element) || (tel.test(value));
}, "请正确填写您的电话号码");
jQuery.validator.addMethod("super_password",
				function(value, element) {
			var length = value.length;
			return this.optional(element) || length>=8;
				}, "密码长度至少8位");
jQuery.validator.addMethod("lrunlv", function(value, element) {
	return this.optional(element) || /^\d+(\.\d{1,2})?$/.test(value);
}, "输入格式不正确,小数位不能超过两位");
$().ready(function() {
	$("#agentRegisterform").validate( {
		rules : {
			supername : "required",
			agentsName : "required",
			loginName : {
				required : true,
				isMobile : true
			},
			agentsCode : "required",
			IDCard : {
				required : true,
				isIdCardNo : true
			},
			agentstype : "required",
			max_sub_agents : {
				required : true,
				digits : true
			},
			balance : {
				digits : true
			},
			balanceAlarm : {
				lrunlv : true
			},
			loginPwd : {
				required : true,
				rangelength : [ 6, 20 ]
			},
			right_password_register : {
				required : true,
				rangelength : [ 6, 20 ],
				equalTo : "#password_register"
			},
			tradePwd : {
				required : true,
				rangelength : [ 8, 20 ],
				super_password : true
			},
			right_super_password : {
				required : true,
				rangelength : [ 8, 20 ],
				super_password : true,
				equalTo : "#tradePwd"
			},
			batch_level_id : {
				required : true,
				digits : true
			},
			fixedPhone : {
				isPhone : true
			},
			mobilePhone : {
				required : true,
				isMobile : true
			},
			qq : {
				digits : true
			},
			email : {
				email : true
			}
		},
		messages : {
			supername : "上级代理商名称不能为空",
			agentsName : "请输入代理商名称",
			agentsCode : "请输入代理商编号",
			loginName : {
					required :"不能为空",	
					alnum :"必须为手机号"
			},
			IDCard : {
				required : "请输入身份证号",
				isIdCardNo : "身份证号不正确"
			},
			agentstype : "代理商类别不能为空",
			max_sub_agents : {
				required : "请输入可发展下家数",
				digits : "输入格式不正确"
			},
			balance : {
				required : "余额(信用点)不能为空",
				digits : "请输入数字"
			},
			balanceAlarm : "请输入告警余额" ,
			loginPwd : {
				required : "登录密码不能为空",
				rangelength : jQuery.format("密码必须在6~20个字符之间，建议数字和字母组合")
			},
			right_password_register : {
				required : "再输入一次登录密码",
				rangelength : jQuery.format("密码必须在6~20个字符之间，建议数字和字母组合"),
				equalTo : "两次输入的密码不一致"
			},
			tradePwd : {
				required : "交易密码不能为空",
				rangelength : jQuery.format("交易密码必须在8~20个字符之间"),
				regexPassword : '密码至少包含一个大写字母、一个小写字母及一个符号，长度必须在8~20个字符之间'
			},
			right_super_password : {
				required : "再输入一次交易密码",
				rangelength : jQuery.format("交易密码必须在8~20个字符之间"),
				regexPassword : '密码至少包含一个大写字母、一个小写字母及一个符号，长度必须在8~20个字符之间',
				equalTo : "两次输入的密码不一致"
			},
			batch_level_id : {
				required : "请输入批价级别",
				digits : "输入格式不正确"
			},
			fixedPhone : {
				required : "请输入固定电话号码"
			},
			mobilePhone : { required : "请输入手机号码" },
			username_register : { required : "格式必须为手机号码" },
			qq : { digits : "输入格式不正确" },
			email : { email : "请输入正确的email地址" }
		}
	});
});

$(document).ready(function() {
	parent.resetTime(); 
					$('#agentsubmit').click(function() {
								// $('#signupForm').submit();
									var areavalue = document.getElementById("area").value;
									var agent_type = document.getElementById("agent").value;
									if (agent_type == 3) {
										var batch_level = document.getElementById("batch_level").value;
										//var max_sub_agents=document.getElementById("max_sub_agents").value;
									}
									var shop_type = document
											.getElementById("shop_type").value;
									if ($("#agentRegisterform").valid()
											&& user_soles) {
										$
												.ajax( {
													cache : true,
													type : "POST",
													async : false,
													dataType : 'json',
													url : "agentsManage.do?type=agentRegister&areaId="
															+ areavalue
															+ "&batchLevel="
															+ batch_level
															+ "&shopType="
															+ shop_type,
													data : $('#agentRegisterform').serialize(),// 你的formid 
													error : function(err) {
														var result = "<img src='./images/bg_btn3.gif'>给下级代理商注册失败！"+err.status;
														//refresh();
														$("#registermessage")
																.html(result);
														$("#registermessage")
																.show(200)
																.delay(3000)
																.hide(200);
													},
													success : function(json) {
														if (json.retcode == "0") {
															var result = "<img src='${ctx}/images/button/ok.gif'>给下级代理商注册成功！";
														} else {
															result = "<img src='./images/bg_btn3.gif'>"+json.message;
														}
														$("#registermessage")
																.html(result);
														$("#registermessage")
																.show(200)
																.delay(3000)
																.hide(200);
													}
												});
									}
									parent.resetTime(); 
								});
				});

var user_soles = false;
function usersoles() {
	var user_name = encodeURI($.trim($("#username_register").val()));
	$
			.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : "empManage.do?type=empSole&username=" + user_name,
				dataType : 'text',
				error : function(request) {
					alert("Connection error");
				},
				success : function(data) {
					//refresh();
				if (jQuery.trim(data) == "101") {
					$("#username").css("display", "block");
					var agent_name = $.trim($("#username_register").val());
					document.getElementById("username").innerHTML = '<font color="red">不好意思,用户名' + agent_name + '已被注册,请更换！</font>';
				} else if (jQuery.trim(data) == "202") {
					user_soles = true;
					$("#username").css("display", "none");
				}
			}
			});
}
</script>

<div>

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

	<div id="tabCot_product_5" class="tabCot" style="display: none;">
		<div id="form1">
			<input name="agent" id="agent" style="display: none;"
				value="${agent_type}">
			<div style="" id="autoTime">
				<div class="blockremarknone" id="registermessage"></div>
				<form id="agentRegisterform" method="post" action=""  autocomplete="off">
					<div class="block">
						<table width="50%" style="border: none;">
							<tr>
								<td class="td1">
									上级代理商名称：
								</td>
								<td style="width: 70%;">
									<input class="supername" name="supername" id="supername"
										value="${agentsname}" disabled="disabled" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									<span style="color: red">*&nbsp;</span>代理商名称：
								</td>
								<td>
									<input class="agentsname" name="agentsName" id="agentsname" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									<span style="color: red">*&nbsp;</span>代理商登录名（手机号）：
								</td>
								<td>
									<input class="username_register" name="loginName"
										id="username_register" onblur="usersoles();"  AUTOCOMPLETE="off" />
									<span id="username"
										style="display: none; margin: 3px, 10px, 0px, 0px;"></span>
								</td>
							</tr>
							<tr>
								<td class="td1">
									<span style="color: red">*&nbsp;</span>登录密码：
								</td>
								<td>
									<input type="password" class="password_register" AUTOCOMPLETE="off" 
										name="loginPwd" id="password_register" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									<span style="color: red">*&nbsp;</span>确认登录密码：
								</td>
								<td>
									<input type="password" class="right_password_register"
										name="right_password_register" id="right_password_register" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									<span style="color: red">*&nbsp;</span>身份证号码：
								</td>
								<td>
									<input class="idnumber" name="IDCard" id="idnumber" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									代理商类别：
								</td>
								<c:if test="${'3' eq agent_type}">
									<td>
										<input class="agentstype" name="agentstype" id="agentstype" value="直属经销商" disabled="disabled" />
									</td>
								</c:if>
								<c:if test="${'3' ne agent_type}">
									<td>
										<input class="agentstype" name="agentstype" id="agentstype" value="非直属经销商" disabled="disabled" />
									</td>
								</c:if>
							</tr>
								<tr>
									<td class="td1">
										<span style="color: red">*&nbsp;</span>可发展下家数：
									</td>
									<td>
										<input class="max_sub_agents" name="max_sub_agents" value="0" id="max_sub_agents" />
									</td>
								</tr>
							<tr>
								<td class="td1">
									<span style="color: red">*&nbsp;</span>告警余额(元)：
								</td>
								<td>
									<input class="balance_alarm" name="balanceAlarm" value="0"  id="balance_alarm" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									<span style="color: red">*&nbsp;</span>交易密码：
								</td>
								<td style="width: 70%;">
									<input type="password" class="tradePwd" name="tradePwd"
										id="tradePwd" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									<span style="color: red">*&nbsp;</span>确认交易密码：
								</td>
								<td style="width: 70%;">
									<input type="password" class="right_super_password"
										name="right_super_password" id="right_super_password" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									<span style="color: red">*&nbsp;</span>手机：
								</td>
								<td style="width: 70%;">
									<input class="mobile_phone" name="mobilePhone"
										id="mobile_phone" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									所属地区：
								</td>
								<td>
									<select id="area" name="area" style="width: 135px;">
										<option value="${areaid}">
											${areaname}
										</option>
										<c:forEach items="${areaSet}" var="areaSet">
											<option value="${areaSet.id}">
												${areaSet.name}
											</option>
										</c:forEach>
									</select>
								</td>
							</tr>

							<c:if test="${'3' eq agent_type}">
								<tr>
									<td class="td1">
										批价级别：
									</td>
									<td>
										<select id="batch_level" name="batch_level"
											style="width: 135px;">
											<c:forEach items="${BatchLevelList}" var="BatchLevelList">
											<c:if test="${BatchLevelList.id !=1}">
												<option value="${BatchLevelList.id}">
													${BatchLevelList.batchLevel}
												</option>
											</c:if>
											</c:forEach>
										</select>
									</td>
								</tr>
							</c:if>
							<tr>
								<td class="td1">
									店铺类型：
								</td>
								<td>
									<select id="shop_type" name="shop_type" style="width: 135px;">
										<c:forEach items="${shopTypeTblList}" var="shopTypeTblList">
											<option value="${shopTypeTblList.id}">
												${shopTypeTblList.name}
											</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td class="td1">
									联系人：
								</td>
								<td style="width: 70%;">
									<input class="linkman" name="linkman" id="linkman" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									固定电话：
								</td>
								<td style="width: 70%;">
									<input class="fixed_phone" name="fixedPhone" id="fixed_phone" />
								</td>
							</tr>
					
							<tr>
								<td class="td1">
									QQ：
								</td>
								<td>
									<input class="qq" name="qq" id="qq" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									邮件地址：
								</td>
								<td style="width: 70%;">
									<input class="email" name="email" id="email" />
								</td>
							</tr>
							<tr>
								<td class="td1">
									 详细地址：
								</td>
								<td style="width: 70%;">
									<input class="address" name="address" id="address" />
								</td>
							</tr>
							<tr>
								<td></td>
								<td>
									<input id="agentsubmit" name="Submit" type="button" class="Partorange" value="保存"/>
									
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>

		<div class="clear"></div>
	</div>