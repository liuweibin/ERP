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
	
})
 

 
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
     <table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td valign="bottom">
					<table width="100%" border="0" cellpadding="0" cellspacing="0" background=" ">
						<tr style="background-color: rgb(245, 245, 245);height: 30px;">
							<td width="118" nowrap="nowrap" align="left"  style="font-size: 14px;padding-left: 20px;">
								 充值订单确认
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border: 1px solid #efefef">
						<tr>
							<td style="line-height: 28px;">
								<form  method="post" >
									 <input name="rechargeCode"  id="rechargeCode" type="hidden" value="${rechargeCode}">
									  <input name="amount" id="amount" type="hidden" value="${paymoney}">
									  <input name="id" id="id" type="hidden" value="${id}">
									  <input name="type"  type="hidden" value="1">
									<TABLE width="100%" height="181" border=1 cellPadding=6
										cellSpacing=0 borderColor=#e8e8e8
										style="BORDER-COLLAPSE: collapse">
										<TBODY>
											<TR bgcolor="#FFF9EE">
												<TD height=25 colspan="2">
													<font color="#FF0000">说明：</font>
													1、无论采取何种支付方式，充值金额都是实时到帐的，请注意查询。<font color="#FF0000">(0元至999元扣手续费1元/笔，1000元及以上不扣手续费)</font>
												</TD>
											</TR>
											<TR>
												<TD width="36%" height=30 align=right bgColor=#eef7ff>
													充值编号：
												</TD>
												<TD width="64%"
													style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333" class="rechargeCode">${rechargeCode}</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													支付金额：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#F35229" class="paymoney">${paymoney}元</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD height=30 align=right nowrap bgColor=#eef7ff>
													充值金额：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333" class="rechargeMoney">${rechargeMoney}点</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													支付方式：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333"calss="bankName">${payName}</font>
													</strong>
												</TD>
											</TR>
											<TR style="display: none;" class="result">
												<TD align="center" bgColor=#eef7ff height=30 colspan="2">
													<span id="status"></span>
												</TD>
											</TR>
										</TBODY>
									</TABLE>
									<table width="100%" border="0" cellpadding="0" cellspacing="0"
										bordercolor="#eeeeee" style="border-collapse: collapse">
										<tr>
											<td height="30" align="center">
												<div align="center" style="padding: 20px;">
													<input type="button" name="hkbutton" class="an_input2" value="确定付款" id="submitbt" onclick="ajax()" />
													&nbsp;
													<input type="button" name="retbutton" class="an_input2" onclick="document.location='<%=basePath%>jsp/buypoint.jsp'"
														style="cursor: pointer;"
														value="返   回">
												</div>
											</td>
										</tr>
									</table>

								</form>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
       
      </div>
    </div>
 <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
<script language="javascript">
function ajax(){
	var type= "${payName}";
	if(type=="银联支付"){
		unAjax();
	}else if(type=="通联支付"){ 
		tlAjax();
	}
}
function unAjax(){
	$("#submitbt").hide();
	 $(".result").show(); 
	var id = $("#id").val();
	var unAmount = $("#amount").val();
	var rechargeCode = $("#rechargeCode").val();
	$.ajax({ 
	    type: "POST",
	    timeout:"120000",
	    url:"<%=basePath%>unionpay/singleDaiFushi.do", 
	    data:{id:id,unAmount:unAmount,rechargeCode:rechargeCode},
	    dataType : 'json',
	    success: function(data) {
	    	var status = "";
	    	if(data.retcode=="0"){
	    		status = "代收成功"; 
	    	}else{
	    		status ="代收失败";
	    	}
	    	$("#status").html(status);
	    	ajaxAccount();
	    } ,
	    error: function(e) { 
	    	if(e.status==0){
	 	    	$("#status").html("请查看充值记录");
	    	}else{
		        alert("Connection error"); 
	    	}
	    	ajaxAccount();
	    }
	});
} 

function tlAjax(){
	$("#submitbt").hide();
	 $(".result").show(); 
	var id = $("#id").val();
	var tlAmount = $("#amount").val();
	var rechargeCode = $("#rechargeCode").val();
	$.ajax({ 
	    type: "POST",
	    timeout:"120000",
	    url:"<%=basePath%>allinpay/singleDaiFushi.do", 
	    data:{id:id,tlAmount:tlAmount,rechargeCode:rechargeCode},
	    dataType : 'json',
	    success: function(data) {
	    	var status = "";
	    	if(data.retcode=="0"){
	    		status = "代收成功"; 
	    	}else{
	    		status ="代收失败";
	    	}
	    	 parent.ajaxAccount();
	    	$("#status").html(status);
	    } ,
	    error: function(e) { 
	    	if(e.status==0){
	    		 parent.ajaxAccount();
	 	    	$("#status").html("请查看充值记录");
	    	}else{
		        alert("Connection error"); 
	    	}
	    }
	});
}
</script>
