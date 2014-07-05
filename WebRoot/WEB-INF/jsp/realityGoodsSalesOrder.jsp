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
    
    <title>实物销售</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
.cz_main{text-align: -moz-center !important;text-align: center;}
.fontWeight{color:blue;font-size-adjust: none;}
.box_num_down{width:20px; height:20px;text-align:center; background-color:#CCCCCC;}
.box_num_up{width:20px; height:20px;text-align:center; background-color:red;}
.input{height:35px;width:220px;font-size:24px;letter-spacing:2px;line-height:30px;color:#FF6600;font-weight:bold;font-family:Arial;}
 .input_gray{border-style:none;  font-size:18px;  color:#969696;width:200px; background-color:#f7f7f7;}
 
 .center{
	padding: 10px 0px 10px 0px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
	height: auto;
}
 .t_font14 tr{margin: 4px 0;padding: 2px 0;}
</style>

	<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
	<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">
 	<link href="${ctx}/themes/common/button.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">

	<script type="text/javascript" src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.md5.js"></script>
<script type="text/javascript" src="${path}js/jquery.validate.min.js"></script>
<script type="text/javascript" language="JavaScript" src="<%=basePath%>js/jquery.pagination.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidatorRegex.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidator-4.0.1.js"></script>
<script type="text/javascript">

$(document).ready(function(){
   $.formValidator.initConfig({
		 submitButtonID:"cz_bt",
		 onSuccess:function(){
				 //alert("校验组1通过验证，不过我不给它提交");
				 cz_bt();
		 },onError:function(){
			 alert("具体错误，请看网页上的提示");
		 }
	 });
   
	$("#supperPassword").formValidator({onShow:"请输入交易密码",onFocus:"至少8位字符或数字",onCorrect:"交易密码格式正确"}).
	inputValidator({min:8,max:20,onError:"交易密码至少8位"});
	
	$("#sellPrice").formValidator({onShow:"",onFocus:"",onCorrect:""})
      .inputValidator({min:1, type: "number",empty:{emptyError:"销售金额不能有空符号"},onError:"销售金额非法,请确认"}).regexValidator({regExp:"decmal1",dataType:"enum",onError:"销售金额格式不正确"})
      ;
});
 var flag = false;
 function buy(){
 		if(!flag){
 			showMask();
	 			$.ajax({
					url:'goodsSales/reality/saveRealGoodsOrder.do',				
					type:'post',
					timeout:"120000",
				    dataType:'json',
					data:$("#orderForm").serialize(),
					success:function(data){
					if(data.retcode==1){
					 alert(data.message);
					  refresh();
				 	}else{
		 				var success = $('#success');
						var center_form = $('#center_form');
						 displayToggle(center_form);
						 displayToggle(success);
						 next(2);
						 parent.ajaxAccount();
				 	}
					$("#mask").hide();
					},error:function(e){
						if(e.status==0){
							var success = $('#success');
							var center_form = $('#center_form');
							 displayToggle(center_form);
							 displayToggle(success);
							 $("#successMessage").html("订单超时！是否销售成功请看销售记录");
							 next(2);
							 parent.ajaxAccount();
						}else{
							alert(e.status);
							  refresh();
						}
						$("#mask").hide();
					}
				});
			flag = true;
		}else{
			alert("请不要重复提交");
		}
			
 }
 var flag_cz_bt = false;
 function cz_bt(){
	   if(!flag_cz_bt){
			 var sellQuantity = $('#sellQuantity').val();
			 var sellPrice = $('#sellPrice').val();
			 var reg = /^(([1-9]\d{0,9})|0)(\.\d{1,2})?$/;
			 var reg_sellQuantity = /^[0-9]*[1-9][0-9]*$/;
		     var bo =  reg.test(sellPrice);
		     var bo_sellQuantity =  reg_sellQuantity.test(sellQuantity);
		    if(!bo){
		    alert("金额输入有误！");
		    		return;
		    }
		    if(!bo_sellQuantity){
		       alert("销售数量有误！");
		    		return;
		    }
				var data = $("#orderForm").serialize();
				var i = data.lastIndexOf("&supperPassword")
				var sub = data.substr(i,data.length);
				var supperPassword = $("#supperPassword").val();
				var params = data.replace(sub,"&supperPassword="+$.md5(supperPassword))
		     $.ajax({
					url:'goodsSales/reality/createRealGoodsOrder.do',
					type:'post',
					dataType:'json',
					data:params,
					success:function(data){
					 if(data.retcode==1){
						 alert(data.message);
						 refresh();
					 }else{
							var obj = $(".t_font14 tr");
							var bt_button = $('.bt_button');
							var bt_submit = $('.bt_submit');
							displayToggle(obj);
							displayToggle(bt_button);
							displayToggle(bt_submit);
							displayToggle($('#gameno_tr'));
							
							$('#sellQuantity').removeClass('input').addClass('input_gray');
							$('#sellQuantity').attr('readonly',"true" );
							$('#sellPrice').removeClass('input').addClass('input_gray');
							$('#sellPrice').attr('readonly',"true" );
							next(2)
							$('#orderCode').val(data.data.orderCode);
							$('#totalPrice').val(data.data.totalPrice);
							}
					},error:function(){
						alert("error");
					}
					});
				flag_cz_bt = true;	
	    }else{
				alert("请不要重复提交");
		}
}
      
    function refresh(){
 		location.href="<%=basePath%>goodsSales/realitySales.do?stockId=${data[0].stockId}";
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
    function next(step){
		$("#process_lc_img").attr("src","${ctx}/images/step/process_lc_img"+step+".jpg");
}

  //兼容火狐、IE8
  function showMask(){
  	$("#mask").css("height",350);
  	$("#mask").css("width",$(document).width());
  	$("#mask").show();
  }
</script>
  </head>
  <body>
   <div id="mask" class="mask" style="text-align: center;z-index: 0;font-size: 30px;color: red;margin-top: 80px;line-height:350px;display: none">订单处理中请稍后。。。</div>
  <div class="cz_main" >
  	<div style="height: 350">
  	<div class="tabContainer" style="width: 100%">
			<ul class="tabHead" id="tabCot_product-li-currentBtn-">
				<li class="currentBtn">
				<a href="<%=basePath%>goodsSales/realitySales.do?stockId=${data[0].stockId}"		title="实物销售" >实物销售</a></li>
			</ul>
		</div>
		<div style="border-right : 2px solid #efefef;border-left : 2px solid #efefef;border-bottom: 2px solid #efefef;margin-top: -9px;" >
		<div style="margin-top: 10px;" >
				<img alt="" id="process_lc_img" src="${path}images/step/process_lc_img1.jpg">
		</div>
		<div style="height: 350px;padding-top: 15px;margin: 0 auto;" id="center_form" >
		<form id="orderForm" style="text-align: center;font-size: 18px;"> 
				<input type="hidden" name="token" value="${token}" />
		<input type="hidden" value="${data[0].stockId}" name="stockId"> 
		<input type="hidden" value="${data[0].goodsName}" name="goodsName"> 
		<input type="hidden" value="${data[0].goodsCode}" name="goodsCode"> 
		<input type="hidden" value="${data[0].goodsBatchPrice}" name="goodsBatchPrice"> 
		<input type="hidden" value="${data[0].quantity}" name="quantity"> 
		<input type="hidden" value="${data[0].creatTime}" name="time"> 
		<input type="hidden" value="${data[0].goodsParValue}" name="goodsParValue"> 
		<input type="hidden" value="${data[0].suggestRetailPrice}" name="suggestRetailPrice"> 
			<!--动态内容区 start-->
			<div style="text-align: center;" >
					<table width="100%" border="0" cellpadding="4" cellspacing="0" class="t_font14"  style="margin: 0 auto;">
						<tbody>
						<tr style="display:none;">
							<td width="34%" align="right" nowrap="nowrap">
								订单号:
							</td>
							<td width="66%" align="left" colspan="2">
								<strong >
								<input type ='text' style="border-style:none;  font-size:18px;  color:#969696;width:200px; background-color:white;" name="orderCode" id ='orderCode'></input></strong>
							</td>
						</tr>
						<tr>
							<td width="34%" align="right" nowrap="nowrap">
								商品名称:
							</td>
							<td width="66%" align="left" colspan="2">
								<strong>${data[0].goodsName}</strong>
							</td>
						</tr>
						<tr>
							<td width="34%" align="right" nowrap="nowrap">
								商品编号:
							</td>
							<td width="66%" align="left" colspan="2">
								<strong>${data[0].goodsCode}</strong>
							</td>
						</tr>
						<tr >
							<td width="34%" align="right" nowrap="nowrap">
								批价 (元):
							</td>
							<td width="66%" align="left" colspan="2">
								<strong>${data[0].goodsBatchPrice}</strong>
							</td>
						</tr>
						<tr >
							<td width="34%" align="right" nowrap="nowrap">
								面值 (元):
							</td>
							<td width="66%" align="left" colspan="2">
								<strong>${data[0].goodsParValue}</strong>
							</td>
						</tr>
						<tr >
							<td width="34%" align="right" nowrap="nowrap">
								建议零售价 (元):
							</td>
							<td width="66%" align="left" colspan="2">
								<strong>${data[0].suggestRetailPrice}</strong>
							</td>
						</tr>
						<tr >
							<td width="34%" align="right" nowrap="nowrap">
								库存数量:
							</td>
							<td width="66%" align="left" colspan="2">
								<strong>${data[0].quantity}</strong>
							</td>
						</tr>
						<tr id="gameno_tr" style="font-size:18px;font-family:Arial;">
								<td style="text-align: right; vertical-align: middle;"  width="30%">销售价格(元):</td>
						<td align="left"  width="70%" style="padding: 5px 0;" colspan="2">
						<input maxlength=9        name="sellPrice" id="sellPrice"  class="input"  value="${data[0].suggestRetailPrice}" >
						&nbsp;<span id="sellPriceTip" style="width:250px" class=""></span>
                		</td>
						</tr>
						<tr id="gameno_tr" style="font-size:18px;font-family:Arial;">
								<td style="text-align: right; vertical-align: middle;">销售数量:</td>
						<td align="left" colspan="2">
						<input onkeyup="value=value.replace(/[^\d]/g,'') "   class="input" value="1"  name="sellQuantity" id="sellQuantity"
						onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
                		</td>
						</tr>
						<tr id="gameno_tr" style="font-size:18px;font-family:Arial;">
								<td style="text-align: right; vertical-align: middle;">交易密码:</td>
								<td  style="padding: 5px 0;"><input type="password" value="" name="supperPassword" class="input" id="supperPassword" autocomplete="off"></td>
                				<td> <span id="supperPasswordTip" style="width:180px;font-size: 12px;" class=""></span> </td>
						</tr>
						<tr style="display:none;">
							<td width="24%" align="right" nowrap="nowrap">
								总金额(元):
							</td>
							<td width="76%" align="left">
								<strong ><input type ='text' style="border-style:none;  font-size:18px;  color:#969696;width:200px; background-color:#f7f7f7;" name="totalPrice" id ='totalPrice'></input></strong>
							</td>
						</tr>
					</tbody></table></div>
					<!--动态内容区 end -->
					<div class="bt_button"  style="height: 80px;display:block;padding-top: 10px;">
						<span>	<c:if test="${data[0].quantity=='0'}"><p style="color: red;">库存量不足</p></c:if>
						<input type="button"  class="bt Partorange" id="cz_bt" value="提交订单" 	 	
						style="margin-top: 10px;<c:if test="${data[0].quantity=='0'}"> display: none</c:if>"> </span>
						<span>	<a href="javascript:void(0)" onclick="javascript:history.go(-1);" style="font-size: 12px;">返回</a></span>
						
					</div>
					<div class="bt_submit" style="width: 700px;height: 150px;display: none;" >
						<span><input type="button" id="fk_sb" class="bt_bg Partorange" onclick="buy()" value="确定购买" style="margin-top: 10px;"> </span>
						<span>	
						<a href="<%=basePath%>goodsSales/realitySales.do?stockId=${data[0].stockId}" onclick="javascript:history.go(-1);" style="font-size: 12px;">返回</a>
						</span>
					</div>
				</form>
		</div>
		
		 <div id="success" style="text-align: center;height: 150px;display: none;">
	       <div style="height: 150px;margin-top: 100px;">
	       		<span style="border-top: 30px;"><strong style="color: red;font-size: 35px;" id="successMessage">销售成功</strong></span>
						<span>	<a href="javascript:void(0)" onclick="javascript:history.go(-1);" style="font-size: 12px;">返回</a></span>
	       <div >
	       		</div>
	       </div>
       </div>
       </div>
  </div>
  </div>
  </body>
</html>
