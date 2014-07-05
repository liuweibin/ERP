<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<%
String tabNum= request.getParameter("num");
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
	changeSubTab('con_title_'+<%=tabNum%>,1,"");
	init();
	option();
	correctOrderfactorquery();
})
function option(){
	 
	 $.formValidator.initConfig({
		 formID:"orderForm",
		 debug:false,
		 submitOnce:true,
		 onSuccess:function(){
				//alert("校验组1通过验证，不过我不给它提交");
				tjButton();
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
			  }).functionValidator({
				  fun:valid_
				  });
			
			 $("#gameno").keyup(function() { d(this); });
			// $("#gameno").blur(function() { d(this); });
			
			
			$('#amount').blur(function() {
			   var obj=document.getElementById('checkbox').getElementsByTagName("li")
				var amount = $('#amount').val();
				if(amount.length>0){
				 var bo = false;
				 for(i = 0; i < obj.length; i++) {  
			 		 var cValue = $.trim(obj[i].outerText);
				      if(cValue == amount){  
				        obj[i].checked = true;
				        bo = true;
				      }  
				    }	
				}
			});
	 
}
 function tjButton(){ 
		var superPassword = $("#superPassword").val();
		var gameno = $("#gameno").val();
		var amount = $("#amount").val();
		superPassword = $.md5(superPassword);
		  $.ajax({
				url:'<%=basePath%>correctOrder/creatCorrectOrder.do',
				type:'post',
				dataType:'json',
				data:{"gameno":gameno,"amount":amount,"superPassword":superPassword},
				success:function(data){
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
						$('.hid_vild').hide();
						$('.show').hide();
						$('.hide').show();
						step(2);
					}
				},error:function(){
					alert("error");
				}
				});
	}

 /*
 根据冲正订单号创建新的充值工单
 */
  
 function correct(){ 
	 var correctOrderCode =document.getElementById("correctOrderCode").innerHTML;
	 if(correctOrderCode){
	 showMask();
	  $.ajax({
		  url:'<%=basePath%>correctOrder/creatRechargeOrder.do',
			type:'post',
			dataType:'json',
			timeout:"120000",
			//async:false,
			data:{ correctOrderCode:correctOrderCode},
			success:function(data, textStatus){
				var status = data.retcode;
	 			if(status==1){
	 					displayToggle($("#center"));
	 					$("#error").html("<strong style='color: red;font-size: 50px;'>"+data.message+"</strong><a href='<%=basePath%>correctOrder/correctOrderView.do'>返回</a>");
	 				displayToggle($("#error"));
	 			}else{
	 				 step(3);
	 				 $(".center_form").hide();
	 			    displayToggle($("#success"));
	 			    $("#successMessage").html(data.message);
	 			  	correctOrderfactorquery();
	 			     ajaxAccount(); $("#useable_banlance").html($("#useableBalance").html());
	 			}
	 			$("#mask").hide();
			},error:function(e){
				if(e.status==0){
					 step(3);
					 $(".center_form").hide();
	 			    displayToggle($("#success"));
	 				  correctOrderfactorquery();
	 			     ajaxAccount();
	 			    $("#mask").hide(); $("#useable_banlance").html($("#useableBalance").html());
	 			}else{
	 				alert(e.status);
	 				correctOrderfactorquery();
	 			}
			}
			});
 	}
 }

//获取可以冲正商品价格
function getGoodsPriceByGameno(type){
	var carrierName = "";
		$.ajax({
		url:'<%=basePath%>correctOrder/getGoodsPriceByGameno.do',
		type:'post',
		dataType:'json',
		cache:false,
		async:false,
		data:{gameno:$('#gameno').val(),'type':type},
		success:function(data, textStatus){
			var status = data.retcode;
			if(status==1){
				$("#gamenoTip").html(data.message);
				//alert(data.message);
			}else{
				 //$('.hide');
				$('.hid_vild').show();
				carrierName  = data.message;
				data = data.data;
				var checkbox = $(".checkbox");
				checkbox.html(''); 
				$.each(data,function(i,attr){
					if(i==0){
						$('#amount').val(attr.goodsPrice);
						$(".checkbox").append("<li><a href='javascript:void(0)' class='over'  onclick=changeSubTab('checkbox',0);change('"+attr.goodsPrice+"');>"+attr.goodsPrice+" </a></li>");
					}else{
						$(".checkbox").append("<li><a href='javascript:void(0)'    onclick=changeSubTab('checkbox','"+i+"');change('"+attr.goodsPrice+"');>"+attr.goodsPrice+" </a></li>");
					}
				});
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alert(textStatus);
		}
		});
return carrierName;
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
 	var bo1 = validPhone($("#gameno").val());//验证手机号位数
 	var bo2 = validfixed($("#gameno").val());//验证固话号位数
 	if(bo1||bo2){ 
 		
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
			 $("#amount").formValidator({onCorrect:"冲正金额合法",onShow:"",onFocus:"请输入30.00元到100000.00元之间的充值金额"})
				.inputValidator({min:1,	onError:"冲正金额不能为空,请确认"});
				var carrierName =	getGoodsPriceByGameno("gh");
				if(carrierName==""){
					$("#chkgamenoTip").html("该号码不可冲正");
				}else{
					$("#chkgamenoTip").html(carrierName);
				}
				return true;
			}
		  temp =validPhone(no);
		if(temp){   
			$("#amount").formValidator({onCorrect:"冲正金额合法",onShow:"",onFocus:"请输入30.00元到100000.00元之间的充值金额"})
			.inputValidator({min:1,	onError:"冲正金额不能为空,请确认"}).functionValidator({fun:isOk});
				var carrierName =	getGoodsPriceByGameno("sj");
				if(carrierName==""){
					alert("该号码不可冲正");
					$("#chkgamenoTip").html("该号码不可冲正");
				}else{
					$("#chkgamenoTip").html(carrierName);
				}
			return true;
		}
	}
 function isOk(){
	  var obj=document.getElementById('checkbox').getElementsByTagName("li")
		var amount = $('#amount').val();
		if(amount.length>0){
		 var bo = false;
		 for(i = 0; i < obj.length; i++) {  
	 		 var cValue = $.trim(obj[i].outerText);
		      if(cValue == amount){  
		        obj[i].checked = true;
		        bo = true;
		      }  
		    }	
		}
	 
			var amount = $('#amount').val();
			if(amount.length>0){
				 var bo = false;
				 var parValue ='';
				 for(i = 0; i < obj.length; i++) { 
					 var valueTemp = $.trim(obj[i].outerText);
					 	if(i<obj.length-1){
						 	parValue +=  valueTemp+" ,";
					 	}
					 	if(i==obj.length-1)	{
					 		parValue = parValue+valueTemp+";"
					 	}
					      if(valueTemp == amount){  
					        obj[i].checked = true;
					        bo = true;
					      }  
				    }	
				   if(!bo){
							return '请选择或输入以下面值(元):'+parValue;
				   } 			
			}
	}
function init(){
	$.ajax({
		url:"<%=basePath%>goodsSales/mobile/"+<%=tabNum%>+"C/sjcz.do",
		type:'post',
		dataType:'json',
		data:'',
		success:function(data){
			//alert(data.data.message);
			var maeeage = data.data.message;
			var token = data.data.token;
			$("#message").html(maeeage);
			$("#token").val(token);
		},error:function(e){
			alert(e.status);
		}
	})
}


 
function change(goodsPrice){  
			$("#amount").val(goodsPrice);
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
	$("#mask").css("height",400);
	$("#mask").css("width",860);
	$("#mask").show();
}

function correctOrderfactorquery() {
  	var url_ = "<%=basePath%>correctOrder/correctOrderList.do?fromBrowser=true&pageno=1&pagesize=5";
  	var num = <%=tabNum%>;
  	var goodsCategorySmallTblId = num=="0"?"2":"5";
  	$.ajax( {
  				cache : true,
  				type : "POST",
  				async : false,
  				url : url_,
  				data:{'orderStatusTemp':'1','goodsCategorySmallTblId':goodsCategorySmallTblId},
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
  					$(".tablelist tr").hover(function() {
  						$(this).addClass("tbover");
  					}, function() {
  						$(this).removeClass("tbover");
  					});
  				}
  			});
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
 		  <div id="mask" class="mask" style="height:300px;position:absolute; top:358px; left:360px;line-height: 300px;width: 860px;display: none;" >订单处理中请稍后。。。</div>
         <h1>支持<span id="message"></span>号码冲正 </h1>
        <div class="czbzTit01" id="czbzTit">  <h2>一：提交订单</h2>  <h3>二：确认冲正</h3> <h4>三：冲正成功</h4> </div>
 		<div style="display: block;" class="center_form" >
			<form id="orderForm" method="post" action=""> 
		  		<input type="hidden" name="token" id="token" />
				<input type="hidden" name="isFull" id="isFull" value="<%=tabNum%>">
				<input type="hidden" name="isByGoodsCode" id="isByGoodsCode" value="${isByGoodsCode}">
				<input type="hidden" name="loginType" value="0">
				<input type="hidden" name="goodsCode" id="goodsCode" value="${goodsCode}">
		       <div class="czxx">
		              <table width="806" border="0" cellspacing="0" cellpadding="0">
						  <tr class="show">
						    <td width="232"  class="wz">误交号码：</td>
						    <td width="332"><input type="text" class="input1"  name="gameno"   id="gameno"  maxlength="11"  autocomplete="off" /></td>
						    <td width="242"  id="gamenoTip" ></td>
						  </tr>
						  <tr class="show">
						    <td class="wz"></td>
						    <td>  <span name="chkgameno"   id='chkgameno' ></span> </td>
						    <td id="diqu"> </td>
						  </tr> 
						  <tr class="hid_vild"  style="display: none;">
						    <td class="wz">冲正金额(元)：</td>
						    <td><input name="amount" type="text" class="input1" id="amount" /></td>
						    <td><span id="amountTip" style="width:180px" class=""></span></td>
						  </tr>
						  <tr class="hid_vild" style="display: none;">
						    <td class="wz">冲正面值(元)：</td>
						    <td>    
						    <div class="money_list"> 
								<ul class="checkbox" id="checkbox">
									</ul>
							 </div>
							 </td>
						    <td>&nbsp;</td>
						  </tr> 
						  
						  <tr class="hid_vild"  style="display: none;">
						    <td class="wz">交易密码：</td>
						    <td><input name="superPassword" type="password" class="input1" id="superPassword" /></td>
						    <td><span id="supperPasswordTip" style="width:180px" class=""></span></td>
						  </tr>
						  
						  <tr class="hide" style="display:none;">
								<td class="wz">
									<label  class="label" style="size: 30px;">误交号码:</label>
								</td>
								<td  id="errorNo" class="font01" colspan="2"></td>
						   </tr>
							
						   <tr  class="hide" style="display:none;">
								<td class="wz"><label  class="label">充值金额(元):</label>
								</td>
								<td id="errorMoney" class="font01" colspan="2"></td>
							</tr>
							<tr class="hide" style="display:none;" >
								<td class="wz">
									<label  class="label">
									<p   id="oldRechargeCode" style="display: none"></p>
									<p   id="correctOrderCode" style="display: none"></p>
									充值流水:</label>
								</td>
								<td  id="orderCode" class="font01" colspan="2"></td>
							</tr>
							<tr   class="hide" style="display: none;" >
								<td class="wz"> <label  class="label" style="font-size: 18px;">充值时间:</label></td>
								<td id="orderCreateTime" class="font01" colspan="2"></td>
							</tr>
							
						  <tr class="hid_vild" style="display: none;">
						    <td>&nbsp;</td>
						    <td><input name="button" type="submit" class="an_input1"  id="creatSubmit" value="提交订单" />
						    <td>&nbsp;</td>
						  </tr>
						  <tr class="hide" style="display: none;">
						    <td>&nbsp;</td>
						    <td style="float: left;"><input name="button" type="button" class="an_input1" id="fk_sb" value="确定冲正" onclick="correct();" />
						    <a      href="<%=basePath%>./sjCorrect.jsp?num=0<%=tabNum%>">取消</a> </td>
						    <td>&nbsp;</td>
						  </tr>
				</table>
		  </div>
	    </form> 
    </div>
          	 <div id="success" style="border: 0px solid green;text-align: center;height: 100px;display: none;">
			       <div style="height: 200px;margin-top: 50px;">
			       		<span style="border-top: 30px;"><strong style="color: red;font-size: 30px;" id="successMessage">订单成功,是否充值成功请查看交易记录</strong>
			       		  <a      href="<%=basePath%>./sjCorrect.jsp?num=0<%=tabNum%>">返回</a></span>
			       </div>
       		</div>
  </div>
        </div>
        <div class="zjcz">
        <div  width="970"  align="center">
               <span class="red" style="color: #f00;">最近5次交易记录 <a href="javascript:void(0)" onclick="correctOrderfactorquery()" ><img src="<%=basePath%>images/images/sx.gif" width="80" height="30" /></a></span> 
        </div>
          <table width="970" border="0" cellspacing="0" cellpadding="0" id="tablelist" class="tablelist"> 
          <thead>
             <tr>
              <td bgcolor="#eaf2f7">冲正订单编号 </td>
              <td bgcolor="#eaf2f7">充值订单编号</td>
              <td bgcolor="#eaf2f7">充值工单编号 </td>
              <td bgcolor="#eaf2f7">商品名称</td>
              <td bgcolor="#eaf2f7">电话号码 </td>
              <td bgcolor="#eaf2f7">运营商</td>
              <td bgcolor="#eaf2f7">金额 (元)</td>
              <td bgcolor="#eaf2f7">处理时间 </td>
              <td bgcolor="#eaf2f7">状态 </td>
              <th>  
              
            </tr></thead>
           <tbody id="correctOrderdataTable" style="text-align: center;" >
											
											
											</tbody>
          </table>
        </div>
        
        
        
        
      </div>
    </div>
   <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
