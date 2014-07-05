<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE>购买信用点</TITLE>
		
		<link type="text/css" rel="stylesheet"		href="<%=basePath%>themes/common/ofui.global.css" />
		<base href="<%=basePath%>">
		<link rel="stylesheet" type="text/css"		href="<%=basePath%>themes/common/bank.css" />
		<script type="text/javascript" language="javascript"		src="<%=basePath%>js/jquery.min.js"></script>
		<script language="JavaScript" src="<%=basePath%>js/buycredit.js?1211" type="text/JavaScript"></script>
		<script type="text/javascript" language="JavaScript"			src="<%=basePath%>js/thickbox.js"></script>
		<script language="JavaScript">
$(document).ready(function() {
	parent.resetTime();    
	// 绑定选中样式
		$("input[type=radio]").click(function() {
			var name = ($(this).attr('name'));
			var id = ($(this).attr('id'));
			$("input[type=radio][name=" + name + "]").removeClass('current');
			$("#" + id).addClass('current');
		});
	});
	
//添加、编辑通联账号 
function alterBackAccount(style,type,param){ 
	var name = "";
	var url;
	if(style==0){
		url = "allinpay/"+type+"TlAccount.do?id="+param;
		name = "通联";
	}else if(style==1){
		url = "unionpay/"+type+"UnAccount.do?id="+param;
		name = "银联";
	}
	
		var title = "";
		if(type == 'edit'){
			title ="编辑"+name+"账号 ";
		}else if(type=='query'){
			title ="查看"+name+"号";
		}else if(type=='add'){
			title ="添加"+name+"账号";
		}
		var width = 850;
		var height = 550;
		parent.LightBox(url, title, width, height);
}
function deleteTL(id,type){ 
	var bo = false;
	  if(confirm("确定要删除?")){
			bo=true;
		}
	  if(bo){
		  $.ajax({
				url:"<%=basePath%>allinpay/delete.do?id="+id,
					dataType:'json',
					type:'post',
					cache:false,
					success:function(datas){
						if(datas.retcode==0){
							alert("删除成功！");
						}else{
							alert("删除失败！");
						}
						if(type==0){
							queryPage();
						}else{
							queryPageUn();
						}
					},error:function(e){
						alert(e.status);
					}
			});
	  }
	
}
</script>
<style type="text/css">
body {
    color: #484848;
    font: 12px/1.5 Tahoma,Helvetica,Arial,Simsun,sans-serif;
}
.note, blockquote {
    background: none repeat scroll 0 0 #F3F4F5;
    border: 1px solid #CCCCCC;
}
#tenpay div ul {
	display: block;
}
.tenpay_ul_li {
	cursor: pointer;
}

.tab li a span, .tab-nojs li a span {
    background-position: left -402px;
    padding-left: 10px;
    padding-right: 0;
}
#supplierdataTable{font-size: 13px;}
html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, font, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, figcaption, figure, footer, header, hgroup, menu, nav, section, summary, time, mark, audio {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0);
    border: 0 none;
    margin: 0;
    outline: 0 none;
    padding: 0;
    vertical-align: baseline;
}
#tablelist_tl thead  tr th {font-size: 12px;}
#tablelist_Un thead  tr th {font-size: 12px;}
</style>
</HEAD>
	<BODY>
		<form name="buyxydfrm" id="buycreditform" method="post"		action="<%=basePath%>credit/buyCredit.do"	onsubmit="return chkCreditSub();">
			<div id="ajaxmsg" class="blockremark puhst disnone">
				<span id="bulletin"><span id="message"></span> </span>
			</div>
			<input type="hidden" name="alipay_buy_action" id="alipay_buy_action"	value="<%=basePath%>alipay/prepay.do" />

			<input type="hidden" name="tenpay_buy_action" id="tenpay_buy_action"			value="<%=basePath%>tenpay/prepay.do" />
			<input type="hidden" name="tlpay_buy_action" id="tlpay_buy_action"			value="<%=basePath%>allinpay/prepay.do" /><!-- singleDaiFushi -->
			<input type="hidden" name="unpay_buy_action" id="unpay_buy_action"			value="<%=basePath%>unionpay/prepay.do" /><!-- singleDaiFushi -->

			<input type="hidden" name="buyType" id="buyType" value="2" />

			<input type="hidden" name="selectPayType" id="selectPayType"		value="1" />

			<input type="hidden" name="bank_type_value" id="bank_type_value"		value="0" />
			<div class="block" id="alipy_bankPay">
				<ul class="formul">
					<li>
						<label>
							购买信用点金额 ：
						</label>
						<select name="cash" id="selCash" class="shorter">
							<option value="0.01">
								0.01
							</option>
							<option value="1">
								1
							</option>
							<option value="5">
								5
							</option>
							<option value="10">
								10
							</option>
							<option value="30">
								30
							</option>
							<option value="50">
								50
							</option>
							<option value="100">
								100
							</option>
							<option value="200">
								200
							</option>
							<option value="300">
								300
							</option>
							<option value="400">
								400
							</option>
							<option value="500" selected="">
								500
							</option>
							<option value="900">
								900
							</option>
							<option value="1000">
								1000
							</option>
							<option value="1500">
								1500
							</option>
							<option value="2000">
								2000
							</option>
							<option value="3000">
								3000
							</option>
							<option value="3500">
								3500
							</option>
							<option value="4000">
								4000
							</option>
							<option value="4500">
								4500
							</option>
							<option value="4999">
								4999
							</option>
							<option value="5000">
								5000
							</option>
							<option value="10000">
								10000
							</option>
							<option value="20000">
								20000
							</option>
							<option value="50000">
								50000
							</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span id="paymsg" style="color: red"></span>
					</li>
				</ul>
			</div>

			<div class="block pusht" id="rmPay" style="display: none;">
				<span class="Lfloat"></span>
				<span class="Lfloat gntitbg"> 汇款购买信用点</span>
				<span class="Rfloat"></span>
				<span class="Lfloat"></span><span class="Lfloat gntitbg">金额：<input
						size="8" type="text" name="rmAmount" id="rmAmount"
						onkeyup="createAmount()" /> <samp>
						元
					</samp> 随机零头金额：<input size="6" type="text" name="oddAmount" id="oddAmount"
						readonly="readonly" /> <samp>
						元
					</samp> 预留信息：<input type="text" name="remark" id="remark" /> </span><span
					class="Rfloat"></span>
			</div>

			<div class="boxall">
				<ul id="tab" class="tab pusht"> 
					 <li class="current" >
						<a href="javascript:void(0)" onclick="changebankshow('1')"><span>支付宝</span>
						</a>
					</li>
					<li class=""  >
						<a href="javascript:void(0)" onclick="changebankshow('2')"><span>财付通</span>
						</a>
					</li>
					<li class="">
						<a href="javascript:void(0)" onclick="changebankshow('3')"><span>银行汇款</span>
						</a>
					</li>
					<li class="">
						<a href="javascript:void(0)" onclick="changebankshow('4')"><span>通联支付</span>
						</a>
					</li>
					<li class="">
						<a href="javascript:void(0)" onclick="changebankshow('5')"><span>银联支付</span>
						</a>
					</li>
				</ul>

				<div class="blockcommon bankarea">
					<!-- 支付宝 -->	 
					<div style="display: block;" id="pay1">
						<p>
							网银直联
						</p>
						<ul id="ul_bank_card_pay" style="display: block;">
							<c:forEach items="${alipayList}" var="abank" varStatus="status">
								<li>
									<input type="radio" id="alipay_${abank.bankBriefCode}_bank" name="select_paygate" value="${abank.id}"
										onclick="changeBuyType(2);" <c:if test="${status.index==0}"> checked="checked"</c:if> />
									<label for="alipay_${abank.bankBriefCode}_bank"
										class="alipay_${abank.bankBriefCode}_bank_pic"
										onclick="changeBuyType(2);" title="${abank.bankName}">
										${abank.bankName}
									</label>
								</li>
							</c:forEach>
						</ul>
						<p>
							支付宝
						</p>
						<ul id="ul_third_pay" style="display: block;">
							<li>
								<input type="hidden" name="alipay_cn_name" id="alipay_cn_name"value="支付宝" />
								<input type="radio" id="alipay_pay" onclick="changeBuyType(3);"	name="select_paygate" value="ALIPAY_PAY" />
								<label for="alipay_pay" onclick="changeBuyType(3);"	class="alipay_pay_pic" title="支付宝">
									支付宝
								</label>
							</li>
						</ul>
					</div>
					
					<div id="tenpay" style="display: none;">
						<div style="display: block;">
							<TABLE style="FONT-SIZE: 12px" cellSpacing=1 cellPadding=3	width="100%" align=center bgColor=#D8D9DB border=0>
								<tr>
									<td width="754" height="36" style="background: #F1F3F2">
										&nbsp;
										<img src="<%=basePath%>images/logo.gif" />
										为您提供以下网上支付服务
										<span style="color: #868686">（财付通是腾讯旗下第三方支付平台）</span>
									</td>
								</tr>
								<tr>
									<td height="36" style="background: #FFFFFF; padding-left: 20px">
										<div id="tenpayBankList" style="display: block;">
											<p>
												网银直联
											</p>
											<ul style="display: block;">
												<c:forEach items="${tenpayList}" var="tenpaybank"
													varStatus="status">
													<li>
									<input type="radio" id="tenpay_${tenpaybank.bankBriefCode}_bank"		name="select_tenpaygate" value="${tenpaybank.id}" onclick="changeBuyType(2);"
									<c:if test="${status.index==0}"> checked="checked"</c:if> />
														<label for="tenpay_${tenpaybank.bankBriefCode}_bank"
															class="tenpay_${tenpaybank.bankBriefCode}_bank_pic"
															style="cursor: pointer" onclick="changeBuyType(2);"
															title="${tenpaybank.bankName}">
															${tenpaybank.bankName}
														</label>
													</li>
												</c:forEach>
											</ul>
											<p>
												财付通
											</p>
											<ul>
												<c:forEach items="${tenpays}" var="tenpay"
													varStatus="status">
													<li>
														<input type="radio" id="tenpay_${tenpay.bankBriefCode}_bank"
															name="select_tenpaygate" value="${tenpay.id}"
															onclick="changeBuyType(4);"
															/>
														<label for="tenpay_${tenpay.bankBriefCode}_bank"
															class="tenpay_${tenpay.bankBriefCode}_bank_pic"
															style="cursor: pointer" onclick="changeBuyType(4);"
															title="${tenpay.bankName}">
															${tenpay.bankName}
														</label>
													</li>
												</c:forEach>
											</ul>
										</div>
									</td>
								</tr>
							</TABLE>
						</div>
					</div>

					<!-- 汇款  -->
					<div style="display: none;" id="pay3">

						<table class="tablelist" align="center">
							<tbody>
								<tr>
									<th>
										序号
									</th>
									<th>
										汇款银行
									</th>
									<th>
										收款人
									</th>
									<th>
										收款帐号
									</th>
								</tr>
								<c:forEach items="${banks}" var="bank" varStatus="status">
									<tr>
										<td align="center">
											<input type="radio" name="rmBank" value="${bank.id}"
												onclick="changeBuyType(1);"
												<c:if test="${status.index==0}"> checked="checked"</c:if> />
										</td>
										<td align="center">
											${bank.bankName}
										</td>
										<td align="center">
											${bank.payee}
										</td>
										<td align="center">
											<p>
												${bank.accountCode}
											</p>
										</td>
									</tr>
								</c:forEach>
								<tr>
									<td colspan="4">
										<strong>备注：</strong>
										<br />
										汇款后请主动联系客服，同时建议汇款金额后面带零头，便于客服核对。

										<br />
										费率：同城免费，异地：网银0.2%，最低2元，封底20元。柜台＜1万
										5.5元;1万＜柜台＜10万，10.5元;10万＜柜台＜50，15.5元；封底50元，公对公交易按人行公布费率执行。
										<br />
									</td>
								</tr>
							</tbody>

						</table>

					</div>
					<!-- 通联支付 -->
					<div style="display: none;" id="pay4">
					 	<table class="tablelist pusht" id="tablelist_tl" >
							<thead>
								<tr>
									<th>
										序号
									</th>
									<th>
										银行账号
									</th>
									<th>
									持卡人
									</th>
									<th>
									证件类型
									</th>
									<th>
									证件号
									</th>
									<th>
									开户行
									</th>
									<th>
									 省份
									</th>
									<th>
									 城市
									</th>
									<th>
									签约状态
									</th>
									<th colspan="2">
									操作
									</th>
								</tr>
							</thead>
							<tbody id="supplierdataTable" style="text-align: center;" >
								
							</tbody>
						</table>
						
						<p style="display: none;">
							<a href="javascript:void(0)" onClick="javascript:alterBackAccount('0','add','');"><span style="font-size: 13px;">添加通联账号</span>
					</a>
						</p>
					</div>
					<!-- 银联支付 -->
					<div style="display: none;" id="pay5">
					 	<table class="tablelist pusht" id="tablelist_Un" >
							<thead>
								<tr>
									<th>
										序号
									</th>
									<th>
										银行账号
									</th>
									<th>
									持卡人
									</th>
									<th>
									证件类型
									</th>
									<th>
									证件号
									</th>
									<th>
									开户行
									</th>
									<th>
									 省份
									</th>
									<th>
									 城市
									</th>
									<th>
									签约状态
									</th>
									<th colspan="2">
									操作
									</th>
								</tr>
							</thead>
							<tbody id="supplierdataTable" style="text-align: center;" >
								
							</tbody>
						</table>
						
						<p id="addTL">
							<a href="javascript:void(0)" onClick="javascript:alterBackAccount('1','add','');"><span style="font-size: 13px;">添加银联账号</span>
					</a>
						</p>
					</div>
				</div>
			</div>

			<div class="tcenter">
				<button type="submit" class="big pusht unkjzf"  name="Submit">
					确定充值
				</button>
			</div>

			<div class="block note pusht">
				<strong>什么是信用点</strong>
				<p>
					信用点是一种用于数字卡购买的虚拟货币。信用点的兑价为1信用点=1人民币。目前信用点可以本站所有数字卡商品以及其他增值服务。信用点可以通过银行卡在线购买，银行汇款，邮局汇款等形式得到。
				</p>
				<p class="gray">
					<strong>经验：</strong>“便宜得离谱！”就意味着骗子！
				</p>
			</div>
		</form>
	</BODY>
	 <script type="text/javascript">
  function queryPage(){  
		$("#tablelist_tl tbody").empty();
		var tbody = "";
		$.ajax({
			url:'<%=basePath%>allinpay/find.do',
			dataType:'json',
			type:'post',
			cache:false,
			success:function(datas){
			$("#tablelist_tl tbody").empty();
			if(datas.retcode==0){
				var data = datas.data;
					$.each(data, function(index,dlist) {
								 tbody += "<tr>";
								 if(dlist.signStatus=="2"){
									 tbody+="<td   align='center'><input type='radio'   name='tl_radio'  checked value="+dlist.id+"></td>";
								 }else{
									 tbody+="<td   align='center'><input type='radio' name='tl_radio' disabled value="+dlist.id+"></td>";
								 }
								 var acct = replaceAcc(dlist.acct);
								 var idno = replaceAcc(dlist.idno);
								 tbody+="<td   align='center' >"+acct+" </td>";
								 tbody+="<td   align='center' >"+dlist.acName+" </td>";
								 tbody+="<td   align='center' >"+dlist.idTypeTrans+" </td>";
							     tbody+="<td align='center'> "+idno+" </td>";
							     tbody+="<td align='center'>"+dlist.bankName+"</td>";
							     tbody+="<td> "+dlist.province+" </td> "; 
							     tbody+='<td align="center">'+dlist.city+'</td> ';
							     tbody+='<td    align="center">'+dlist.signStatusTrans+'</td> ';
							     tbody+="<td    align='center'><a href='javascript:void(0)' onClick='javascript:alterBackAccount(0,\"edit\","+dlist.id+")';>编辑</a></td>";
							     if(dlist.signStatus==2||dlist.signStatus==1){
							     tbody+="<td    align='center'><a href='javascript:void(0)' disabled='disabled'	 >删除</a></td>";
							     }else{
									
							     tbody+="<td    align='center'><a href='javascript:void(0)' onClick=deleteTL("+dlist.id+",'0')>删除</a></td>";
							     }
							tbody += "</tr>";
							
					});
				}else if(datas.retcode==1){
					alert(datas.message);
				}
				if (tbody != '') {
						   	$("#tablelist_tl tbody").html(tbody);
				} else {
					$("#tablelist_tl tbody").html('<tr><td colspan="10" align="center">没有符合条件的记录！</td></tr>');
				}

				
			},
			error:function(error){alert(error.status);}
		});
		parent.resetTime();    
	}
  function replaceAcc(acct){
	  var l = acct.length;
	  if(l<10)return acct;
	  var st = acct.substring(0,4);
	  var en = acct.substring(l-4,l);
	  return st+"****"+en;
  }
  function queryPageUn(){  
		$("#tablelist_Un tbody").empty();
		var tbody = "";
		$.ajax({
			url:'<%=basePath%>unionpay/find.do',
			dataType:'json',
			type:'post',
			cache:false,
			success:function(datas){
			$("#tablelist_Un tbody").empty();
			if(datas.retcode==0){
				var data = datas.data;
					$.each(data, function(index,dlist) {
								 tbody += "<tr>";
								 if(dlist.signStatus=="2"){
									 tbody+="<td   align='center'><input type='radio'   name='un_radio'  checked value="+dlist.id+"></td>";
								 }else{
									 tbody+="<td   align='center'><input type='radio' name='un_radio' disabled value="+dlist.id+"></td>";
								 }
								 var acct =replaceAcc(dlist.acct);
								 var idno = replaceAcc(dlist.idno);
								 tbody+="<td   align='center' >"+acct+" </td>";
								 tbody+="<td   align='center' >"+dlist.acName+" </td>";
								 tbody+="<td   align='center' >"+dlist.idTypeTrans+" </td>";
							     tbody+="<td align='center'> "+idno+" </td>";
							     tbody+="<td align='center'>"+dlist.bankName+"</td>";
							     tbody+="<td> "+dlist.province+" </td> "; 
							     tbody+='<td align="center">'+dlist.city+'</td> ';
							     tbody+='<td    align="center">'+dlist.signStatusTrans+'</td> ';
							     if(dlist.signStatus==2||dlist.signStatus==1){
							     tbody+="<td    align='center'><a href='javascript:void(0)' disabled='disabled' >编辑</a></td>";
							     tbody+="<td    align='center'><a href='javascript:void(0)' disabled='disabled'	 >删除</a></td>";
							     }else{
							     tbody+="<td    align='center'><a href='javascript:void(0)' onClick='javascript:alterBackAccount(1,\"edit\","+dlist.id+")';>编辑</a></td>";
							     tbody+="<td    align='center'><a href='javascript:void(0)' onClick='deleteTL("+dlist.id+",\"1\")';>删除</a></td>";
							     }
							tbody += "</tr>";
							
					});
				}else if(datas.retcode==1){
					alert(datas.message);
				}
				if (tbody != '') {
							$("#addTL").hide();
						   	$("#tablelist_Un tbody").html(tbody);
				} else {
					$("#addTL").show();
					$("#tablelist_Un tbody").html('<tr><td colspan="10" align="center">没有符合条件的记录！</td></tr>');
				}

				
			},
			error:function(error){alert(error.status);}
		});
		parent.resetTime();    
	}
  </script>
</HTML>

