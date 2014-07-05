<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>我的账户信息</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css"     href="${ctx}/themes/common/titletab.css"  />
		<link rel="stylesheet" type="text/css"	   href="${path}themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"	   href="${path}themes/sales/home/esales.style.css">
 		<link href="${ctx}/themes/common/button.css" rel="stylesheet" type="text/css" />
			<script type="text/javascript" language="javascript"			src="${path}js/jquery.min.js"></script>
		
		<script type="text/javascript" language="javascript"			src="${path}js/jquery.tableui.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/jquery.pagination.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/thickbox.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/jquery.form.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/jquery.metadata.js"></script>
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
			},
			realName : {
				required:true
			},
			cardNumber : {
				required:true,
				isIdCardNo:true
			},
			phoneNumber : {
				required : true,
				isMobile: true
			},
			email : {
				required:true,
				email:true
			},
			telNumber : {
				isPhone:true
			},
			qqNumber : {
				digits:true
			}
		},
		messages : {
			qqNumber : "输入格式不正确",
			balanceAlarm :{
				required:"请输入告警余额"
			},
			realName : {
				required:"请填写真实姓名"
			},
			cardNumber : {
				required : "请填写证件号码"
			},
			phoneNumber : {
				required : "请输入手机号码"
			},
			email : {
				required:"用于收货和找回密码,请认真填写",
				email:"邮箱格式不正确"
			}
		}
	});
});
		
function checkidcard(num) {
	var len = num.length, re;
	if (len == 15) {
		re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{3})$/);
	} else if (len == 18) {
		re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\d)$/);
	} else {
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
			return false;
		}
	}

	return true;
}


function ecode(value){
	return encodeURI(encodeURI(value));
}

function processData(){
	parent.resetTime(); 
	var queryString = "&phoneNumber="+ecode($("#phoneNumber").val())+"&email="+ecode($("#email").val())+"&telNumber="+ecode($("#telNumber").val())+"&qqNumber="+ecode($("#qqNumber").val())+"&balanceAlarm="+ecode($("#balanceAlarm").val());
	$.ajax({    
		url:'${ctx}/account.do?type=updInfo',
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
				var result = "<img src='./images/button/ok.gif'>个人资料修改成功！";
				$("input[type=text]").val("");
				$("#message").html(result);
				$("#message").show(200).delay(3000).hide(200);
			}
			getInfo();
		},
		error: function(e){
			$("#message").html("<img src='./images/bg_btn3.gif'>个人资料修改失败！"+e.status);
			$("#message").show(200).delay(3000).hide(200);
			getInfo();
		}
	});
}
$(document).ready(function() {
	parent.resetTime(); 
	$("#btn_fb").click(function(){
		if($("#thisFrm").valid()){
			processData();
		}
	});
	getInfo();
	
	
});
	
function getInfo(){
	parent.resetTime(); 
	$.ajax({
		url:'${ctx}/account.do?type=baseInfo',
		type:'post',
		dataType:'json',
		cache : true,
		async : false,
		success:function(datas){
			if(datas.retcode==-1){
				alert(datas.message);
			}else{
				var data = datas.data;
				if(data.userType=="1"){
					$(".userType1").css("display", "none");
					$("#id").val(data.id);
					$("#loginName2").val(data.loginName);
					$("#telNumber2").val(data.telNumber);
				}else if(data.userType=="0"){
					$(".userType2").css("display", "none");
					$("#balance").val(data.balance);
					$("#bail").val(data.bail);
					$("#balanceAlarm").val(data.balanceAlarm);
					$("#loginName").val(data.loginName);
					$("#realName").val(data.realName);
					$("#cardNumber").val(data.cardNumber);
					$("#areaName").val(data.areaName);
					$("#phoneNumber").val(data.phoneNumber);
					$("#email").val(data.email);
					$("#telNumber").val(data.telNumber);
					$("#qqNumber").val(data.qqNumber);
				}
			}
		},error:function(e){alert(e.status)}
	});
	
}
function load(){
	　　parent.document.getElementById("main").style.height = "800px"; 
   　} 
</script>


<style type="text/css">
.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
</style>

	</head>

	<body onload="load()">
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%; ">
					<div id="tabCot_product" class="tab"  style="width: 100%; height: 120px;">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="${ctx}/account.do?type=baseInfoPage" title="账户管理" rel="1">账户管理</a>
								</li>

							</ul>
						</div>
						<div id="tabCot" style="height:59px;">

							<div style="" id="autoTime" >

								<div class="block">

									<div class="subnav">
										<a href="account.do?type=baseInfoPage" target="_self"
											class="current"> <span>基本资料</span> </a>
										<a href="account.do?type=editPwd" target="_self"> <span>修改密码</span>
										</a>
										<a href="account.do?type=loginLog" target="_self"> <span>登录日志</span>
										</a>

									</div>

								</div>
							</div>
						</div>

						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>
					</div>
					<%-- form页面 --%>
						<div class="blockcommon pusht userType1"  style="margin-top: 10px;">
							<form name="thisFrm" id="thisFrm" method="post">
								<h3 class="formultitle">
									基本资料
								</h3>
								<ul class="formul">
									<li>
										<label>
											<em>*</em>登录帐号：
										</label>
										<input type="text" name="loginName" id="loginName" disabled/>									
									</li>
									<li>
										<label>
											<em>*</em>真实姓名：
										</label>
										<input type="text" name="realName" id="realName" disabled/>											
									</li>
									<li>
										<label>
											<em>*</em>证件号码：
										</label>
										<input type="text" name="cardNumber" id="cardNumber" disabled/>
									</li>
									<li>
										<label>
											<em>*</em>所在地区：
										</label>
										<input type="text" name="areaName" id="areaName" disabled/>
									</li>
									<li>
										<label>
											<em>*</em>余额(元)：
										</label>
										<input type="text" name="balance" id="balance" disabled/>
									</li>
									<li>
										<label>
											<em>*</em>保证金(元)：
										</label>
										<input type="text" name="bail" id="bail" disabled/>
									</li>
									<li>
										<label>
											<em>*</em>告警余额(元)：
										</label>
										<input type="text" name="balanceAlarm" id="balanceAlarm"/>
									</li>
								</ul>
								<h3 class="formultitle">
									联系方式
								</h3>
								<ul class="formul">
									<li>
										<label>
											<em>*</em>手机号码：
										</label>
										<input type="text" id="phoneNumber" name="phoneNumber"/>
									</li>

									<li>
										<label>
											<em>*</em>E-Mail：
										</label>
										<input type="text" name="email" id="email"/>
									</li>
									<li>
										<label>
											<em>*</em>联系电话：
										</label>
										<input type="text" id="telNumber" name="telNumber"/>
									</li>
									<li>
										<label>
											<em>*</em>QQ号码：
										</label>
										<input type="text" id="qqNumber" name="qqNumber"/>
									</li>
									<li class="label">
								<input id="btn_fb" type="button"  class="Partorange" style="width: 80px;" value="保存">
									</li>
								</ul>
							</form>
							</div>
				</div>

			</div>


			<div class="clear"></div>
		</div>
		</div>
		<div class="noprint">
			<script type="text/javascript" language="jscript">
function tab(o, s, cb, ev) {//tab切换类
	var $ = function(o) {
		return document.getElementById(o)
	};
	var css = o.split((s || '_'));
	if (css.length != 4)
		return;
	this.event = ev || 'onclick';
	o = $(o);
	if (o) {
		this.ITEM = [];
		o.id = css[0];
		var item = o.getElementsByTagName(css[1]);
		var j = 1;
		for ( var i = 0; i < item.length; i++) {
			if (item[i].className.indexOf(css[2]) >= 0
					|| item[i].className.indexOf(css[3]) >= 0) {
				if (item[i].className == css[2])
					o['cur'] = item[i];
				item[i].callBack = cb || function() {
				};
				item[i]['css'] = css;
				item[i]['link'] = o;
				this.ITEM[j] = item[i];
				item[i]['Index'] = j++;
				item[i][this.event] = this.ACTIVE;
			}
		}
		return o;
	}
}
tab.prototype = {
	ACTIVE : function() {
		var $ = function(o) {
			return document.getElementById(o)
		};
		this['link']['cur'].className = this['css'][3];
		this.className = this['css'][2];
		try {
			$(this['link']['id'] + '_' + this['link']['cur']['Index']).style.display = 'none';
			$(this['link']['id'] + '_' + this['Index']).style.display = 'block';
		} catch (e) {
		}
		this.callBack.call(this);
		this['link']['cur'] = this;
	}
}

new tab('tabCot_product-li-currentBtn-', '-');
</script>
		</div>

	</body>
</html>