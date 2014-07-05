<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>

<script type="text/javascript">
var pageno = 1;
var pagesize = 10;
function pageorderCallback(page_id, jq) {
	var pageno_id = page_id + 1
	orderQuery(pageno_id);
	return false;
}

$(function(){

	orderQuery(1);
})

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
		orderQuery(1);
	});
});

function orderQuery(pageno) {
	var url_ = "<%=basePath%>agentsManage.do?type=agentOrder&";
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
						'<tr><td colspan="12">查询出错！</td></tr>');
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
			
		}
	});
 
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

</head>

<body>
<div class="main">


<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
        
        <div class="nyRight">
          <div class="nyTit">下级</div>
          <div class="gamenamebox">
           <jsp:include page="memberManagerTitle.jsp" >
			  <jsp:param name="num" value="3" /> 
			</jsp:include>
            <div class="gamename">
	              <div class="spcxtj" id="con_spcx_4" >
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
					  <tr>
					    <td class="wz">订单编号：</td>
					    <td>
					     <input name="ordercode" type="text" class="input6" id="ordercode" />
					    </td>
					    <td class="wz">订单状态：</td>
					    <td><select name="orderstate" class="input6" id="orderstate">
					      <option value="-1">——全部——</option>
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
					    </select></td>
					    <td class="wz">商品类型：</td>
					    <td>
					     <select name="good_type" class="input6" id="good_type">
					   <option value='-1'>——全部——</option>
				<option value="1">
					商品编码
				</option>
				<option value="2">
					商品名称
				</option>
					    <input name="textfield" type="text" class="input6" id="input_three_text" /></td>
					 
					  </tr>
					    <tr>
					    <td class="wz">开始时间：</td>
					    <td>
	<input id="begin_Date" name="start" type="text"
				onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_Date\')}' ,minDate:'#F{$dp.$D(\'end_Date\',{M:-3})||\'%y-%MM-%d\'}'})"
				style="font-size: 10pt; display: none;"/>
			<input id="orderStartTime" name="orderStartTime" class="Wdate middle,input6"
				type="text"
				onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"
				style="width: 140px;height: 25px;" />
					
					    </td>
					    <td class="wz">结束时间：</td>
					    <td>
					    	<input id="orderEndTime" name="orderEndTime" class="Wdate middle"
				type="text"
				onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"
				style="width: 140px;height: 25px;" /></td>
					    <td class="wz"></td>
					    <td>
					    </td>
					 
					  </tr>
					  <tr>
					    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" onclick="orderQuery(1)" value="查询" /></td>

					    </tr>
					</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="240" class="wz">订单编号</td>
	                    <td width="230" class="wz">代理商编号</td>
	                    <td width="280" class="wz">商品名称</td>
	                    <td width="116" class="wz">数量</td>
	                    <td width="130" class="wz">进价（元）</td>
	                    <td width="130" class="wz">批价（元）</td>
	                    <td width="116" class="wz">销售价格（元）</td>
	                    <td width="116" class="wz">利润（元）</td>
	                    <td width="230" class="wz">订单状态</td>
	                    <td width="230" class="wz">返利状态</td><%--
	                    <td width="130" class="wz">积分状态</td>
	                    --%><td width="280" class="wz">订单生成时间</td>
	                  </tr>
	                    <tbody id="dataOrderTable" style="text-align: center">
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td><%--
	                    <td>&nbsp;</td>--%>
	                    <td>&nbsp;</td>
					  </tbody>
						<td colspan="11" align="center" id="selectOrderFactor">
							请选择查询条件
						</td>
	                  
	                </table>
	              </div>
	              	<div id="pages">
						<div id="PaginationOrder" class="pagination"></div>
					</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
