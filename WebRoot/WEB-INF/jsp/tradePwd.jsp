<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>My JSP 'tradePwd.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" type="text/css"
			href="${ctx}/themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"
			href="${ctx}/themes/sales/home/esales.style.css">
		<%--<script type="text/javascript" language="javascript"
			src="${ctx}/js/common/jquery-1.8.0.min.js">
</script>
		--%>
		<script type="text/javascript" language="javascript"
			src="${ctx}/js/jquery.min.js">
</script>

<script type="text/javascript" src="${ctx}/js/jquery.md5.js"></script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/thickbox.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.validate.min.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.metadata.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.form.js">
</script>
		<script type="text/javascript">
</script>
<style type="text/css">

.tab #tabCot{padding:20px 15px 10px 15px;border-left:1px solid #d6d6d6;border-right:1px solid #d6d6d6;}
</style>
		<script language="javascript">
jQuery.validator.addMethod("newpwd", function(value, element) {  
    return this.optional(element);//|| /^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/.test(value)  
}, "密码长度至少8位");
$().ready(function() {
	$("#tradepwdForm").validate( {
		rules : {
			oldpwd : {
				required : true
			},
			newpwd : {
				required : true,
				rangelength: [8, 20]
				//newpwd :true
			},
			chknewpwd : {
				required : true,
				equalTo : "#newpwd"
			}
		},
		messages : {
			oldpwd : {
				required : "请输入交易密码"
			},
			newpwd : {
				required : "交易密码不能为空",
				rangelength : jQuery.format("交易密码必须在8~20个字符之间"),
				newpwd: '密码长度必须在8~20个字符之间'
			},
			chknewpwd : {
				required : "再输入一次新密码",
				equalTo : "两次输入的密码不一致"
			}
		}
	});
});

$(document).ready(function() {
	$("#btn_fb").click(function() {
		if($("#tradepwdForm").valid()){
			processData();
			}
		});
});

function ecode(value) {
	return encodeURI(encodeURI(value));
}
function hidebox(){
	$("#message").hide();
	$("#oldpwd").val("");
	$("#newpwd").val("");
	$("#chknewpwd").val("");
}

function showbox(){
	$("#message").hide().fadeIn("slow");
	setTimeout("hidebox()",3000);
}

function processData() {
	var loginpwd = document.getElementById("oldpwd").value;
	var newpwd = document.getElementById("newpwd").value;
	var chknewpwd = document.getElementById("chknewpwd").value;
	var queryString = "oldPwd="+$.md5(escape(encodeURIComponent(loginpwd)))+"&newPwd="+$.md5(escape(encodeURIComponent(newpwd)));
	
	$.ajax( {
		type : "POST",
		url : "${ctx}/user/updateTradePwd.do",
		cache : false,
		timeout : 15000,
		data : queryString,
		dataType : 'json',
		success : function(json) {
			var result="";
			if(json.retcode=="0"){
				var result = "<img src='${ctx}/images/button/ok.gif'>交易密码修改成功！";
			}else{
				result = "<img src='./images/bg_btn3.gif'>"+json.message;
			}
			$("#message").html(result);
			showbox();
		},
		error : function() {
			$("#message").html("<img src='./images/bg_btn3.gif'>交易密码修改失败 ！");
			showbox();
	}
	});
}
</script>

	</head>

	<body >
	
	
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab"
						style="width: 100%; height: 30px">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="${ctx}/user/tradePwd.do" title="安全设置" rel="1">安全设置</a>
								</li>

							</ul>
						</div>
						<div id="tabCot">

							<div style="" id="autoTime">

								<div class="block">

									<%--<div class="blockcommon">
									--%>
									<div class="subnav">
										<a href="${ctx}/user/tradePwd.do" target="_self"
											class="current"> <span>支付密码设置</span> </a>
										<a href="${ctx}/user/safeBound.do" target="_self" class="current"> <span>安全绑定</span>
										</a>

									</div>

								</div>
							</div>


							<div class="clear"></div>
						</div>

						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>
					</div>
					
			<div class="blockcommon" style="margin-top: 20px;">
			<div id="ajaxmsg" class="blockremarknone">
				<span id="message"></span>
			</div>
			<form name="tradepwdForm" id="tradepwdForm" method="post">
				<input type="hidden" name="mode" id="mode" value="updTradePwd">
				<input type="hidden" name="settype" id="settype" value="">
				<ul class="formul">
					<li id="actnew" class="label"></li>
					
					<li id="old">
						<label>
							原交易密码：
						</label>
						<input type="password" id="oldpwd" name="oldpwd">
						<span class="red" id="chktradepwd"></span>
					</li>
					<li id="new">
						<label>
							新交易密码：
						</label>
						<input type="password" id="newpwd" name="newpwd">
					</li>
					<li id="chknew">
						<label>
							确认新交易密码：
						</label>
						<input type="password" id="chknewpwd" name="chknewpwd">
					</li>
					<li class="label">
						<button type="button" id="btn_fb" class="small">
							保存
						</button>
					</li>
				</ul>
			</form>
		</div>
		<blockquote>
			<p>
				<strong>说明：</strong>
			</p>
			<p style="margin-left: 40px;">
				交易密码让您的账户又多了一层安全保障，如果登录时候的IP地址和上次登录时候的IP地址不同，系统会提示您输入交易密码才能进行其他相关操作,如果是同一IP，您不需要输入交易密码。
			</p>
		</blockquote>
					
					
				</div>

			</div>


			<div class="clear"></div>
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
