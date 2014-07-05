<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
#showprice li{ width: 450px}
#showAnnouncement li{ width: 450px}
</style>
</head>
<body>
<div class="main">
<script type="text/javascript">
$(function(){
	showAnnouncement();
	showprice();
});

function showAnnouncement(){
	$.ajax({
	    type: "post",
	    dataType: "json",
	    url: '<%=basePath%>announcementTbl/getTopTenAnnouncement.do',
	    timeout:30000,
	    error: function (xmlHttpRequest, error) { 
	                    $("#showAnnouncement").innerHTML= "<p style='text-align:center;border:0;>查询出错，请刷新后重试！</p>"
	              },
		   success:function(json) {	    			
	 	  if(json.result=='ok'){
	 	  	var ullist = '';
				$.each(json.data,function(index,announcement){
					ullist += '<li><a href=\"<%=basePath%>announcementTbl/getDetail.do?id='+announcement.id+'\" target=\"_blank\">';
					ullist += announcement.title
					var time=announcement.createTime;
					ullist += '</a> <cite>'+time.substring(0, 10)+'</cite> </li>';
				});
				
				if ( ullist == '' ) {
					ullist = "<p style='text-align:center;border:0;'>暂时没有公告</p>";
				}
			
				$("#showAnnouncement").html(ullist);
			  }			
	     }//end success
	  });//end ajax	
}

function showprice(){
 $.ajax({
      type: "post",
      dataType: "json",
      url: '<%=basePath%>announcementTbl/getPriceAdjust.do?tenOrAll=ten',
      timeout:30000,
      error: function (xmlHttpRequest, error) {
                      $("#showprice").html("<p style='text-align:center;border:0;>查询出错，请刷新后重试！</p>");
                },
	   success:function(json) {	    			
   	  if(json.result=='ok'){
   	  	var ullist = '';
			$.each(json.data,function(index,priceinfo){
					var time=priceinfo.createTime;
				ullist += "<li>";
				ullist += priceinfo.upOrDown=="down" ? "<image src='<%=basePath%>/images/icon_saleDown.jpg'></image>" : "<image src='<%=basePath%>/images/icon_saleUp.jpg'></image>";
					ullist += priceinfo.content;
					ullist+="<s>"+priceinfo.oldPrice+"</s>";
				ullist += "<Strong style='color: red'>"+priceinfo.newPrice+"</Strong> <cite>"+time.substring(0, 10)+"</cite></li>";
			});
			if ( ullist == '' ) {
				ullist = "<p style='text-align:center;border:0;'>暂时没有公告</p>";
			}
			
			$("#showprice").html(ullist);
		  }			
       }//end success
    });//end ajax	
}
	
</script>
<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
       
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
        <div class="banner" id="idTransformView2">
          <ul class="slider slider2" id="idSlider2">
            <li><img src="<%=basePath%>images/images/banner_1.jpg" width="992" height="400" /></li>
            <li><img src="<%=basePath%>images/images/banner_2.jpg" width="992" height="400" /></li>
            <li><img src="<%=basePath%>images/images/banner_3.jpg" width="992" height="400" /></li>
            <li><img src="<%=basePath%>images/images/banner_4.jpg" width="992" height="400" /></li>
          </ul>
          <ul class="num" id="idNum2">
            <li>1</li>
            <li>2</li>
            <li>3</li>
            <li>4</li>
         </ul>
        </div>
        <script type="text/javascript">
var $$ = function (id) {
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
	var oContainer = $$(container), oSlider = $$(slider), oThis = this;
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
		Up:	true,//是否向上(否则向左)
		Step:	5,//滑动变化率
		Time:	10,//滑动延时
		Auto:	true,//是否自动转换
		Pause:	2000,//停顿时间(Auto为true时有效)
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
	var objs = $$("idNum2").getElementsByTagName("li");
	var tv = new TransformView("idTransformView2", "idSlider2", 992, 4, {
		onStart: function(){ Each(objs, function(o, i){ o.className = tv.Index == i ? "on" : ""; }) },//按钮样式
		Up: false
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
</script>

        <div class="newsBox"><%--
          <div class="newsnr" style="padding-left:15px;">
            <h1><span><a href="#">更多>></a></span>[ 最新通知 ]</h1>
            <ul>
              <li><a href="#">让你更轻松地浏览与管理你的音乐、视频及更多</a></li>
              <li><a href="#">全新 iTunes 已经完全重新设计</a></li>
              <li><a href="#">添加至你的收藏，随时随地播放。添加至你</a></li>
              <li><a href="#">让你更轻松地浏览与管理你的音乐、视频及更多</a></li>
              <li><a href="#">全新 iTunes 已经完全重新设计</a></li>
            </ul>
          </div>
          --%>
          <div class="newsnr" style="width: 450px">
            <h1 style="width: 450px"><span><a href="<%=basePath%>jsp/newsAnnouncement.jsp">更多>></a></span>[ 平台公告 ]</h1>
            <ul id="showAnnouncement" style="width: 450px">
            <%--
              <li><a href="#">让你更轻松地浏览与管理你的音乐、视频及更多</a></li>
              <li><a href="#">全新 iTunes 已经完全重新设计</a></li>
              <li><a href="#">添加至你的收藏，随时随地播放。添加至你</a></li>
              <li><a href="#">让你更轻松地浏览与管理你的音乐、视频及更多</a></li>
              <li><a href="#">全新 iTunes 已经完全重新设计</a></li>
            --%></ul>
          </div>
          <div class="newsnr" style="border-right:none; padding-right:0px;width: 450px;">
            <h1 style="width: 450px"><span><a href="<%=basePath%>jsp/newsAnnouncementAdjust.jsp">更多>></a></span>[ 商品调价通知 ]</h1>
            <ul id="showprice" style="width: 450px"><%--
              <li><a href="#">让你更轻松地浏览与管理你的音乐、视频及更多</a></li>
              <li><a href="#">全新 iTunes 已经完全重新设计</a></li>
              <li><a href="#">添加至你的收藏，随时随地播放。添加至你</a></li>
              <li><a href="#">让你更轻松地浏览与管理你的音乐、视频及更多</a></li>
              <li><a href="#">全新 iTunes 已经完全重新设计</a></li>
            --%></ul>
          </div>
        </div>
      </div>
    </div>
    <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
