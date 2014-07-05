<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
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
body {
	margin: 10px 20 px;
}
.tab #tabCot {
	padding: 20px 10px 10px 10px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
 .num_red{border-style:dotted; border-width:1px; border-color:#F5AC69; font-size:18px; font-weight:bold; font-family:Verdana, Arial, Helvetica, sans-serif; color:#FF6600; width:35px; height:25px; background-color:#FDEDDF;}
 .text_red{font-size:14px; font-weight:bold; color:#FF6600;}
 .num_gray{border-style:dotted; border-width:1px; border-color:#666666; font-size:18px; font-weight:bold; font-family:Verdana, Arial, Helvetica, sans-serif; color:#969696;width:35px; height:25px; background-color:#f7f7f7}
 .text_gray{font-size:14px; font-weight:bold; color:#969696;}
 
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
.form .section-field input{height: 30px;line-height: 30px;}
.form .submit {
	PADDING-BOTTOM: 8px; PADDING-LEFT: 210px; PADDING-RIGHT: 0px; PADDING-TOP: 8px
}
.hidetxt{cursor:default;border: 0px solid #FF0000; }
.section-field em{color: #ff6500;font-size:20px;font-style:normal;}
#game_cz ul li a{color: red}

#apDiv1 {
	width: 100%;
	height: 235px;
}
.TabbedPanelsContent ul li { padding: 6px 0px;margin: 2px 6px;float: left;}
.TabbedPanelsContent  ul{ white-space:nowrap;vertical-align:bottom;}

.error{font: 13px;}
.gmlist li  { margin:5px 5px; }
.gmlist ul li { margin-top: 10px;margin-left: 10px;float: left;white-space:nowrap}
.game01 ul li{border: 0px solid red;margin-left: 0px;}

</style>


<script type="text/javascript">
jQuery.validator.addMethod("decimal", function(value, element) {
	return this.optional(element) || /^(([1-9]\d{0,9})|0)(\.\d{1,2})?$/.test(value);
}, "请输入正确的金额");
var cache;
$( document ).ready(function() {
	 queryPage();
	 var goodsCode = '${goodsCode}';
	 //var goodsContentId = '${goodsContentId}';
	 if(goodsCode){
		 gameCzAjax("goodsCode="+goodsCode);
		// setChargeGame(goodsContentId);
	 }
	 $("#form").validate({
		  debug: true,
		  submitHandler: function(form) {
			//alert("校验组1通过验证，不过我不给它提交");
		    //$(form).submit();
			creatOrder();
		  }
		 });
	 
	 
});
function test(attributes){

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
					sb +="<div class='section game-change' style="+display_+"><label class='section-title'>"+nameCn+":</label><div class='section-field' id='J_section'><input type='text'  name='"+nameEn+"' class='{required:true,messages:{required:\"请输入"+nameCn+"\" }}' value='"+value+"'  autocomplete='off'/></div></div>";
				}else if(valueType==2){//，2:不给值）',
					if(nameEn=="gameAccount"){
						sb +="<div class='section game-change' style="+display_+"><label class='section-title'>"+nameCn+":</label><div class='section-field' id='J_section'><input type='text' id='gameAccount' name='gameAccount' class='{required:true,messages:{required:\"请输入"+nameCn+"\"}}'  value=''  autocomplete='off'/></div></div>";
						sb +="<div class='section game-change' style="+display_+"><label class='section-title'>确认"+nameCn+":</label><div class='section-field' id='J_section'><input type='text'  id='confirm_gameAccount' name='confirm_gameAccount' class={required:true,equalTo:'#gameAccount',messages:{required:\"请确认"+nameCn+"\",equalTo:\"请输入相同的账户\"}}  value=''  autocomplete='off'/></div></div>";
					}else{
						sb +="<div class='section game-change' style="+display_+"><label class='section-title'>"+nameCn+":</label><div class='section-field' id='J_section'><input type='text'  name='"+nameEn+"' class='{required:true,messages:{required:\"请输入"+nameCn+"\"}}'  value=''  autocomplete='off'/></div></div>";
					}
				}else if(valueType==1){//，1通过url
					var res = getGoodsParams(params);
					if(res.indexOf("!=")>-1){
					    sb +="<div class='section game-change'  style="+display_+"><label class='section-title'>"+nameCn+":</label><div class='section-field' id='J_section'><input type='text' name='"+nameEn+"' onclick=listen(this,'"+value+"','"+res+"') class='{required:true,messages:{required:\"请输入"+nameCn+"\"}}' style='background-color: #f3f4f3;' readonly='readonly' value=''  autocomplete='off'/></div></div>";
					}else{
						var r_value=ajax_text(value,res);
					    sb +="<div class='section game-change'  style="+display_+"><label class='section-title'>"+nameCn+":</label><div class='section-field' id='J_section'><input type='text' name='"+nameEn+"' onclick=listen(this,'"+value+"','"+res+"') class='{required:true,messages:{required:\"请输入"+nameCn+"\"}}' style='background-color: #f3f4f3;' readonly='readonly' value='"+r_value+"'  autocomplete='off'/></div></div>";
					}
				}
			}else if(labelType==1){//1是select
				if(valueType==0){ //（0:默认值
					sb +="<div class='section game-change'  style="+display_+"><label class='section-title'>"+nameCn+":</label><div class='section-field' id='J_section'>";
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
					sb +="<div class='section game-change'  style="+display_+"><label class='section-title'>"+nameCn+":</label><div class='section-field' id='J_section'>";
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
	$.ajax({
		url:'goodsSales/games/creatGameGoodsOrder.do',
		dataType:'json',
		async:false,
		type:'post',
		data:$("form").serialize(),
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
					displayToggle($("#form_orderCode"));
					displayToggle($("#btn-t2"));
			 }
		},
		error:function(e){alert(e.status)}
	});
	
}
function button2(){
	saveOrder();
}
function saveOrder(){
	$.ajax({
		url:'goodsSales/games/saveGameGoodsOrder.do',
		dataType:'json',
		async:false,
		type:'post',
		data:$("form").serialize(),
		success:function(data){
			 if(data.retcode=="1"){
				 alert(data.message);
				 reset();
			 }else{
				 reflush(3);
					displayToggle($(".form"));
					displayToggle($("#success"));
			 }
		},
		error:function(e){alert(e.status)}
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
			for ( var i = 0; i < contentOften.length; i++) {
				games += "<li><a href=javascript:void(0) onclick=setChargeGame('"+contentOften[i].id+"')>"+contentOften[i].name+"</a></li>";
			}
			common.html(games+"</ul>");
		
			
			for(var i=1 ;i<=7;i++){
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
				reset();
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
					gmlist.append("<li style='"+li+"'><label>"+att.goodsName+":"+att.parValue/100+"元&nbsp;<a href=javascript:void(0) onclick=gameCzAjax('"+params+"')>充值</a></label></li>");
				})
					gmlist.append("</ul>");
				reset();
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
 getGoodsContentTbl();
</script>
</head>
<body>
	<div id="wrapper" style="width: auto">

		<div id="container">
			<div class="block">

				<div id="wrap" style="width: 100%">
					<div id="body" style="width: 100%">
						<div id="main" style="overflow: hidden; width: 100%;">
							<div id="tabCot_product" class="tab" style="width: 100%">
								<div class="tabContainer" style="width: 100%">
									<ul class="tabHead" id="tabCot_product-li-currentBtn-">
										<li class="currentBtn"><a href="javascript:void(0)"
											title="游戏充值" rel="1">游戏充值</a></li>
									</ul>
								</div>
								<div id="tabCot" style="padding-left: 0px;padding-right: 0px;"><!-- tabCot start -->

									<div style="border: 0px solid red;height: 100px;width: 100%;" id="autoTime"><!-- center start -->
										<div class="" align="center" style="width: 50%;float: right;border: 1px solid #dadada;height:355px;margin-right: 5px;">
										<!-- center_right start --> 
											<div style="border: 0px solid red;width: 100%;height: auto;">
												<div class="cz_title" style="width:100%;height:30px;text-align: center;text-align: -moz-center !important;">
													<img alt="" id="process_lc_img" src="${path}images/step/process_lc_img1.jpg" width="100%">
												</div>
												<form action="" id="form">
														<input type="hidden" name="goodsContentId" id="goodsContentId" >
															<input type="hidden" name="goodsCode" id="goodsCode">
															<input type="hidden"   name="parValue"   id="parValue" value=""  autocomplete="off"/>
												<div class="form game-form" id="game-form" style="display: none;">
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
													<label class="section-title">面值：</label>
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
													<label class="section-title">批价:</label>
														<div class="section-field" id="J_section">
														<span id="batchPrice"></span>(元)
														</div>				
												</div>
												<div id="add"></div>
												
												<div class="section game-change">
													<label class="section-title">价格:</label>
														<div class="section-field" id="J_section">
														<em id="price"></em></span><span id="priceTip"></span>
														</div>				
												</div>
													<div class="section ">
														<span class="btn btn-t1" id="btn-t1" style="display: block;padding-top: 10px;">
															<span>
																<input type="submit"   id="submit" value="提交订单">
															</span>
														</span>
													</div>
													<div class="section ">
														<span class="btn btn-t2" id="btn-t2" style="display: none;">
															<span>
																<button id="subbtn" onclick="button2()">确认充值</button>
															</span>
														</span>
													</div>
												</div>
												</form>
												
			<div id="success" style="border: 0px solid green;text-align: center;height: 300px;width 100px;display: none;">
	       <div style="height: 200px;width 100px;margin-top: 100px;">
	       		<span style="border-top: 30px;"><strong style="color: red;font-size: 25px;">订单成功,是否充值成功请查看交易记录</strong></span>
	       </div>
       </div>
												
											</div> 
										</div><!-- center_right end -->
											<div style="border: 0px solid #dadada ;height: 200px;width: 48%;float: left;height: 355px;margin-right: 3px;margin-left: 5px;min-width: 550px;margin-right : -550px;">
											<!-- left start--> 
													<div id="apDiv1" style="float: left;">
													  <div id="TabbedPanels1" class="TabbedPanels">
													    <ul class="TabbedPanelsTabGroup">
													      <li class="TabbedPanelsTab" tabindex="0">常用 </li>
													      <li class="TabbedPanelsTab" tabindex="0">ABC</li>
													      <li class="TabbedPanelsTab" tabindex="0">DEFG</li>
													      <li class="TabbedPanelsTab" tabindex="0">HIJK</li>
													      <li class="TabbedPanelsTab" tabindex="0">LMNOP</li>
													      <li class="TabbedPanelsTab" tabindex="0">QR</li>
													      <li class="TabbedPanelsTab" tabindex="0">STUV</li>
													      <li class="TabbedPanelsTab" tabindex="0">WXYZ</li>
													    </ul>
													    <div class="TabbedPanelsContentGroup">
													      <div class="TabbedPanelsContent common"></div> 
													      <div class="TabbedPanelsContent game01">暂无游戏</div>
													      <div class="TabbedPanelsContent game02">暂无游戏</div>
													      <div class="TabbedPanelsContent game03">暂无游戏</div>
													      <div class="TabbedPanelsContent game04">暂无游戏</div>
													      <div class="TabbedPanelsContent game05">暂无游戏</div>
													      <div class="TabbedPanelsContent game06">暂无游戏</div>
													      <div class="TabbedPanelsContent game07">暂无游戏</div>
													    </div>
													  </div>
													</div> 
												<div style="border: 1px solid  #dadada;height: 100px;width: 100%;margin-right: 0px;" class="gmlist">  			
									
												</div>	 
												
											</div><!-- left end-->
									</div> <!-- center end -->
									
									<div style="border: 1px solid #dadada;height: 200px;margin : 10px 5px 0px 5px;text-align: center;"><!-- bottom start -->
									  <div class="topTip" style="margin-top: 5px;text-align: center;font-size: 23px; color: red" >最近5次充值交易记录  <input type="button" value="刷新" onclick="queryPage()" style="width: 80px;height: 30px;"> </div>
								       <div class="table" style="width: 90%;margin-bottom: 5px;">
								       	<table class="tablelist pusht" id="tablelist" >
																		<thead>
																			<tr >
													<th>订单号</th>
													<th>商品名</th>
													<th class="title_1">充值帐号</th>
													<th width="30">数量</th>
													<th>面值(元)</th>
													<th width="60"    >批价(元)</th>
													<th>售价(元)</th>
													<th>订单时间</th>
													<th>订单状态</th>
												</tr>
																			</thead>
																			<tbody id="supplierdataTable" style="text-align: center;" >
																			
																			
																			</tbody>
																		</table>
											</div>
									</div><!-- bottom end -->
									
									
									
								</div><!-- tabCot start -->

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
<script type="text/javascript">
  function queryPage( ){ 
		$("#tablelist tbody").empty();
		var tbody = "";
		$.ajax({
			url:'tradingRecord/getTradeRecord.do',
			dataType:'json',
			type:'post',
			data:{'pageno':1,'pagesize':5,'type':2,'categoryId':'1','goodsType':0},
			success:function(datas){
			$("#tablelist tbody").empty();
			if(datas.retcode==0){
				var page = datas.data;
				var total= page.totalCount;
				var pageno=  page.currentPageNo;
				var pagesize = page.pageSize;
				var data = page.result;
					$.each(data, function(index,dlist) {
								 tbody += "<tr>";
								 tbody+="<td   align='center' >"+dlist.orderCode+" </td>";
							     tbody+="<td align='center'> "+dlist.goodsName+" </td>";
							     tbody+="<td align='center'>"+dlist.rechargeAccount+"</td>";
							     tbody+="<td> "+dlist.rechargeNumber+" </td> "; 
							     tbody+='<td align="center">'+dlist.inPrice/100.0+'</td> ';
							     tbody+='<td   >'+dlist.batchPrice/100.0+'</td> '; 
							     tbody+='<td >'+dlist.sellPrice/100.0+'</td> ';
							     tbody+='<td align="center">'+dlist.createTime+'</td> ';
							     tbody+='<td    align="center">'+dlist.orderStatusString+'</td> ';
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

				
			},
			error:function(error){alert(error.status);}
		});
		
	}
  </script>
</body>
</html>
