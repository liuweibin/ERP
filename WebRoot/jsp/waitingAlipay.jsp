<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>

	<head>
		<title>确认订单</title>

		<style type="text/css">
* {
	padding: 0px 0px 0px 0px;
	margin: 0px 0px 0px 0px;
}

#center_div {
	text-align: center;
	width: 100%;
	height: 100%;
}

#top_div {
	width: 100%;
	height: 70%;
}

#buttom_div {
	background-image: url("<%=basePath%>images/alipay_w_buttom_bg.jpg");
	background-repeat: repeat-x;
	width: 100%;
	height: 30%;
	padding-top: 10px;
}

.alipay_big {
	background-image: url("<%=basePath%>images/alipay_c_r.jpg");
	background-repeat: no-repeat;
}

.alipay_cs_confirm {
	border: 0px;
	width: 87px;
	height: 31px;
	background-position: -10px -45px;
	text-align: center;
	color: white;
	font-size: 14px;
	cursor: pointer;
}

.alipay_hs_confirm {
	border: 0px;
	width: 87px;
	height: 31px;
	background-position: -10px -9px;
	text-align: center;
	color: white;
	font-size: 14px;
	cursor: pointer;
}

.alipay_huis_confirm {
	border: 0px;
	width: 87px;
	height: 31px;
	background-position: -170px -8px;
	text-align: center;
	color: orange;
	font-size: 14px;
	cursor: pointer;
}
</style>
		<script type="text/javascript" language="javascript"
			src="<%=basePath%>js/jquery.min.js">
</script>
		<script type="text/javascript">
function chargeClass(this_, removeclass, addclass) {
	$(this_).removeClass(removeclass);
	$(this_).addClass(addclass);
}

function close_() {
	parent.tb_remove();
	document.getElementById('a_to_buy_credit').click();
}

function onClickTranSucc(stateVal) {
	$
			.ajax( {
				type : "get",
				async : true,
				url : "<%=basePath%>alipay/queryTranState.do?rechargeCode=${rechargeCode}",
				dataType : "json",
				success : function(data) {
					if (data.state == 2) {
						if (stateVal == 'succ') {
							close_();
						}

						if (stateVal == 'reorder') {
							$("#opreation_exception_alt_div").attr( {
								style : "display:block"
							});
							$("#common_alt_div").attr( {
								style : "display:none"
							});
							$("#prossing_alt_div").attr( {
								style : "display:none"
							});
							$("#fail_alt_div").attr( {
								style : "display:none"
							});
						}
					}

					if (data.state == 3 || data.state == 0) {
						if (stateVal == 'reorder') {
							close_();
						}

						$("#fail_alt_div").attr( {
							style : "display:block"
						});
						$("#common_alt_div").attr( {
							style : "display:none"
						});
						$("#prossing_alt_div").attr( {
							style : "display:none"
						});
						$("#opreation_exception_alt_div").attr( {
							style : "display:none"
						});
					}

					if (data.state == 1) {
						$("#fail_alt_div").attr( {
							style : "display:none"
						});
						$("#common_alt_div").attr( {
							style : "display:none"
						});
						$("#prossing_alt_div").attr( {
							style : "display:block"
						});
						$("#opreation_exception_alt_div").attr( {
							style : "display:none"
						});
					}
				},
				error : function(err) {
					//alert(err);
			}
			});

	$("#buttom_div").attr( {
		style : "display:none"
	});

}
</script>
	</head>

	<body>
		<a href="<%=basePath%>credit/toBuyCredit.do" id="a_to_buy_credit"
			target="main"></a>
		<div id="center_div">
			<div id="top_div">
				<table border="0">
					<tr>
						<td valign="top">
							<img alt="" src="<%=basePath%>images/alipay_alarm.jpg">
						</td>

						<td valign="top" align="left">
							<div id="common_alt_div" style="display: block;">

								<p>
									<font size="5" color="orange">请你在新打开的页面完成支付!</font>
								</p>
								<br />
								<p>
									<img alt="" src="<%=basePath%>images/dot.jpg">
									支付完成前请不要关闭此窗口
								</p>
								<br />
								<p>
									<img alt="" src="<%=basePath%>images/dot.jpg">
									支付完成后，请根据结果选择
								</p>
								<br />
								<p>
									<img alt="" src="<%=basePath%>images/dot.jpg">
									支付失败时，可拨打00000,1+客服竭诚为您服务
								</p>
							</div>
							<div id="succ_alt_div" style="display: none;">
							</div>
							<div id="fail_alt_div" style="display: none;">
								<p>
									<font size="5" color="orange">你付款没有成功!</font>
								</p>
								<br />
								<p>
									<img alt="" src="<%=basePath%>images/dot.jpg">
									可拨打00000, 咨询1+客服
								</p>
							</div>
							<div id="prossing_alt_div" style="display: none;">
								<p>
									<font size="5" color="orange">你的交易正在处理中!</font>
								</p>
								<br />
								<p>
									<img alt="" src="<%=basePath%>images/dot.jpg">
									可拨打00000, 咨询1+客服
								</p>
							</div>

							<div id="opreation_exception_alt_div" style="display: none;">
								<p>
									<font size="5" color="orange">你已经付款成功!</font>
								</p>
								<br />
								<p>
									<img alt="" src="<%=basePath%>images/dot.jpg">
									可拨打00000, 咨询1+客服
								</p>
							</div>

						</td>
					</tr>
				</table>
			</div>

			<div id="buttom_div">
				<input type="button" class="alipay_big alipay_cs_confirm"
					name="hkbutton" class="submitbt" value="支付成功"
					onmouseover="chargeClass(this,'alipay_cs_confirm','alipay_hs_confirm')"
					;
				   onmouseout="chargeClass(this,'alipay_hs_confirm','alipay_cs_confirm')"
					;
				   onclick="onClickTranSucc('succ');" />
				&nbsp;

				<input type="button" name="retbutton"
					class="alipay_big alipay_huis_confirm"
					onclick="onClickTranSucc('reorder');" value="重新下单">
			</div>

		</div>
	</body>
</html>