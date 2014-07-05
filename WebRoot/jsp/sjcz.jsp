<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<base href="<%=basePath%>">
<%
String tabNum= request.getParameter("num");
String goodsCode= request.getParameter("goodsCode");
%>
<style type="text/css">
#chkgameno{
font-size: 35px;
font-weight: 700;
color: #d86201;
}

.money_list{width:330px; float:left; height:auto; line-height:41px; margin-left:10px;}
.money_list ul{list-style:none; margin-top:10px;}
.money_list ul li{margin-bottom:3px;width:52px; height:25px; line-height:25px; float:left; text-align:center; border:#1369c0 1px solid; margin-right:15px; font-family:"微软雅黑"; font-size:16px; color:#1369c0;}
.money_list ul li a{color:#185895;display:block;}
.money_list ul li a:active{color:#185895;}
.money_list ul li a:link{color:#185895;}
.money_list ul li a:visited{color:#185895;}
.money_list ul li a:hover{color:#185895; background-color:#69aae4; color:#FFFFFF;}
.money_list ul li a.over{color:#185895; background-color:#69aae4; color:#FFFFFF;}

.font01 {font-weight: 700;font-size: 19px;}
</style>
<script type="text/javascript">
var flag = false;
$(function(){
	changeSubTab('con_title_0',0)
	init();
	option();
queryPage();
})
function option(){
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
				tjButton();
		 },onerror:function(msg,obj,errorlist){
				alert(msg);
			}
		});
	 $("#fk_sb").click(function() {
		 if(!flag){
					saveOrder();
					flag = true;
				}else{
					alert("请不要重复提交");
				}
		 });
	//$("#sellPrice").formValidator({ tipid: "sellPriceTip",onShow:"默认为面值",onFocus:"默认为面值",onCorrect:""})
 // .regexValidator({regExp:"decmal6",dataType:"enum",onError: "输入错误"});
  
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
}
 function tjButton(){ 
	 	var sellPrice = $("#sellPrice").val();
		var loginType =$("#loginType").val();
		var gameno =	$("#gameno").val();
		var goodsCode =	$("#goodsCode").val();
		var supperPassword =	$("#supperPassword").val();
		  $.ajax({
				url:'<%=basePath%>goodsSales/mobile/createRechargeOrder.do',
				type:'post',
				dataType:'json',
				data:{"sellPrice":sellPrice,"loginType":loginType,"gameno":gameno,"goodsCode":goodsCode,"supperPassword":MD5(supperPassword)},
				success:function(data){
				 if(data.retcode=="1"){
					 alert(data.message);
				 }else{
						$('.bt_button').show();
						$('.hide').show();
						$(".hid_vild").hide();
						$(".show").hide();
						$('#orderCode').val(data.data.orderCode);
						$(".goodsName").show();
						//$("#batch_Price").html($("#batchPrice").html());
						$("#sell_Price").html($("#sellPrice").val());
						
						$("#phone_No").html($("#gameno").val());
						$("#order_Code").html(data.data.orderCode);
						$("#goodsName").html(data.data.goodsName);
						step(2);
						}
				},error:function(){
					alert("error");
				}
				});
	}


 function saveOrder(){ 
	 showMask();
	  $.ajax({
			url:'<%=basePath%>goodsSales/mobile/saveRechargeOrder.do',
			type:'post',
			dataType:'json',
			timeout:"120000",
			//async:false,
			data:$("#orderForm").serialize(),
			success:function(data){
			 if(data.retcode=="1"){
				 alert(data.message);
				 location.href='<%=basePath%>jsp/sjcz.jsp?num=<%=tabNum%>';
			 }else{
				 $('#success').show();
				 $("#showMessage").html(data.message);
				 $('.center_form').hide();
				 step(3);
				 ajaxAccount();	
			 queryPage();
			 $("#useable_banlance").html($("#useableBalance").html());
			}
			 $("#mask").hide();
			},error:function(e){
				if(e.status==0){
					 $('#success').show();
					 $('.center_form').hide();
					 step(3);
					 ajaxAccount();
					 queryPage();
				}else{
					alert("error:"+e.status);
					queryPage();
				}
				 $("#mask").hide();
			}
			});
 }

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
			$(".hid_vild").show();
			document.getElementById("supperPassword").focus();
		}else{
			$(".hid_vild").hide();
			$("#diqu").html('');
		}
	}else{
		$(".hid_vild").hide();
		$("#diqu").html('');
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
function isOk(){
	var boolen = false;
	var result ='';
	$.ajax({
		url:'<%=basePath%>goodsSales/verifyMobileNumberNew.do',
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
					var parValue =  attr.parValue/100.0;
					var goodsCode = attr.goodsCode;
					 if(i==0){
 					    $("#sellPrice").val(attr.suggestRetailPrice/100.0);
					//	$("#batchPrice").html(attr.batchPrice/100.0);
						$(".parValueShow").html(parValue);
						$("#goodsCode").val(goodsCode);
						$("#goodsName").val(attr.goodsName);
						$(".checkbox").append("<li><a href='javascript:void(0)' class='over' onclick=changeSubTab('checkbox',0);change('"+goodsCode+"')>"+parValue+" </a></li>");
					}else{ 
						$(".checkbox").append("<li><a href='javascript:void(0)'   onclick=changeSubTab('checkbox','"+i+"');change('"+goodsCode+"')>"+parValue+" </a></li>");
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

function init(){ 
	var tabNum = <%=tabNum%>;
	var goodsCode = '<%=goodsCode%>';
	$.ajax({
		url:"<%=basePath%>goodsSales/mobile/"+tabNum+"/sjcz.do",
		type:'post',
		dataType:'json',
		cache : 'false',
		data:{'goodsCode':goodsCode},
		success:function(data){
			var maeeage = data.data.message;
			var token = data.data.token;
			var isByGoodsCode = data.data.isByGoodsCode;
			var goodsCode = data.data.goodsCode;
			var goodsName = data.data.goodsName;
		//	var isFull = data.data.isFull;
			if(isByGoodsCode=="1"){
				$("#isByGoodsCode").val("1");// 商品编号充值的 标识	
				$("#goodsCode").val(goodsCode);	
				$("#goodsName").html(goodsName);	
				$(".goodsName").show();
			}else{
				$("#isByGoodsCode").val("0");
			}
			//$("#isFull").val(isFull);// 商品编号充值的 标识	
			$("#message").html(maeeage);
			$("#token").val(token);
		},error:function(e){
			alert(e.status);
		}
	})
}
 

function change(goodsCode){  
	  // $("#sellPrice").val(suggestRetailPrice);
		$.each(data_s,function(i,attr){
			if(attr.goodsCode==goodsCode){
	   				$("#sellPrice").val(attr.suggestRetailPrice/100.0);
					//$("#batchPrice").html(attr.batchPrice/100.0);
					$(".parValueShow").html(attr.parValue/100.0);
					$("#goodsCode").val(attr.goodsCode);
					$("#goodsName").val(attr.goodsName);
			}
		});
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

function step(num){
	document.getElementById("czbzTit").className = "czbzTit0"+num;
}

//兼容火狐、IE8
function showMask(){
	$("#mask").css("height",450);
	$("#mask").css("width",860);
	$("#mask").show();
}
</script>

</head>

<body>
<div class="main">

<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
<%@include file="./menu.jsp" %>
      
        <div class="nyRight"><%--
          <div class="nyTit">手机充值</div>
			<%@include file="./czTitle.jsp" %>
          --%>
			  <jsp:include page="czTitle.jsp" >
			  <jsp:param name="num" value="<%=tabNum%>" /> 
			</jsp:include>
<div class="sjczBox" id="sjczBox">
 		  <div id="mask" class="mask" style="height:450px;position:absolute; top:358px; left:360px;line-height: 300px;width: 860px;display: none;" >订单处理中请稍后。。。</div>
         <h1>支持<span id="message"></span>手机号码充值 </h1>
        <div class="czbzTit01" id="czbzTit">  <h2>一：提交订单</h2>  <h3>二：支付订单</h3> <h4>三：充值成功</h4> </div>
 		<div style="display: block;" class="center_form" >
			<form id="orderForm" method="post" action=""> 
		  		<input type="hidden" name="token" id="token" />
				<input type="hidden" name="isFull" id="isFull" value="<%=tabNum%>">
				<input type="hidden" name="isByGoodsCode" id="isByGoodsCode" value="">
				<input type="hidden" name="loginType" value="0">
				<input type="hidden" name="goodsCode" id="goodsCode" value="">
				<input type ='hidden'   name="orderCode" id ='orderCode'/>
		       <div class="czxx">
		              <table width="806" border="0" cellspacing="0" cellpadding="0">
						  <tr class="show goodsName"  style="display: none;">
						    <td width="232"  class="wz">商品名称：</td>
						    <td width="332"><span id="goodsName"></span></td>
						    <td width="242">&nbsp;</td>
						  </tr>
						  <tr class="show">
						    <td width="232"  class="wz">手机号码：</td>
						    <td width="332"><input type="text" class="input1"  name="gameno"   id="gameno"  maxlength="11"  autocomplete="off" /></td>
						    <td width="242"  id="gamenoTip" >&nbsp;</td>
						  </tr>
						  <tr class="show">
						    <td class="wz"></td>
						    <td> 
						    <span name="chkgameno"   id='chkgameno' ></span>
						    </td>
						    <td id="diqu"> </td>
						  </tr> 
						  <tr class="hid_vild" style="display: none;">
						    <td class="wz">面值（元）：</td>
						    <td id="praValue">    
						    <div class="money_list"> 
									<ul class="checkbox" id="checkbox">
									</ul>
							 </div>
							 </td>
						    <td>&nbsp;</td>
						  </tr> 
						  <tr   style="display: none;">
						    <td class="wz">实际销售价格（元）：</td>
						    <td><input name="sellPrice" type="text"  class="input4" id="sellPrice" /></td>
						    <td><span id="sellPriceTip" style="width:180px" class=""></span></td>
						  </tr>
						  <tr style="display: none;">
						    <td class="wz">批价（元）：</td>
						    <td> 
						    	<span id="batchPrice" style="font-size: 18px;font-weight: 700px;"></span>
						    </td>
						    <td>&nbsp;</td>
						  </tr>
						  <tr class="hid_vild"  style="display: none;">
						    <td class="wz">交易密码：</td>
						    <td><input name="supperPassword" type="password" class="input5" id="supperPassword" /></td>
						    <td><span id="supperPasswordTip" style="width:180px" class=""></span></td>
						  </tr>
						  
						  <tr class="hide" style="display:none;">
								<td class="wz">
									<label  class="label" style="size: 30px;">订单号 :</label>
								</td>
								<td  id="order_Code" class="font01" colspan="2"></td>
						   </tr>
							
						   <tr  class="hide" style="display:none;">
								<td class="wz"><label  class="label">手机号码:</label>
								</td>
								<td id="phone_No" class="font01" colspan="2"></td>
							</tr>
							<tr  style="display:none;" >
								<td class="wz">
									<label  class="label">批价(元):</label>
								</td>
								<td  id="batch_Price" class="font01" colspan="2"></td>
							</tr>
							<tr   style="display: none;" >
								<td class="wz"> <label  class="label" style="font-size: 18px;">实际销售价格(元):</label></td>
								<td id="sell_Price" class="font01" colspan="2"></td>
							</tr>
							<tr   class="hide" style="display: none;" >
								<td class="wz"> <label  class="label" style="font-size: 18px;">面值(元):</label></td>
								<td   class="font01 parValueShow" colspan="2"></td>
							</tr>
							<tr  class="hide" style="display:none;">
								<td class="wz"><label  class="label">充值方式:</label></td>
								<td colspan="2" class="font01"> 快充 </td>
							</tr>
							
						  <tr class="hid_vild" style="display: none;">
						    <td>&nbsp;</td>
						    <td><input name="button" type="submit" class="an_input1"  id="cz_bt" value="提交订单" />
						    <input name="button" type="reset" class="an_input1" id="button" value="重置" / style="margin-left:15px;"></td>
						    <td>&nbsp;</td>
						  </tr>
						  <tr class="bt_button" style="display: none;">
						    <td>&nbsp;</td>
						    <td style="float: left;"><input name="button" type="button" class="an_input1" id="fk_sb" value="确认充值" />
						    <a      href="<%=basePath%>jsp/sjcz.jsp?num=<%=tabNum%>">取消支付</a> </td>
						    <td>&nbsp;</td>
						  </tr>
				</table>
		  </div>
	    </form> 
    </div>
          	 <div id="success" style="border: 0px solid green;text-align: center;height: 100px;display: none;">
			       <div style="height: 200px;margin-top: 50px;">
			       		<span style="border-top: 30px;"><strong style="color: red;font-size: 30px;" id="showMessage">订单成功,是否充值成功请查看交易记录</strong>
			       		  <a      href="<%=basePath%>jsp/sjcz.jsp?num=<%=tabNum%>">返回</a></span>
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
			data:{'pageno':1,'pagesize':5,'goodsType':0,'categoryLargeId':'2','categorySmallId':'2','type':<%=tabNum%>},
			success:function(datas){//'type':${isFull},
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
