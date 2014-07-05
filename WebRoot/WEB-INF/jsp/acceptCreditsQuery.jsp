<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


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

#accept {
	width: 100%;
	height: 74px;
	float: left;
}

#accept ul {
	width: 800px;
}

#accept li {
	width: 400px;
	float: left;
	display: block;
}
</style>

<script type="text/javascript">
function pageAcceptCallback(page_id, jq) {
	var pageno_id = page_id + 1
	acceptQuery(pageno_id);
	return false;
}
$(document).ready(function() {
	parent.resetTime();   
	$('#acceptSumbit').click(function() {
		var startTime = document.getElementById("acceptStartTime").value;
		var endTime = document.getElementById("acceptendsTime").value;
		startTime = startTime.replace(/-/g, "/");
		endTime = endTime.replace(/-/g, "/");
		var d1 = new Date(startTime);
		var d2 = new Date(endTime);
		if (d2.getTime() - d1.getTime() < 0) {
			alert("时间有错，起始时间不能大于结束时间！");
			return false;
		}
		
		acceptQuery(0);
	});
});

function acceptQuery(pageno) {
	var url_ = "accountRecord.do?type=acceptCreditsQuery&pageno=" + pageno
			+ "&pagesize=" + pagesize + "&acceptStartTime="
			+ $.trim($("#acceptStartTime").val()) + "&endsTime="
			+ $.trim($("#acceptendsTime").val()) + "&changeAgentAccount="
			+ ecode($.trim($("#changeAgentAccount").val())) + "&json=";
		url_ += acceptData();
	$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : url_,
				dataType : 'json',
				error : function(request) {
					$("#dataAcceptTable")
							.html(
									'<tr><td colspan="11" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectAcceptFactor").css("display", "none");
				},
				success : function(data) {
					var total = 0;
					var pageno = 0;
					var pagesize;
					$("#selectAcceptFactor").css("display", "none");
					var tab = '';
					var number = '';
					for ( var i = 0; i < data.length; i++) {
						total = data[i].totalCount;
						pagesize = data[i].pageSize;
						pageno = data[i].pageNo;
						tab += '<tr>';
							tab += '<td>' + data[i].code + '</td>';
							tab += '<td>' + data[i].serial + '</td>';
							tab += '<td>' + data[i].registerUsername + '</td>';
							tab += '<td>' + data[i].money + '</td>';
							tab += '<td>' + data[i].balance + '</td>';
						tab += "<td style='font-size: 9px;'>" + data[i].createTime + '</td>';
						tab += '<td class="content_1" style="display:none">' + data[i].remark + '</td>';
						tab += '</tr>';
						$("#rowsPerPage").val(data[i].rowsPerPage);
						number = data[i].acceptCount;
					}
					if (tab != '') {
						$("#dataAcceptTable").html(tab);
						document.getElementById("acceptCount").innerHTML = number;
						showList('acceptRemark', 1);
					} else {
						$("#dataAcceptTable").html(
								'<tr><td colspan="10">没有符合条件的记录！</td></tr>');
						document.getElementById("acceptCount").innerHTML = "";
					}
					$("#dataAcceptTable tr").hover(function() {
						$(this).addClass("over");
					}, function() {
						$(this).removeClass("over");
					});
					//加入分页的绑定
					var current_page = pageno - 1;
					$("#PaginationAccept").pagination(total, {
						callback : pageAcceptCallback,
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

function acceptData() {
	var accepttemp = $("#tabCot_product_4").is(":visible");
	if (accepttemp) {
		var jsonData = {
			agentsCode : ecode($.trim($("#c_number").val())),
			registerUsername : encodeURI($.trim($("#changeAgentAccount").val())),
			type : "1",
			status : "1",
			startTime : $.trim($("#acceptStartTime").val()),
			endTime : $.trim($("#acceptendsTime").val())
		};
		return replace(JSON.stringify(jsonData));
	}
}
function replace(str) {
	re = new RegExp("\"", "g");
	return str.replace(re, "'");
}

function ecode(value) {
	return encodeURI(encodeURI(value));
}

function showList(checkboxid, id) {
	if ($("#" + checkboxid).attr("checked") == true) {
		$(".title_" + id).show();
		$(".content_" + id).show();
	} else {
		$(".title_" + id).hide();
		$(".content_" + id).hide();
	}
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

#tabCot_product_4 {
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
	margin-right: 8px;
}
</style>


<div id="tabCot_product_4" class="tabCot" style="display: none;">
	<input type="hidden" id="c_number" value="${agentCode}" />
	<ul class="formul">
		<li style="width: 100%;">
			<label>
				时间：
			</label>
			<input  id="begin_Date" name="start" type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_Date\')}' ,minDate:'#F{$dp.$D(\'end_Date\',{M:-3})||\'%y-%MM-%d\'}'})"   style="height:15px; width:80px; font-size:10pt; display: none"/>
			   		 <input id="acceptStartTime" name="acceptStartTime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
			   		至<input id="acceptendsTime" name="acceptendsTime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
		</li>
		<li style="width: 100%;">
			<label>
				转出代理商帐户名：
			</label>
			<input type="text" name="changeAgentAccount" id="changeAgentAccount"
				value="" class="middle">
		</li>
		<li class="btnarea">
        		   <input id="acceptSumbit" type="button" class="Partorange"  value="查询"/>
		</li>
	</ul>

	<div class="blockcommon pusht" style="margin: 0px, 10px, 0px, 10px;">
		<ul class="discontrol">
			<li class="bold">
				是否显示：
			</li>
			<li>
				<input type="checkbox" id="acceptRemark" class="showColumn"
					value="1" onClick="showList('acceptRemark',1)" />
				<label for="acceptRemark">
					显示备注
				</label>
			</li>
		</ul>
	</div>

	<div style="" id="autoTime">
		<div class="block">
			<form name="frm1" method="post">
				<table class="tablelist pusht" style="margin-top: 20px;"
					width="100%">
					<tr>
							<th>
								转入编号
							</th>
							<th>
								序列号
							</th>
							<th>
								转出人账户
							</th>
							<th>
								转入点数(元)
							</th>
							<th>
								代理商余额(元)
							</th>
							<th style="width: 14%">
								接受时间
							</th>
							<th class="title_1" style="display: none;">
								备注
							</th>

					</tr>
					<tbody id="dataAcceptTable" style="text-align: center">
					</tbody>
					<td colspan="10" align="center" id="selectAcceptFactor">
						请选择查询条件
					</td>
				</table>
			</form>
		</div>
	</div>
	<div id="pages">
		<div id="PaginationAccept" class="pagination"></div>
	</div>
	<div class="blockcommon pusht" style="margin: 0px, 10px, 0px, 10px;">
		<ul class="formul column2">
			<li style="width: 800px; margin-top: -20px;">
				<li style="width: 400px">
					<label>
						接受总额：
					</label>
					<span id="acceptCount"></span>
				</li>
			</li>
		</ul>
	</div>

	<div class="clear"></div>
</div>
