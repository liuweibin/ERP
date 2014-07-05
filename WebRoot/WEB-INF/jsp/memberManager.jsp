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

		<title>My JSP 'memberManage.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript" language="javascript"			src="${ctx}/js/common/jquery-1.8.0.min.js"></script>
		<script src="${ctx}/js/My97DatePicker/WdatePicker.js"			type="text/javascript"></script>
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />	
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">	
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">	
		<link href="${ctx}/themes/common/button.css" rel="stylesheet"			type="text/css" />
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.metadata.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.form.js"></script>
		<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" src="${ctx}/js/jquery.pagination.js"></script>
		<script src="${ctx}/js/My97DatePicker/namespace.js"			type="text/javascript"></script>
		<script src="${ctx}/js/My97DatePicker/datePicker_AutoSetDay.js"			type="text/javascript"></script>

		<!-- Load data to paginate -->
		<style type="text/css">
		body{margin: 0;padding: 0;}
.checkLab {
	background: #dc143c;
	color: #fff;
	padding-top: 3px;
	padding-bottom: 3px;
	height: 25px;
	line-heigth: 25px;
	border: 1px solid #f0e68c;
}

.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
</style>

		<script>
var pageno = 1;
var pagesize = 10;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1
	agentsManager(pageno_id);
	return false;
}

$(document).ready(
		function() {
			$("input[type=radio]").click(
					function() {
						var name = ($(this).attr('name'));
						var id = ($(this).attr('id'));

						$("input[type=radio][name=" + name + "]").parent().removeClass('checkLab');

						$("#" + id).parent().addClass('checkLab');
					});
		});

$(document).ready(function() {
	parent.resetTime();    
	//agentsManager(0);
		$('#submitbtn').click(function() {
			// $('#signupForm').submit();
				agentsManager(0);
			});
	});

function agentsManager(pageno) {
	var timevalue = "";
	var radionum = document.getElementsByName("timeRange");
	for ( var i = 0; i < radionum.length; i++) {
		if (radionum[i].checked) {
			timevalue = radionum[i].value;
		}
	}

	if ($("#handTime").is(":visible")) {
		var starttime = document.getElementById("agentstarttime").value;
		var endtime = document.getElementById("agentendtime").value;
		queryString = "&agentsCode=" + ecode($("#userid").val())
				+ "&startTime=" + starttime + "&endTime=" + endtime;
	} else {
		queryString = "&agentsCode=" + ecode($("#userid").val()) + "&timeUnit="
				+ timevalue;
	}

	var url_ = "agentsManage.do?type=agentsInfo";
	url_ += "&pageno=" + pageno;
	url_ += "&pagesize=" + pagesize;

	$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : url_,
				data : queryString,
				dataType : 'json',
				error : function(request) {
					$("#dataTable")
							.html(
									'<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectfactor").css("display", "none");
				},
				success : function(data) {
					if (data.retcode == "1") {
						$("#dataTable")
								.html(
										'<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
						$("#selectfactor").css("display", "none");
						return false;
					}

					var total = data.data.totalCount;
					var pageno = data.data.pageNo;
					var pagesize = data.data.pageSize;

					$("#selectfactor").css("display", "none");
					var tab = '';
					for ( var i = 0; i < data.data.result.length; i++) {
						total = data.data.result[i].totalCount;
						pagesize = data.data.result[i].pageSize;
						pageno = data.data.result[i].pageNo;
						tab += '<tr>';
						tab += '<td>' + data.data.result[i].agentsCode + '</td>';
						tab += '<td>' + data.data.result[i].name + '</td>';
						tab += '<td>' + data.data.result[i].shoptype + '</td>';
						if (data.data.result[i].auditstatus == 0) {
							tab += '<td>未审核</td>';
						} else if (data.data.result[i].auditstatus == 1) {
							tab += '<td>审核通过</td>';
						} else if (data.data.result[i].auditstatus == 2) {
							tab += '<td>审核未通过</td>';
						} else {
							tab += '<td>删除</td>';
						}
						if (data.data.result[i].type == 1) {
							tab += '<td>直属经销商</td>';
						} else {
							tab += '<td>非直属经销商</td>';
						}
						tab += '<td>' + data.data.result[i].fAgentsname + '</td>';
						tab += '<td>' + data.data.result[i].balance + '</td>';
						tab += '<td>' + data.data.result[i].bail + '</td>';
						tab += '<td>' + data.data.result[i].balanceAlarm + '</td>';
						tab += '<td>' + data.data.result[i].mobile_phone + '</td>';
						tab += "<td style='font-size:9px;'>" + data.data.result[i].registeredtime + '</td>';
						tab += '</tr>';
					}
					if (tab != '') {
						$("#dataTable").html(tab);
					} else {
						$("#dataTable").html(
								'<tr><td colspan="11">没有符合条件的记录！</td></tr>');
					}
					$("#dataTable tr").hover(function() {
						$(this).addClass("over");
					}, function() {
						$(this).removeClass("over");
					});
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
					parent.document.getElementById("mmain").style.height= "1100px";
					parent.resetTime();    
				}
			});
}

function ecode(value) {
	return encodeURI(encodeURI(value));
}
</script>


		<script language="javascript">
function changeTimePanel(type) {
	$("#timetype").val(type);
	if (type == '1') {
		$("#autoTime").show();
		$("#handTime").hide();
	} else {
		$("#handTime").show();
		$("#autoTime").hide();
	}
}
$(document).ready(
		function() {
			$("input[type=radio]").click(
					function() {
						var name = ($(this).attr('name'));
						var id = ($(this).attr('id'));

						$("input[type=radio][name=" + name + "]").parent()
								.removeClass('checkLab');

						$("#" + id).parent().addClass('checkLab');
					});
			
		});

function load(){a(${tab});
	　　parent.document.getElementById("main").style.height =  "1100px"; 
     　} 
function a(n){
	$("#tabCot_product_1").css('display','none'); 
	$("#tabCot_product_"+n).css('display','block'); 
		$(".tabHead>li:nth-child("+n+") >a").click();
}


</script>


	</head>

	<body onload="load();">
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab" style="width: 100%">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li   class="currentBtn">
									<a href="javascript:void(0)" title="查询下级基本信息" rel="1">查询下级基本信息</a>
								</li>
								<li>
									<a href="javascript:void(0)" title="查询下级账务" rel="2">查询下级账务</a>
								</li>
								<li>
									<a href="javascript:void(0)" title="查询下级商品" rel="3">查询下级商品</a>
								</li>
								<li >
									<a href="javascript:void(0)" title="查询下级订单" rel="4">查询下级订单</a>
								</li>
								<c:if test="${agentsLevel ne maxLevel}">
									<li>
										<a href="javascript:void(0)" title="下级代理商注册" rel="5">下级代理商注册</a>
									</li>
								</c:if>

							</ul>
						</div>
						<%@include file="agentsManage.jsp"%>

						<%@include file="agentFinance.jsp"%>

						<%@include file="agentsGood.jsp"%>

						<%@include file="agentOrder.jsp"%>

						<%@include file="agentRegister.jsp"%>

						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>
					</div>

				</div>
			</div>

			<div class="clear"></div>
		</div>
		</div>
		<div class="noprint">
			<script type="text/javascript" language="jscript">
function tab(o, s, cb, ev) {//tab切换类
	parent.resetTime();    
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
