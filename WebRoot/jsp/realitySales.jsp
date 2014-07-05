<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<%
String stockId= request.getParameter("stockId");
%>
<style type="text/css">
.font01 {font-weight: 700;font-size: 19px;}
.hidetxt{cursor:default;border: 0px solid #FF0000; }
</style>
<script type="text/javascript">
var flag = false;
$(function(){
	init();
	option();
	queryPage();
})
function option(){
	 $.formValidator.initConfig({
		 formID:"orderForm",
		 submitOnce:true,
		 onSuccess:function(){
				//alert("校验组1通过验证，不过我不给它提交");	
				tjButton();
		 },onerror:function(msg,obj,errorlist){
				alert(msg);
			}
		});
	 $("#fk_sb").click(function() { 
			 if(flag){
				 alert("请不要重复提交");
			}else{
				saveOrder();
				flag = true;
			}
		 });
	$("#sellPrice").formValidator({ tipid: "sellPriceTip",onShow:"默认为面值",onFocus:"默认为面值",onCorrect:""})
  .regexValidator({regExp:"decmal6",dataType:"enum",onError: "输入错误"});
		$("#sellQuantity").formValidator({ tipid: "sellQuantityTip",onShow:"请输入销售数量",onFocus:"请输入销售数量",onCorrect:"销售数量合法"})
  		.regexValidator({regExp:"intege1",dataType:"enum",onError: "输入错误"});
  
		 
			$("#supperPassword").formValidator({onShow:"请输入交易密码",onFocus:"至少8位字符或数字",onCorrect:"交易密码格式正确"}).
			inputValidator({min:8,max:20,onError:"交易密码至少8位"});
	 
}
 function tjButton(){ 
	 	var  stockId = $("#stockId").val();
	 	var sellQuantity = $("#sellQuantity").val();
	 	var goodsBatchPrice = $("#goodsBatchPrice").val();
	 	var sellPrice = $("#sellPrice").val();
		var goodsCode =	$("#goodsCode").val();
		var supperPassword =	$("#supperPassword").val();
		$.ajax({
				url:'<%=basePath%>goodsSales/reality/createRealGoodsOrder.do',
				type:'post',
				dataType:'json',
				data:{"stockId":stockId,"sellQuantity":sellQuantity,"goodsBatchPrice":goodsBatchPrice,"sellPrice":sellPrice,"goodsCode":goodsCode,"supperPassword":$.md5(supperPassword)},
				success:function(data){
				 if(data.retcode=="1"){
					 alert(data.message);
				 }else{
						$("#orderCode").val(data.data.orderCode);
						$(".orderCodeTip").html(data.data.orderCode);
						$(".bt_01").hide();
						$(".hide").show();
						$('.hid_vild').hide();
						$(".orderForm input[type='text']").addClass("hidetxt").attr("UNSELECTABLE","on");
						$("#sellPrice").attr("disabled",true).unFormValidator(true); //解除校验
						$("#sellQuantity").attr("disabled",true).unFormValidator(true); //解除校验
						step(2);
					}
				},error:function(){
					alert("error");
				}
				});
	}


 function saveOrder(){ 
	showMask();
	var orderCode = $("#orderCode").val();
	var token = $("#token").val();
	  $.ajax({
			url:'<%=basePath%>goodsSales/reality/saveRealGoodsOrder.do',
			type:'post',
			dataType:'json',
			timeout:"120000",
			//async:false,
			data:{'orderCode':orderCode,'token':token},
			success:function(data){
				 if(data.retcode=="1"){
					 alert(data.message);
					 location.href='<%=basePath%>jsp/realitySales.jsp?stockId='+$("#stockId").val();
				 }else{
					 step(3);
					 $(".center_form").hide();
					 $("#success").show();
					 $("#showMessage").html(data.message);
					 ajaxAccount();	
					 queryPage();
				}
			  $("#mask").hide();
			},error:function(e){
				if(e.status==0){
					 step(3);
					 $(".center_form").hide();
					 $("#success").show();
					 ajaxAccount();	
					 queryPage();
				}else{
					alert("error:"+e.status);
				}
				$("#mask").hide();
			}
			});
 }
 
function init(){ 
	var stockId = '<%=stockId%>';
	$.ajax({
		url:"<%=basePath%>goodsSales/realitySalesInit.do",
		type:'post',
		dataType:'json',
		cache : 'false',
		syanc:'false',
		data:{'stockId':stockId},
		success:function(data){
		if(data.retcode==0){
			var goodInfo =  data.data[0];
			var token = data.data[1].token;
		var stockId = goodInfo.stockId;
		var suggestRetailPrice = goodInfo.suggestRetailPrice;
		var quantity = goodInfo.quantity;
		var goodsName = goodInfo.goodsName;
		var goodsCode = goodInfo.goodsCode;
		var goodsPicture = goodInfo.goodsPicture;
		var goodsBatchPrice = goodInfo.goodsBatchPrice;
		var goodsParValue = goodInfo.goodsParValue;
		var createTime = goodInfo.createTime;
		var remark = goodInfo.remark;
		var isSell = goodInfo.isSell;
		var isHaveBatchlevel = goodInfo.isHaveBatchlevel;
	 		$(".goodsNameTip").html(goodsName);
	 		$(".goodsCodeTip").html(goodsCode);
	 		$("#goodsCode").val(goodsCode);
	 		$(".goodsBatchPriceTip").html(goodsBatchPrice);
	 		$(".goodsParValueTip").html(goodsParValue);
	 		$(".suggestRetailPriceTip").html(suggestRetailPrice);
	 		$(".quantityTip").html(quantity);
	 		$("#sellPrice").val(suggestRetailPrice);
	 		$("#sellQuantity").val(1);
	 		$("#goodsBatchPrice").val(goodsBatchPrice);
			//$("#message").html(maeeage);
			$("#token").val(token);
		}else{
			alert(data.message);
		}
		},error:function(e){
			alert(e.status);
		}
	})
}

function step(num){
	document.getElementById("czbzTit").className = "czbzTit0"+num;
}
//兼容火狐、IE8
function showMask(){
	$("#mask").css("height",600);
	$("#mask").css("width",860);
	$("#mask").show();
}
function clean(){
	 var stockId = $("#stockId").val();
	  location.href="<%=basePath%>jsp/realitySales.jsp?stockId="+stockId;
}  
</script>
<style type="text/css">
.hidetxt{cursor:default;border: 0px solid #FF0000;}
.czxx table tr td{height: 25px;line-height: 25px;}
</style>
</head>

<body>
<div class="main">

<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
<%@include file="./menu.jsp" %>
      
        <div class="nyRight"> 
          <div class="nyTit">实体销售</div>
<div class="sjczBox" id="sjczBox" style="margin-top: 10px;">
 		  <div id="mask" class="mask" style="height:300px;position:absolute; top:240px; left:360px;line-height: 300px;width: 860px;display: none;" >订单处理中请稍后。。。</div>
        <div class="czbzTit01" id="czbzTit">  <h2>一：提交订单</h2>  <h3>二：支付订单</h3> <h4>三：充值成功</h4> </div>
 		<div style="display: block;" class="center_form" >
			<form id="orderForm" method="post" class="orderForm"> 
		<input type="hidden" name="token" id="token"  />
		<input type="hidden"  name="stockId" id="stockId" value="<%=stockId%>"> 
		<input type="hidden"  name="goodsName" id="goodsName"> 
		<input type="hidden"  name="goodsCode" id="goodsCode"> 
		<input type="hidden"  name="goodsBatchPrice" id="goodsBatchPrice"> 
		<input type="hidden"  name="quantity" id="quantity"> 
		<input type="hidden"   name="goodsParValue" id="goodsParValue"> 
		<input type="hidden"   name="suggestRetailPrice" id="suggestRetailPrice"> 
		<input  type="hidden"  name="orderCode" id="orderCode"></input>
		       <div class="czxx">
		              <table width="806" border="0" cellspacing="0" cellpadding="0">
						  <tr class="hide"  style="display: none;">
						    <td width="232"  class="wz">订单号：</td>
						      <td width="332"><span style="font-size: 20px;color: gray;" class="orderCodeTip"></span></td>
						    <td width="242">&nbsp;</td>
						  </tr>
						  <tr class="show" >
						    <td width="232"  class="wz">商品名称：</td>
						    <td width="332"><span style="font-size: 20px;color: gray;" class="goodsNameTip"></span></td>
						    <td width="242">&nbsp;</td>
						  </tr>
						  <tr class="show">
						    <td width="232"  class="wz">商品编号：</td>
						    <td width="332"><span style="font-size: 20px;color: gray;" class="goodsCodeTip"> </span></td>
						    <td width="242" >&nbsp;</td>
						  </tr>
						  <tr class="show">
						    <td width="232"  class="wz">批价（元）：</td>
						    <td width="332"><span style="font-size: 20px;color: gray;" class="goodsBatchPriceTip"> </span></td>
						    <td width="242"  >&nbsp;</td>
						  </tr>
						  <tr class="show">
						    <td width="232"  class="wz">面值（元）：</td>
						    <td width="332"><span style="font-size: 20px;color: gray;" class="goodsParValueTip"> </span></td>
						    <td width="242" >&nbsp;</td>
						  </tr>
						  <tr class="show">
						    <td width="232"  class="wz">建议零售价（元）：</td>
						    <td width="332"><span style="font-size: 20px;color: gray;" class="suggestRetailPriceTip"> </span></td>
						    <td width="242"  >&nbsp;</td>
						  </tr>
						  <tr class="show">
						    <td width="232"  class="wz">库存数量（元）：</td>
						    <td width="332"><span style="font-size: 20px;color: gray;" class="quantityTip"> </span></td>
						    <td width="242"  >&nbsp;</td>
						  </tr>
						  <tr class="show">
						    <td width="232"  class="wz">销售价格（元）：</td>
						    <td width="332"><input type="text" class="input5"  name="sellPrice"   id="sellPrice"    autocomplete="off" /></td>
						    <td width="242"  id="sellPriceTip" ></td>
						  </tr>
						  <tr class="show">
						    <td width="232"  class="wz">销售数量：</td>
						    <td width="332"><input type="text" class="input5"  name="sellQuantity"   id="sellQuantity"   autocomplete="off" /></td>
						    <td width="242"  id="sellQuantityTip" ></td>
						  </tr>
						  <tr class="hid_vild" >
						    <td class="wz">交易密码：</td>
						    <td><input name="supperPassword" type="password" class="input5" id="supperPassword" /></td>
						    <td><span id="supperPasswordTip" style="width:180px" class=""></span></td>
						  </tr>
							<tr  class="hide" style="display:none;">
								<td class="wz"><label  class="label">充值方式:</label></td>
								<td colspan="2" class="font01"> 快充 </td>
								<td></td>
							</tr>
							
						  <tr class="bt_01"  >
						    <td>&nbsp;</td>
						    <td><input name="button" type="submit" class="an_input1"  id="cz_bt" value="提交订单" />
						    <input name="button" type="reset" class="an_input1" id="button" value="重置" / style="margin-left:15px;"></td>
						    <td>&nbsp;</td>
						  </tr>
						  <tr class="hide" style="display: none;">
						    <td>&nbsp;</td>
						    <td style="float: left;"><input name="button" type="button" class="an_input1" id="fk_sb" value="确认充值" />
						    	<input name="button" type="button" class="an_input1" id="button" value="取消支付"  onclick="clean();" style="margin-left:15px;">
						    	</td>
						    
									
						    <td>&nbsp;</td> 
						  </tr>
				</table>
		  </div>
	    </form> 
    </div>
          	 <div id="success" style="border: 0px solid green;text-align: center;height: 100px;display: none;">
			       <div style="height: 200px;margin-top: 50px;">
			       		<span style="border-top: 30px;"><strong style="color: red;font-size: 30px;" id="showMessage">订单成功,是否充值成功请查看交易记录</strong>
			       		  <a  href="<%=basePath%>jsp/realitySales.jsp?stockId=<%=stockId%>">返回</a></span>
			       </div>
       		</div>
  </div>
        </div>
        <div class="zjcz">
        <div  width="970"  align="center">
               <span class="red" style="color: #f00;">最近5次交易记录 <a href="javascript:void(0)" onclick="queryPage()" ><img src="${ctx}/images/images/sx.gif" width="80" height="30" /></a></span> 
        </div>
          <table width="970" border="0" cellspacing="0" cellpadding="0" id="tablelist" class="tablelist"> 
          <thead>
             <tr>
              <td bgcolor="#eaf2f7">订单号</td>
              <td bgcolor="#eaf2f7">商品名</td>
              <td bgcolor="#eaf2f7">充值号码</td>
              <td bgcolor="#eaf2f7">数量</td>
              <td bgcolor="#eaf2f7">面值(元)</td>
              <td bgcolor="#eaf2f7">批价(元)</td>
              <td bgcolor="#eaf2f7">售价(元)</td>
              <td bgcolor="#eaf2f7">订单时间</td>
              <td bgcolor="#eaf2f7">订单状态</td>
            </tr></thead>
           <tbody id="supplierdataTable" style="text-align: center;" >
											
											
											</tbody>
          </table>
        </div>
        
        
        
        
      </div>
    </div>
   <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
 <script type="text/javascript">
  function queryPage(){ 
		$("#tablelist tbody").empty();
		var tbody = "";
		$.ajax({
			url:'<%=basePath%>tradingRecord/getTradeRecord.do',
			dataType:'json',
			type:'post',
			data:{'pageno':1,'pagesize':5,'goodsType':1},
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
				$(".tablelist tr").hover(function() {
					$(this).addClass("tbover");
				}, function() {
					$(this).removeClass("tbover");
				});
			},
			error:function(error){alert(error.status);}
		});
	}
  </script>
</html>
