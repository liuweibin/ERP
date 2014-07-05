<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@page import="com.erp.core.common.Constants"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
<title>1+分销系统</title>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
 <link rel="stylesheet" type="text/css" href="<%=basePath%>themes/css/mainForm.css"/>
 
<script type="text/javascript" src="<%=basePath%>js/mainForm.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/thickbox.js"></script>

<style type="text/css">
html{overflow-x:hidden}
body { margin:0px; padding:0px;margin-top:10px;   font-family: "微软雅黑","Arial Narrow";TEXT-ALIGN: center;font-size: 12px;overflow-x:hidden}
</style>
<script type="text/javascript">
var path = "${ctx}";
/*刷新余额*/	
function ajaxAccount(){
	parent.resetTime(); 
	$.ajax({
		url:path+'/account.do?name=getUserBalance',
		async:false,
		cache:false,
		dataType:'json',
		type:'post',
		success:function(data){
			$("#useableBalance").html(data.param0);
			$("#balance").html(data.param1);
			$("#bail").html(data.param2);
		},
		error:function(error){alert("余额刷新失败,请重试.:"+error.status);}
	});
}
/*刷新余额 end*/
 /*
 刷新未读消息数
 */
	function notReadMessage(){
		$.ajax({
			url:path+'/informationManage.do?type=notReadMessageQuery',
			async:false,
			cache:false,
			dataType:'json',
			type:'post',
			success:function(data){
				var mess = data.data;
				if(mess==0){
					$("#nav3").html("<a   href='<%=basePath%>informationManage.do?type=IfMessage' target='main'>我的消息</a>");
				}else{
					$("#nav3").html("<span id='message'> <a   href='javascript:void(0);' onclick='myMessage();' target='main' onmousemove='stop()' onmouseout='start()' >"+mess+"条未读</a></span>");
				}
				
			},
			error:function(error){alert("未读消息刷新失败,请重试.:"+error.status);}
		});
	}	
	function dyniframesize(down) {alert("down"+down); 
		var pTar = null; 
		if (document.getElementById){ 
			pTar = document.getElementById(down); 
		} 
		else{ 
			eval('pTar = ' + down + ';'); 
		} 
		if (pTar && !window.opera){ 
		//begin resizing iframe 
			pTar.style.display="block" 
			if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){ 
			//ns6 syntax 
				pTar.height = pTar.contentDocument.body.offsetHeight +20; 
				pTar.width = pTar.contentDocument.body.scrollWidth+20; 
			}else if (pTar.Document && pTar.Document.body.scrollHeight){ 
			//ie5+ syntax 
				pTar.height = pTar.Document.body.scrollHeight; 
				pTar.width = pTar.Document.body.scrollWidth; 
			} 
		} 
		} 
	var m = setInterval(function(){ $("#message").fadeOut(100).fadeIn(100); },800); 
		function stop(){
			clearInterval(m);
		}
		function start(){
			m = setInterval(function(){ $("#message").fadeOut(100).fadeIn(100); },800); 
		}
		function myMessage(){
		window.open("<%=basePath%>informationManage.do?type=IfMessage", "main");
		clearInterval(m);
		}
		resetTime();
</script>
</head>
    <body>
		<p id="hid_message" style="display: none; text-align: center;"></p>
    	<div class="mainFrame">
    		<div class="top">
				<div class="info">
					<div class="welcome">
						欢迎您，${session_user_data.agents.name}
					</div>
					<div class="phone">
					<c:forEach items="${list}" var="config">
						<c:choose >
						<c:when test="${config.nameEn=='Customer_Service_Hotline'}">
										${config.nameCn}:${config.value}
						</c:when>
						</c:choose>
					</c:forEach>
					</div>
				</div>
    			<div class="nav">
    				<div class="clock">
    					离线倒计时:<span id="showTimes" class="orange" style="color: orange;"></span>
    				</div>
	    			<ul>
	    				<li><span id="nav1" onclick="SwitchNav(this);"><a href="javascript:void(0);" onclick="IsExit()" >退出系统</a></span></li>
	    				<li><span id="nav2" onclick="SwitchNav(this);"><a href="<%=basePath%>user/tradePwd.do"  target="main" >安全设置</a></span></li>
	    				<li><span id="nav3" onclick="SwitchNav(this);">
	    					<c:if test="${message==0}">
	    					<a   href="<%=basePath%>informationManage.do?type=IfMessage" target="main">我的消息</a>
	    					</c:if>
   							<c:if test="${message!=0}">
	    					<span id="message"> <a   href="javascript:void(0);" onclick="myMessage();" target="main" onmousemove="stop()" onmouseout="start()">${message}条未读</a></span>
	    					</c:if>
	    					</span>
	    				</li>
	    				<li><span id="nav4" onclick="SwitchNav(this);"  class="nav_on"><a href="<%=basePath%>indexNew.jsp"  target="main">首页</a></span></li>
	    			</ul>
				</div>

    		</div>
	    	<div class="main" id="mmain">
	    			<div class="rmain">
					<div class="IFramePage" id="IFramePage" style="margin: 0;padding: 0;" >
						<iframe id="main"   width="100%"  name="main" height="1"  onload="turnHeight('main');" frameborder="0"  src="<%=basePath%>indexNew.jsp" style="display: block;" scrolling="no">  

						</iframe> 
					</div>
				</div>
	    		<div class="Lmain"><!-- Lmain -->
	    			<div class="Lmain_top"><!-- Lmain_top -->
	    				<div class="fastHandle_title title_img">
	    				<span>快捷操作</span>
	    				</div>
	    				<div class="content">
						<div class="gruop">
							<c:if test="${SYS_GH==0}">
							<div class="itemLeft " onmouseout="className='itemLeft'" onmouseover="className='itemLeft ShortcutItemOver'"
							onclick="addTap('<%=basePath%>goodsSales/mobile/2/sjczPage.do')">
								 <span class="big-icons big-icons-ghcz"></span>
								<div style="margin-top:0px;">固话充值</div>
							</div>
							</c:if>
							<c:if test="${SYS_GH!=0}">
							<div class="itemLeft ShortcutItemOverDis" ><%--onmouseout="className='itemLeft'" onmouseover="className='itemLeft ShortcutItemOver'"
							onclick="addTap('<%=basePath%>goodsSales/mobile/2/sjczPage.do')"
								--%><span class="big-icons big-icons-ghcz"></span>
								<div style="margin-top:0px;">固话充值</div>
							</div>
							</c:if>
							<c:if test="${SYS_GAMEVIEW==0}">
							<div class="itemRight " onmouseout="className='itemRight'" onmouseover="className='itemRight ShortcutItemOver'"
							onclick="addTap('<%=basePath%>goodsSales/games/gamesCZPage.do')">
								<span class="qgcz small-icons-ghkd"></span>
								<div style="margin-top:0px;">游戏充值</div>
							</div><!-- ShortcutItemOverDis -->
							</c:if>
							<c:if test="${SYS_GAMEVIEW!=0}">
								<div class="itemRight ShortcutItemOverDis">
								<span class="qgcz small-icons-ghkd"></span>
								<div style="margin-top:0px;">游戏充值</div>
							</div> 
							
							</c:if>
						</div>
						<div class="gruop">
							<c:if test="${SYS_PHONEVIEW==0}">
								<div class="itemLeft " onmouseout="className='itemLeft'" onmouseover="className='itemLeft ShortcutItemOver'"
								onclick="addTap('<%=basePath%>goodsSales/mobile/0/sjczPage.do')">
									<span class="big-icons big-icons-qgcz"></span>
									<div style="margin-top:0px;">话费充值</div>
								</div>
							</c:if>
							<c:if test="${SYS_PHONEVIEW!=0}">
								<div class="itemLeft ShortcutItemOverDis" >
									<span class="big-icons big-icons-qgcz"></span>
									<div style="margin-top:0px;">话费充值</div>
									</div>
							</c:if>
							<c:if test="${SYS_QQVIEW==0}">
							<div class="itemRight " onmouseout="className='itemRight'" onmouseover="className='itemRight ShortcutItemOver'"
							onclick="addTap('<%=basePath%>goodsSales/games/gameInfo.do?goodsCode=qq')"><%--ShortcutItemOverDis
								--%><span class="big-icons big-icons-qbzc"></span>
								<div style="margin-top:0px;">Q币充值</div>
							</div>
							</c:if>
							<c:if test="${SYS_QQVIEW!=0}">
							<div class="itemRight ShortcutItemOverDis"> 
								 <span class="big-icons big-icons-qbzc"></span>
								<div style="margin-top:0px;">Q币充值</div>
							</div>
							</c:if>
						</div>
						</div>
	    			</div><!-- Lmain_top -->
					<div class="Lmain_middle"><!-- Lmain_middle -->
							<div class="funMenuTitle title_img">
								<span>功能菜单</span>
							</div>
							<div class="menu_nav">
							
							
							 <ul id="ulFirst">  
								<c:forEach items="${resources}" var="data"> 
									<c:if test="${data.pid=='0'}">
									<li class="first">
									<a href="javascript:void(0)"><span class="small-icons small-icons-czjf">${data.remark}</span></a> 
												<ul>
													<c:forEach items="${resources}" var="data2"> 
														<c:if test="${data.id==data2.pid}">  
														<c:if test="${data2.name=='agentRegister'}">
															<c:if test="${agentsLevel ne maxLevel}">
														       <li class="first">
																	<a href="javascript:void(0)" onclick="addTap('${ctx}${data2.url}')"  title="${data2.remark}">
																	<span class="small-icons small-icons-czjf">${data2.remark}</span>
																	</a>
																</li>
														  </c:if>
														
														</c:if>
														
															<c:if test="${data2.name!='agentRegister'}">
																<li class="first">
																	<a href="javascript:void(0)" onclick="addTap('${ctx}${data2.url}')"  title="${data2.remark}">
																	<span class="small-icons small-icons-czjf">${data2.remark}</span>
																	</a>
																</li>
															</c:if>	
																
														</c:if>
													</c:forEach>
												</ul>
									</li>
									</c:if>
								</c:forEach>
							</ul><!-- 
							 
								<ul id="ulFirst">  
									<li class="first">
										<a href="javascript:void(0)">
										<span class="small-icons small-icons-czjf">充值缴费</span>
										</a> 
										<ul>
											<li class="first">
												<a href="javascript:void(0)" onclick="addTap('./index.html')">
												<span class="small-icons small-icons-czjf">充值缴费</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)" onclick="addTap('./index.html')">
												<span class="small-icons small-icons-qbyx">Q币游戏</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)" onclick="addTap('./index.html')">
												<span class="small-icons small-icons-zhgl">账户管理</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)" onclick="addTap('./index.html')">
												<span class="small-icons small-icons-xtgl">系统管理</span>
												</a>
											</li>
										</ul> 
									</li>
									<li class="first">
										<a href="javascript:void(0)">
										<span class="small-icons small-icons-qbyx">Q币游戏</span>
										</a>
										<ul>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-czjf">充值缴费</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-qbyx">Q币游戏</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-zhgl">账户管理</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-xtgl">系统管理</span>
												</a>
											</li>
										</ul> 
									</li>
									<li class="first">
										<a href="javascript:void(0)">
										<span class="small-icons small-icons-zhgl">账户管理</span>
										</a>
										<ul>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-czjf">充值缴费</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-qbyx">Q币游戏</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-zhgl">账户管理</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-xtgl">系统管理</span>
												</a>
											</li>
										</ul> 
									</li>
									<li class="first">
										<a href="javascript:void(0)">
										<span class="small-icons small-icons-xtgl">系统管理</span>
										</a>
										<ul>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-czjf">充值缴费</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-qbyx">Q币游戏</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-zhgl">账户管理</span>
												</a>
											</li>
											<li class="first">
												<a href="javascript:void(0)">
												<span class="small-icons small-icons-xtgl">系统管理</span>
												</a>
											</li>
										</ul> 
									</li>
								</ul>	-->
							</div>
					</div><!-- Lmain_middle -->
					<div class="Lmain_bottom"><!-- Lmain_bottom -->
						 <div class="CSTab">
						 		<div id="nav5" class="on" onclick="SwitchPanel(this)">联系我们</div>
						 		<div id="nav6" class="boxcontent"  onclick="SwitchPanel(this)" >我的钱包</div>
						 </div>
						 <div id ="lxkf" class="cs" style="display: block;">
							<c:forEach items="${list}" var="config">
								<c:choose >
								<c:when test="${config.nameEn=='Join_Hotline'}">
								<div class="kf_list"><span class="kc">${config.nameCn}:${config.value}</span></div>
								</c:when>
								<c:when test="${config.nameEn=='qq'}">
								<div class="kf_list"><span class="kc">${config.nameCn}:${config.value}</span></div>
								</c:when>
								<c:when test="${config.nameEn=='National_Hotline'}">
								<div class="kf_list"><span class="sh" >${config.nameCn}:${config.value}</span></div>
								</c:when>
								</c:choose>
						   </c:forEach>
						 </div>
						 <div id="myaccountinfo" class="cs" style="display: none;text-align: left;">
							<ul style="line-height:27px;padding-left: 4px;">
							<li><strong >钱包余额： <span id="balance">${balance}</span> 元</strong></li>
							<li><strong >可用额度：<span id="useableBalance">${useableBalance}</span> 元</strong></li>
							<li><strong >冻结资金：<span  id="bail">${bail}</span> 元</strong>[<a  onclick="ajaxAccount();" href="javascript:void(0)">刷新</span>]</li>
							</ul>
						 </div>
					</div><!-- Lmain_bottom -->
	    		</div><!-- Lmain -->

	    	</div>

		</div>
    </body>
</html>
