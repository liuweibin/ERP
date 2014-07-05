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
								<form name="subxyd" method="post" action="<%=basePath%>credit/confirmCredit.do" target="_self">
									<input name="rechargeCode" type="hidden" value="${recharge.rechargeCode}"/>
									<input name="soupayid" type="hidden" value="">
									<input name="type" type="hidden" value="1">

									<input name="fromip" type="hidden" value="116.247.76.42" />
									<input name="paygate" type="hidden" value="汇款支付">
									<input name="paygatecode" type="hidden" value="">
									<input name="bankcode" type="hidden" value="">
									<input name="payaccount" type="hidden" value="">
									<input name="OrderNo" type="hidden" value="C130806917626">
									<input name="amount" type="hidden" value="11.3">
									<input name="wlflag" type="hidden" value="1" />
									<input name="cname" type="hidden"
										value="25c929b0c438fc28e3926bb603fb63ec4f4339325508e1a6321309e20ae0f177" />
									<input name="verifycode" type="hidden"
										value="13922368715d09c53fa8bae12c6a4abb" />
									<TABLE width="100%" height="181" border=1 cellPadding=6
										cellSpacing=0 borderColor=#e8e8e8
										style="BORDER-COLLAPSE: collapse">
										<TBODY>
											<TR bgcolor="#FFF9EE">
												<TD height=25 colspan="2">
													<font color="#FF0000">说明：</font>
													1、无论采取何种支付方式，充值金额都是实时到帐的，请注意查询。
												</TD>
											</TR>
											<TR>
												<TD width="36%" height=30 align=right bgColor=#eef7ff>
													充值编号：
												</TD>
												<TD width="64%"
													style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333" class="rechargeCode">${recharge.rechargeCode}</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													支付金额：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#F35229" class="paymoney">${recharge.payMoney/100.0}元</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD height=30 align=right nowrap bgColor=#eef7ff>
													充值金额：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333" class="rechargeMoney">${recharge.rechargeMoney/100.0}点</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													支付方式：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333"calss="bankName">${bank.bankName}</font>
													</strong>
												</TD>
											</TR>
											
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													收款人：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="blue">${bank.payee}</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													收款账号：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#F35229">${bank.accountCode}
													</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													汇款支付预留信息：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333">${recharge.remark}</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													备注：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333">汇款后请主动联系1+客服，同时建议汇款金额后面带零头，便于1+客服核对。</font>
													</strong>
												</TD>
											</TR>
										</TBODY>
									</TABLE>
									<table width="100%" border="0" cellpadding="0" cellspacing="0"
										bordercolor="#eeeeee" style="border-collapse: collapse">
										<tr>
											<td height="30" align="center">
												<div align="center" style="padding: 20px;">
													<input type="submit" name="hkbutton" class="an_input2" value=汇款下单成功 "  />
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
function waitRechargePage() {
	var url = "<%=basePath%>tenpay/waitingTenpay.do?rechargeCode=${recharge.rechargeCode}&TB_iframe=true";
	var title = "确认付款结果";
	var width = 500;
	var height = 250;
	parent.LightBox(url, title, width, height);
	return true;
}
</script>
