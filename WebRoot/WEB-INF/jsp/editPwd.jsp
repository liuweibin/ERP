<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>My JSP 'editPwd.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">
 		<link href="${ctx}/themes/common/button.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" language="javascript"			src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.metadata.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.form.js"></script>

<script type="text/javascript" src="${ctx}/js/jquery.md5.js"></script>
<script language="javascript">

$().ready(function () {
	parent.resetTime(); 
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
	document.location.href = "account.do?type=editPwd";
}

function showbox(){
	$("#message").hide().fadeIn("slow");
	setTimeout("hidebox()",3000);
}


function processData(){
	parent.resetTime(); 
	var newpwd = $("#newpwd").val();
	if ( newpwd.length < 6 || newpwd.length > 15 ) {
		alert("密码必须在6~20个字符之间，建议数字和字母组合");
		return;
	}
	var loginpwd = document.getElementById("oldpwd").value;
	var newpwd = document.getElementById("newpwd").value;
	var chknewpwd = document.getElementById("chknewpwd").value;
	var queryString = "oldPwd="+$.md5(escape(encodeURIComponent(loginpwd)))+"&newPwd="+$.md5(escape(encodeURIComponent(newpwd)));
	$.ajax({    
		type: "POST",
		url: "account.do?type=updatePwd",
		cache: false,
		timeout: 15000,
		data: queryString,
		dataType : 'json',
		success: function(json) {
			var result = "";
			
			if(json.retcode=="0"){
				alert( "登录密码修改成功,请重新登录！" );
				parent.window.location.href = "${ctx}/user/loginMain.do";
			}else{
				result = "<img src='./images/bg_btn3.gif'>"+json.message;
			}
			
			$("#message").html(result);
			showbox();
		},
		error: function(){
			$("#message").html("<img src='./images/bg_btn3.gif'>登录密码修改失败 ！");
			showbox();
		}
	});
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

	<body>
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab" style="width: 100%;height: 120px">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="${ctx}/account.do?type=editPwd" title="账户管理" rel="1">账户管理</a>
								</li>

							</ul>
						</div>
						<div id="tabCot" style="height:57px;">

							<div style="" id="autoTime">

								<div class="block">
						  	<div class="subnav">
										<a href="account.do?type=baseInfoPage" target="_self"
											class="current"> <span>基本资料</span> </a>
										<a href="account.do?type=editPwd" target="_self">
											<span>修改密码</span> </a>
										<a href="account.do?type=loginLog" target="_self">
											<span>登录日志</span> </a>

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
					
					<%-- form页面 --%>
		<div class="blockremarknone" id="message"></div>
		<div class="blockcommon pusht" style="margin-top: 10px;">
			<!--上级代注册，下级修改密码时提示-->

			<!--新注册用户，修改资料时提示-->

			<form id="thispwdForm" method="post" action="">
				<input type="hidden" name="mode" id="mode" value="updPwd">
				<ul class="formul">
					<li>
						<label for="oldpwd">
							原登录密码：
						</label>
						<input type="password" id="oldpwd" name="oldpwd"/>
							
					</li>
					<li>
						<label for="newpwd">
							新密码：
						</label>
						<input type="password" id="newpwd" name="newpwd"/>
					</li>
					<li>
						<label for="chknewpwd">
							确认新密码：
						</label>
						<input type="password" id="chknewpwd" name="chknewpwd"/>
					</li>
					<li class="btnarea">
								<input id="sumbitpwd" type="button"  class="Partorange" style="width: 80px;" value="保存">
					</li>
				</ul>
			</form>
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
