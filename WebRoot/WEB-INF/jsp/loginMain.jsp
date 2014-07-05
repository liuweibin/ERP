<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
  
    <base href="<%=basePath%>"/>
    
    <title>1+登录首页</title>
    
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
	<meta http-equiv="description" content="This is my page"/>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

 <link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/base-e.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.style.css"/>

	<style type="text/css">
</style>
 <script type="text/javascript" language="javascript" src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
 <script type="text/javascript"> 
$(document).ready(function(){
	$("#showAnnouncement").html('<div style="line-height:50px;height:50px;text-align:center;">正在加载...</div>');	
		
 	$.ajax({
       type: "post",
       dataType: "json",
       url: 'announcementTbl/getTopTenAnnouncement.do',
       timeout:30000,
       error: function (xmlHttpRequest, error) {
                       $("#showAnnouncement").html('<div class="red">查询出错，请刷新后重试！</div>');
                 },
	   success:function(json) {	    			
    	  if(json.result=='ok'){
    	  
    	  
    	  	var ullist = '<ul>';
    	  	
			$.each(json.data,function(index,announcement){
					
				ullist += '<li><cite>';
				ullist += announcement.createTime;
				ullist += '</cite><a href=\"announcementTbl/getDetail.do?id='+announcement.id+'\" target=\"main\">';
				ullist += announcement.title
				ullist += '</a></li>';
			});
			
			ullist += '</ul>';
			if ( ullist == '<ul></ul>' ) {
				ullist = '暂时没有公告';
			}
			
			$("#showAnnouncement").html(ullist);
		  }			
        }//end success
     });//end ajax	
 
});


$(function(){ $('a').click(function(){ var link=this.href+'?'+'fileName=vgss.apk'; window.open(link); return false; }); });
</script>
  </head>
  
  <body>

		<div id="container">
			<div class="topmain">
				<div class="top-left">
					您好，欢迎来到1+分级销售平台
				</div>
				<div class="top-right">
					<a href="#" target="_blank">帮助中心</a>|
					<a href="#" target="_blank">1+分级销售平台网</a>
				</div>
			</div>
		</div>
		<div id="toptitle">
			<div id="logo">
				<a	href="#">经销商平台</a>
			</div>
			<div id="logotitle">
				<div id="logotitle1" align="left">
					<span>xx</span>经销商平台
				</div>
			</div>
		</div>
		<!-- 页头 -->

		<div id="main" align="center">
			<div class="main-left">
				<div class="lmleft">
					<!--代理商登录  -->
					<div class="yhdl" style="margin-bottom: 10px">
						<div class="head font14px1">
							代理商登录
						</div>

						<div class="login_bg" align="center">
							<iframe	style="height: 264px; margin: 0px; padding: 0px; width: 100%;"
								frameborder="0" scrolling="no"  src="user/new_login.do"></iframe>
						</div>
					</div>
					<!--常见问题  -->
					<div class="cjwt" >
						<div class="head">
							常见问题
						</div>
						<div class="login_bg" style="padding-bottom: 0px; height: 200px; border-bottom-width: 3px;" >
							<ul>
								<li>
									<a href="#"
										target="_blank">·如何使用手机登录？ </a>
								</li>
								<li> 
									<a href="javascript:void(0)" title="扫描下载手机客户端"><img src="<%=basePath%>images/vgss-mobel.png" /></a>
								</li>
								<li>
										<a style="font-size:30 ;" href="fileOperate/download.do"  target="blank">
											手机客户端下载
											</a>
								</li>
							</ul>
						</div>
					</div>
					<!--常见问题  -->
				</div>
				<div class="lmright">
					<!--首页图片  -->
					<div id="mainbanner">
						<iframe frameborder="0" width="504" height="180"
							src="user/login_top.do">
						</iframe>
					</div>
					<!--首页图片  -->
					<!-- 公告 -->
					<div class="ofgg">
						<div class="gghead">
							<h1>
								<span>平台公告</span>
							</h1>
						</div>
						<div class="news-list" style="overflow:scroll; width:500px; height:160px" id="showAnnouncement">
				
						</div>
					</div>
					<div class="zxxt" >
						<div class="gghead" >
							<h1>
								<span>1+平台简介</span>
							</h1>
						</div>
						<div class="nr" style="overflow:scroll;text-align:left;width:490px; height:100px" >
						<samp style="text-align: left">&nbsp;&nbsp;
						１＋系统是一套为地区一级代理商量身定做的销售管理系统，
						系统包含了供货商管理、经销商管理、客户管理、商品管理、
						价格管理、财务管理、虚拟货币管理、权限管理、信息平台
						管理等等，是一套网络分级销售的综合管理系统。
						<br/>
						&nbsp;&nbsp;１＋系统基于云平台开发，用户可以很方便地根据实际经营
                                                              情况随时调整配置，以达到系统地最高性价比。
                            </samp>
                        </div>

					</div>
				</div>
				<div class="jmlc">
					<div class="gghead">
						<h1>
							<span>加盟流程示意图</span>
						</h1>
					</div>
				</div>
			</div>
			<div class="main-right">
				<div class="navlist">
					<div class="navleft"></div>
					<div class="navmid">
						<ul>
							<li>
								<a href="#" target="_blank"></a>
							</li>
							<li>
								<a href="#" target="_blank"></a>
							</li>
						</ul>
					</div>
					<div class="navrig"></div>
				</div>
				<div class="jmxx">


					<div class="head">
						加盟信息
					</div>
					<ul class="formul">
					<c:forEach items="${list}" var="config">
					<li>
					<c:choose >
					<c:when test="${config.nameEn=='qq'}">
						<a id="live800iconlink" target="_self" href="javascript:void(0)"
								onclick="">
									${config.nameCn}:${config.value}
							</a>
					</c:when>
					
					<c:otherwise>
						${config.nameCn}:${config.value}
					</c:otherwise>
					
					</c:choose>
				
					
					</li>
					</c:forEach>
						
					</ul>

				</div>
				<div class="xsxt" style="">
					<div class="head">
						1+分级销售系统
					</div>
					<ul class="formul">
						<li>
							<a href="#"><img src="<%=basePath%>images/r230-88_003.jpg"/></a>
							</a>
						</li>
						<li>
						<a href="#"><img src="<%=basePath%>images/r230-88_003.jpg"/></a>
							</a>
						</li>
					</ul>
				</div>
				<div class="qtpt">
					<div class="head">
						
					</div>
					<ul class="formul">
						<li>
							<a href="#"><img src="<%=basePath%>images/r230-88_003.jpg"/></a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 页脚 -->
		<div class="bottom">
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
						<samp style="font-size: 14px;font:large;font-weight: bolder">1+</samp>分级销售系统 V1.0
						<samp style="padding-left: 10px;">
						上海大指头网络技术有限公司
						</samp>
					</div>
				</div>
			</div>
		</div>

	</body>
</html>
