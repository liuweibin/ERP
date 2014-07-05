<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>手机充值</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
	<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">
 	<link href="${ctx}/themes/common/button.css" rel="stylesheet" type ="text/css" />
	<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">
<style type="text/css">
body{  font-family:  "微软雅黑","Arial Narrow";  margin:0;
 padding:0;
 text-align: center;}
.cz_main{text-align: -moz-center !important;text-align: center;}
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
.hid_vild{display: none;}

.center{
	padding: 10px 0px 10px 0px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
	height: auto;
}
.center_form {
padding-top: 10px;
text-align: center;
}
.center_form tr{
display: block;
padding-bottom: 10px;
}
.center_form tr td{
vertical-align: middle;
height: 50px;
font-size: 18px;
font-weight: 700;
}
.label{
	width: 200px;
  	padding-right: 50px;
	text-align: right;
	display: block;
	color: #D86201;
	font-size: 22px;
    font-weight: bold;
    height: 44px;
    line-height: 44px;
}
.checkbox {
    color: #242424;
    float: left;
    font-size: 16px;
    font-weight: bold;
    height: 70px;
    line-height: 20px;
    width: 277px;
    padding-top: 2px;
}
.checkLab {
	background: #dc143c;
	color: #fff;
	height: 10px;
}

.gray{
color: gray;
}
.Blue{
color:Blue;
font-weight: bold;
font-size: 14px;
}
.checkbox span{
	display: block;
	width: auto;
	height: 30px;
	line-height:30px;
	float: left;
	margin-right: 3px;
}
#chkgameno{
font-size: 35px;
font-weight: 700;
color: #d86201;
}
</style>
<script type="text/javascript" src="${path}js/jquery.min.js"></script>
<script type="text/javascript" src="${path}js/jquery.metadata.js"></script>

<script type="text/javascript" src="${path}js/jquery.md5.js"></script>
<script type="text/javascript" src="${path}js/hm/common.js"></script>
<script type="text/javascript" src="${path}js/jquery.validate.min.js"></script>
<script type="text/javascript" language="JavaScript" src="<%=basePath%>js/jquery.pagination.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidatorRegex.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidator-4.1.3.js"></script>
<script type="text/javascript">
var data_s = new Array();
var flag = false;
var flag2 = false;
$(document).ready(function(){
	parent.resetTime();    
	document.getElementById("gameno").focus();
	queryPage();
	 $("#cz_bt").bind("click",function(){//防止提交表单时面值选择还原
		 	 $("#gameno").unFormValidator(true); //解除校验
     });            
	 $("#gameno").blur(function() {
		  d(this);
		});
	 $("#gameno").keyup(function() {
		  d(this);
		});
	 $.formValidator.initConfig({
		 formID:"orderForm",
		 submitOnce:true,
		 onSuccess:function(){
				//alert("校验组1通过验证，不过我不给它提交");	
				button1();
		 },onerror:function(msg,obj,errorlist){
				alert(msg);
			}
		});
	 
	 $("#sellPrice").formValidator({ tipid: "sellPriceTip",onShow:"默认为面值",onFocus:"默认为面值",onCorrect:""})
     .regexValidator({regExp:"decmal6",dataType:"enum",onError: "输入错误"});
     
		 $("#gameno").formValidator({onFocus:"",onCorrect:"",onShow:""})
	     .inputValidator({
	         min:11,
	         max:11,
	         onError:"手机号码必须是11位的,请确认"})
	     .regexValidator({
	         regExp:"mobile",
	         dataType:"enum",    //如果是"string",则regExp必须是正则表达式
	         onError:"你输入的手机号码格式不正确"
	     }).functionValidator({fun:isOk});
 
			$("#supperPassword").formValidator({onShow:"请输入交易密码",onFocus:"至少8位字符或数字",onCorrect:"交易密码格式正确"}).
			inputValidator({min:8,max:20,onError:"交易密码至少8位"});
		//回车监听
			$("#gameno").keydown(function(e) {
			if(e.keyCode==13){  return false;
					//var chkgameno = $('#chkgameno').val();
					//if(chkgameno.length==11)valid();
			}
		});
		$(":radio[name='money']").formValidator({tipID:"moneyTip",onShow:"请选面值",onFocus:"没有空面值了，你选一个吧",onCorrect:"输入正确",defaultValue:["1"]}).inputValidator({min:1,max:1,onError:"面值忘记选了,请确认"}).defaultPassed();

	
 $("#fk_sb").click(function() {
 if(!flag){
			saveOrder();
			flag = true;
		}else{
			alert("请不要重复提交");
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
	var bo = validPhone($("#gameno").val());//验证手机号位数
	if(bo){
		var bo = isOk();
		if(bo==true){
			//parent.document.getElementById("main").style.height= window.document.body.clientHeight+20+"px";
			//$(".hid_vild").show();
			displayToggle($(".hid_vild"),true);
			document.getElementById("sellPrice").focus();
		}else{
			$(".hid_vild").hide();
			$("#diqu").html('');
		}
	}else{
		$(".hid_vild").hide();
		$("#diqu").html('');
	}
}
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
function validPhone(gameno){//验证手机号位数
	gameno = $.trim(gameno);
	 var reg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\d{8})$/;
	if(gameno.length==11){
			return reg.test(gameno);
	}else{
		return false;
	}
}
function valid(phoneNum){
	//var returnObj = $.formValidator.oneIsValid("chkgameno");
	 //if(!returnObj.isValid)return;
		 var reg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\d{8})$/;
		 var  gameno = phoneNum==""?$('#gameno').val():phoneNum;
		 if(gameno.length==11){
			 if(reg.test(gameno)){
				 $(".hid_vild").fadeIn(1);
					parent.document.getElementById("main").style.height= "800px";
			}else{ 
				$(".hid_vild").fadeOut(1);
				return;
			}
		 }else{
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
			var praValue = $(".checkbox");
			  praValue.html(''); 
			if(datas.retcode==1){
				boolen = false; //
				result = " 请输入"+data_s.areaName+data_s.carrierName+"手机号";
			}else if(datas.retcode==2){
				boolen = false; //
				result = datas.message;
			}else if(datas.retcode==0){
				result =  datas.useableBalance;
				$("#diqu").html(result);
				$.each(data_s,function(i,attr){
					var suggestRetailPrice = accDiv(attr.suggestRetailPrice,100);
					var value = attr.parValue/100.0+","+attr.goodsCode+","+suggestRetailPrice;
					 if(i==0){
 					    $("#sellPrice").val(accDiv(attr.suggestRetailPrice,100));
						$("#batchPrice").html(accDiv(attr.batchPrice,100));
						$("#goodsCode").val(attr.goodsCode);
						$("#goodsName").val(attr.goodsName);
						 $(".checkbox").append("<span class='checkLab'><input type='radio' checked='checked'    name='money'  id='"+attr.goodsCode+"' value='"+value+"' onClick=change('"+attr.goodsCode+"')   /> <label >"+attr.parValue/100.0+"元</label></span>"); 
					}else{ 
						 $(".checkbox").append("<span><input type='radio'   name='money'   id='"+attr.goodsCode+"'  value='"+value+"' onClick=change('"+attr.goodsCode+"')  /> <label >"+attr.parValue/100.0+"元</label></span>"); 
					 }
				});
				boolen = true;
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
	var sellPrice = $("#sellPrice").val();
	var loginType =$("#loginType").val();
	var gameno =	$("#gameno").val();
	var goodsCode =	$("#goodsCode").val();
	var supperPassword =	$("#supperPassword").val();
	  $.ajax({
			url:'goodsSales/mobile/createRechargeOrder.do',
			type:'post',
			dataType:'json',
			data:{"sellPrice":sellPrice,"loginType":loginType,"gameno":gameno,"goodsCode":goodsCode,"supperPassword":$.md5(supperPassword)},
			success:function(data){
			 if(data.retcode=="1"){
				 alert(data.message);
			 }else{
					var bt_button = $('.bt_button');
					$('.bt_submit').show();
					var show = $('.show');
					var hide = $('.hide');
					displayToggle(show);
					displayToggle(hide);
					displayToggle(bt_button);
					$('#orderCode').val(data.data.orderCode);
					
					$(".batch_Price").html($("#batchPrice").html());
					$(".sell_Price").html($("#sellPrice").val());
					
					$(".phone_No").html($("#gameno").val());
					$(".order_Code").html(data.data.orderCode);
					reflush(2);
					}
			},error:function(){
				alert("error");
			}
			});
	
}
function saveOrder(){
	showMask();
	  $.ajax({
			url:'goodsSales/mobile/saveRechargeOrder.do',
			type:'post',
			dataType:'json',
			timeout:"120000",
			//async:false,
			data:$("#orderForm").serialize(),
			success:function(data){
			 if(data.retcode=="1"){
				 alert(data.message);
				 location.href='<%=basePath%>goodsSales/mobile/0/sjczPage.do';
			 }else{
				 $('#success').show();
				 $("#showMessage").html(data.message);
				var center_form = $('.center_form');
				 displayToggle(center_form);
				 reflush(3);
				 parent.ajaxAccount();
				 queryPage();
			}
			 $("#mask").hide();
			},error:function(e){
				if(e.status==0){
					 $('#success').show();
					 var center_form = $('.center_form');
					 displayToggle(center_form);
					 reflush(3);
					 parent.ajaxAccount();
					 queryPage();
				}else{
					alert("error:"+e.status);
					queryPage();
				}
				 $("#mask").hide();
			}
			});
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
function displayToggle(obj,bo){
	$.each(obj,function(i,attr){
		if(bo){
			attr.style.display="block";
		}else{
			if(attr.style.display=='block'||attr.style.display==''){
				attr.style.display='none';	
			}else if(attr.style.display=='none'){
				var BrowseType="";
				if(getbrowse()=="MSIE"){
				    BrowseType="block";
				}
				else{
				    BrowseType="block";
				}
			attr.style.display=BrowseType;
			}
		}
	
	});
};


function change(id){  
	$('input[type=radio][name="money"]').parent().removeClass('checkLab');
	$("#" + id).parent().addClass('checkLab');
	
	   var value =  $('input[name="money"]:checked').val();
	   var praValue = value.split(",")[0];
	   var goodsCode = value.split(",")[1];
	   var suggestRetailPrice = value.split(",")[2];
	   
	   $('#sellPrice').val(suggestRetailPrice);
		$.each(data_s,function(i,attr){
			if(attr.goodsCode==goodsCode){
					$("#batchPrice").html(accDiv(attr.batchPrice,100));
					$("#goodsCode").val(attr.goodsCode);
					$("#goodsName").val(attr.goodsName);
			}
		});
}
function reflush(step){
		$("#process_lc_img").attr("src","${ctx}/images/step/process_lc_img"+step+".jpg");
}
 
  $(function(){
      //IE
      if($.browser.msie){
            $("#chkgameno").get(0).attachEvent("onpropertychange",function (o){
            	var chkgameno = $("#chkgameno").val();
            	var gameno = $("#gameno").val();
                     if(chkgameno==gameno){
                    		var chkgameno = $('#chkgameno').val();
    						if(chkgameno.length==11)valid();
                     }
              });
      //非IE
      }else{
      $("#chkgameno").get(0).addEventListener("input",function(o){
      	var returnObj = $.formValidator.oneIsValid("chkgameno");
              if(returnObj.isValid){
          		var chkgameno = $('#chkgameno').val();
					if(chkgameno.length==11)valid();
           }else{
         	  returnObj =''; 
           }
          },false);
      }
}); 

//兼容火狐、IE8
function showMask(){
	$("#mask").css("height",400);
	$("#mask").css("width",$(document).width());
	$("#mask").show();
}
parent.document.getElementById("main").style.height =  "800px"; 
</script>
  </head>
  <body  >
  <div id="mask" class="mask" style="margin-top: 80px;line-height:400px;display: none">订单处理中请稍后。。。</div>
  <div class="cz_main">
  		<div class="tabContainer" style="width: 100%">
			<ul class="tabHead" id="tabCot_product-li-currentBtn-">
				<li class="currentBtn">
				<a href="<%=basePath%>goodsSales/mobile/0/sjczPage.do"		title="手机充值" >手机充值</a></li>
			</ul>
		</div>
  	<div class="center" >
  	
		<div style="margin-top: 3px;">
			<label class="gray">支持</label><label class="Blue">${message}</label><label class="gray">手机号码充值</label>
		</div>
		<div style="margin-top: 10px;" >
				<img alt="" id="process_lc_img" src="${path}images/step/process_lc_img1.jpg">
		</div>
		<div style="display: block;" class="center_form" >
		<form id="orderForm" method="post" action=""> 
		<input type="hidden" name="token" value="${token}" />
		<input type="hidden" name="isFull" id="isFull" value="${isFull}">
		<input type="hidden" name="isByGoodsCode" id="isByGoodsCode" value="${isByGoodsCode}">
		<input type="hidden" name="loginType" value="0">
		<input type="hidden" name="goodsCode" id="goodsCode" value="${goodsCode}">
		<input type ='hidden'   name="orderCode" id ='orderCode'/>
			<!--动态内容区 start-->
					<table  border="0" cellpadding="4" cellspacing="0" style="margin: auto;">
						<tbody>
						<c:if test="${! empty goodsName}">
						<tr >
							<td nowrap>
								<label class="label">商品名称:</label>
							</td>
							<td nowrap="nowrap" colspan="2">
							<c:out value="${goodsName}"></c:out>
							</td>
						</tr>
						</c:if>
						<tr   class="show" >
							<td>
							<label class="label">手机号码:</label>
							</td>
							<td>
								<input type="text" class="input_l" name="gameno"   id="gameno"  maxlength="11"  autocomplete="off">
	                		</td>
	                		<td><span id="gamenoTip" style="width:200px" class=""></span></td>
						</tr>
						<tr   class="show" >
							<td>
							<label class="label">确认号码:</label>
							</td>
							<td colspan="2">
								<span id='chkgameno' class='chkgameno' ></span><span id="diqu" style="font-size: 10px;margin-left: 3px;"></span>
	                		</td>
						</tr>
							<tr class="hid_vild show" style="display: none;" >
							<td>
								<label  class="label">面值(元):</label>
							</td>
							<td align="left" id="praValue" style="width: 277px;white-space: nowrap;" >
						<div class="checkbox" > 
						
						</div>
                			</td>
                			<td><span id="moneyTip" style="width:200px" class=""></span></td>
						</tr>
						<tr   class="hid_vild show" style="display: none;" >
								<td> <label  class="label" style="font-size: 18px;">实际销售价格(元):</label></td>
								<td><input type="text" class="input_l sellPrice" name="sellPrice" style="" id="sellPrice" autocomplete="off"></td>
                				<td><span id="sellPriceTip" style="width:180px" class=""></span></td>
						</tr>
						<tr class="hid_vild show" style="display: none;">
							<td>
								<label  class="label">批价(元):</label>
							</td>
							<td align="left"  style="word-break: keep-all;white-space:nowrap;" colspan="2">
							<span id="batchPrice" style="font-size: 18px;font-weight: 700px;"></span>
                			</td>
						</tr>
						<tr class="hid_vild show" style="display: none;">
							<td>
								<label  class="label">交易密码:</label>
							</td>
								<td><input type="password" value="" name="supperPassword" class="input_l" id="supperPassword" autocomplete="off"></td>
                				<td><span id="supperPasswordTip" style="width:180px" class=""></span></td>
                			</td>
						</tr>
							<tr class="hide" style="display:none;">
								<td>
									<label  class="label">订单号 :</label>
								</td>
								<td  class="order_Code" colspan="2"></td>
							</tr>
							
							<tr  class="hide" style="display:none;">
								<td><label  class="label">手机号码:</label>
								</td>
								<td class="phone_No" colspan="2"></td>
								</tr>
							<tr class="hide" style="display:none;" >
								<td>
									<label  class="label">批价(元):</label>
								</td>
								<td  class="batch_Price" colspan="2">
	                			</td>
							</tr>
							<tr   class="hide" style="display: none;" >
								<td> <label  class="label" style="font-size: 18px;">实际销售价格(元):</label></td>
								<td class="sell_Price" colspan="2"></td>
							</tr>
							<tr  class="hide" style="display:none;">
								<td ><label  class="label">充值方式:</label></td>
								<td colspan="2"><span>快充</span></td>
							</tr>
						</div>
						
						
					</tbody></table>
					<!--动态内容区 end -->
					<div class="bt_button hid_vild"  style="width: 700px;height: 50px;display:">
						<span>	
							<input id="cz_bt" type="submit"  class="Partorange" name="btn" style="width: 100px;border: 0;" value="提交订单">
						<span>	
					</div>
					<div class="bt_submit" id="bt_submit" style="height: 50px;width: 700px;display: none;" >
						<span>	
							<input type="button" id="fk_sb" class="Partorange" value="确认充值" style="width: 100px;">	
						<span>	
						<a  target="main"   href="<%=basePath%>goodsSales/mobile/1/sjczPage.do">取消支付</a>
					</div>
				</form>
		</div>
		 <div id="success" style="border: 0px solid green;text-align: center;height: 100px;display: none;">
	       <div style="height: 200px;margin-top: 50px;">
	       		<span style="border-top: 30px;"><strong style="color: red;font-size: 30px;" id="showMessage">订单成功,是否充值成功请查看交易记录</strong>
	       		<a href="<%=basePath%>goodsSales/mobile/0/sjczPage.do">返回</a></span>
	       </div>
       </div>
  </div>
  </div>
   	<div class="modBottom">
									<span class="modABL"></span> <span class="modABR"></span>
		</div>
  <div id="list" class="list">
   <div class="topTip" style="margin-top: 5px;text-align: center;font-size: 23px; color: red" >
   最近5次充值交易记录  <input type="button" value="刷新" onclick="queryPage()"  class="Partorange">
</div>
       <div class="table" style="margin-bottom: 5px;">
       	<table class="tablelist pusht" id="tablelist" >
										<thead>
											<tr >
					<th>订单号</th>
					<th>商品名</th>
					<th class="title_1">充值号码</th>
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
			data:{'pageno':1,'pagesize':5,'goodsType':0,'categoryLargeId':'2','categorySmallId':'2'},
			success:function(datas){//'type':${isFull},
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
