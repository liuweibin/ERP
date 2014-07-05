<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>日对账</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
		<link rel="stylesheet" type="text/css"			href="${path}themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"			href="${path}themes/sales/home/esales.style.css">
		<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/common/style.css" 	media="screen">

 		<link href="<%=basePath%>themes/common/button.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" language="javascript"			src="${path}js/common/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" language="javascript"			src="${path}js/jquery.tableui.js"></script>
		<script type="text/javascript" language="JavaScript"		src="${path}js/jquery.pagination.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/members.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/thickbox.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/jquery.form.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${path}js/jquery.metadata.js"></script>
<!-- Load data to paginate -->
<script src="<%=basePath%>js/My97DatePicker/WdatePicker.js"	type="text/javascript"></script>
<script src="<%=basePath%>js/My97DatePicker/namespace.js"	type="text/javascript"></script>
<script src="<%=basePath%>js/My97DatePicker/datePicker_AutoSetDay.js"	type="text/javascript"></script>
		<script type="text/javascript">
$(document).ready(function() {
	parent.resetTime(); 
	//correctOrderfactorquery(0);
	$('#correctOrderfactorbtn').click(function() {
		correctOrderfactorquery(0);
	});
});

function correctOrderfactorquery(pageno) {
	parent.resetTime(); 
	var url_ = "accountRecord.do?type=dayAccountSum&time="+ecode($.trim($("#d16").val()));
	$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : url_,
				dataType : 'json',
				error : function(request) {
					$("#correctOrderdataTable").html('<tr><td colspan="4" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#correctOrderdataTable2").html('<tr><td colspan="4" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectcorrectOrderFactor").css("display", "none");
				},
				success : function(data) {
					if(data.retcode=="1"){
						$("#correctOrderdataTable").html('<tr><td colspan="4">查询出错！</td></tr>');
						$("#correctOrderdataTable2").html('<tr><td colspan="4">查询出错！</td></tr>');
						return false;
					}
					var total = data.data.totalCount;
					var pageno = data.data.pageNo;
					var pagesize = data.data.pageSize;
					var tab = '';
					var tabGame = '';
					var commissionTotal = 0;
					$.each(data.data,function (i,attr){
						if(i==3){
							tabGame += '<tr>';
							tabGame += '<td align="center">' + attr.name + '</td>';
							tabGame += '<td align="center">' + attr.cnt + '</td>';
							tabGame += '<td align="center">' + attr.commission/100 + '</td>';
							tabGame += '<td align="center">' + attr.amount/100 + '</td>';
							tabGame += '</tr>';
							commissionTotal +=attr.commission;
						}else if(i==4){
							$("#bail").html(attr.bail/100+"元");
							$("#balance").html(attr.balance/100+"元");
						}else {
							tab += '<tr>';
							tab += '<td align="center">' + attr.name + '</td>';
							tab += '<td align="center">' + attr.cnt + '</td>';
							tab += '<td align="center">' + attr.commission/100 + '</td>';
							tab += '<td align="center">' + attr.amount/100 + '</td>';
							tab += '</tr>';
							commissionTotal +=attr.commission;
						}
					});
					$("#commissionTotal").html(commissionTotal/100+"元");				
					if (tab != '<tr></tr>') {
						$("#correctOrderdataTable").html(tab);
					} else {
						$("#correctOrderdataTable").html('<tr><td colspan="4">没有符合条件的记录！</td></tr>');
					}
					if (tabGame != '<tr></tr>') {
						$("#correctOrderdataTable2").html(tabGame);
					} else {
						$("#correctOrderdataTable2").html('<tr><td colspan="4">没有符合条件的记录！</td></tr>');
					}
					$("#correctOrderdataTable2 tr").hover(function() {
						$(this).addClass("over");
					}, function() {
						$(this).removeClass("over");
					});
					$("#correctOrderdataTable tr").hover(function() {
						$(this).addClass("over");
					}, function() {
						$(this).removeClass("over");
					});

					parent.document.getElementById("main").style.height= window.document.body.clientHeight+20+"px";
				}
			});

}


function ecode(value) {
	return encodeURI(encodeURI(value));
}


function bindLargeData_() {
	var queryStr = "";
	queryStr += "&startTime="+ ecode($.trim($("#d4321").val()));
	queryStr += "&endTime="+ecode($.trim($("#d4322").val()));
	queryStr += "&orderStatus="+ecode($.trim($("#order_status").val()));
	queryStr += "&operationId="+ecode($.trim($("#operationId").val()));
	queryStr += "&correctOrderCode="+ecode($.trim($("#correctOrderCode").val()));
	queryStr += "&orderCode="+ecode($.trim($("#orderCode").val()));
	queryStr += "&agentsCode="+ecode($.trim($("#agentsCode").val()));
	queryStr += "&mobileNo="+ecode($.trim($("#mobileNo").val()));
	return queryStr;
}


function replace(str) {
	re = new RegExp("\"", "g");
	return str.replace(re, "'");
}


</script>

		<style type="text/css">
.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
</style>
<style type="text/css">
body{
margin: 10px 20	px;
}
.checkLab{
	background:#dc143c;
	color:#fff;
	padding-top:3px;
	padding-bottom:3px;
	height:25px;
	line-heigth:25px;
	border:1px solid #f0e68c;
	
}
.blockcommon{
padding: 10px
}
.queryForm li{
padding: 5px 0;
vertical-align: middle;
}
#form tr td{
width: 280
}

</style>
	</head>
	<body>
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab" style="width: 100%">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="${ctx}/accountRecord.do?type=dayAccount" title="日对账" rel="1">日对账</a>
								</li>

							</ul>
						</div>
						<div id="tabCot_product_4" class="tabCot" style="display: block;">
						 <div class="blockcommon">
		<form action="" id="queryForm" >
				<input type="hidden" id="agentsCode" value="${agentsCode}">
		
				<ul class="queryform" >
					<li id="queryTime" ><label >对账日期：</label>
	                  <input class="Wdate" type="text" name="time" readonly="true" id="d16" value="${time}" onfocus="WdatePicker({maxDate:'%y-%M-%d'})"/>
                    </li>
				</ul>
				<ul class="form_ul">
					<li>
								<input type="button"  id="correctOrderfactorbtn" class="Partorange"  value="查询"/>
								<input type="reset" class="Partgreen"  onclick="$('#queryForm')[0].reset()" value="重置"/>
					</li>
				</ul>
			</form>
</div>
</div>					
											
 <div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>								
										<table class="tablelist pusht"  ">
											<tr>
												<th colspan="4">
													 话费充值
												</th>
											</tr>
											<tr>
												<th>
													充值渠道
												</th>
												<th>
													当天充值笔数
												</th>
												<th>
													当天充值总佣金（元）
												</th>
												<th>
													当天充值总金额（元）
												</th>
											</tr>
											<tbody id="correctOrderdataTable" style="text-align: center">
											<tr>
												<td>
													移动
												</td>
											<td></td><td></td><td></td>
											</tr>
											<tr>
												<td>
													电信
												</td>
												<td></td><td></td><td></td>
											</tr>
											<tr>
												<td>
													联通
												</td>
													<td></td><td></td><td></td>
											</tr>
											</tbody>
										</table>
										<table class="tablelist pusht">
										<tr>
												<th colspan="4">
													 游戏充值
												</th>
											</tr>
											<tr>
												<th>
													充值渠道
												</th>
												<th>
													当天充值笔数
												</th>
												<th>
													当天充值总佣金（元）
												</th>
												<th>
													当天充值总金额（元）
												</th>
											</tr>
												<tbody id="correctOrderdataTable2" style="text-align: center">
											<tr>
											<td>翔钻</td><td></td><td></td><td></td>
											</tr>
												</tbody>
											<tr>
												<th>
													保障金<span id="bail" style="color: red;margin-left: 3px;"></span>
												</th>
												<th colspan="2">
													余额 <span id="balance" style="color: red;margin-left: 3px;"></span>
												</th>
												<th>
													佣金<span id="commissionTotal" style="color: red;margin-left: 3px;"></span>
												</th>
											</tr>
											<tbody id="correctOrderdataTable" style="text-align: center">
											</tbody>
										</table>
									</form>
								</div>
							</div>

							<div class="clear"></div>
						</div>

					</div>

				</div>

				<div class="clear"></div>
			</div>
		</div>

	</body>
</html>