<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>充正</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=basePath%>themes/common/titletab.css" rel="stylesheet"type="text/css" />
	<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">
 	<link href="<%=basePath%>themes/common/button.css" rel="stylesheet" type="text/css" />
 	
	<script type="text/javascript" src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.md5.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/thickbox.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/hm/common.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidatorRegex.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidator-4.1.3.js"></script>
	
		<style type="text/css">
body{  font-family:  "微软雅黑","Arial Narrow";  text-align: center; margin: 0;padding: 0;margin-top: -18px;}
.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
	height: auto;
}
#center{ 
border:0px solid #d6d6d6;
}
body{TEXT-ALIGN: center;}
.input{height:35px;width:220px;font-size:24px;letter-spacing:2px;line-height:30px;color:#FF6600;font-weight:bold;font-family:Arial;}
 .input_gray{border-style:none;  font-size:18px;  color:#969696;width:200px; background-color:#f7f7f7;}
 
.t_font14 tr {margin: 2px 2px;}
.input{height:35px;width:220px;font-size:24px;letter-spacing:2px;line-height:30px;color:#FF6600;font-weight:bold;font-family:Arial;}
 .input_gray{border-style:none;  font-size:18px;  color:#969696;width:200px; background-color:#f7f7f7;}
 
 .input_l {
background: url("${ctx}/images/img0001.png") repeat scroll 0 -876px rgba(0, 0, 0, 0);
    border: medium none;
    float: left;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 32px;
    font-weight: bold;
    height: 43px;
    line-height: 43px;
    padding-left: 10px;
    width: 277px;
}
#czForm td{height: 44px;}
#czForm tr td{
vertical-align: middle;
}
#czForm label{
	width: 150px;
  	padding-right: 50px;
	text-align: right;
	display: block;
	color: #D86201;
	font-size: 22px;
    font-weight: bold;
    height: 44px;
    line-height: 44px;
}
.table2{
text-align: center;
}
.table2 tr td{
font-size: 18px;
color: #D86201;
font-weight: 700;
}
.table2 table{margin: auto;}
.table2 tr {
margin-top: 10px;
height: 40px;
}

.checkLab {
	background: #dc143c;
	color: #fff;
	padding-top: 3px;
	padding-bottom: 3px;
	height: 25px;
	line-heigth: 25px;
	border: 1px solid #f0e68c;
}
.praValue span{
	padding-top: 3px;
	padding-bottom: 3px;
	margin-right:5px;
	height: 25px;
	line-heigth: 25px;
}
#chkgameno{
font-size: 35px;
font-weight: 700;
color: #d86201;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	parent.resetTime();    
	correctOrderfactorquery();
	document.getElementById("gameno").focus();
 $.formValidator.initConfig({
 formID:"czForm",
 debug:false,
 submitOnce:true,
 onSuccess:function(){
		//alert("校验组1通过验证，不过我不给它提交");
		creatOrder();
 },onError:function(){
	 alert("具体错误，请看网页上的提示");
 }
});
	 	
 $("#creatSubmit").bind("click",function(){ 
	 $("#gameno").unFormValidator(true); //解除校验
 }); 
	$("#superPassword").formValidator({onShow:"请输入交易密码",onFocus:"至少8位字符或数字",onCorrect:"交易密码格式正确"}).
		inputValidator({min:8,max:20,onError:"你输入的交易密码不正确,请确认"});
		
	$("#gameno").formValidator({onShow:"",onFocus:"",empty:false,onCorrect:""})
      .inputValidator({
          min:11,
          max:12,
          onError:"请输入正确的号码"})
      .regexValidator({
    	   regExp:"^((075\\d)|(076\\d)|(066\\d))(\\d{7,8})|^(020)(\\d{8})|^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\\d{8})",
         onError:"号码格式不正确"
	  }).functionValidator({fun:valid_});
	
	 $("#gameno").keyup(function() { d(this); });
	 $("#gameno").blur(function() { d(this); });
	
	
	$('#amount').blur(function() {
	   var obj = document.getElementsByName('money');
		var amount = $('#amount').val();
		if(amount.length>0){
		 var bo = false;
		 for(i = 0; i < obj.length; i++) {  
		      if(obj[i].value == amount){  
		        obj[i].checked = true;
		        bo = true;
		      }  
		    }	
		}
	});
	
});
//控制div里显示的数字
function d(e){
	var i = e.value;
	i=$.trim(i);
	var h=i.substring(0,3);
	i=i.substring(3);
	while(i&&i.length>0){
		h+=" "+i.substring(0,4);
		i=i.substring(4)
	}
	$("#chkgameno").html(h);
	var bo1 = validPhone($("#gameno").val());//验证手机号位数
	var bo2 = validfixed($("#gameno").val());//验证固话号位数
	if(bo1||bo2){ 
		 if(bo1)$("#type").val("sj");
		 if(bo2)$("#type").val("gh");
	}else{
		 $('.hide').hide();
		 $('.czmz').hide();
		 $("#chkgamenoTip").html("");
	}
}
function validfixed(gameno){//验证固话号位数
	gameno = $.trim(gameno);
	 var reg = /^((075\d)|(076\d)|(066\d))(\d{7,8})|^(020)(\d{8})/;
	if(gameno.length==11||gameno.length==12||gameno.length==7){ 
			return reg.test(gameno);
	}else{
		return false;
	}
}
function validPhone(gameno){//验证手机号位数
	gameno = $.trim(gameno);
	 var reg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\d{8})$/;
	if(gameno.length==11){
			return reg.test(gameno);
	}else{
		return false;
	}
}
function valid_(){	 
	var no = $("#gameno").val();
	var temp =validfixed(no);
		if(temp){
			$("#chkgamenoTip").html("广东电信");
				 $('.hide').show();
				 $('.czmz').hide(); 
		 $("#amount").formValidator({onCorrect:"冲正金额合法",onShow:"",onFocus:"请输入30.00元到100000.00元之间的充值金额"})
			.inputValidator({min:1,	onError:"冲正金额不能为空,请确认"});
			return true;
		}
	  temp =validPhone(no);
	if(temp){   
		$("#amount").formValidator({onCorrect:"冲正金额合法",onShow:"",onFocus:"请输入30.00元到100000.00元之间的充值金额"})
		.inputValidator({min:1,	onError:"冲正金额不能为空,请确认"}).functionValidator({fun:isOk});
			var carrierName =	getGoodsPriceByGameno(no);
			$("#chkgamenoTip").html(carrierName);
		return true;
	}
}
function isOk(){
  var obj = document.getElementsByName('money');
		var amount = $('#amount').val();
		if(amount.length>0){
		 var bo = false;
		 var parValue ='';
		 for(i = 0; i < obj.length; i++) { 
		 	if(i<obj.length-1){
			 	parValue +=  obj[i].value+" ,";
		 	}
		 	if(i==obj.length-1)	{
		 		parValue = parValue+obj[i].value+";"
		 	}
		      if(obj[i].value == amount){  
		        obj[i].checked = true;
		        bo = true;
		      }  
		    }	
		   if(!bo){
					return '请选择或输入以下面值(元):'+parValue;
		   } 	
		}
}


 function change(id){
		$('input[type=radio][name="money"]').parent().removeClass('checkLab');
		$("#" + id).parent().addClass('checkLab');
	 
   var a =  $('input[name="money"]:checked').val();
   $('#amount').val(a);
 }
 //生成冲正订单
function creatOrder(){
	 var data = $("#czForm").serialize();
		var i = data.lastIndexOf("&")
		var sub = data.substr(i,data.length);
		var superPassword = $("#superPassword").val();
		data = data.replace(sub,"&superPassword="+$.md5(superPassword))
	$.ajax({
	url:'correctOrder/creatCorrectOrder.do',
	type:'post',
	dataType:'json',
	cache:false,
	data:data,
	success:function(data, textStatus){
		var status = data.retcode;
		if(status==1){
			alert(data.message);
		}else{
			var orderCode = data.data.orderCode;
			var orderCreateTime = data.data.orderCreateTime;
			var oldRechargeCode = data.data.oldRechargeCode;
			var correctOrderCode = data.data.correctOrderCode;
			document.getElementById("orderCode").innerHTML=orderCode;
			document.getElementById("orderCreateTime").innerHTML=orderCreateTime;
			document.getElementById("oldRechargeCode").innerHTML=oldRechargeCode;
			document.getElementById("correctOrderCode").innerHTML=correctOrderCode;
			document.getElementById("errorNo").innerHTML=$("#gameno").val();
			document.getElementById("errorMoney").innerHTML=$("#amount").val();
			$('.table2').show();
			reflush(2);
			displayToggle($('.bottom_button'));
			displayToggle($("#form"));
		}
	},
	error:function(XMLHttpRequest, textStatus, errorThrown){
		alert(textStatus);
	}
	});
	parent.resetTime();    
}
/*
根据冲正订单号创建新的充值工单
*/
function correct(){
var correctOrderCode =document.getElementById("correctOrderCode").innerHTML;

	if(correctOrderCode){
		showMask();
		$.ajax({
		url:'correctOrder/creatRechargeOrder.do',
		type:'post',
		timeout:"120000",
		dataType:'json',
		cache:false,
		data:{ correctOrderCode:correctOrderCode},
		success:function(data, textStatus){
			var status = data.retcode;
			if(status==1){
					displayToggle($("#center"));
					$("#error").html("<strong style='color: red;font-size: 50px;'>"+data.message+"</strong><a href='<%=basePath%>correctOrder/correctOrderView.do'>返回</a>");
				displayToggle($("#error"));
			}else{
				reflush(3);
				displayToggle($("#center"));
			    displayToggle($("#success"));
			    $("#successMessage").html(data.message);
			  	correctOrderfactorquery();
			    parent.ajaxAccount();
			}
			$("#mask").hide();
		},
		error:function(e){
			if(e.status==0){
				reflush(3);
				displayToggle($("#center"));
			    displayToggle($("#success"));
				  correctOrderfactorquery();
			    parent.ajaxAccount();
			    $("#mask").hide();
			}else{
				alert(e.status);
				correctOrderfactorquery();
			}
		}
		});
	}
	parent.resetTime();    
}
//获取可以冲正商品价格
function getGoodsPriceByGameno(){
	var carrierName = "";
		$.ajax({
		url:'correctOrder/getGoodsPriceByGameno.do',
		type:'post',
		dataType:'json',
		cache:false,
		async:false,
		data:{gameno:$('#gameno').val()},
		success:function(data, textStatus){
			var status = data.retcode;
			if(status==1){
				alert(data.message);
			}else{
				//displayToggle($('.hide'));
				$('.hide').show();
				carrierName  = data.message;
				data = data.data;
				var praValue = $(".praValue");
				praValue.html(''); 
				$.each(data,function(i,attr){
					if(i==0){
						$('#amount').val(attr.goodsPrice);
						$(".praValue").append("<span class='checkLab'><input type='radio'  checked id='"+attr.goodsPrice+"'  name='money' value='"+attr.goodsPrice+"' onClick=change('"+attr.goodsPrice+"') />"+attr.goodsPrice+"</span>"); 
					}else{
						$(".praValue").append("<span ><input type='radio'  id='"+attr.goodsPrice+"' name='money' value='"+attr.goodsPrice+"' onClick=change('"+attr.goodsPrice+"') />"+attr.goodsPrice+"</span>"); 
					}
				});
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alert(textStatus);
		}
		});
		parent.resetTime();    
return carrierName;
}


function displayToggle(obj){
	$.each(obj,function(i,attr){
		if(attr.style.display=='block'||attr.style.display==''){
				attr.style.display='none';	
		}else if(attr.style.display=='none'){
			var BrowseType="";
			if(getbrowse()=="MSIE"){
			    BrowseType="block";
			}
			else{
			    BrowseType="";
			}
		attr.style.display=BrowseType;
		}
	});
};

function getbrowse(){ //判断当前浏览器是何种浏览器
    var str="";
    // 包含「Opera」文字列
    Agent=navigator.userAgent;
    if(Agent.indexOf("Opera") != -1) {
        str='Opera';
    }
    // 包含「MSIE」文字列
    else if(Agent.indexOf("MSIE") != -1) {
        str='MSIE';
    }
    // 包含「Firefox」文字列
    else if(Agent.indexOf("Firefox") != -1) {
        str='Firefox';
    }
    // 包含「Netscape」文字列
    else if(Agent.indexOf("Netscape") != -1) {
        str='Netscape';
    }
    // 包含「Safari」文字列
    else if(Agent.indexOf("Safari") != -1) {
        str='Safari';
    }
    else{  
    }  
    return str;
}
function reflush(step){
	$("#process_lc_img").attr("src","<%=basePath%>images/step/process_lc_img"+step+".jpg");
}
//兼容火狐、IE8
function showMask(){
	$("#mask").css("height",350);
	$("#mask").css("width",$(document).width());
	$("#mask").show();
}
parent.document.getElementById("mmain").style.height=  "800px";	
parent.document.getElementById("main").style.height=  "800px";
</script>
<style type="">
#tabCot{text-align: center; }
#wrap{	border: 0px solid green;	text-align: -moz-center !important;text-align: center;}
#czForm tr td label{
 	width: 200px;
 	display: block;
 	text-align: right;
 }
 #czForm tr td {
 height: 50px;
 }
</style>
  </head>
  
  <body>
  <div id="mask" class="mask" style="text-align: center;z-index: 0;font-size: 30px;color: red;margin-top: 80px;line-height:350px;display: none">订单处理中请稍后。。。</div>
 	<div id="wrap" style="width: 100%;height: 100%">
			<div id="body" style="width: 100%;height: 100%">
				<div id="main" style="overflow: hidden; width: 100%;height: 100%">
					<div id="tabCot_product" class="tab" style="width: 100%">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a   href="<%=basePath%>correctOrder/correctOrderView.do"	 title="冲正" rel="1">冲正</a>
								</li>

							</ul>
						</div>   
<div id="tabCot" >
    <div id="center" style="display: block;text-align: center;">
  		<div style="  height: 32px; margin-top: 10px;text-align: center;" >
					<img alt="" id="process_lc_img" src="${ctx}/images/step/process_lc_img1.jpg">
		</div>
		<div style="color: blue;height: 30px;color: blue;font-size: 14px;font-weight: 700;">
					<span style="color:red ">提示：</span>支持广东省内  	<span style="color:red ">移动 联通 电信</span> 手机号码冲正<br>
			支持广东省内  	<span style="color:red ">电信固话  </span>冲正
		
		</div>
			<div style="height: 300px;padding-top: 20px;display: block;" id="form" >
			<form id="czForm">
				<table border="0" cellpadding="4" cellspacing="0" class="t_font14">
					<tr >
						<td ><label>误缴号码:</label></td>
						<td>
							<input type="text" class="input_l gameno" name="gameno" style="" id="gameno"  maxlength="12"  autocomplete="off">
                		</td>
                		<td><span id="gamenoTip" style="width:200px" class=""></span></td>
					</tr>
					<tr id="chkgameno_tr" >
							<td><label></label></td>
							<td align="left" style="word-break: keep-all;white-space:nowrap;">
							<span id="chkgameno"></span>
                			</td>
                			<td><span id="chkgamenoTip" style="width:200px" class=""></span></td>
					</tr>
					<tr style="font-size:18px;display: none" class="hide czje">
						<td ><label>冲正金额(元):</label></td>
						<td align="left" style="word-break: keep-all;white-space:nowrap;">
							<input type="text" class="input_l amount" name="amount" style="" id="amount" autocomplete="off">
                		</td><td>	<span id="amountTip" style="width:180px" class=""></span></td>
					</tr>
					<tr style="font-size:18px; display: none" class="hide czmz">
						<td><label>冲正面值(元):</label></td>
						<td align="left" class="praValue">
						
                		</td>
					</tr>	
					<tr style="font-size:18px; display: none" class="hide mima">
						<td><label>交易密码:</label></td>
						<td align="left" style="word-break: keep-all;white-space:nowrap;">
							<input type="password" class="input_l superPassword" name="superPassword" style="" id="superPassword" autocomplete="off">
                		</td>
						<td><span id="superPasswordTip" style="width:180px"></span></td>
					</tr>	
					
					<tr style="display: none;margin-top: 10px;" class="hide top_submit" >
						<td></td> 
						<td>
						<input type="submit" id="creatSubmit" value="提交订单" class="Partorange" >
						</td>
					</tr>
				</table>
			</form>
			</div>
		<div style="height: 230px;border:1px solid #d6d6d6;display: none;margin-top: 30px;" class="table2" id="table2">
		<table style="width: 80%;margin-top: 10px;"  >
			<tbody >
				<tr   class="errorNo">
					<td  width="40%" align="right" >
						误交号码:
					</td>	
					<td width="60%" align="left">
						<p   id="errorNo" ></p>
					</td>				
				</tr>
					<tr height="40px"  class="errorMoney">
					<td  width="40%" align="right" >
						充值金额(元):
					</td>	
					<td width="60%" align="left">
						<p   id="errorMoney"  ></p>
					</td>				
				</tr>
				<tr   style="">
					<td  width="40%" align="right" >
						<p   id="oldRechargeCode" style="display: none"></p>
						<p   id="correctOrderCode" style="display: none"></p>
						充值流水:
					</td>	
					<td width="60%" align="left">
						<p   id="orderCode" ></p>
					</td>				
				</tr>
				<tr   >
					<td  width="40%" align="right" >
						充值时间:
					</td>
					<td width="60%" align="left">
						<p   id="orderCreateTime"></p>
					</td>
				</tr>
				<tr style="display: none;" class="bottom_button" >
					<td colspan="2" align="center" style="text-align: center;" >
					<input type="button" value="确定冲正"  class="Partorange" onclick="correct();">
					<a  target="main"   href="<%=basePath%>correctOrder/correctOrderView.do">取消</a>
					</td> 
				</tr>
			</tbody>
		</table>
	</div>
		</div>
</div>
		   <div id="success" style="border: 0px solid red;text-align: center;height: 250px;width:600px;display: none;margin-left: auto;margin-right: auto;">
	       <div style="height: 200px;width:100%;margin-top: 100px;">
		       		<span style="border-top: 30px;"><strong style="color: red;font-size: 30px;" id="successMessage">订单成功,是否冲正成功请查看冲正记录</strong></span>
		       		<a href="<%=basePath%>correctOrder/correctOrderView.do">返回</a></span>
		       </div>
	       </div>
           <div id="error" style="border: 0px solid green;text-align: center;height: 300px;width:600px;display:none;margin-left: auto;margin-right: auto;">
		       <div style="height:200px;width:100%;margin-top: 100px;">
		       		<span style="border-top: 30px;" ><strong style="color: red;font-size: 45px;">冲正失败</strong></span>
		       </div>
	       </div>
						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>
 <div id="list" class="list">
   <div class="topTip" style="margin-top: 5px;text-align: center;font-size: 23px; color: red" >
   最近5次充值交易记录  <input type="button" value="刷新" onclick="correctOrderfactorquery()"  class="Partorange">
</div>
       <div class="table" style="margin-bottom: 5px;">
       	<table class="tablelist pusht" id="tablelist" style="width: 98%;margin: 2px 10px;font-size: 14px;" >
						<thead>
							<tr> 
								<th> 冲正订单编号 </th>
						 		<th> 充值订单编号 </th>
							 	<th> 充值工单编号 </th>
						 		<th> 商品名称 </th>
						 		<th> 电话号码 </th>
						 		<th> 	运营商 </th>
					 			<th> 金额 (元) </th>
					 			<th> 		处理时间 </th>
					 			<th> 		状态 	</th>
				 			</tr> 	
				 			</thead>
											<tbody id="correctOrderdataTable" style="text-align: center;font-size: 12px;" >
											
											
											</tbody>
				</table>
			</div>
       </div>
					</div>

				</div>
			</div>
		</div>
  </body><script type="text/javascript">
  function correctOrderfactorquery() {
  	var url_ = "correctOrder/correctOrderList.do?fromBrowser=true&pageno=1&pagesize=5";
  	$.ajax( {
  				cache : true,
  				type : "POST",
  				async : false,
  				url : url_,
  				data:{'orderStatusTemp':'1'},
  				dataType : 'json',
  				error : function(request) {
  					$("#correctOrderdataTable")
  							.html( '<tr><td colspan="14" class="red">查询出错，请刷新后重试！</td></tr>');
  					$("#selectcorrectOrderFactor").css("display", "none");
  				},
  				success : function(data) {
  					var res = data.data;
  					if(data.retcode=="1"){
  						$("#correctOrderdataTable").html('<tr><td colspan="14">查询出错！</td></tr>');
  						return false;
  					}
  					
  					var total = res.totalCount;
  					var pageno = res.pageNo;
  					var pagesize = res.pageSize;
  					
  					var tab = '';
  					$.each(res.result,function(i,attr){
  						if(attr.status==0){
  							return true;
  						}
  						tab += '<tr>';
  						tab += '<td align="left">' + attr.correctOrderCode + '</td>';
  						tab += '<td align="left">' + attr.orderCode + '</td>';
  						tab += '<td align="left">' + attr.rechargeCode + '</td>';
  						tab += '<td align="left">' + attr.goodsName + '</td>';
  						tab += '<td align="left">' + attr.mobileNo + '</td>';
  						tab += '<td align="left">' + attr.operationId + '</td>';
  						tab += '<td align="left">' + attr.amount + '</td>';
  						tab += '<td align="left" style="font-size:10px">' + attr.handleTime + '</td>';
  						tab += '<td align="left">' + attr.order_status + '</td>';
  						tab += '</tr>';
  					})
  					if (tab != '') {
  						$("#correctOrderdataTable").html(tab);
  					} else {
  						$("#correctOrderdataTable").html('<tr><td colspan="14">没有符合条件的记录！</td></tr>');
  					}
  					$("#correctOrderdataTable tr").hover(function() {
  						$(this).addClass("over");
  					}, function() {
  						$(this).removeClass("over");
  					});

  					parent.document.getElementById("main").style.height= window.document.body.clientHeight+20+"px";
  				}
  			});
  	parent.resetTime();    
  }

  </script>
</html>
