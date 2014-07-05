<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<HTML>
	<HEAD>
		<TITLE>购买信用点确认</TITLE>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
		<link rel="stylesheet" type="text/css" href="/include/style.css">
		<link rel="stylesheet" type="text/css" href="/css/p.public.css">
	<script type="text/javascript" language="javascript"
			src="<%=basePath %>js/jquery.min.js">
</script>
<style type="text/css">
  *{
  padding:0px 0px 0px 0px;
  margin: 0px 0px 0px 0px;
  }
  .alipay_big{
   background-image: url("<%=basePath %>images/alipay_c_r.jpg");
   background-repeat: no-repeat;
  }
  
  .alipay_cs_confirm{
     border:0px;
     width: 87px;
     height: 31px;
     background-position: -10px -45px;
     text-align: center;
     color: white;
     font-size: 14px;
     cursor: pointer;
  }
  
    .alipay_hs_confirm{
     border:0px;
     width: 87px;
     height: 31px;
     background-position: -10px -9px;
     text-align: center;
     color: white;
     font-size: 14px;
     cursor: pointer;
  }
  
     .alipay_huis_confirm{
     border:0px;
     width: 87px;
     height: 31px;
     background-position: -170px -8px;
     text-align: center;
     color: orange;
     font-size: 14px;
     cursor: pointer;
  }
</style>

<script type="text/javascript">
function chargeClass(this_, removeclass, addclass){
	$(this_).removeClass(removeclass);
	$(this_).addClass(addclass);
}
</script>
	</HEAD>
	<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0
		MARGINHEIGHT=0 style="background-color: transparent;">
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td valign="bottom">
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						background="http://esales.ofpay.com/images/3_ima/list_top_bg1.gif">
						<tr>
							<td width="8"
								background="<%=basePath %>images/list_top_bg.jpg">
								<img
									src="<%=basePath %>images/list_top_left.jpg"
									width="6" height="25" />
							</td>
							<td width="118" nowrap="nowrap" align="left"
								background="<%=basePath %>images/list_top_bg.jpg"
								style="font-size: 12px; font-weight: bold; color: #ffffff; padding-top: 4px;">
								&middot;充值订单确认
							</td>
							<td width="47">
								<img
									src="<%=basePath %>images/list_top_right.gif"
									width="23" height="25" />
							</td>
							<td width="1049" class="t_font_gray">
								&nbsp;
							</td>
							<td width="29" align="right">
								<img
									src="<%=basePath %>images/list_top_right1.gif"
									width="8" height="25" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="85"
								style="background-image: url(<%=basePath %>images/list_mid_left.jpg); background-repeat: repeat-y; width: 6px;">
								<img
									src="<%=basePath %>images/list_mid_left.jpg"
									width="6" height="25" />
							</td>
							<td
								style="background-image: url(<%=basePath %>images/main_top_bg.gif); background-position: top right; background-repeat: repeat-x; padding: 0 15px; line-height: 28px;">
								<form name="subxyd" method="post" onsubmit="return waitRechargePage();"
									action="<%=basePath%>alipay/pay.do" target="_bank">
									<input name="WIDsubject" type="hidden" value="购买信用点">
									<input name="WIDbody" type="hidden" value="购买信用点">
									<input name="WIDdefaultbank" type="hidden"
										value="${bank.bankBriefCode}">


									<br>
									<input name="rechargeCode" type="hidden"
										value="${recharge.rechargeCode}" />
									<input name="soupayid" type="hidden" value="">

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
													<strong><font color="#333333">${recharge.rechargeCode}</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													支付金额：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#F35229">${paymoney}元</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD height=30 align=right nowrap bgColor=#eef7ff>
													充值金额：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333">${recharge.rechargeMoney/100.0}点</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													支付方式：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333">${bank.bankName}</font>
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
													<input type="submit" class="alipay_big alipay_cs_confirm" name="hkbutton" class="submitbt"
														value=去付款 " 
														onmouseover="chargeClass(this,'alipay_cs_confirm','alipay_hs_confirm')";
														onmouseout="chargeClass(this,'alipay_hs_confirm','alipay_cs_confirm')";
														/>
													&nbsp;
													<input type="button" name="retbutton" class="alipay_big alipay_huis_confirm"
														onclick="document.location='<%=basePath%>credit/toBuyCredit.do'"
														style="cursor: pointer;"
														value="返   回">
												</div>
											</td>
										</tr>
									</table>

									<p>
										&nbsp;
									</p>
									<p>
										&nbsp;
									</p>
								</form>
							</td>
							<td
								style="background-image: url(<%=basePath %>images/list_mid_right.jpg); background-repeat: repeat-y; width: 8px;"
								align="right">
								<img
									src="<%=basePath %>images/list_mid_right.jpg"
									width="8" height="25" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						background="<%=basePath %>images/list_bottom_bg.jpg">
						<tr>
							<td>
								<img
									src="<%=basePath %>images/list_bottom_left.jpg"
									width="6" height="5" />
							</td>
							<td></td>
							<td align="right">
								<img
									src="<%=basePath %>images/list_bottom_right.jpg"
									width="6" height="5" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>
<script language="javascript">
window.parent.window.location.hash = "toptb";
function waitRechargePage() {
	var url = "<%=basePath%>alipay/waitingAlipay.do?rechargeCode=${recharge.rechargeCode}&TB_iframe=true";
	var title = "确认付款结果";
	var width = 500;
	var height = 250;
	parent.LightBox(url, title, width, height);
	return true;
}
</script>
