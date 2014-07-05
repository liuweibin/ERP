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
		<script type="text/javascript" language="javascript" src="${ctx}/js/jquery.min.js">
</script>
		<script type="text/javascript" language="JavaScript" src="${ctx}/js/thickbox.js">
</script>
		<script type="text/javascript" language="JavaScript" 	src="${ctx}/js/jquery.validate.min.js">
</script>
		<script type="text/javascript" language="JavaScript" 	src="${ctx}/js/jquery.metadata.js">
</script>
		<script type="text/javascript" language="JavaScript" src="${ctx}/js/jquery.form.js">
</script> 
<script type="text/javascript" charset="gb2312" src="http://counter.sina.com.cn/ip/"></script>
<style type="text/css">

.tab #tabCot{padding:20px 15px 10px 15px;border-left:1px solid #d6d6d6;border-right:1px solid #d6d6d6;}
</style>
		<script language="javascript">
jQuery.validator.addMethod("newpwd", function(value, element) {  
    return this.optional(element) || /^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/.test(value);  
}, "密码至少包含一个大写字母、一个小写字母及一个符号，长度至少8位");
$().ready(function() {
		$("#radio").change(function() {
         var isChecked = $("input[name='radioName']:checked").val();           // 获取当前选中radio的值
         if(isChecked=="on"){
         	var ip = ILData[0];
			var strs= new Array(); //定义一数组
				strs = ip.split('.');
			$("#ip1").val(strs[0]);
			$("#ip2").val(strs[1]);
			$("#ip3").val(strs[2]);
			$("#ip4").val(strs[3]);
		         	
         }
     });
     


	$("#safeBoundForm").validate( {
		rules : {
			ip1 : {
				required : true,
				digits:true
			},
			ip2 : {
				required : true,
				digits:true
			},
			ip3 : {
				required : true,
				digits:true
			},
			ip4 : {
				required : true,
				digits:true
			}
		},
		messages : {
			ip1 : {
				required : "请输入完整的ip地址",
				digits:"请输入数字"
			},
			ip2 : {
				required : "请输入完整的ip地址",
				digits:"请输入数字"
			},
			ip3 : {
				required : "请输入完整的ip地址",
				digits:"请输入数字"
			},
			ip4 : {
				required : "请输入完整的ip地址",
				digits:"请输入数字"
			}
		}
	});
});

$(document).ready(function() {
	var btype="${bandtype}";
	var bvalue="${bandvalue}";
	var mtype="${mobileBindType}";
	var mvalue="${mobileBindValue}";
	var arr=new Array();
	if(btype==1){
		$("#pc_bind_type").find("option[value='1']").attr("selected",true);
		arr=bvalue.split(".");
		for(var i=0;i<arr.length;i++)
			{
			var ip1=arr[0];
			var ip2=arr[1];
			var ip3=arr[2];
			var ip4=arr[3];
			$("#ip1").val(ip1);
			$("#ip2").val(ip2);
			$("#ip3").val(ip3);
			$("#ip4").val(ip4);
			}
	}else if(btype==2){
		$("#pc_bind_value").val(bvalue);
		$("#pc_bind_type").find("option[value='2']").attr("selected",true);
	}else {
		$("#pc_bind_type").find("option[value='0']").attr("selected",true);
	}
	if(mtype==1){
		$("#mobile_bind_type").find("option[value='1']").attr("selected",true);
		$("#mobile_bind_value").val(mvalue);
	}else if(mtype==2){
		$("#mobile_bind_type").find("option[value='2']").attr("selected",true);
		$("#macmobile_value").val(mvalue);
	}else{
		$("#mobile_bind_type").find("option[value='0']").attr("selected",true);
	}
	selectype();
	selectMoblieType();
	$("#btn_safe").click(function() {
		var pctype=$("#pc_bind_type").val();
		var moblietype=$("#mobile_bind_type").val();
		if(pctype==2&&moblietype==1){
				testvalue();
				testmb();
			 if(testvalueresult&&testphone){
				processData();
				}
		}else if(pctype==2&&moblietype==2){
				testvalue();
				testmbmac();
			 if(testvalueresult&&testmac){
				processData();
				}
		}else if(pctype==1&&moblietype==1){
				testmb();
				$("#pcmac_value").css("display","none");
			 if($("#safeBoundForm").valid()&&testphone){
				processData();
				}
		}else if(pctype==1&&moblietype==2){
				testmbmac();
				$("#pcmac_value").css("display","none");
			 if($("#safeBoundForm").valid()&&testmac){
				processData();
				}
		}else if(pctype==0&&moblietype==1){
				testmb();
				 if(testphone){
				processData();
				}
		}else if(pctype==0&&moblietype==2){
				testmbmac();
				 if(testmac){
				processData();
				}
		}else if(moblietype==0&&pctype==2){
				testvalue();
				 if(testvalueresult){
				processData();
				}
		}else if(moblietype==0&&pctype==1){
				 if($("#safeBoundForm").valid()){
				processData();
				}
		}
		 if (pctype==0&&moblietype==0){
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
	var queryString = "&pc_bind_type=" + ecode($("#pc_bind_type").val()) + "&ip1="
			+ ecode($("#ip1").val()) + "&ip2="+ ecode($("#ip2").val()) + "&ip3="+ ecode($("#ip3").val())+ "&ip4="+ ecode($("#ip4").val())
			+ "&pc_bind_value="+ encodeURI($("#pc_bind_value").val())+"&mobile_bind_type="+ ecode($("#mobile_bind_type").val())+"&mobile_bind_value="+ encodeURI($("#mobile_bind_value").val())+"&macmobile_value="+ encodeURI($("#macmobile_value").val());
	var url_="${ctx}/user/safeBoundInfo.do";
	$.ajax( {
		type : "POST",
		url : url_,
		cache : false,
		timeout : 15000,
		data : queryString,
		dataType : 'text',
		success : function(msg) {
			var result="";
			if(jQuery.trim(msg) == "202"){
				var result = "<img src='${ctx}/images/button/ok.gif'>添加绑定方式成功！";
				$("input[type=text]").val("");
			}else if(jQuery.trim(msg) == "101"){
				result = "<img src='${ctx}/images/bg_btn3.gif'>添加绑定方式失败！";
			} 
			$("#message").html(result);
			showbox();
		},
		error : function() {
			$("#message").html("<img src='${ctx}/images/bg_btn3.gif'>添加绑定方式失败！");
			showbox();
	}
	});
}

function selectype(){
	var pctype=$("#pc_bind_type").val();
	if(pctype==2){
		$("#ipvalue").hide();
		$("#mac_value").css("display","block");
	}
	if(pctype==1){
		$("#ipvalue").css("display","block");
		$("#mac_value").css("display","none");
		$("#pcmac_value").css("display","none");
	}
	if(pctype==0){
		$("#ipvalue").css("display","none");
		$("#mac_value").css("display","none");
		$("#pcmac_value").css("display","none");
	}
	
}

function selectMoblieType(){
	var moblietype=$("#mobile_bind_type").val();
	if(moblietype==1){
		$("#moblie_values").css("display","block");
		$("#mac_moblie_value").css("display","none");
		$("#ph_mac_value").css("display","none");
	}
	if(moblietype==2){
		$("#mac_moblie_value").css("display","block");
		$("#moblie_values").css("display","none");
		$("#ph_value").css("display","none");
	}
	if(moblietype==0){
		$("#mac_moblie_value").css("display","none");
		$("#moblie_values").css("display","none");
		$("#ph_mac_value").css("display","none");
		$("#ph_value").css("display","none");
	}
}
var testvalueresult=false;
var testphone=false;
var testmac=false;

function testvalue(){
	var pcvalue=$("#pc_bind_value").val();
	if(pcvalue==""){
				$("#pcmac_value").css("display","block");
				document.getElementById("pcmac_value").innerHTML = '<font color="red">请输入要绑定的PC mac 地址</font>';
				}else {
				$("#pcmac_value").css("display","none");
				testvalueresult=true;
				}
}

function testmb(){
		var moblievalue=$("#mobile_bind_value").val();
		var macmobilevalue=$("#mobile_bind_value").val();
		var moblietype=$("#mobile_bind_type").val();
		if(moblietype==1&&macmobilevalue==""){
			$("#ph_value").css("display","block");
			$("#ph_mac_value").css("display","none");
				document.getElementById("ph_value").innerHTML = '<font color="red">请输入要绑定的 设备编号</font>';
		}else{
				$("#ph_value").css("display","none");
				testphone=true;
		}
}

function testmbmac(){
	var moblievalue=$("#mobile_bind_value").val();
		var macmobilevalue=$("#macmobile_value").val();
		var moblietype=$("#mobile_bind_type").val();
	if(moblietype==2&&macmobilevalue==""){
			$("#ph_mac_value").css("display","block");
			$("#ph_value").css("display","none");
			document.getElementById("ph_mac_value").innerHTML = '<font color="red">请输入要绑定的手机mac地址</font>';
		}else{
			$("#ph_mac_value").css("display","none");
			testmac=true;
		}
}

</script>

	</head>

	<body>
	
	
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab"
						style="width: 100%; height: 30px">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="javascript:void(0)" title="安全设置" rel="1">安全设置</a>
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
										<a href="${ctx}/user/safeBound.do" target="_self"> <span>安全绑定</span>
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
			<form name="safeBoundForm" id="safeBoundForm" method="post">
				<input type="hidden" name="mode" id="mode" value="updTradePwd">
				<input type="hidden" name="settype" id="settype" value="">
				<h3 class="formultitle">
							PC绑定
					</h3>
				<ul class="formul">
					<li id="actnew" class="label"></li>
					<li id="old">
						<label>
							<em>*</em>选择PC 绑定方式：
						</label>
						<%--<input id="bind_type" name="bind_type">
						--%>
						<select id="pc_bind_type" name="pc_bind_type" style="width: 155px;" onchange="selectype();">
						<option value="0">不绑定PC</option>
						<option value="1" selected="selected">IP地址绑定</option>
						<option value="2">mac地址绑定</option>
						</select>
					</li>
					<li >
						<div id="ipvalue">
						<label id="pcvalues">
							<em>*</em>绑定值：
						</label>
						<input type="text" name="ip1" id="ip1" class="input_text1" style="width:45" maxlength="3" /><span>.</span><input type="text" name="ip2" id="ip2" class="input_text1" style="width:45" maxlength="3" /><span>.</span><input type="text" name="ip3" id="ip3" class="input_text1" style="width:45" maxlength="3" /><span>.</span><input type="text" name="ip4" id="ip4" class="input_text1" style="width:45" maxlength="3" />
						自动获取:<input type="radio" id="radio"  name="radioName"> 
						</div>
						<div id="mac_value" style="display: none">
						<label id="pcvalues">
							<em>*</em>绑定值：
						</label>
						<input type="text" id="pc_bind_value" name="pc_bind_value" onblur="testvalue();"></div><span id="pcmac_value" style="display: none;margin: 3px,10px,0px,200px;"></span>
					</li>
					</ul>
					<h3 class="formultitle">
									手机绑定
					</h3>
					<ul class="formul">
					<li id="chknew">
						<label>
							<em>*</em>选择手机绑定方式：
						</label>
						<select id="mobile_bind_type" name="mobile_bind_type" style="width: 155px;" onchange="selectMoblieType();">
						<option value="0">不绑定手机</option>
						<option value="1" selected="selected">设备编号绑定</option>
						<option value="2">mac地址绑定</option>
						</select>
					</li>
					<li id="new">
					<div id="moblie_values">
						<label>
							<em>*</em>绑定值：
						</label>
						<input type="text" id="mobile_bind_value" name="mobile_bind_value" onblur="testmb();"><span id="ph_value" style="display: none;margin: 3px,10px,0px,200px;"></span>
						</div>
						<div id="mac_moblie_value" style="display: none">
						<label id="pcvalues">
							<em>*</em>绑定值：
						</label>
						<input type="text" id="macmobile_value" name="macmobile_bind_value" onblur="testmbmac();"></div><span id="ph_mac_value" style="display: none;margin: 3px,10px,0px,200px;"></span>
					</li>
					<li class="label">
						<button type="button" id="btn_safe" class="small">
							保存
						</button>
					</li>
				</ul>
			</form>
		</div>
		<blockquote>
			<p>
				<strong>说明（目前只支持IP绑定，不支持mac绑定）：</strong>
			</p>
			<p style="margin-left: 40px;">
				一、登录器登录时，可以选择绑定网卡。
			</p>
			<p style="margin-left: 40px;">
				二、为了加强安全，有固定IP地址的代理商请填写自己的IP地址。
			</p>
			<p style="margin-left: 40px;">
				三、没有固定IP地址的代理商，请不要绑定IP地址。
			</p>
			<p style="margin-left: 40px;">
				四、手机设备编码获取方式 手机直接拨号 *#06# 获取（注：有字母的字母要小写）
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
