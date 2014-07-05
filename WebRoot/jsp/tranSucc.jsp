<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>


<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>




<HTML>
	<HEAD>
		<TITLE>信用点购买成功</TITLE>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
		<link rel="stylesheet" type="text/css" href="/include/style/style.css">
		<script language="javascript">
             window.parent.window.location.hash = "toptb";
        </script>
	</HEAD>
	<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0
		MARGINHEIGHT=0 style="background-color: transparent;">
		<TABLE WIDTH=98% BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
			<TR>
				<TD width="100%" height="290" valign="top">
					<table width="100%" border="0" align="center" cellpadding="0"
						cellspacing="0">
						<tr>
							<th scope="row">
								<TABLE class=t1 style="BORDER-COLLAPSE: collapse"
									borderColor=#eeeeee cellSpacing=0 cellPadding=0 width="100%"
									border=0>
									<TBODY>
										<TR>
											<TD align="center">
												<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
													<TBODY>
														<TR>
															<TD align=middle>
																<table width="100%" border="1" cellpadding="0"
																	cellspacing="0" bordercolor="#BCD9E7"
																	background="../images/opbg1.gif"
																	style="border-collapse: collapse">
																	<tr>
																		<td height="22">
																			<font face=webdings color="#FF9900">8&nbsp;</font><a
																				href="javascript:void(0);"><font color="#246694">成功充值</font>
																			</a>
																		</td>
																	</tr>
																</table>
															</TD>
														</TR>
													</TBODY>
												</TABLE>
											</TD>
										</TR>
									</TBODY>
									<tr>
										<td height="3"></td>
										<tr>
											<td align="center">
												<TABLE style="BORDER-COLLAPSE: collapse" borderColor=#e8e8e8
													cellSpacing=0 cellPadding=0 width="100%" border=1>
													<TBODY>
														<TR>
															<TD width="469" height=30 align=right bgColor=#eef7ff>
																您目前剩余信用点：
															</TD>
															<TD width="751" height=15>
																<strong><font color="#FF6600">&nbsp;${agents.balance/100.0}点</font>
																</strong>
															</TD>
														</TR>
														
														<TR>
															<TD height=30 align=right bgColor=#eef7ff>
																订单编号：
															</TD>
															<TD>
																<strong><font color="#009900">&nbsp;${recharge.rechargeCode}</font>
																</strong>
															</TD>
														</TR>
														<TR>
															<TD align=right bgColor=#eef7ff height=30>
																支付金额：
															</TD>
															<TD height=25>
																<strong><font color="#009900">&nbsp;${recharge.payMoney/100.0}</font>
																</strong>
															</TD>
														</TR>
														<TR>
															<TD height=30 align=right nowrap bgColor=#eef7ff>
																充值金额：
															</TD>
															<TD height=25>
																<strong><font color="#009900">&nbsp;${recharge.rechargeMoney/100.0}</font>
																</strong>
															</TD>
														</TR>
													</TBODY>
												</TABLE>
											</td>
											<tr>
												<td height="3"></td>
												<tr>
													<td align="center">
														<%--<table width="100%" border="1" cellpadding="0"
															cellspacing="0" bordercolor="#eeeeee"
															style="border-collapse: collapse">
															<tr>
																<td height="30" align="center" bgcolor="#E6F7FF">
																	<a href="/jsp/credit/creditddtx.jsp" target="main"><input
																			name="submit" type="button" value="继续购买信用点">
																	</a>
																</td>
															</tr>
														</table>
								--%></TABLE>
							</th>
						</tr>
					</table>
				</TD>
			</TR>
		</TABLE>
	</BODY>
</HTML>