<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
long time = (new Date()).getTime();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'sjcz.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
<link rel="stylesheet" type="text/css"			href="${path}themes/sales/home/of.global.100518.css">
<link rel="stylesheet" type="text/css"			href="${path}themes/sales/home/esales.style.css">
<style type="text/css">
.cz_main{	border: 1px solid #dadada;	text-align: -moz-center !important;text-align: center;}
.fontWeight{color:blue;font-size-adjust: none;}
.cz_3line span{float: left;}
.cz_3line span div{float: left;}
.cz_3line span{	margin: 10px,5px;}
.box_num_down{width:20px; height:20px;text-align:center; background-color:#CCCCCC;}
.box_num_up{width:20px; height:20px;text-align:center; background-color:red;}
.input{height:35px;width:220px;font-size:30px;letter-spacing:2px;line-height:30px;color:#FF6600;font-weight:bold;font-family:Arial;}
 .hidetxt{cursor:default;border: 0px solid #FF0000;background-color: white;}
 .t_font14 tr td{font-size: 29px;padding-right: 10px;}
 #gameno{color: #FF6600}
 .hid_vild{display: none;}
#money{border: 0 10px;}
#praValue label{margin-left: 10px;margin-right: 15px;margin-top: 20px;}
#praValue  { white-space:nowrap;height: auto; width: 300px;word-wrap:break-word}
</style>

<script type="text/javascript" src="${path}js/jquery.min.js"></script>
<script type="text/javascript" src="${path}js/jquery.metadata.js"></script>
<script type="text/javascript" src="${path}js/jquery.validate.min.js"></script>
<script type="text/javascript" language="JavaScript" src="<%=basePath%>js/jquery.pagination.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidatorRegex.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidator-4.1.3.js"></script>
<script type="text/javascript">
var data_s = new Array();
var flag = false;
var flag2 = false;
$(document).ready(function(){
	queryPage( );
	 $("#cz_bt").bind("click",function(){
		 $("#sellPrice2").val($("#sellPrice").val());
     });            
	
	 $.formValidator.initConfig({
		 formID:"orderForm",
		 debug:false,
		 submitOnce:true,
		 onSuccess:function(){
				//alert("校验组1通过验证，不过我不给它提交");	
				button1();
		 },onerror:function(msg,obj,errorlist){
				alert(msg);
			}
		});

	 $("#sellPrice").formValidator({ tipid: "sellPriceTip",onShow:"",onFocus:"请输入正确的金额",onCorrect:"输入正确"})
     .regexValidator({regExp:"decmal6",dataType:"enum",onError: "输入错误"});
     
		 $("#gameno").formValidator({onShow:"请输入手机号"})
	     .inputValidator({
	         min:11,
	         max:11,
	         onError:"手机号码必须是11位的,请确认"})
	     .regexValidator({
	         regExp:"mobile",
	         dataType:"enum",    //如果是"string",则regExp必须是正则表达式
	         onError:"你输入的手机号码格式不正确"
	     }).functionValidator({fun:isOk});
		 
		$("#chkgameno").formValidator({onShow:"请确认手机号",onCorrect:"手机号码一致"})
		.inputValidator({ min:11,max:11,empty:{leftEmpty:false,rightEmpty:false,emptyError:"手机号两边不能有空符号"},
		onError:"确认手机号至少11位,请确认"}).compareValidator({desID:"gameno",operateor:"=",onError:"2次手机号不一致,请确认"});
		
		$("#chkgameno").blur(function() {
			var chkgameno = $('#chkgameno').val();
				if(chkgameno.length==11)valid();
		});
		$(":radio[name='money']").formValidator({tipID:"moneyTip",onShow:"请选面值",onFocus:"没有空面值了，你选一个吧",onCorrect:"输入正确",defaultValue:["1"]}).inputValidator({min:1,max:1,onError:"面值忘记选了,请确认"});//.defaultPassed();

	
 $("#fk_sb").click(function() {
 if(!flag){
			creatOrder();
			flag = true;
		}else{
			alert("请不要重复提交");
		}
 });
	
});
function accDiv(arg1,arg2){ 
	var t1=0,t2=0,r1,r2; 
	try{t1=arg1.toString().split(".")[1].length}catch(e){} 
	try{t2=arg2.toString().split(".")[1].length}catch(e){} 
	with(Math){ 
	r1=Number(arg1.toString().replace(".","")) 
	r2=Number(arg2.toString().replace(".","")) 
	return (r1/r2)*pow(10,t2-t1); 
	} 
}
function valid(){
	 if(!flag2)return;
	 var reg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\d{8})$/;
	 var  gameno = $('#gameno').val();
	 var  chkgameno = $('#chkgameno').val();
		 if(reg.test(gameno)&&gameno==chkgameno){
			 $(".hid_vild").fadeIn(2000);
		}else{
			//$('#czForm').resetForm();
			return;
		}
	 }
function isOk(){ 
	
	var boolen = false;
	var result ='';
	$.ajax({
		url:'goodsSales/verifyMobileNumber.do',
		type:'post',
		dataType:'json',
		 async: false,
		data:$("#orderForm").serialize(),
		success:function(datas){
			data_s = datas.data;
			var praValue = $("#praValue");
			praValue.html(''); 
			if(datas.retcode==1){
				boolen = false; //
				result = " 请输入"+data_s.areaName+data_s.carrierName+"手机号";
			}else if(datas.retcode==2){
				boolen = false; //
				result = datas.message;
			}else if(datas.retcode==0){
				$.each(data_s,function(i,attr){
					var value = attr.parValue/100.0+","+attr.goodsCode;
					if(i==0){
 					    $('#sellPrice').val(accDiv(attr.parValue,100));
						$("#batchPrice").html(accDiv(attr.batchPrice,100));
						$("#goodsCode").val(attr.goodsCode);
						$("#goodsName").val(attr.goodsName);
						$("#praValue").append("<input type='radio' checked='checked' class='money'  name='money'   value='"+value+"'onClick='change()'   /><label>"+attr.parValue/100.0+"</label>"); 
					}else{
						$("#praValue").append("<input type='radio' class='money'  name='money'  value='"+value+"'onClick='change()'   /><label>"+attr.parValue/100.0+"</label>"); 
					}
				});
				boolen = true;
				flag2 = true;
			}
		},
		error:function(error){
			alert(error.status);
		}
	});
	var re = boolen?boolen:result;
	return re;
}
function button1(){
	var sellPrice = $("#sellPrice2").val();
	var loginType =$("#loginType").val();
	var gameno =	$("#gameno").val();
	var goodsCode =	$("#goodsCode").val();
	  $.ajax({
			url:'goodsSales/mobile/createRechargeOrder.do',
			type:'post',
			dataType:'json',
			data:{"sellPrice":sellPrice,"loginType":loginType,"gameno":gameno,"goodsCode":goodsCode},
			success:function(data){
			 if(data.retcode=="1"){
				 alert(data.message);
			 }else{
					var bt_button = $('.bt_button');
					var bt_submit = $('.bt_submit');
					var show = $('.show');
					var hide = $('.hide');
					displayToggle(show);
					displayToggle(hide);
					displayToggle(bt_button);
					displayToggle(bt_submit);
					$('#orderCode').val(data.data.orderCode);
					
					$(".batch_Price").html($("#batchPrice").html());
					$(".phone_No").html($("#gameno").val());
					$(".order_Code").html(data.data.orderCode);
					reflush(2);
					}
			},error:function(){
				alert("error");
			}
			});
	
}
function creatOrder(){
	  $.ajax({
			url:'goodsSales/mobile/saveRechargeOrder.do',
			type:'post',
			dataType:'json',
			data:$("#orderForm").serialize(),
			success:function(data){
			 if(data.retcode=="1"){
				 alert(data.message);
			 }else{
				var success = $('#success');
				var center_form = $('#center_form');
				 displayToggle(center_form);
				 displayToggle(success);
				 reflush(3);
				 parent.ajaxAccount();
				 queryPage( );
			}
			},error:function(){
				alert("error");
			}
			});
	
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
			    BrowseType="table-row";
			}
		attr.style.display=BrowseType;
		}
	});
};


function change(){
	   var value =  $('input[name="money"]:checked').val();
	   var praValue = value.split(",")[0];
	   var goodsCode = value.split(",")[1];
	   
	   
	   $('#sellPrice').val(parseFloat(praValue));
		$.each(data_s,function(i,attr){
			if(attr.goodsCode==goodsCode){
					$("#batchPrice").html(accDiv(attr.batchPrice,100));
					$("#goodsCode").val(attr.goodsCode);
					$("#goodsName").val(attr.goodsName);
			}
		});
}
function reflush(step){
		$("#process_lc_img").attr("src","<%=basePath%>images/step/process_lc_img"+step+".jpg");
}

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
</script>
  </head>
  <body>
  <div class="cz_main">
  	<div style="width: 80%;height: 300">
		<div class="cz_3line" style="height: 80px;text-align: center;text-align: -moz-center !important;">
		<div style="margin-top: 10px;">
			<label style="color: red;font-weight: 900;">${message}</label>
		</div>
			<div style="width: 54%; height: 40px; border-top-width: 10px; margin-top: 10px;" >
					<img alt="" id="process_lc_img" src="${path}images/step/process_lc_img1.jpg">
			</div>
		</div>
		<div style="height: 250px;display: block;" id="center_form" >
		<form id="orderForm" method="post" action=""> 
		
		<input type="hidden" name="isFull" id="isFull" value="${isFull}">
		<input type="hidden" name="isByGoodsCode" id="isByGoodsCode" value="${isByGoodsCode}">
		<input type="hidden" name="loginType" value="0">
		<input type="hidden" name="sellPrice2" id="sellPrice2">
		<input type="hidden" name="goodsCode" id="goodsCode" value="${goodsCode}">
		<input type ='hidden'   name="orderCode" id ='orderCode'></input>
			<!--动态内容区 start-->
					<table width="80%" border="0" cellpadding="4" cellspacing="0" class="t_font14">
						<tbody>
						<c:if test="${! empty goodsName}">
						<tr >
							<td width="40%" align="right" >
								商品名称:
							</td>
							<td width="60%" align="left" nowrap="nowrap" style="font-size: 25px;">
							<c:out value="${goodsName}"></c:out>
							</td>
						</tr>
						</c:if>
						<tr id="gameno_tr" class="show" style="font-size:18px;font-family:Arial;">
							<td width="40%" style="text-align: right; vertical-align: top;">
							手机号码:
							</td>
							<td  width="60%" align="left">
								<input type="text" class="input gameno" name="gameno" style="width: 80%;" id="gameno" maxlength="11"  minlength="11" autocomplete="off">
	                		</td>
	                		<td><span id="gamenoTip" style="width:200px" class=""></span></td>
						</tr>
						<tr id="gameno_tr" class="show" style="font-size:18px;font-family:Arial;">
							<td width="40%" style="text-align: right; vertical-align: top;" nowrap>
							确认手机号码:
							</td>
							<td  width="60%" align="left">
							<input type="text" class="input gameno" name="chkgameno"  style="width: 80%"  id="chkgameno" maxlength="11"  minlength="11" autocomplete="off">
	                		</td>
	                		<td><span id="chkgamenoTip" style="width:200px" class=""></span></td>
						</tr>
						<tr id="gameno_tr" class="hid_vild show" style="font-size:18px;font-family:Arial;">
								<td style="text-align: right; vertical-align: top;width: 40%">销售价格(元):</td>
						
								<td align="left" style="word-break: keep-all;white-space:nowrap;width: 60%">
							<input type="text" class="input sellPrice" name="sellPrice" style="" id="sellPrice" autocomplete="off">
                		</td><td>	<span id="sellPriceTip" style="width:180px" class=""></span></td>
						</tr>
						<tr class="hid_vild show" >
							<td align="right" width="40%" >
								面值(元):
							</td>
							<td align="left" id="praValue" style="">
                			</td>
                			<td><span id="moneyTip" style="width:200px" class=""></span></td>
						</tr>
						<tr class="hid_vild show" >
							<td align="right"  >
								批价(元):
							</td>
							<td align="left"  style="word-break: keep-all;white-space:nowrap;">
							<span id="batchPrice"></span>
                			</td>
						</tr>
						
						<!--  -->
							<tr class="hide" style="display:none;">
								<td width="40%" align="right" nowrap="nowrap">
									订单号 :
								</td>
								<td width="60%" align="left" class="order_Code"></td>
							</tr>
							
							<tr  class="hide" style="display:none;">
								<td width="40%" style="text-align: right; vertical-align: top;">
								手机号码:
								</td>
								<td  width="60%" align="left" class="phone_No"></td>
								</tr>
							<tr class="hide"style="display:none;" >
								<td align="right" width="40%">
									批价(元):
								</td>
								<td align="left" class="batch_Price">
	                			</td>
							</tr>
							<tr  class="hide" style="display:none;">
								<td style="text-align: right; vertical-align: top;">充值方式:</td>
								<td align="left">
										<label for="cityin_0">	快充</label>
									</td>
							</tr>
						</div>
						
						
					</tbody></table>
					<!--动态内容区 end -->
					<div class="bt_button hid_vild"  style="width: 700px;height: 50px;display:">
					<span>	<input id="cz_bt" type="submit"  style="width: 100px;" value="提交订单">
						</span>
						<span onclick="javascript:history.go(-1)" style="cursor: hand; float: right; font-size: 12px; color: #336699;">返回上一页</span>
					</div>
					<div class="bt_submit" style="width: 700px;height: 50px;display: none;" >
						<span><input type="button" id="fk_sb" class="bt_bg" value="确认充值" style="margin-top: 10px;"> </span>
					</div>
				</form>
		</div>
		 <div id="success" style="border: 0px solid green;text-align: center;height: 100px;width 100px;display: none;">
	       <div style="height: 200px;width 100px;margin-top: 50px;">
	       		<span style="border-top: 30px;"><strong style="color: red;font-size: 30px;">订单成功,是否充值成功请查看交易记录</strong></span>
	       </div>
       </div>
  </div>
  </div>
  <div id="list" style="border: 1px solid #dadada;height: 200px;width: auto;text-align: center;border-top: 0px;">
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
       </div>
  </body>
  <script type="text/javascript">
  function queryPage( ){ 
		$("#tablelist tbody").empty();
		var tbody = "";
		$.ajax({
			url:'tradingRecord/getTradeRecord.do',
			dataType:'json',
			type:'post',
			data:{'pageno':1,'pagesize':5,'type':${isFull}},
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
</html>
