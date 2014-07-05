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

<title>游戏充值</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=basePath%>themes/common/titletab.css" rel="stylesheet"	type="text/css" />
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/of.global.100518.css">
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/esales.style.css">
<link href="<%=basePath%>themes/common/button.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>

<script type="text/javascript" src="<%=basePath%>js/jquery.md5.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>js/hm/common.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.validate.min.js" charset="UTF8"></script>
<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
<style type="text/css">
body {
	 text-align: center;margin: 0;padding: 0;
}
.tab #tabCot {
	padding: 20px 0px 10px 8px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
 .error{
 font-size: 12px;
 font-weight: 300;
 }
.form .section {
	BORDER-BOTTOM: #eaebea 1px solid;   MARGIN: 0px 1px 1px; ZOOM: 1;font-size: 20px; 
}
.section{height: 40px;vertical-align: middle;margin: auto auto;}
.form .section:after {
	DISPLAY: block; HEIGHT: 0px; VISIBILITY: hidden; CLEAR: both; CONTENT: "."
}
.form .submit {
	MARGIN-BOTTOM: 1px
}
.form .section-title {
	TEXT-ALIGN: right; WIDTH: 210px; DISPLAY: block; FLOAT: left;line-height: 40px;
}
.form .section-field {
	FLOAT: left;  height: 40px; padding-top: 5px;
}
.form .section-field  span{
display:block;
 margin-top: 8px;
}
.form .section-field  select {
display:block;
 margin-top: 5px;
 width: 80px;
 height: 25px;
}
.form .section-field input{height: 30px;line-height: 30px;}
.form .submit {
	PADDING-BOTTOM: 8px; PADDING-LEFT: 210px; PADDING-RIGHT: 0px; PADDING-TOP: 8px
}
.hidetxt{cursor:default;border: 0px solid #FF0000; }
.section-field em{color: #ff6500;font-size:20px;font-style:normal;}

.error{font: 13px;}
.center{
border:0px solid red;
min-height: 300px;
margin: 10px auto;
width: 700px;
}
#priceTip{display: inline;}
.section{
border: 0px solid red;
clear: both;
}

/*表格*/
.supplierdataTable tr td{
white-space:nowrap;overflow:hidden;
}
 tr.first{ 
     height:20px; 
     font-size:12px; 
     line-height:20px; 
   } 
   
   .ellipsis{
      white-space: nowrap;
      overflow: hidden;             
      -o-text-overflow: ellipsis;    /* Opera */
      text-overflow:    ellipsis;    /* IE, Safari (WebKit) */
}
</style>


<script type="text/javascript">
jQuery.validator.addMethod("decimal", function(value, element) {
	return this.optional(element) || /^(([1-9]\d{0,9})|0)(\.\d{1,2})?$/.test(value);
}, "请输入正确的金额");
var cache;
$( document ).ready(function() {
	parent.resetTime();    
	$("#form_").validate({
	 	rules: {
	     supperPassword: {
		    required: true,
		    minlength: 8
		   }
	   },
	   messages: {
		   supperPassword: {
		    required: "请输入密码",
		    minlength: jQuery.format("密码不能小于{0}个字符")
		   } 
	  },  submitHandler: function(form) {
			//alert("校验组1通过验证，不过我不给它提交");
		    //$(form).submit();
			creatOrder();
		  }
    });
	 queryPage();
	 var goodsCode = '${goodsCode}';
	 //var goodsContentId = '${goodsContentId}';
	 if(goodsCode){
		 gameCzAjax("goodsCode="+goodsCode);
		// setChargeGame(goodsContentId);
	 }
	 test();
	 
});
function test(){
	attributes =  ${gameForm} ; 
	var obj = eval( attributes );
	attributes = obj.data; 
	var map =  getMap();
		var sb = "";
		$('#game_name').val(attributes.goodsName);
		$('#parValue').val(attributes.parValue);
		$('#parValueTip').text(attributes.parValue);
		$('#sellPrice').val(attributes.suggestRetailPrice);
		$('#goodsCode').val(attributes.goodsCode);
		$('#batchPrice').text(attributes.batchPrice);
		$('#price').text(attributes.batchPrice+"元");
		$('#priceTip').text("("+attributes.batchPrice+"元*1)");
		var good_attributes = attributes.attribute;
		if(!good_attributes){
			return;
		}
	$.each(good_attributes,function(i,attr){
		var labelType = attr.labelType;//'标签类型（0是Input:text、1是select）',
		var display = attr.display;//'是否显示（0不显示，1显示）',
		var mapField = attr.mapField;
		var valueType = attr.valueType;// （0:默认值，1通过url，2:不给值）',
		var nameCn = attr.nameCn;
		var nameEn = attr.nameEn;
		var orderNo = attr.orderNo;
		var id = attr.id;
		var value = attr.value;
		var params = attr.params;
		var isMapping = attr.isMapping;
		map.put(orderNo,nameEn);
		var display_ = "";
		if(display==0){
			 display_ = "display:none;";
		}
			if(labelType==0){//0是Input:text
				if(valueType==0){ //（0:默认值
					sb +="<div class='section game-change' style="+display_+"><label class='section-title'>"+nameCn+"：</label><div class='section-field' id='J_section'><input type='text'  name='"+nameEn+"' class='{required:true,messages:{required:\"请输入"+nameCn+"\" }}' value='"+value+"'  autocomplete='off'/></div></div>";
				}else if(valueType==2){//，2:不给值）',
					if(nameEn=="gameAccount"){
						sb +="<div class='section game-change' style="+display_+"><label class='section-title'>"+nameCn+"：</label><div class='section-field' id='J_section'><input type='text' id='gameAccount' name='gameAccount' class='{required:true,messages:{required:\"请输入"+nameCn+"\"}}'  value=''  autocomplete='off'/></div></div>";
						sb +="<div class='section game-change hide_' style="+display_+"><label class='section-title'>确认"+nameCn+"：</label><div class='section-field' id='J_section'><input type='text'  id='confirm_gameAccount' name='confirm_gameAccount' class={required:true,equalTo:'#gameAccount',messages:{required:\"请确认"+nameCn+"\",equalTo:\"请输入相同的账户\"}}  value=''  autocomplete='off'/></div></div>";
					}else{
						sb +="<div class='section game-change' style="+display_+"><label class='section-title'>"+nameCn+"：</label><div class='section-field' id='J_section'><input type='text'  name='"+nameEn+"' class='{required:true,messages:{required:\"请输入"+nameCn+"\"}}'  value=''  autocomplete='off'/></div></div>";
					}
				}else if(valueType==1){//，1通过url
					var res = getGoodsParams(params);
					if(res.indexOf("!=")>-1){
					    sb +="<div class='section game-change'  style="+display_+"><label class='section-title'>"+nameCn+"：</label><div class='section-field' id='J_section'><input type='text' name='"+nameEn+"' onclick=listen(this,'"+value+"','"+res+"') class='{required:true,messages:{required:\"请输入"+nameCn+"\"}}' style='background-color: #f3f4f3;' readonly='readonly' value=''  autocomplete='off'/></div></div>";
					}else{
						var r_value=ajax_text(value,res);
					    sb +="<div class='section game-change'  style="+display_+"><label class='section-title'>"+nameCn+"：</label><div class='section-field' id='J_section'><input type='text' name='"+nameEn+"' onclick=listen(this,'"+value+"','"+res+"') class='{required:true,messages:{required:\"请输入"+nameCn+"\"}}' style='background-color: #f3f4f3;' readonly='readonly' value='"+r_value+"'  autocomplete='off'/></div></div>";
					}
				}
			}else if(labelType==1){//1是select
				if(valueType==0){ //（0:默认值
					sb +="<div class='section game-change'  style="+display_+"><label class='section-title'>"+nameCn+"：</label><div class='section-field' id='J_section'>";
					sb +="<select name='"+nameEn+"'  title="+nameCn+"'不能为空' class='{required:true}'  id='"+nameEn+"'  >";
					var r_value=value;
					var strs= new Array(); //定义一数组
					strs=r_value.split(","); //字符分割      
					for (i=0;i<strs.length ;i++ )    
					    {    
					sb +="<option  value='"+strs[i]+"'>"+strs[i]+"</option>";
					    } 
					sb +="</select></div></div>";
				}else if(valueType==1){//，1通过ur
					sb +="<div class='section game-change'  style="+display_+"><label class='section-title'>"+nameCn+"：</label><div class='section-field' id='J_section'>";
					var res = getGoodsParams(params);
					if(res.indexOf("!=")>-1){
						sb +="<select name='"+nameEn+"'   id='"+nameEn+"' title='"+nameCn+"不能为空' class='{required:true}'  onclick=listen(this,'"+value+"','"+res+"') >";
						sb +="<option selected='selected'  value=''>"+"请选择"+nameCn+"</option>";
					}else{
						sb +="<select name='"+nameEn+"'  title='"+nameCn+"不能为空'  class='{required:true}'  onchange=listenBuyNum(this,'"+value+"','"+res+"') id='"+nameEn+"' >";
						var r_value=ajax(value,res);
						sb +=r_value;
					}
					sb +="</select></div></div>";
				}else if(valueType==0){
					
				}
				}
				function getGoodsParams(params){//参数处理
					var result='';
					if(params=="")return result;
					var arr = new Array();
					arr = params.split(",");
					for(var i=0;i<arr.length;i++){
						var arr_param = new Array();
						arr_param = arr[i].split("=")
						if(arr_param[0]!="goodsContentId"&&arr_param[0]!="goodsCode"){
							var temp = arr_param[0]+"="+arr_param[1];
							var orderNo = arr_param[1];
							var id = map.get(orderNo);
							var value = arr_param[0]+"!="+id;
							params = params.replace(temp,value);
						}
					}
					result +=params.replace(/,/g,"&");
					return result;
				}
		});
		$("#add").html('');
		sb +="<div class='section game-change hide_'  ><label class='section-title'>交易密码：</label><div class='section-field' id='J_section'><input type='password' id='supperPassword' name='supperPassword' class='{required:true,messages:{required:\"请输入交易密码\"},minlength:8}' value=''  autocomplete='off'/></div></div>";
		$("#add").append(sb);
		displayToggle($("#game-form"),1);
	}
function listenBuyNum(o,url,params){
		if(o.id=='buyNum')select();
}
function listen(o,url,params){
		var arr_params = new Array();
		var arr_param = new Array();
		arr_params = params.split("&");
		for(var i=0;i<arr_params.length;i++){
			if(arr_params[i].indexOf("!=")>-1){
				arr_param = arr_params[i].split("!=");
			}
		}
		var value = $('#'+arr_param[1]).val();
		if(value=="")return;//父节点为空时返回
		if(value==cache){//父节点没有改变子节点不在重新加载
			if(o.id=='buyNum')select();
			return;
		}
		cache = value;
		var new_params= params.replace(arr_param[1],value);
		new_params= new_params.replace("!=","=");
		var option = ajax(url,new_params);
		$("#"+o.id).empty();
		$("#"+o.id).append(option);
		if(o.id=='buyNum')select();
		var pid='id='+arr_param[1];
		if($("#add").html().split("onchange=pListen")==-1)//判断是否已经添加了监听
		{
			var html = $("#add").html().replace(pid,pid+"  onchange=pListen(this,"+o.id+",'"+url+"','"+params+"')");//给父元素添加监听
			$("#add").html(html);
		}
}
function pListen(obj,childId,url,params){
	params = params.replace("!="+obj.id,"="+obj.value);
	var option = ajax(url,params);
	$("#"+childId.id).empty();
	if(option!="")
	$("#"+childId.id).append(option);
}
function select(){ 
	var num = $("#buyNum").val();
	var batchPrice = $("#batchPrice").text();
	var price = ((batchPrice*1000)*num)/1000;
	$("#price").text(price);
	$("#priceTip").text("元("+batchPrice+"元*"+num+")");
}
function ajax_text(url,params){
	var re="";
	$.ajax({
		url:url,
		dataType:'text',
		type:'post',
		async:false,
		data:params,
		success:function(datas){
			re = datas;
		},error:function(e){
			alert(e.status);
		}
	});
	return re;
}
function ajax(url,params){
	var re="";
	$.ajax({
		url:url,
		dataType:'json',
		type:'post',
		async:false,
		data:params,
		success:function(datas){
			var data =datas;// eval(datas);
			for(var i=0;i<data.total;i++){
				re += "<option  value='"+data.data[i].id+"'>"+data.data[i].name+"</option>"
			}
		},error:function(e){
			alert(e.status);
		}
	});
	return re;
}
function displayToggle(obj,type){
	$.each(obj,function(i,attr){
		if(type==0){
			attr.style.display='none';	
		}else if(type==1){
			attr.style.display='block';	
		}
		else{
				if(attr.style.display=='block'||attr.style.display==''){
						attr.style.display='none';	
				}else if(attr.style.display=='none'){
					var BrowseType="";
					if(getbrowse()=="MSIE"){
					    BrowseType="block";
					}
					else{
					    BrowseType="table-row";
					}
				attr.style.display=BrowseType;
			}
		}
	});
};

function creatOrder(){
	var data = $("form").serialize();
	//alert($("form").serialize());supperPassword=12345678
	//var data = $("form").serialize();
		var i = data.lastIndexOf("&")
		var sub = data.substr(i,data.length);
		var supperPassword = $("#supperPassword").val();
		data = data.replace(sub,"&supperPassword="+$.md5(supperPassword))
	$.ajax({
		url:'goodsSales/games/creatGameGoodsOrder.do',
		dataType:'json',
		async:false,
		type:'post',
		data:data,
		success:function(datas){ 
			 if(datas.retcode=="1"){
				 alert(datas.message);
			 }else{
				 var data =datas.data;
				 $("#orderCode").val(data.orderCode);
					$("div#game-form input[type='text']").addClass("hidetxt").attr("UNSELECTABLE","on");
					$("div#game-form input[type='text']").addClass("hidetxt").attr("UNSELECTABLE","on");
					reflush(2);
					displayToggle($("#btn-t1"));
					displayToggle($(".hide_"));
					displayToggle($("#form_orderCode"));
				 $("#btn-t2").show();
			 }
		},
		error:function(e){alert(e.status)}
	});
	
}
function saveOrder(){
	showMask();
	$.ajax({
		url:'goodsSales/games/saveGameGoodsOrder.do',
		dataType:'json',
		type:'post',
		timeout:"120000",
		data:$("form").serialize(),
		success:function(data){
			 if(data.retcode=="1"){
				 alert(data.message);
				 clean();
			 }else{
				 reflush(3);
					displayToggle($(".form"));
					$("#success").show();
					$("#successMessage").html(data.message);
					queryPage();
					 parent.ajaxAccount();
					 $("#mask").hide();
			 }
		},
		error:function(e){
			if(e.timeout==0){
				 reflush(3);
					displayToggle($(".form"));
					displayToggle($("#success"));
					queryPage();
					 parent.ajaxAccount();
					 $("#mask").hide();
			}else{
				alert(e.status);
				queryPage();
			}
		}
	});
	
}

function getMap() {//初始化map_,给map_对象增加方法，使map_像Map    
    var map_ = new Object();    
    map_.put = function(key, value) {    
        map_[key+'_'] = value;    
    };    
    map_.get = function(key) {    
        return map_[key+'_'];    
    };    
    map_.remove = function(key) {    
        delete map_[key+'_'];    
    };    
    map_.keyset = function() {    
        var ret = "";    
        for(var p in map_) {    
            if(typeof p == 'string' && p.substring(p.length-1) == "_") {    
                ret += ",";    
                ret += p.substring(0,p.length-1);    
            }    
        }    
        if(ret == "") {    
            return ret.split(",");    
        } else {    
            return ret.substring(1).split(",");    
        }    
    };    
    return map_;    
}  

//------games
function gameCzAjax(params){
		 reset();
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
 
 
function reset(){
	displayToggle($("#game-form"),0);
	 $("#orderCode").val('');
	 $("#form_orderCode")[0].style.display='none';
	 $("#success")[0].style.display='none';
	 reflush(1);
	$("div#game-form input[type='text']").removeClass("hidetxt").attr("UNSELECTABLE","off");
	$("div#game-form input[type='text']").removeClass("hidetxt").attr("UNSELECTABLE","off");
	displayToggle($("#btn-t1"),1);
	displayToggle($("#btn-t2"),0);
	
}
function reflush(step){
	$("#process_lc_img").attr("src","<%=basePath%>images/step/process_lc_img"+step+".jpg");
}
function load(){
	//　　parent.document.getElementById("main").style.height = window.document.body.clientHeight<800?800:window.document.body.clientHeight+"px"; 
	　　parent.document.getElementById("main").style.height ="1000px";
	
	　　parent.document.getElementById("mmain").style.height = "1000px"; 
   　} 
 function clean(){
	 var goodsCode = $("#goodsCode").val();
	  location.href="<%=basePath%>goodsSales/games/gameInfo.do?goodsCode="+goodsCode;
 }  
//兼容火狐、IE8
 function showMask(){
 	$("#mask").css("height",450);
 	$("#mask").css("width",$(document).width());
 	$("#mask").show();
 }
</script>
</head>
<body onload="load()" style="border: 0px solid red;">
<div id="mask" class="mask" style="text-align: center;z-index: 0;font-size: 30px;color: red;margin-top: 80px;line-height:450px;display: none;font-weight: 700;">订单处理中请稍后。。。</div>

							<div id="tabCot_product" class="tab" style="width: 780px;">
								<div class="tabContainer"  >
									<ul class="tabHead" id="tabCot_product-li-currentBtn-">
										<li class="currentBtn"><a href="javascript:void(0)"
											title="游戏充值" rel="1">游戏充值</a></li>
									</ul>
								</div>
								<div id="tabCot"  style="width: 770px;"><!-- tabCot start -->

									<div  class="center"><!-- center start -->
											<div style="border: 0px solid red; height: auto;">
												<div class="cz_title" style="height:30px;text-align: center;text-align: -moz-center !important;margin: 3px 100px;">
													<img alt="" id="process_lc_img" src="${path}images/step/process_lc_img1.jpg" width="100%">
												</div>
												<form action="" id="form_" style="">
												
												<input type="hidden" name="token" value="${token}" />
												<input type="hidden" name="goodsContentId" id="goodsContentId" >
												 <input type="hidden" name="goodsCode" id="goodsCode">
												 <input type="hidden"   name="parValue"   id="parValue" value=""  autocomplete="off"/>
												<div class="form game-form" id="game-form" style="display: none;width: 90%;margin: 0 auto;border: 0px solid red;">
												<div class="section game-change" style="display: none;" id="form_orderCode">
													<label class="section-title">订单号：</label>
														<div class="section-field" id="J_section">
															<input type="text" class="hidetxt" name="orderCode"   id="orderCode" value="" autocomplete="off"/>
														</div>	
												</div>
												<div class="section game-change">
													<label class="section-title">游戏名称：</label>
														<div class="section-field" id="J_section">
															  <input type="text"  name="game_name" id="game_name" value="" autocomplete="off"/>
														</div>	
												</div>
												<div class="section game-change">
													<label class="section-title">面值(元)：</label>
														<div class="section-field" id="J_section">
															<span id="parValueTip"></span>
														</div>				
												</div>
												<div class="section game-change">
													<label class="section-title">销售价格：</label>
														<div class="section-field" id="J_section">
															<input type="text"  name="sellPrice"  id="sellPrice" class='{required:true,decimal:true,messages:{required:"请输入正确金额",required:"请输入销售价格"}}'  value="100"  autocomplete="off"/>
														</div>				
												</div>
												<div class="section game-change">
													<label class="section-title">批价(元)：</label>
														<div class="section-field" id="J_section">
														<span id="batchPrice"></span>
														</div>				
												</div>
												<div id="add"></div>
												
												<div class="section game-change">
													<label class="section-title">价格：</label>
														<div class="section-field" id="J_section" style="padding-top: 10px;">
														<em id="price"></em></span><span id="priceTip"></span>
														</div>				
												</div>
													<div class="section" style="text-align: center;">
														<span class="btn btn-t1" id="btn-t1" style="display: block;padding-top: 5px;float: inherit;">
																<input type="submit" id="submit" class="Partorange" style="border: 0;" value="提交订单" >
														</span>
													</div>
													<div class="section" style="text-align: center;clear: both;">
														<span class="btn btn-t2" id="btn-t2" style="display: none;padding-top: 5px;float: inherit;">
																<input type="button" id="subbtn"  onclick="saveOrder()"  class="Partorange" value="确认充值" >
																<a  target="main" style="color: black;font-size: 12px;" onclick="clean();" href="javascript:void(0);"  >取消充值</a>
														</span>
													</div>
												</div>
												</form>
												
			<div id="success" style="border: 0px solid green;text-align: center;height:60px; display: none;">
			       <div style="height: 50px; margin-top: 100px;">
			       		<span style="border-top: 30px;"><strong style="color: red;font-size: 25px;" id="successMessage">订单成功,是否充值成功请查看交易记录</strong></span>
																<a  target="main" style="color: black;font-size: 12px;" onclick="clean();" href="javascript:void(0);" >返回</a>
			       </div>
       </div>
												
											</div> 
									</div> <!-- center end -->
								
									<!-- bottom start -->
									<div style="border: 1px solid #dadada; margin : 10px 5px 0px 0px;text-align: center;">
										  <div  style="text-align: center;font-size: 23px; color: red" >
												  最近5次充值交易记录  <input type="button" value="刷新"  class="Partorange" onclick="queryPage()" style="width: 80px;height: 30px;"> 
										  </div>
								      <div class="table" style="border: 0px solid green;">
								       	<table class="tablelist pusht" id="tablelist" style="width: 100%">
												<thead>
											 	<tr>
													<th width="14%" onmouseover="this.bgColor='green'" onmouseout="this.bgColor=''">订单号</th>
													<th width="15%">商品名</th>
													<th width="15%">充值帐号</th>
													<th width="6%">数量</th>
													<th width="10%">面值(元)</th>
													<th width="10%">批价(元)</th>
													<th width="10%">售价(元)</th>
													<th width="10%">订单时间</th>
													<th width="10%">订单状态</th>
												</tr>
										     </thead>
													<tbody id="supplierdataTable" class="supplierdataTable" style="text-align: center;" >
													
													
													</tbody>
										</table>
											</div>
									</div>
									<!-- bottom end -->
									
									
									
								</div><!-- tabCot end -->

								<div class="modBottom">
									<span class="modABL"></span> <span class="modABR"></span>
								</div>	
							</div>

			
<script type="text/javascript">
  function queryPage( ){ 
		$("#tablelist tbody").empty();
		var tbody = "";
		$.ajax({
			url:'tradingRecord/getTradeRecord.do',
			dataType:'json',
			type:'post',
			data:{'pageno':1,'pagesize':5,'type':2,'categoryLargeId':'1'},
			success:function(datas){
			$("#tablelist tbody").empty();
			if(datas.retcode==0){
				var page = datas.data;
				var total= page.totalCount;
				var pageno=  page.currentPageNo;
				var pagesize = page.pageSize;
				var data = page.result;
					$.each(data, function(index,dlist) {
							 tbody += "<tr >";
							 tbody+="<td   align='center' >"+dlist.orderCode+" </td>";
						     tbody+='<td align="center"><div style="width:100px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;">'+dlist.goodsName+" </div></td>";
						     tbody+="<td align='center'>"+dlist.rechargeAccount+"</td>";
						     tbody+="<td> "+dlist.rechargeNumber+" </td> "; 
						     tbody+="<td align='center'>"+dlist.inPrice/100.0+"</td>";
						     tbody+="<td >"+dlist.batchPrice/100.0+"</td>"; 
						     tbody+="<td>"+dlist.sellPrice/100.0+"</td>";
						     tbody+="<td align='center' style='font-size:9px;'>"+dlist.createTime+"</td>";
						     tbody+="<td    align='center'>"+dlist.orderStatusString+"</td>";
						tbody += "</tr>";
						
					
					});
				}else if(datas.retcode==1){
					alert(datas.message);
				}
				if (tbody != '') {
						   	$("#tablelist tbody").html(tbody);
				} else {
					$("#tablelist tbody").html('<tr><td colspan="10" align="center">没有符合条件的记录！</td></tr>');
				}
				$("#tablelist tr").hover(function() {
					$(this).addClass("over");
				}, function() {
					$(this).removeClass("over");
				});

				parent.document.getElementById("main").style.height= window.document.body.clientHeight+20+"px";
			},
			error:function(error){alert(error.status);}
		});
		
	}
  </script>
</body>
</html>
