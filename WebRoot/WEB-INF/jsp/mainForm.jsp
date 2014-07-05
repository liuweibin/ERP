<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/commons/taglibs.jsp"%>
<%@page import="com.erp.core.common.Constants"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>1+分级销售系统 V1.0  ${session_user_data.agents.name}</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
       <link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/base-e.css">
       <script type="text/javascript" language="javascript" src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
       <script type="text/javascript" language="JavaScript" src="<%=basePath%>js/thickbox.js"></script>
	<script type="text/javascript" language="JavaScript" src="<%=basePath%>js/jquery.form.js"></script>
	<script type="text/javascript" language="JavaScript" src="<%=basePath%>js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="JavaScript" src="<%=basePath%>js/jquery.metadata.js"></script>
	
	<style type="text/css">
.paneltoolbar {
	padding-right: 10px;
	overflow: hidden;
}

.paneltoolbar span {
	line-height: 19px;
}

.paneltoolbar {
	float: right;
}

.paneltoolbar li {
	float: left;
	list-style: none;
}


.paneltoolbar a,.paneltoolbar a span {s; *
	float: left;
	height: 20px;
	line-height: 19px;
	line-height: 20px\9;
	cursor: pointer;
}

span.shrink a {
	background-position: -55px top;
	width: 23px;
}

span.shrink a:hover {
	background-position: -27px top;
}

span.shrink a:active {
	background-position: 0px top;
}
/* 树形菜单开始 */
/* menuDiv */
.menuDiv{border:1px solid #CCCCCC;background:#FFFFFF;padding:1px;}
.menuDiv h3{font-size:14px;font-weight:bold;color:#030303;padding:0px 5px 5px 15px;background:#DCDCDC;cursor:pointer;height:22px;line-height:22px;overflow:hidden;vertical-align: middle;}
.menuDiv ul li{color:#333333;background:#EEEEEE;padding:5px 5px 5px 15px;font-size:12px;margin:1px 0 0 0;height:16px;}
.menuDiv ul li a{color:#333333;background:#F4F4F4;display:block;padding:5px 5px 5px 15px;font-size:12px;margin:-5px -5px -5px -15px;text-decoration:none;height:16px;}
.menuDiv ul li a:hover{color:#0A0A0A;background:#DCDCDC;font-family:Georgia;font-family:Arial;}
#common_info {margin: 5px 5px;width: 190px;text-align: center;height: 140px;}


</style>
		<script type="text/javascript">
		
		var twinkle = setInterval(function(){ $("#balance_Alarm").fadeOut(100).fadeIn(100); },350);
		$("#document").ready(function(){
			ajaxAccount();
			setTimeout(hide,5000);
		});
		
		function hide(obj){
			twinkle=window.clearInterval(twinkle);
			$("#balanceAlarm").hide();
		}
	function LightBox(url, title1, width1, height1,modal,msg){
				if(url.indexOf('?')!=-1){
					url=url+"&width="+width1;
					url=url+"&height="+height1;
				}else{
					url=url+"?width="+width1;
					url=url+"&height="+height1;
				}
				if(modal){
					url=url+"&modal=true";
				}
				
				tb_show(title1,url,true);
				changeMsg(msg);
				//$.weeboxs.open(url, {contentType:'ajax',showButton:false,title:title1,width:width1,height:height1});
			}
			
			function changeMsg(msg){
				$("#hid_message").html(msg);
				$("#TB_ajaxContent").html( '<p id="hid_message">'+msg+'</p>');
			}
	function ajaxAccount(){
		$.ajax({
			url:'account.do?name=getUserBalance',
			async:false,
			cache:false,
			dataType:'json',
			type:'post',
			success:function(data){
				$("#useableBalance").html(data.param0);
			},
			error:function(error){alert("余额刷新失败,请重试.:"+error.status);}
		});
	}
	function logOut(){
		//user/logout.do
		
	}
	
	function hidden(){
		$("#hidetd").toggle();
	}
	
	//树状菜单
	$(document).ready(function(){
		$("#firstpane .menu_body:eq(0)").show();
		$("#firstpane p.menu_head").click(function(){
			$(this).addClass("current").next("div.menu_body").slideToggle(300).siblings("div.menu_body").slideUp("slow");
			//$(this).siblings().removeClass("current");
		});
	});
		</script>
  </head>
  		<input type="hidden" name="softlogin" id="softlogin" value="false">
		<input type="hidden" name="wdwk" id="wdwk" value="">
		<input type="hidden" name="keycontrol" id="keycontrol" value="">
		<p id="hid_message" style="display: none; text-align: center;"></p>
		<div id="top">
			<div class="topcolumn">
				<div id="logo-area">
					<a href="<%=basePath%>user/mainForm.do">xx供货系统</a>
				</div>
				<ul class="paneltoolbar">
					<li>
						<a href="user/tradePwd.do"	target="main">安全设置</a>
					</li>
					<span>|</span>
					<li>
						<a href="user/logout.do"  target="_top">安全退出</a>
					</li>
				</ul>
				<span class="shrink"><a href="javascript:void(null)"title="隐藏/显示左侧功能条" onclick="hidden()">收缩</a> </span>

				<span class="backhome"><a href="user/mainForm.do" target="_parent"		title="返回首页">返回首页</a> </span>

			</div>
			<c:if test="${balanceAlarm>useableBalance}">
				<div id="balanceAlarm" style="color: red;"><p id="balance_Alarm" onmouseover="hide();">您的余额不足${balanceAlarm}元 为避免影响您使用请及时充值</p></div>
			</c:if>
		</div>
		<!-- top end -->
		<table width="100%" cellspacing="0">
			<tbody>
				<tr>
					<td width="220" valign="top" id="hidetd"  class="hidetd">
						<div id="sidecolumn">
							<h2 class="member">
								<span>${session_user_data.agents.name}</span>
							</h2>
							<div class="sideblock">
								<ul class="formul">
									<li>
										<label>
										代理商编号：
										</label>
										<strong class="orange">${session_user_data.agents.agentsCode}</strong>
									</li>
									<li>
										<label>
											账号：
										</label>
										<span title="${session_user_data.username}">
											${session_user_data.username}</span>
									</li>
									<li>
										<label>
											可用余额：
										</label>
										<strong class="f-left font14" style="padding-top: 0;">￥<a
											href="javascript:void(0)" class="blue" id="useableBalance"
											onclick="ajaxAccount();" title="点击刷新信用点">${useableBalance}</a></strong>
										<a href="<%=basePath%>credit/toBuyCredit.do" class="f-left boxtop boxrl" target="main"> <img
												src="<%=basePath%>images/c_z.gif" border="0" style="margin-top: -3px;">
										</a>

									</li>


									<li>
										<label>
											未读消息：
										</label>
										<a href="informationManage.do?type=IfMessage" target="main"><span id="mailimg" style="display: none;"></span>
										<span	id="noreadnum" class="t_mem_1">${message}</span>条消息</a>
									</li>
								</ul>
							</div>
							<div id="common">
								  <h2 class="title"><span class="close">快捷操作</span></h2>
									<table id="common_info">
									<tr style="margin-bottom: 10px;">
										<td><a href="<%=basePath%>goodsSales/mobile/0/sjczPage.do" target="main"><img src="<%=basePath%>images/app_phone_charge.png" width="48" height="48"><br>手机充值</a></td>
										<td ><a href="<%=basePath%>goodsSales/mobile/1/sjczPage.do" target="main"><img src="<%=basePath%>images/app_game_card.png" width="48" height="48"><br>全国充值</a></td>
									</tr>
										<tr>
										<td><a href="<%=basePath%>goodsSales/games/gamesCZPage.do" target="main"><img src="<%=basePath%>images/app_game_card.png" width="48" height="48"><br>游戏充值</a></td>
										<td ><a href="<%=basePath%>goodsManager/commonGoodsPage.do" target="main"><img src="<%=basePath%>images/app_game_card.png" width="48" height="48"><br>常用商品</a></td>
									</tr>
									</table>
							</div>
			<div style="width:215px;margin:10px auto;">
						  <h2 class="title"><span class="close">系统功能</span></h2>
						  <c:forEach items="${resources}" var="data"> 
								<c:if test="${data.pid=='0'}">
								<div class="menuDiv">
							 	<h3>${data.remark}</h3> 	
									 <ul>  
											<c:forEach items="${resources}" var="data2"> 
											<c:if test="${data.id==data2.pid}">
												<li>
												<a href="${ctx}${data2.url}" target="main" title="${data2.remark}">${data2.remark}</a>
												</li>
											</c:if>
											</c:forEach>
									 </ul>
							  	  </div>
								</c:if>
								</c:forEach>
			</div>
			
	<!--						
							
	<c:if test="${data.name == 'tradingRecord'}">
										<span class="pushl">
											<a href="tradingRecord.do?queryTime=yesterday" target="main">昨</a> 
										</span>
										<span>
											<a href="tradingRecord.do?queryTime=today" class="boxleft" target="main">今</a>
										 </span>
									</c:if>
							<h2>
								<span>联系信息</span>
							</h2>
							<div class="sideblock">
								<ul class="formul severs">
									<li style="padding-bottom: 10px;">
										<a id="live800iconlink" target="_self"
											href="javascript:void(0)" onclick=""><img	name="live800icon" id="live800icon"
												src="<%=basePath%>images/SurferServer" border="0">
										</a>
									</li>
									<li>
										<label>
											客服热线：
										</label>
										021-00000000
									</li>
									<li>
										<label>
											加款热线：
										</label>
										400-000-000
									</li>
								</ul>
							
							</div>-->
					</div>
						<!-- sidecolumn end -->
					</td>
					<td valign="top" class="buttd" width="8">
						<a href="javascript:void(null)" title="隐藏/显示左侧功能条" onclick="hidden()">隐藏/显示左侧功能条</a>
					</td>
					<td valign="top">
<style>
.tcenter {
	text-align: center;
}

.bold {
	font-weight: bold;
}

.blockcommon,.block,.blockremark,blockquote {
	padding: 10px;
}

.blockcommon,.block {
	border: 1px solid #aeaeae;
}

.block {
	background: #fff;
	border: 1px solid #ccc;
}

.note,blockquote {
	background: #f3f4f5;
	border: 1px solid #ccc;
}

.important {
	background: #f9f7e7;
	border: 1px solid #baa22f;
}

.warning {
	background: #feefef;
	border: 1px solid #b32525;
}

.remark {
	background: #eaf7e5;
	border: 1px solid #58a63a;
}

.info {
	background: #f7f7f7;
	border: 1px solid #f1f1f1;
}

samp,em {
	padding: 0 5px;
}

em {
	color: #d91010;
}

strong {
	font-weight: bold;
}

.error,.fail,.red,.warn {
	color: #bb2828;
}

.success,.green {
	color: #1cae1c;
}

.orange {
	color: #e37513;
}

.blue {
	color: #1292cd;
}

.gray {
	color: #6d6d6d;
}

.oatmeal {
	color: #ccc;
}

.backred,.backgreen,.backorange,.backblue,.backgray {
	margin: 0 3px;
	padding: 2px 5px;
	color: #f7f7f7;
}

.backred {
	background: #d91010;
}

.backgreen {
	background: #29ad3b;
}

.backorange {
	background: #ee8528;
}

.backblue {
	background: #2bb3f1;
}

.backgray {
	background: #8a8989;
}

.hide {
	display: none;
}
</style>
						<div class="block warning tcenter pushB hide">
							【公告】本系统于
							<span class="backred bold">2013年x月xx日凌晨3:00 - 6:00</span>，对系统进行维护。期间将暂停服务，给您带来不便，敬请谅解！
						</div>

						<div style="padding: 10px;">
							<iframe src="user/main_center.do" name="main" scrolling="auto" frameborder="0" id="main" width="100%" height="auto"
								allowtransparency="true" onload="this.height=768"></iframe>
						</div>
					
					</td>
				</tr>
			</tbody>
		</table>
<div id="footer" style="text-align: center;">
		<div class="bottommain">
				<div class="bottomright" style="text-align: center">
					<a href="#" target="_blank">关于我们</a>
					<a href="#" target="_blank">联系我们</a>
					<a href="#" target="_blank">友情链接</a>
					<a href="#" target="_blank">ICP证：沪ICP备08108966号  </a>
					<br/>
					<div style="margin-top: 10px; line-height: 20px;">
						Copyright © 2013 - 2015  All Rights Reserved.推荐分辨率：1024*768以上
						<br/>
						<samp style="font-size: 14px;font-weight: bolder">1+</samp>分级销售系统 V1.0
						<samp style="padding-left: 10px;">
						上海大指头网络技术有限公司
						</samp>
					</div>
				</div>
			</div>
<div style="display: none">
			

		</div>
		
<script type="text/javascript">
function MenuSwitch(className){		
	this._elements = [];
	this._default = -1;
	this._className = className;
	this._previous = false;
}
MenuSwitch.prototype.setDefault = function(id){
	this._default = Number(id);
}
MenuSwitch.prototype.setPrevious = function(flag){
	this._previous = Boolean(flag);
}
MenuSwitch.prototype.collectElementbyClass = function(){
	this._elements = [];
	var allelements = document.getElementsByTagName("div");
	for(var i=0;i<allelements.length;i++){
		var mItem = allelements[i];
		if (typeof mItem.className == "string" && mItem.className == this._className){
			var h3s = mItem.getElementsByTagName("h3");
			var uls = mItem.getElementsByTagName("ul");
			if(h3s.length == 1 && uls.length == 1){
				h3s[0].style.cursor = "hand";					
				if(this._default == this._elements.length){
					uls[0].style.display = "block";	
				}else{
					uls[0].style.display = "none";	
				}
				this._elements[this._elements.length] = mItem;
			}				
		}
	}
}
MenuSwitch.prototype.open = function(mElement){
	var uls = mElement.getElementsByTagName("ul");
	uls[0].style.display = "block";
}
MenuSwitch.prototype.close = function(mElement){
	var uls = mElement.getElementsByTagName("ul");
	uls[0].style.display = "none";
}
MenuSwitch.prototype.isOpen = function(mElement){
	var uls = mElement.getElementsByTagName("ul");		
	return uls[0].style.display == "block";
}
MenuSwitch.prototype.toggledisplay = function(header){
	var mItem;
	if(window.addEventListener){
		mItem = header.parentNode;
	}else{
		mItem = header.parentElement;
	}
	if(this.isOpen(mItem)){
		this.close(mItem);
	}else{
		this.open(mItem);
	}		
	if(!this._previous){
		for(var i=0;i<this._elements.length;i++){
			if(this._elements[i] != mItem){				
				var uls = this._elements[i].getElementsByTagName("ul");
				uls[0].style.display = "none";		
			}
		}
	}
}	
MenuSwitch.prototype.init = function(){		
	var instance = this;
	this.collectElementbyClass();
	if(this._elements.length==0){
		return;
	}
	for(var i=0;i<this._elements.length;i++){
		var h3s = this._elements[i].getElementsByTagName("h3");			
		if(window.addEventListener){
			h3s[0].addEventListener("click",function(){instance.toggledisplay(this);},false);
		}else{
			h3s[0].onclick = function(){instance.toggledisplay(this);}
		}
	}
}
</script>
<script language="javascript">
	var mSwitch = new MenuSwitch("menuDiv");
	mSwitch.setDefault(0);
	mSwitch.setPrevious(false);
	mSwitch.init();
</script>
	</body>
</html>