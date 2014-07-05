<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
		<script language="JavaScript" src="<%=basePath%>js/buycreditNew.js?1211" type="text/JavaScript"></script>
<style type="text/css">
.block {clear: both;height: 80px;border: 1px solid #efefef;font-size: 14px;}
.formul  {margin-left: 100px;margin-top: 30px;}
.formul  select{font-size: 15px;line-height: 15px;width: 80px;height: 25px;}

 
.button li{float: left;text-align:center;margin: 10px 0;}

.note{background-color: rgb(243, 244, 245);padding: 10px 10px;}
.spcxtj table.cxjg tr td.wz{
padding:5px;background:#f2f0f0 url(${ctx}/images/ofui_protype.png) left -632px repeat-x;text-align:center;vertical-align: middle;border:1px solid #ccc;border-width:0 0 1px 1px;font-weight:bold;
 }
.cxjg{border: 1px solid #ccc;
 
</style>
<script type="text/javascript">
 $(function(){
	 init();
 })

 function init(){
 	$.ajax({
 		cache : true,
 		type : "POST",
 		async : false,
 		dataType:'json',
 		url:'<%=basePath%>credit/toBuyCreditInit.do',
 		success:function(data){
 		if(data.retcode==0){
 			var data = data.data;
 			var  banks = data.banks;
 			var  alipayList = data.alipayList;
 			var  tenpayList = data.tenpayList;
 			var  tenpays = data.tenpays;
 			var  alipay_is_show = data.alipay_is_show;
 			var  tenpay_is_show = data.tenpay_is_show;
 			var  tl_is_show = data.tl_is_show;
 			var  yl_is_show = data.yl_is_show;
 			if(alipay_is_show==0){
 				$("#gmxzzf1").show();
 			}else{
 				$("#con_gmxzzf_1").hide();
 				$("#gmxzzf1").hide();
 			}
 			if(tenpay_is_show==0){
 				$("#gmxzzf2").show();
 			}else{
 				$("#con_gmxzzf_2").hide();
 				$("#gmxzzf2").hide();
 			}
 			if(tl_is_show==0){
 				$("#gmxzzf4").show();
 			}else{
 				$("#con_gmxzzf_4").hide();
 				$("#gmxzzf4").hide();
 			}
 			if(yl_is_show==0){
 				$("#gmxzzf5").show();
 			}else{
 				$("#con_gmxzzf_5").hide();
 				$("#gmxzzf5").hide();
 			}
 			$("#ul_bank_card_pay").html();
 			var banksHtml = "";
 			$.each(alipayList,function(i,attr){
 				var bankBriefCode = attr.bankBriefCode; 
 				var id = attr.id; 
 				var bankBriefCode = "alipay_"+attr.bankBriefCode; 
 				var bankName = attr.bankName; 
 				if(i==0){
	 				banksHtml +="<li><input type='radio'  checked='checked'  value="+id+" id='"+bankBriefCode+"' name='select_paygate' /> <label  id='"+bankBriefCode+"_label' title="+bankName+" for='"+bankBriefCode+"' class='bank "+bankBriefCode+"'>"+bankName+"</label></li>";
 				}else{
	 				banksHtml +="<li><input type='radio' id='"+bankBriefCode+"' value="+id+" name='select_paygate' /> <label  id='"+bankBriefCode+"_label' title="+bankName+" for='"+bankBriefCode+"' class='bank "+bankBriefCode+"'>"+bankName+"</label></li>";
 				}
 				})
			$("#ul_bank_card_pay").html(banksHtml);
 		
 			$("#tenpayBankList").html();
 			var banksHtml = "";
 			$.each(tenpayList,function(i,attr){
 				var bankBriefCode = attr.bankBriefCode; 
 				var id = attr.id; 
 				var bankBriefCode = "tenpay_"+attr.bankBriefCode; 
 				var bankName = attr.bankName; 
	 				if(i==0){
		 				banksHtml +="<li><input type='radio' checked='checked' id='"+bankBriefCode+"' value="+id+" name='select_tenpaygate' /> <label  id='"+bankBriefCode+"_label' title="+bankName+" for='"+bankBriefCode+"' class='bank "+bankBriefCode+"'>"+bankName+"</label></li>";
	 				}else{
		 				banksHtml +="<li><input type='radio'  id='"+bankBriefCode+"' value="+id+" name='select_tenpaygate' /> <label  id='"+bankBriefCode+"_label' title="+bankName+" for='"+bankBriefCode+"' class='bank "+bankBriefCode+"'>"+bankName+"</label></li>";
	 				}
 				})
			$("#tenpayBankList").html(banksHtml);
 			
 			
 			$(".tenpay").html();
 			var tenpayHtml = "";
 			$.each(tenpays,function(i,attr){
 				var bankBriefCode = attr.bankBriefCode; 
 				var id = attr.id; 
 				var bankBriefCode = "tenpay_"+attr.bankBriefCode; 
 				var bankName = attr.bankName; 
 					tenpayHtml += "<h1>"+bankName+"</h1>";
 					tenpayHtml +="<ul><li><input type='radio'  value="+id+" name='select_tenpaygate' onclick='changeBuyType(4);'/> <label  id='"+bankBriefCode+"_label' title="+bankName+" for='"+bankBriefCode+"' class='bank "+bankBriefCode+"'>"+bankName+"</label></li></ul>";
 				})
			$(".tenpay").html(tenpayHtml);
 			
 			$(".banks").html();
 			var banksHtml = "";
 			$.each(banks,function(i,attr){
	 				var bankBriefCode = attr.bankBriefCode; 
	 				var id = attr.id; 
	 				var bankName = attr.bankName; 
	 				var payee = attr.payee; 
	 				var accountCode = attr.accountCode; 
	 				banksHtml += "<tr>";
	 				banksHtml += "<td><input type='radio' name='rmBank' checked='checked'  value="+id+" onclick='changeBuyType(1);'  /></td>";
	 				banksHtml += "<td>"+bankName+"</td>";
	 				banksHtml += "<td>"+payee+"</td>";
	 				banksHtml += "<td>"+accountCode+"</td>";
	 				banksHtml +="</tr>";
 				})
			$(".banks").html(banksHtml);
 		}
 		},error:function(e){
 			alert(e.status);			
 		}
 	})
 }
 
 
function setTabBank(name,cursel,n){ 
		for(i=1;i<=n;i++){
			var menu=document.getElementById(name+i);
			var con=document.getElementById("con_"+name+"_"+i);
			menu.className=i==cursel?"hover":"";
			con.style.display=i==cursel?"block":"none";
		}
		$("#selectPayType").val(cursel); 
		if(cursel==3){  
		 	$("#rmPay").attr({style:"display:block"});
		    $("#alipy_bankPay").attr({style:"display:none"});
		}else{
			 $("#rmPay").attr({style:"display:none"});
		     $("#alipy_bankPay").attr({style:"display:block"});
		}
		
		if(cursel==1||cursel==2){
			$("#buyType").val("2");			
		}else{
			$("#buyType").val("1");			
		}
		
		if(cursel==4){
			queryPage();
		}else if(cursel==5){
			queryPageUn();
		}
	}
	
function createAmount(){
	validateAmount();
	createOddAmount();
}
function validateAmount(){
var amount = $("#rmAmount").val(); 
if(amount!=""){
	if(isNaN(amount) || parseFloat(amount)<=0){
		alert("汇款金额不正确，请重新输入！");
		$("#rmAmount").val(""); 
		$("#oddAmount").val(""); 
		$("#rmAmount").focus();
		return false;
	}	
	
	//信用卡还款金额不能到分
	if(amount.indexOf(".")>0){
		alert("汇款金额只能是整数，请重新输入")
		$("#rmAmount").val(""); 
		$("#oddAmount").val(""); 
		$("#rmAmount").focus();
		return false;
	}
}else{
	alert("请输入正确汇款金额");
	$("#rmAmount").val(""); 
	$("#oddAmount").val(""); 
	$("#rmAmount").focus();
	return false;
}
return true;
}
function createOddAmount() {
    var oddAmount = parseInt(Math.random() * (9) + 1);
    if (oddAmount == 10) {
        createOddAmount();
    } else {
        oddAmount = "0." + oddAmount;
      $("#oddAmount").val(oddAmount);   
    }
}

function changeBuyType(buytype){ 
	 $("#buyType").val(buytype);
}



	
	//添加、编辑通联账号 
	function alterBackAccount(style,type,param){  
		var name = "";
		var url;
		if(style==0){
			url = "<%=basePath%>allinpay/"+type+"TlAccount.do?id="+param;
			name = "通联";
		}else if(style==1){
			url = "<%=basePath%>unionpay/"+type+"UnAccount.do?id="+param;
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
	};
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
     
        <div class="nyRight">
          <div class="nyTit">财务管理 &gt; 购买信用点</div>
         <form name="buyxydfrm"    id="buycreditform" method="post"		action="<%=basePath%>credit/buyCredit.do"	onsubmit="return chkCreditSub();">
        	<input type="hidden"   id="alipay_buy_action"	        value="<%=basePath%>alipay/prepay.do" />
			<input type="hidden"   id="tenpay_buy_action"			value="<%=basePath%>tenpay/prepay.do" />
			<input type="hidden"   id="tlpay_buy_action"			value="<%=basePath%>allinpay/prepay.do" /><!-- singleDaiFushi -->
			<input type="hidden"   id="unpay_buy_action"			value="<%=basePath%>unionpay/prepay.do" /><!-- singleDaiFushi -->

			<input type="hidden" name="buyType" id="buyType" value="2" />
			<input type="hidden" name="type" id="type" value="1" />
			<input type="hidden" name="selectPayType" id="selectPayType"		value="1" />

			<input type="hidden" name="bank_type_value" id="bank_type_value"		value="0" />
         
         
          <div class="block" id="alipy_bankPay" style="display: none;" >
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
			<div class="block pusht" id="rmPay"  >
				<div style="margin-top: 30px;margin-left: 10px;">
				
						<span class="Lfloat gntitbg"> 汇款购买信用点</span>
						<span class="Lfloat"></span><span class="Lfloat gntitbg">金额：<input
								size="8" type="text" name="rmAmount" id="rmAmount" class="input11"
								onkeyup="createAmount()" /> <samp>
								元
							</samp> 随机零头金额：<input size="6" type="text" name="oddAmount" id="oddAmount" class="input11"
								readonly="readonly" /> <samp>
								元
							</samp> 预留信息：<input type="text" name="remark" id="remark" class="input11" /> </span> 
				</div>
			</div>
			
          <div class="gamenamebox">
            <ul class="tit">
              <li id="gmxzzf1"   onclick="setTabBank('gmxzzf',1,5)">支付宝</li>
              <li id="gmxzzf2"   onclick="setTabBank('gmxzzf',2,5)">财付通</li>
              <li id="gmxzzf3"  class="hover"  onclick="setTabBank('gmxzzf',3,5)">银行汇款</li>
              <li id="gmxzzf4"   onclick="setTabBank('gmxzzf',4,5)">通联支付</li>
              <li id="gmxzzf5"   onclick="setTabBank('gmxzzf',5,5)">银联支付</li>
            </ul>
            <div class="gamename">
              <div class="gmxxd " id="con_gmxzzf_1" style="display: none;">
                <h1>网银直联</h1>
                <ul id="ul_bank_card_pay">
                  
                </ul>
                <h1>支付宝</h1>
                <ul>
                  <li>
                    <input type="hidden" name="alipay_cn_name" id="alipay_cn_name"value="支付宝" />
                  	<input type="radio" id="alipay_pay" onclick="changeBuyType(3);" name="select_paygate" value="ALIPAY_PAY" /> 
                  	<label  id="alipay_pay"   class="bank zhifubao" title="支付宝">支付宝</label>
                  </li>
                </ul>
              </div>
              <div class="gmxxd" id="con_gmxzzf_2" style="display: none;">
               <h1>网银直联</h1>
                <ul id="tenpayBankList">
                  
                </ul>
                  <div class="tenpay">
	               
                  </div>
              </div>
              <div class="gmxxd spcxtj" id="con_gmxzzf_3" >
                 <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
		              <tr>
			              <td class="wz">序号</td>
			              <td class="wz">汇款银行</td>
			              <td class="wz">收款人</td>
			              <td class="wz">收款账号</td>
		              </tr>
		              <tbody class="banks">
		              
		              </tbody>
		              
		              <tr>
		              <td colspan="4" style="text-align : left;">
												<strong>备注：</strong>
												<br />
												汇款后请主动联系客服，同时建议汇款金额后面带零头，便于客服核对。
		
												<br />
												费率：同城免费，异地：网银0.2%，最低2元，封底20元。柜台＜1万
												5.5元;1万＜柜台＜10万，10.5元;10万＜柜台＜50，15.5元；封底50元，公对公交易按人行公布费率执行。
												<br />
						</td>
		              </tr>
	              </table>
              </div>
              <div class="gmxxd spcxtj" id="con_gmxzzf_4" style="display: none;">
	              <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg" id="tablelist_tl"> 
	              <tr>
		              <td class="wz">序号</td>
		              <td class="wz">银行账号</td>
		              <td class="wz">持卡人</td>
		              <td class="wz">证件类型</td>
		              <td class="wz">证件号</td>
		              <td class="wz">开户行</td>
		              <td class="wz">省份</td>
		              <td class="wz">城市</td>
		              <td class="wz">签约状态</td>
		              <td class="wz"  colspan="2">操作</td>
	              </tr>
	              <tbody class="tlTableData">
	              
	              
	              </tbody>
	              </table>
	             	<p style="display: none;">
							<a href="javascript:void(0)" onClick="javascript:alterBackAccount('0','add','');"><span style="font-size: 13px;">添加通联账号</span> </a>
					</p>
					 <div class="block note " style="height: 35px;">
						<strong>备注：</strong>
						<p>
							0元至999元扣手续费1元/笔，1000元及以上不扣手续费
						</p>
					 </div>
              </div>
              <div class="gmxxd spcxtj" id="con_gmxzzf_5" style="display: none;">
              
              <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg" id="tablelist_Un">
                <tr>
		              <td class="wz">序号</td>
		              <td class="wz">银行账号</td>
		              <td class="wz">持卡人</td>
		              <td class="wz">证件类型</td>
		              <td class="wz">证件号</td>
		              <td class="wz">开户行</td>
		              <td class="wz">省份</td>
		              <td class="wz">城市</td>
		              <td class="wz">签约状态</td>
		              <td class="wz" style="" colspan="2">操作</td>
	              </tr>
	          <tbody class="unTableData">
	          
	          </tbody>
              </table>
              
              	<p id="addTL" style='<c:if test="${parentId==-1}">display: none;</c:if>'>
							<a href="javascript:void(0)" onClick="javascript:alterBackAccount('1','add','');"><span style="font-size: 13px;">添加银联账号</span> </a>
              </p>
               <div class="block note " style="height: 35px;">
						<strong>备注：</strong>
						<p>
							0元至999元扣手续费1元/笔，1000元及以上不扣手续费
						</p>
					 </div>
              
              </div>
                 <ul class="button">
                 	 <li style="width: 100%"><input   type="submit" class="an_input2" id="button" value="确定充值" /></li>
                </ul>
                
                <div class="block note pusht">
				<strong>什么是信用点</strong>
				<p>
					信用点是一种用于数字卡购买的虚拟货币。信用点的兑价为1信用点=1人民币。目前信用点可以本站所有数字卡商品以及其他增值服务。信用点可以通过银行卡在线购买，银行汇款，邮局汇款等形式得到。
				</p>
				<p class="gray">
					<strong>经验：</strong>“便宜得离谱！”就意味着骗子！
				</p>
			</div>
            </div>
          </div>
          </form>
        </div>
      </div>
    </div>
 <%@include file="./bottom.jsp" %>
  </div>
</div>
 <script type="text/javascript">
  function queryPage(){  
		var tbody = "";
		$.ajax({
			url:'<%=basePath%>allinpay/find.do',
			dataType:'json',
			type:'post',
			cache:false,
			success:function(datas){
			$(".tlTableData").empty();
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
						   	$(".tlTableData").html(tbody);
				} else {
					$(".tlTableData").html('<tr><td colspan="10" align="center">没有符合条件的记录！</td></tr>');
				}

				
			},
			error:function(error){alert(error.status);}
		});
	}
  function replaceAcc(acct){
	  var l = acct.length;
	  if(l<10)return acct;
	  var st = acct.substring(0,4);
	  var en = acct.substring(l-4,l);
	  return st+"****"+en;
  }
  function queryPageUn(){  
		var tbody = "";
		$.ajax({
			url:'<%=basePath%>unionpay/find.do',
			dataType:'json',
			type:'post',
			cache:false,
			success:function(datas){
			$(".unTableData").empty();
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
						   	$(".unTableData").html(tbody);
						   	$("#addTL").hide();
				} else {
					$(".unTableData").html('<tr><td colspan="10" align="center">没有符合条件的记录！</td></tr>');
				}

				
			},
			error:function(error){alert(error.status);}
		});
	}
  </script>
</body>
</html>
