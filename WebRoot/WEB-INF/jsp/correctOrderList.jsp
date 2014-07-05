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

		<title>My JSP 'empManage.jsp' starting page</title>

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
var pageno = 1;
var pagesize = 5;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	correctOrderfactorquery(pageno_id);
	return false;
}


$(document).ready(function() {
	parent.resetTime(); 
	correctOrderfactorquery(0);
	$('#correctOrderfactorbtn').click(function() {
		correctOrderfactorquery(0);
	});
});

function correctOrderfactorquery(pageno) {
	parent.resetTime(); 
	var url_ = "correctOrder/correctOrderList.do?fromBrowser=true&pageno=" + pageno + "&pagesize=" + pagesize;
	url_+=bindLargeData_();
	$
			.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : url_,
				dataType : 'json',
				error : function(request) {
					$("#correctOrderdataTable")
							.html(
									'<tr><td colspan="14" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectcorrectOrderFactor").css("display", "none");
				},
				success : function(data) {
					
					if(data.retcode=="1"){
						$("#correctOrderdataTable").html('<tr><td colspan="14">查询出错！</td></tr>');
						return false;
					}
					
					var total = data.data.totalCount;
					var pageno = data.data.pageNo;
					var pagesize = data.data.pageSize;
					
					var tab = '';
					
					for ( var i = 0; i < data.data.result.length; i++) {
						tab += '<tr>';
						tab += '<td align="left">' + data.data.result[i].correctOrderCode + '</td>';
						tab += '<td align="left">' + data.data.result[i].orderCode + '</td>';
						tab += '<td align="left">' + data.data.result[i].rechargeCode + '</td>';
						tab += '<td align="left">' + data.data.result[i].goodsName + '</td>';
						tab += '<td align="left">' + data.data.result[i].mobileNo + '</td>';
						tab += '<td align="left">' + data.data.result[i].operationId + '</td>';
						tab += '<td align="left">' + data.data.result[i].amount + '</td>';
						tab += '<td align="left" style="font-size:10px">' + data.data.result[i].orderModifyTime + '</td>';
						tab += '<td align="left">' + data.data.result[i].order_status + '</td>';
						tab += '</tr>';
					}
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

					// $("#databuyTable tr:even").addClass("alt");
					//加入分页的绑定
					var current_page = pageno - 1;
					$("#Pagination").pagination(total, {
						callback : pageselectCallback,
						prev_text : '上一页', //上一页按钮里text  
						next_text : '下一页', //下一页按钮里text  
						items_per_page : pagesize, //显示条数  
						num_display_entries : 6, //连续分页主体部分分页条目数  
						current_page : current_page, //当前页索引  
						num_edge_entries : 2
					//两侧首尾分页条目数  
							});

					parent.document.getElementById("main").style.height= window.document.body.clientHeight+20+"px";
				}
			});

}


function ecode(value) {
	return encodeURI(encodeURI(value));
}

/*
function bindLargeData_() {
var jsonData = {
		startTime :  ecode($.trim($("#d4321").val())),
		endTime : ecode($.trim($("#d4322").val())),
		orderStatus : ecode($.trim($("#order_status").val())),
		operationId : ecode($.trim($("#operationId").val())),
		correctOrderCode : ecode($.trim($("#correctOrderCode").val())),
		orderCode : ecode($.trim($("#orderCode").val())),
		agentsCode : ecode($.trim($("#agentsCode").val())),
		mobileNo:ecode($.trim($("#mobileNo").val()))
	};

	return replace(JSON.stringify(jsonData));
}
*/

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

parent.document.getElementById("mmain").style.height=  "1000px";	
parent.document.getElementById("main").style.height=  "1000px";
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
									<a href="${ctx}/correctOrder/correctOrderListView.do" title="充正订单查询" rel="1">充正订单查询</a>
								</li>

							</ul>
						</div>
						<div id="tabCot_product_4" class="tabCot" style="display: block;">
						 <div class="blockcommon">
		<form action="" id="queryForm" >
				<input type="hidden" id="agentsCode" value="${agentsCode}">
		
				<ul class="queryform" >
					<li id="queryTime" ><label >冲正订单时间：</label>
	                   <input type="text" class="Wdate startTime" value="${startTime}"  name="startTime" id="d4321" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'d4322\',{d:-1});}'})"/>
	                    <span>至</span>
	      			 <input type="text" class="Wdate endTime" name="endTime" value="${endTime}" id="d4322" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'d4321\',{d:1});}'})"/>
						<strong>(注:不能进行跨月选择查询) </strong>
                    </li>
					<li>
						<label>
							冲正订单号：
						</label>
					<input type="text" id="correctOrderCode"/>
					</li>
					<li>
						<label>
							充值订单号：
						</label>
					<input type="text" id="orderCode"/>
					</li>
						<li>
						<label>
							手机号：
						</label>
					<input type="text" id="mobileNo"  style="width: 120px;"/>
					</li>
						<li >
							<label>
								运营商：
							</label>
							<select name="operationId" id="operationId">
								<option value="">
									---全部---
								</option>
								<option value="01">
								移动
								</option>
								<option value="02">
							联通
								</option>
								<option value="03">
							电信
								</option>
							</select>
					</li>	
					<li >
						<label>
							冲正订单状态：
						</label>
						<select name="order_status" id="order_status">
							<option value="" selected="selected">
								---全部---
							</option>
							<option value="0">
								生成
							</option>
							<option value="1">
							处理中
							</option>
							<option value="2">
							处理成功
							</option>
							<option value="3">
							处理失败
							</option>
						</select> 
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
										<table class="tablelist pusht">
											<tr>
												<th>
													冲正订单编号
												</th>
												<th>
													充值订单编号
												</th>
												<th>
													充值工单编号
												</th>
												<th>
													商品名称
												</th>
												<th>
													电话号码
												</th>
												<th>
													运营商
												</th>
												<th>
													金额 (元)
												</th>
												<th>
													处理时间
												</th>
												<th>
													状态
												</th>
												
												
											</tr>
											<tbody id="correctOrderdataTable" style="text-align: center">
											</tbody>
										</table>
									</form>
								</div>
							</div>
							<div id="pages">
								<div id="Pagination" class="pagination"></div>
							</div>

							<div class="clear"></div>
						</div>

					</div>

				</div>

				<div class="clear"></div>
			</div>
		</div>
		<div class="noprint">
			<script type="text/javascript" language="jscript">
function tab(o, s, cb, ev) {//tab切换类
	var $ = function(o) {
		return document.getElementById(o)
	};
	var css = o.split((s || '_'));
	if (css.length != 4)
		return;
	this.event = ev || 'onclick';
	o = $(o);
	if (o) {
		this.ITEM = [];
		o.id = css[0];
		var item = o.getElementsByTagName(css[1]);
		var j = 1;
		for ( var i = 0; i < item.length; i++) {
			if (item[i].className.indexOf(css[2]) >= 0
					|| item[i].className.indexOf(css[3]) >= 0) {
				if (item[i].className == css[2])
					o['cur'] = item[i];
				item[i].callBack = cb || function() {
				};
				item[i]['css'] = css;
				item[i]['link'] = o;
				this.ITEM[j] = item[i];
				item[i]['Index'] = j++;
				item[i][this.event] = this.ACTIVE;
			}
		}
		return o;
	}
}
tab.prototype = {
	ACTIVE : function() {
		var $ = function(o) {
			return document.getElementById(o)
		};
		this['link']['cur'].className = this['css'][3];
		this.className = this['css'][2];
		try {
			$(this['link']['id'] + '_' + this['link']['cur']['Index']).style.display = 'none';
			$(this['link']['id'] + '_' + this['Index']).style.display = 'block';
		} catch (e) {
		}
		this.callBack.call(this);
		this['link']['cur'] = this;
	}
}

new tab('tabCot_product-li-currentBtn-', '-');
</script>
		</div>

	</body>
</html>