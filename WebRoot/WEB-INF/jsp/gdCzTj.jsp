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
	var url_ = "accountRecord.do?type=gdCzTjSum";
	url_ = url_+bindLargeData_();
	$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : url_,
				dataType : 'json',
				error : function(request) {
					$("#correctOrderdataTable").html('<tr><td colspan="4" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectcorrectOrderFactor").css("display", "none");
				},
				success : function(data) {
					if(data.retcode=="1"){
						$("#correctOrderdataTable").html('<tr><td colspan="4">查询出错！</td></tr>');
						return false;
					}
					var total = data.data.totalCount;
					var pageno = data.data.pageNo;
					var pagesize = data.data.pageSize;
					var tab = '';
					$.each(data.data,function (i,attr){
						tab += '<tr>';
						tab += '<td align="center">' + $("#agents_code  option:selected").text() + '</td>';
						tab += '<td align="center">' + attr.name + '</td>';
						tab += '<td align="center">' + attr.rebates_point/100 + '</td>';
						tab += '<td align="center">' + attr.par_value/100 + '</td>';
						tab += '</tr>';
					});
					if (tab != '<tr></tr>') {
						$("#correctOrderdataTable").html(tab);
					} else {
						$("#correctOrderdataTable").html('<tr><td colspan="4">没有符合条件的记录！</td></tr>');
					}
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
	queryStr += "&startTime="+ $.trim($("#d4311").val());
	queryStr += "&endTime="+$.trim($("#d4312").val());
	queryStr += "&agentsCode=" + $.trim(ecode($("#agents_code").val()));
	//queryStr += "&carrierCode=" +  $.trim(ecode($("#carrier_code").val()));
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
#form tr td{
width: 280
}
.queryForm li{
display: block;
float: none;
}
input{width: 140px;height: 25px;}
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
									<a href="${ctx}/accountRecord.do?type=gdCzTj" title="广东充值统计" rel="1">广东充值统计</a>
								</li>
							</ul>
						</div>
						<div id="tabCot_product_4" class="tabCot" style="display: block;">
						 <div class="blockcommon">
		<form action="" id="queryForm" >
				 <ul class="queryForm">
					<li>
						<ul>

						
									<li><label >对账日期：</label>
							<input id="d4311" class="Wdate"  value="${startTime}" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'d4312\')}'})"/> 
	                    <span>至</span>
						<input id="d4312" class="Wdate" type="text" value="${endTime}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'d4311\')}',maxDate:'%y-%M-%ld'})"/>
							
							<label>代理商:</label> 
		                    <select id="agents_code" name="agents_code"  style="width: 140px;height: 25px;" >
								<c:forEach items="${childsAgentsMap}" var="childsAgentsMap">
									<option value="${childsAgentsMap.key}">
										${childsAgentsMap.value}
									</option>
								</c:forEach>
							</select>
									</li>
						</ul>
					</li>
				<!-- 	<li>
						<ul>
		                    <li>
		                    <label>运营商:</label> 
		                    <select id="carrier_code" name="carrier_code"  style="width: 140px;height: 25px;margin-top: 5px;" >
								 <option value="01">移动</option>
								 <option value="02">联通</option>
								 <option value="03">电信</option>
							</select>
		                    
		                    </li>
						</ul>
					 </li> -->
				</ul>
				<div style="width: 200px;padding-top: 5px;margin-left: 200px">
				<ul><li>
								<input type="button"  id="correctOrderfactorbtn" class="Partorange"  value="查询"/>
					</li><li>
								<input type="reset" class="Partgreen"  onclick="$('#queryForm')[0].reset()" value="重置"/>
					</li>
				</ul></div>
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
													代理商
												</th>
												<th>
													充值渠道
												</th>
												<th>
													利润总额（元）
												</th>
												<th>
													充值总额（元）
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