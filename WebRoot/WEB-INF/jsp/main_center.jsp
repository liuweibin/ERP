<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'mian_center.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/base-e.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>themes/sales/home/esales.style.css"/>

<style type="text/css">
<!--
.border_line{ border-style:double; border-width:1px; border-color:#CCCCCC;padding:4px;}
-->
.pusht{margin-top:0px;}
.pushr{margin-right:10px;}
.pushb{margin-bottom:10px;}
.pushl{margin-left:10px;}

.sales-down{
width:10px;
background:url(./images/icon_saleDown.jpg) no-repeat ;
display:inline-block;
height:10px;
vertical-align:middle;
margin-right:7px;
}
 .sales-up{
width:10px;
background:url(./images/icon_saleUp.jpg) no-repeat ;
display:inline-block;
height:10px;
vertical-align:middle;
margin-right:7px;
}

/*
图片切换样式   开始
*/
.container, .container *{margin:0; padding:0;}

.container{width:100%; height:168px; overflow:hidden;position:relative;}

.slider{position:absolute;}
.slider li{ list-style:none;display:inline;}
.slider img{ width:100%; height:168px; display:block;}


.num{ position:absolute; right:5px; bottom:5px;}
.num li{
	float: left;
	color: #FF7300;
	text-align: center;
	line-height: 16px;
	width: 16px;
	height: 16px;
	font-family: Arial;
	font-size: 12px;
	cursor: pointer;
	overflow: hidden;
	margin: 3px 1px;
	border: 1px solid #FF7300;
	background-color: #fff;
}
.num li.on{
	color: #fff;
	line-height: 21px;
	width: 21px;
	height: 21px;
	font-size: 16px;
	margin: 0 1px;
	border: 0;
	background-color: #FF7300;
	font-weight: bold;
}
/*
图片切换样式   结束
*/
</style>
 <script type="text/javascript" language="javascript" src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>


 <script type="text/javascript"> 
 function reflash()
 {
 window.parent.window.location.reload();
 }
$(document).ready(function(){
	//$("#showprice").html('<div style="line-height:50px;height:50px;text-align:center;">正在加载...</div>');	
 	$.ajax({
       type: "post",
       dataType: "json",
       url: 'announcementTbl/getPriceAdjust.do?tenOrAll=ten',
       timeout:30000,
       error: function (xmlHttpRequest, error) {
                       $("#showprice").html('<div class="red">查询出错，请刷新后重试！</div>');
                 },
	   success:function(json) {	    			
    	  if(json.result=='ok'){
    	  
    	  
    	  	var ullist = '<ul>';
    	  	
			$.each(json.data,function(index,priceinfo){
					
				ullist += '<li><cite>';
				ullist += priceinfo.createTime;
				ullist += '</cite>';
				ullist += priceinfo.upOrDown=='down' ? '<image src="./images/icon_saleDown.jpg"></image>' 
					: '<image src="./images/icon_saleUp.jpg"></image>';
				ullist += priceinfo.content;
				ullist+='<s>'+priceinfo.oldPrice+'</s>';
				ullist+='/<Strong style="color: red">'+priceinfo.newPrice+'</Strong>';
				ullist += '</li>';
			});
			
			ullist += '</ul>';
			if ( ullist == '<ul></ul>' ) {
				ullist = '暂时没有公告';
			}
			
			$("#showprice").html(ullist);
		  }			
        }//end success
     });//end ajax	
     
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
				ullist += '</cite><a href=\"javascript:window.open(\'<%=basePath%>announcementTbl/getDetail.do?id='+announcement.id+'\')\" onclick=\"reflash();\">';
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
</script>
 
  </head>
  
  
<body>
<div>
<div id="main-left" style="width:auto;height: 180px;margin-right: 290px;">
	<div style="overflow:scroll;  border: 1px solid #dadada;text-align: center;overflow-x: hidden;overflow-y: hidden;"><!-- picture-new -->
			<div class="container" id="idTransformView">
			  <ul class="slider" id="idSlider">
			     <li><img src="<%=basePath%>images/advertisement/01.jpg"/></li>
			    <li><img src="<%=basePath%>images/advertisement/02.jpg"/></li>
			    <li><img src="<%=basePath%>images/advertisement/03.jpg"/></li>
			  </ul>
			  <ul class="num" id="idNum">
			    <li>1</li>
			    <li>2</li>
			    <li>3</li>
			  </ul>
			</div>
	</div><!-- picture-end -->
		<div id="main-content2" style="width: 100%;height: 200px;border: 0px solid red;margin-top: 10px;">
	 		<div class="head">
				<span class="action" style="margin: -5px,0px,8px,0px;"><a href="announcementTbl/getAll.do" >更多</a></span><h2 class="clearfix push-top"><span>平台公告</span></h2>
			</div>
		
			<div class="news-list" id="showAnnouncement">
	
			</div><!-- news-list end -->
			<div class="head pusht">
				<span class="action" style="margin: -5px,0px,8px,0px;"><a href="announcementTbl/getMorePriceAdjust.do">更多</a></span>
				<h2 class="clearfix push-top"><span>商品调价公告</span></h2>
			</div>
			
			<div id="showprice" class="news-list">
				
			</div>
		</div>
</div><!-- main-left end -->
<div id="main-right" style="width:250px;float: right;overflow:auto; ">
		<div class="safe pusht pushb" style="width: 100%; ">
		<ul class="formul spread" style="width: auto;">
		  
			<li class="center"><strong>您有${day}天未修改密码</strong><a href="<%=basePath%>account.do?type=editPwd" target="main" style="margin-left:5px;">修改</a></li>
			
			<li><label>上次登录IP：</label><strong class="orange">${loginIp}</strong></li>
			<li><label>上次登录时间：</label><strong class="orange">${loginTime}</strong></li>
			<li><label>PC 绑定：</label>
				<c:if test="${'0' eq bindType}">
					<span class="red">未绑定</span>
				</c:if>
				<c:if test="${'0' ne bindType}">
					<span class="red">已绑定</span>
				</c:if>
				<a href="<%=basePath%>user/safeBound.do" target="main">设置</a>
			</li>
			 
			<li><label>手机绑定：</label>
				<c:if test="${'0' eq mobileBindType}">
					<span class="red">未绑定</span>
				</c:if>
				<c:if test="${'0' ne mobileBindType}">
					<span class="red">已绑定</span>
				</c:if>
				
				<a href="<%=basePath%>user/safeBound.do" target="main">设置</a>
			</li>
			
		</ul>
	</div>
</div>
</div>
</body>

<script type="text/javascript">
//图片切换js  开始
var O = function (id) {
	return "string" == typeof id ? document.getElementById(id) : id;
};

var Class = {
  create: function() {
	return function() {
	  this.initialize.apply(this, arguments);
	}
  }
}

Object.extend = function(destination, source) {
	for (var property in source) {
		destination[property] = source[property];
	}
	return destination;
}

var TransformView = Class.create();
TransformView.prototype = {
  //容器对象,滑动对象,切换参数,切换数量
  initialize: function(container, slider, parameter, count, options) {
	if(parameter <= 0 || count <= 0) return;
	var oContainer = O(container), oSlider = O(slider), oThis = this;

	this.Index = 0;//当前索引
	
	this._timer = null;//定时器
	this._slider = oSlider;//滑动对象
	this._parameter = parameter;//切换参数
	this._count = count || 0;//切换数量
	this._target = 0;//目标参数
	
	this.SetOptions(options);
	
	this.Up = !!this.options.Up;
	this.Step = Math.abs(this.options.Step);
	this.Time = Math.abs(this.options.Time);
	this.Auto = !!this.options.Auto;
	this.Pause = Math.abs(this.options.Pause);
	this.onStart = this.options.onStart;
	this.onFinish = this.options.onFinish;
	
	oContainer.style.overflow = "hidden";
	oContainer.style.position = "relative";
	
	oSlider.style.position = "absolute";
	oSlider.style.top = oSlider.style.left = 0;
  },
  //设置默认属性
  SetOptions: function(options) {
	this.options = {//默认值
		Up:			true,//是否向上(否则向左)
		Step:		5,//滑动变化率
		Time:		10,//滑动延时
		Auto:		true,//是否自动转换
		Pause:		2000,//停顿时间(Auto为true时有效)
		onStart:	function(){},//开始转换时执行
		onFinish:	function(){}//完成转换时执行
	};
	Object.extend(this.options, options || {});
  },
  //开始切换设置
  Start: function() {
	if(this.Index < 0){
		this.Index = this._count - 1;
	} else if (this.Index >= this._count){ this.Index = 0; }
	
	this._target = -1 * this._parameter * this.Index;
	this.onStart();
	this.Move();
  },
  //移动
  Move: function() {
	clearTimeout(this._timer);
	var oThis = this, style = this.Up ? "top" : "left", iNow = parseInt(this._slider.style[style]) || 0, iStep = this.GetStep(this._target, iNow);
	
	if (iStep != 0) {
		this._slider.style[style] = (iNow + iStep) + "px";
		this._timer = setTimeout(function(){ oThis.Move(); }, this.Time);
	} else {
		this._slider.style[style] = this._target + "px";
		this.onFinish();
		if (this.Auto) { this._timer = setTimeout(function(){ oThis.Index++; oThis.Start(); }, this.Pause); }
	}
  },
  //获取步长
  GetStep: function(iTarget, iNow) {
	var iStep = (iTarget - iNow) / this.Step;
	if (iStep == 0) return 0;
	if (Math.abs(iStep) < 1) return (iStep > 0 ? 1 : -1);
	return iStep;
  },
  //停止
  Stop: function(iTarget, iNow) {
	clearTimeout(this._timer);
	this._slider.style[this.Up ? "top" : "left"] = this._target + "px";
  }
};

window.onload=function(){
	function Each(list, fun){
		for (var i = 0, len = list.length; i < len; i++) { fun(list[i], i); }
	};
	
	var objs = O("idNum").getElementsByTagName("li");
	
	var tv = new TransformView("idTransformView", "idSlider", 168, 3, {
		onStart : function(){ Each(objs, function(o, i){ o.className = tv.Index == i ? "on" : ""; }) }//按钮样式
	});
	
	tv.Start();
	
	Each(objs, function(o, i){
		o.onmouseover = function(){
			o.className = "on";
			tv.Auto = false;
			tv.Index = i;
			tv.Start();
		}
		o.onmouseout = function(){
			o.className = "";
			tv.Auto = true;
			tv.Start();
		}
	})
	
}
//图片切换js  结束
</script>
</html>