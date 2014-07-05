<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"			+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'queryGoodsPrice.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=basePath%>themes/common/titletab.css" rel="stylesheet"	type="text/css" />
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/of.global.100518.css">
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/esales.style.css">


<link href="<%=basePath%>/js/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath%>/js/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>js/hm/common.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.validate.min.js" charset="UTF8"></script>

<style type="text/css">
body{font-family: 	"微软雅黑",​"Arial Narrow";margin: 0;padding: 0;font-size: 10px;font-weight: 700; text-align: center;}
.tab{
	margin-top:0px;
	padding-top:20px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
	min-height: 350px;overflow:auto;
}
.form .submit {
	MARGIN-BOTTOM: 1px
}
.form .submit {
	PADDING-BOTTOM: 8px; PADDING-LEFT: 210px; PADDING-RIGHT: 0px; PADDING-TOP: 8px
}
#game_cz ul li a{color: red}

.apDiv1 {
	padding:10px 20px 10px 20px;
	min-height: 335px;
}
#TabbedPanelsContentGroup ul{padding :0;margin:0;list-style:inside decimal;}/*white-space:nowrap;*/
#TabbedPanelsContentGroup ul li {
	margin: 0px;
	padding:0; 
	width: 140px;
	height: 25px;
	vertical-align: middle;
	float: left;
	
  white-space:nowrap;    
      text-overflow:ellipsis;     
      -o-text-overflow:ellipsis;     
      overflow: hidden;  
}
	
#TabbedPanelsContentGroup ul li a{
	text-align: left;
	padding: 2px 0;
}
.TabbedPanels ul li{
	margin: 0;
	padding:0; }
.error{font: 13px;}
.gmlist{
border-top: 1px solid  #dadada;
border-left: 1px solid  #dadada;
border-right: 1px solid  #dadada;
 min-height:100px;
    height:auto !important;
    height:100px;
padding: 3px 3px;
}
.gmlist li  { margin:5px 5px; }
.gmlist ul li { margin-top: 10px;margin-left: 10px;float: left;white-space:nowrap;font-size: 14px; }
.game01 ul li{border: 0px solid red;margin-left: 0px;}
</style>


<script type="text/javascript">
$( document ).ready(function() {
	parent.resetTime();    
});


//------games
function gameCzAjax(params){
		
params =(encodeURI(params));
	$.ajax({
		url:'goodsSales/games/gameInfo.do?'+params,
		dataType:'json',
		type:'post',
		success:function(datas){
			if(datas.retcode==1){
				alert(datas.message);
			}else{
				attributes = datas.data;
				test(attributes);
			}
		},
		error:function(e){
			alert("游戏商品加载出错"+e.status)
		}
	});
}
 
 
function getGoodsContentTbl(){
	$.ajax({
		url:'goodsSales/games/getGoodsContentTbl.do',
		dataType:'json',
		type:'post',
		success:function(datas){	
		if(datas.retcode==1){
			alert(datas.message);
		}else{
			var arr = datas.data;
	
			var common = $(".common");
			common.html('');
		
			var games ="<ul>";
		
			var contentOften=arr.contentOften;
			var game1=arr.a;
			var game2=arr.b;
			var game3=arr.c;
			var game4=arr.d;
			var game5=arr.e;
			var game6=arr.f;
			var game7=arr.j;
			var game8=arr.h;
			for ( var i = 0; i < contentOften.length; i++) {
				games += "<li><a href=javascript:void(0) onclick=setChargeGame('"+contentOften[i].id+"')>"+contentOften[i].name+"</a></li>";
			}
			common.html(games+"</ul>");
		
			
			for(var i=1 ;i<=8;i++){
				var game = $(".game0"+i);
				game.html('');
				var gameName ="";
				if(i==1){
					gameName = game1;
				}else if(i==2){
					gameName = game2;
				}else if(i==3){
					gameName = game3;
				}else if(i==4){
					gameName = game4;
				}else if(i==5){
					gameName = game5;
				}else if(i==6){
					gameName = game6;
				}else if(i==7){
					gameName = game7;
				}else if(i==8){
					gameName = game8;
				}
				var game_list ="<ul>";
				for ( var j = 0; j < gameName.length; j++) {
					var name = gameName[j].name;
						game_list += "<li><a href=javascript:void(0) onclick=setChargeGame('"+gameName[j].id+"')>"+ $.trim(name)+"</a></li>";
				}
				game.html(game_list+"</ul>");
			}
			
			
		}
		},
		error:function(e){
			alert("游戏列表加载出错："+e.status);
		}
	});
}
function setChargeGame (id){
	$.ajax({
		url:'goodsSales/games/getGameGoods.do',
		dataType:'json',
		type:'post',
		data:{goodsContentId:id},
		success:function(datas){
			if(datas.retcode==2){
				var gmlist = $('.gmlist');
				gmlist.html('');
				gmlist.append("<li><label>"+datas.message+"</label></li>");
			}else{
				var arr =  datas.data;
				var gmlist = $('.gmlist');
				gmlist.html('');
					gmlist.append("<ul  style='list-style: none;margin: 0px;padding: 0px;'>");
					var li = "float: left;background-color: #ccd;margin: 0px 20px 10px 0px;";
				$.each(arr,function(i,att){
					var params = "goodsCode="+att.goodsCode;
					gmlist.append("<li style='"+li+"'><label>"+att.goodsName+":"+att.parValue/100+"元&nbsp;<a href=goodsSales/games/gameInfo.do?"+params+" target=main title="+att.goodsName+" style=color:red  >充值</a></label></li>");
				})
					gmlist.append("</ul>");
			}
		},
		error:function(e){
			alert("游戏商品加载出错"+e.status)
		}
	});
}
 getGoodsContentTbl();
 

</script>
<style type="text/css">
.main{
position: absolute;
top: 0;left: 0px;
clear: both;
}

.TabbedPanelsTabGroup {
	margin:0px;
	padding: 0px;
	border: 1;
	border-color: red;
}
#TabbedPanels1 .TabbedPanelsTabGroup li{
padding: 2 8px;
}
</style>
</head>
<body >
	<div id="wrapper" style="width: auto">

		<div id="container">
			<div class="block" style="padding-top: 0;">

				<div id="wrap" style="width: 100%">
					<div id="body" style="margin-top: 0;">
						<div class="main" style="overflow: hidden; width: 100%;">
							<div id="tabCot_product" style="width: 100%;clear: both;height: auto;">
								<div class="tabContainer" >
									<ul class="tabHead" id="tabCot_product-li-currentBtn-">
										<li class="currentBtn"><a href="javascript:void(0)"
											title="游戏充值" rel="1">游戏充值</a></li>
									</ul>
								</div>
								<div  class="tab" >  <!--center start   -->
													<div class="apDiv1" style="">
													  <div id="TabbedPanels1" class="TabbedPanels">
													    <ul class="TabbedPanelsTabGroup">
													      <li class="TabbedPanelsTab" tabindex="0">常用 </li>
													      <li class="TabbedPanelsTab" tabindex="0">ABC</li>
													      <li class="TabbedPanelsTab" tabindex="0">DEFG</li>
													      <li class="TabbedPanelsTab" tabindex="0">HIJK</li>
													      <li class="TabbedPanelsTab" tabindex="0">LMNO</li>
													      <li class="TabbedPanelsTab" tabindex="0">PQR</li>
													      <li class="TabbedPanelsTab" tabindex="0">STU</li>
													      <li class="TabbedPanelsTab" tabindex="0">VWX</li>
													      <li class="TabbedPanelsTab" tabindex="0">YZ</li> <div style="clear: both !important"></div>
													    </ul>
													    <div class="TabbedPanelsContentGroup" id="TabbedPanelsContentGroup" style="height:300;overflow:auto;">
													      <div  class="TabbedPanelsContent common"></div> 
													      <div class="TabbedPanelsContent game01">暂无游戏</div>
													      <div class="TabbedPanelsContent game02">暂无游戏</div>
													      <div class="TabbedPanelsContent game03">暂无游戏</div>
													      <div class="TabbedPanelsContent game04">暂无游戏</div>
													      <div class="TabbedPanelsContent game05">暂无游戏</div>
													      <div class="TabbedPanelsContent game06">暂无游戏</div>
													      <div class="TabbedPanelsContent game07">暂无游戏</div>
													      <div class="TabbedPanelsContent game08">暂无游戏</div>
													    </div>
													    <div style="clear: both !important"></div>
													  </div>
													</div>    
													
									</div><!-- center end -->	 
									
									
										<div style="font-size: 14px;" class="gmlist">  			
									
										</div>	
										
								<div class="modBottom">
									<span class="modABL"></span> <span class="modABR"></span>
								</div>
							
							</div>
						</div>
					</div>
				</div>
			</div>
			
	<script type="text/javascript">
 var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
</script>
</body>
</html>
