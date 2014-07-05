<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script type="text/javascript">
function pageorderCallback(page_id, jq) {
	var pageno_id = page_id + 1
	orderQuery(pageno_id);
	return false;
}

$(document).ready(function() {
	parent.resetTime(); 
	$('#orderSumbit').click(function() {
		var startTime = document.getElementById("orderStartTime").value;
		var endTime = document.getElementById("orderEndTime").value;
		startTime = startTime.replace(/-/g, "/");
		endTime = endTime.replace(/-/g, "/");
		var d1 = new Date(startTime);
		var d2 = new Date(endTime);
		if (d2.getTime() - d1.getTime() < 0) {
			alert("时间有错，起始时间不能大于结束时间！");
			return false;
		}
		orderQuery(0);
	});
});

function orderQuery(pageno) {
	var url_ = "agentsManage.do?type=agentOrder&";
	url_ += bindLargeData();
	url_ += "&pageno=" + pageno;
	url_ += "&pagesize=" + pagesize;
	$.ajax( {
		cache : true,
		type : "POST",
		async : false,
		url : url_,
		dataType : 'json',
		error : function(request) {
			$("#dataOrderTable").html(
					'<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
			$("#selectOrderFactor").css("display", "none");
		},
		success : function(data) {
			if (data.retcode == "1") {
				$("#dataOrderTable").html(
						'<tr><td colspan="14">查询出错！</td></tr>');
				return false;
			}

			var total = data.data.totalCount;
			var pageno = data.data.pageNo;
			var pagesize = data.data.pageSize;
			
			$("#selectOrderFactor").css("display", "none");
			var tab = '';
			for ( var i = 0; i < data.data.result.length; i++) {
				tab += '<tr>';
				tab += '<td>' + data.data.result[i].orderCode + '</td>';
				tab += '<td>' + data.data.result[i].agent_Code + '</td>';
				tab += '<td>' + data.data.result[i].name + '</td>';
				tab += '<td>' + data.data.result[i].rechargeNumber + '</td>';
				tab += '<td>' + data.data.result[i].inPrice + '</td>';
				tab += '<td>' + data.data.result[i].batch_price + '</td>';
				tab += '<td>' + data.data.result[i].sellPrice + '</td>';
				tab += '<td>' + data.data.result[i].profit + '</td>';
				if (data.data.result[i].orderStatus == 5) {
					tab += '<td >已撤销</td>';
				} else if (data.data.result[i].orderStatus == 2) {
					tab += '<td >订单成功</td>';
				} else if (data.data.result[i].orderStatus == 0) {
					tab += '<td >订单生成</td>';
				} else if (data.data.result[i].orderStatus == 1) {
					tab += '<td >订单处理中</td>';
				} else if (data.data.result[i].orderStatus == 3) {
					tab += '<td >订单失败</td>';
				} else if (data.data.result[i].orderStatus == 4) {
					tab += '<td >未付款</td>';
				}
				if (data.data.result[i].profitStatus == '0') {
					tab += '<td >未返利</span>';
				} else if (data.data.result[i].profitStatus == '1') {
					tab += '<td >已返利</span>';
				}
				if (data.data.result[i].integrationStatus == 0) {
					tab += '<td >未设积分</td>';
				} else if (data.data.result[i].integrationStatus == 1) {
					tab += '<td >已设积分</td>';
				}
				tab += "<td style='font-size:9px;'>" + data.data.result[i].createTime + '</td>';
				tab += '</tr>';
			}
			if (tab != '') {
				$("#dataOrderTable").html(tab);
			} else {
				$("#dataOrderTable").html(
						'<tr><td colspan="12">没有符合条件的记录！</td></tr>');
			}
			$("#dataOrderTable tr").hover(function() {
				$(this).addClass("over");
			}, function() {
				$(this).removeClass("over");
			});
			//加入分页的绑定
			var current_page = pageno - 1;
			$("#PaginationOrder").pagination(total, {
				callback : pageorderCallback,
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
	parent.resetTime(); 
}

function show() {
	if ($("#orderstate").val() == 1) {
		$("#fdli").show();
		$("#totalprofit").show();
		$(".title_1").show();
		$(".content_1").show();
	} else {
		$("#fdli").hide();
		$("#totalprofit").hide();
		$(".title_1").hide();
		$(".content_1").hide();
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
			show();
			$("select[name=orderstate]").click(function() {
				if ($(this).val() == 2) {
					$("#fdli").show();
				} else {
					$("#fdli").hide();
				}
			});
		});

function select_three_type(type) {
	var type_ = $("#good_type").val();
	if (type_ == type) {
		return $("#input_three_text").val();
	} else {
		return "";
	}
}
function selectorderstatus(status) {
	var status_ = $("#orderstate").val();
	if (status_ == status) {
		var statusvalue = $('input[name="fdstate"]:checked').val();
		return statusvalue;
	} else {
		return "";
	}
}

function bindLargeData() {
	//var orderCode = select_one_type(1);
	var goodsCode = select_three_type(1);
	var goodsName = select_three_type(2);
	var status = $("#orderstate").val();
	var orderStatus = "";
	if (status != 1) {
		orderStatus = $("#orderstate").val();
	}
	var profitStatus = selectorderstatus(2);

	var queryStr = "&orderCode=" + ecode($.trim($("#ordercode").val()));
	queryStr += "&goodsCode=" + encodeURI($.trim(goodsCode));
	queryStr += "&goodsName=" + encodeURI($.trim(goodsName));
	queryStr += "&orderStatus=" + encodeURI($.trim(orderStatus));
	queryStr += "&profitStatus=" + encodeURI($.trim(profitStatus));
	queryStr += "&startTime=" + $.trim($("#orderStartTime").val());
	queryStr += "&endTime=" + $.trim($("#orderEndTime").val());
	return queryStr;
}

function replace(str) {
	re = new RegExp("\"", "g");
	return str.replace(re, "'");
}

function ecode(value) {
	return encodeURI(encodeURI(value));
}
</script>

<style type="text/css">
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

#tabCot_product_4 {
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
</style>



<div id="tabCot_product_4" class="tabCot" style="display: none;padding: 20px 0;">
	<input type="hidden" id="rowsPerPage" />
	<ul class="formul">
		<li style="width: 100%">
			<label>
				订单编号：
			</label>
			<input id="ordercode" name="ordercode" style="width: 125px;" />
		</li> 
		<li style="width: 100%">
			<label>
				订单状态：
			</label>
			<select name="orderstate" id="orderstate">
				<option value="-1" selected="selected">
					---全部---
				</option>
				<option value="1">
					充值中
				</option>
				<option value="2">
					成功
				</option>
				<option value="3">
					失败
				</option>
				<option value="4">
					未付款
				</option> 
				<option value="5">
					已撤消
				</option> 
			</select>
		</li>
		<li style="width: 100%">
			<label>
				商品类型：
			</label>
			<select name="good_type" id="good_type">
				<option value="-1" selected="selected">
					---全部---
				</option>
				<option value="1">
					商品编码
				</option>
				<option value="2">
					商品名称
				</option>
			</select>
			<input type="text" id="input_three_text" class="_form" />
		</li>
		<li style="width: 100%">
			<label>
				时间：
			</label>
			<input id="begin_Date" name="start" type="text"
				onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_Date\')}' ,minDate:'#F{$dp.$D(\'end_Date\',{M:-3})||\'%y-%MM-%d\'}'})"
				style="font-size: 10pt; display: none;"/>
			<input id="orderStartTime" name="orderStartTime" class="Wdate middle"
				type="text"
				onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"
				style="width: 140px;height: 25px;" />
			至
			<input id="orderEndTime" name="orderEndTime" class="Wdate middle"
				type="text"
				onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"
				style="width: 140px;height: 25px;" />
		</li>
		<li id="fdli" style="display: none">
			<label>
				返利状态：
			</label>
			<span class="checkLab"> <input type="radio" name="fdstate"
					id="s0" value="-1" checked="checked" /> <label for="s0">
					全部
				</label> </span>
			<span> <input type="radio" name="fdstate" id="s1" value="0" />
				<label for="s1">
					未返利
				</label> </span>
			<span> <input type="radio" name="fdstate" id="s2" value="1" />
				<label for="s2">
					已返利
				</label> </span>
		</li>
		<li class="btnarea">
			<input id="orderSumbit" name="Submit" type="button" class="Partorange" value="查询"/>
		</li>
	</ul>

	<div style="" id="autoTime">
		<div class="block" style="padding: 10px 0;">
			<form name="frm1" method="post">
				<table class="tablelist pusht" style="margin-top: 30px; width: 100%;border-left: 0;">
					<tr>
						<th style="width: 8%">
							订单编号
						</th>
						<th style="width: 9%">
							代理商编号
						</th>
						<th style="width: 10%">
							商品名称
						</th>
						<th style="width: 5%">
							数量
						</th>
						<th style="width: 7%">
							进价(元)
						</th>
						<th style="width: 7%">
							批价(元)
						</th>
						<th style="width: 9%">
							销售价格(元)
						</th>
						<th style="width: 6%">
							利润(元)
						</th>
						<th style="width: 8%">
							订单状态
						</th>
						<th style="width: 7%">
							返利状态
						</th>
						<th style="width: 7%">
							积分状态
						</th>
						<th style="width: 15%">
							订单生成时间
						</th>
					</tr>
					<tbody id="dataOrderTable" style="text-align: center">
					</tbody>
					<td colspan="12" align="center" id="selectOrderFactor">
						请选择查询条件
					</td>
				</table>
			</form>
		</div>
	</div>

	<div id="pages">
	<div id="PaginationOrder" class="pagination"></div>
	</div>


	<div class="clear"></div>
</div>
