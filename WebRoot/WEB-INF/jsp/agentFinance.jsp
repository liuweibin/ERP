<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script language="javaScript">
$(document).ready(function() {
	parent.resetTime(); 
	var dataPicker;
	var otherDay = '';
	if ('' == 'prv')
		otherDay = 'Yesterday';
	else
		// if(''=='cur')
		otherDay = 'Today';
	if ('' != '') {
		if ('' != '')
			dataPicker = new OfCard.DatePicker( {
				title : '',
				endnum : '',
				otherDay : otherDay
			});
		else
			dataPicker = new OfCard.DatePicker( {
				otherDay : otherDay
			});
	} else {
		if ('' != '')
			dataPicker = new OfCard.DatePicker( {
				title : '',
				otherDay : otherDay
			});
		else
			dataPicker = new OfCard.DatePicker( {
				otherDay : otherDay
			});
	}
	dataPicker.initPicker();

	if ('' != '' && '' != '') {
		var type = $('#t3').attr("type");
		if (type == "radio") {
			$('#t3').click();
			$("input[type=radio][name=timeRange]").parent().removeClass(
					'checkLab');
			$('#t3').parent().addClass('checkLab');
		} else {
			$('#t3').attr('selected', 'selected');
			$('#timeRange').change();
		}
		$('#starttime').val('');
		$('#endtime').val('');
	}


});
</script>
<script type="text/javascript">
function pagefinanceCallback(page_id, jq) {
	var pageno_id = page_id + 1
	financeQuery(pageno_id);
	return false;
}

$(document).ready(function() {
	$('#financeSumbit').click(function() {
		financeQuery(0);
	});
});

function financeQuery(pageno) {
	var url_ = "agentsManage.do?type=agentFinance&";
	url_ += bindStreamData();
	url_ += "&pageno=" + pageno;
	url_ += "&pagesize=" + pagesize;
	$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : url_,
				dataType : 'json',
				error : function(request) {
					$("#dataStreamTable")
							.html(
									'<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectFinanceFactor").css("display", "none");
				},
				success : function(data) {

					if (data.retcode == "1") {
						$("#correctOrderdataTable").html(
								'<tr><td colspan="14">查询出错！</td></tr>');
						return false;
					}

					var total = data.data.totalCount;
					var pageno = data.data.pageNo;
					var pagesize = data.data.pageSize;

					$("#selectFinanceFactor").css("display", "none");
					var tab = '';
					for ( var i = 0; i < data.data.result.length; i++) {
						tab += '<tr>';
						tab += '<td class="content_0" style="display:none">' + data.data.result[i].serial + '</td>';
						tab += '<td >' + data.data.result[i].code + '</td>';
						tab += '<td >' + data.data.result[i].agentsCode + '</td>';
						if (data.data.result[i].type == 1) {
							tab += '<td style="color:purple;">转入</td>';
						} else if (data.data.result[i].type == 2) {
							tab += '<td style="color:purple;">转出</td>';
						} else if (data.data.result[i].type == 3) {
							tab += '<td style="color:purple;">充值</td>';
						} else if (data.data.result[i].type == 4) {
							tab += '<td style="color:purple;">消费</td>';
						} else if (data.data.result[i].type == 5) {
							tab += '<td style="color:purple;">扣点</td>';
						} else if (data.data.result[i].type == 6) {
							tab += '<td style="color:purple;">加点</td>';
						} else if (data.data.result[i].type == 7) {
							tab += '<td style="color:purple;">返点</td>';
						} else if (data.data.result[i].type == 8) {
							tab += '<td style="color:purple;">加保证金</td>';
						} else if (data.data.result[i].type == 9) {
							tab += '<td style="color:purple;">减保证金</td>';
						}else if(data.data.result[i].type ==10){
							tab += '<td style="color:purple;">还点</td>';
						}else if(data.data.result[i].type ==11){
						tab+='<td style="color:purple;">退点</td>'
						}
						data.data.result[i].userName == null ? tab += '<td></td>'
								: tab += '<td>' + data.data.result[i].userName + '</td>';
						tab += '<td class="content_1" style="display:none">' + data.data.result[i].shoptype + '</td>';
						tab += '<td style="color: blue;">' + data.data.result[i].revenue + '</td>';
						tab += '<td style="color: red;">' + data.data.result[i].expenses + '</td>';
						tab += '<td style="color: green;">' + data.data.result[i].bail + '</td>';
						tab += '<td style="color: #ff4500;">' + data.data.result[i].balance + '</td>';
						tab += '<td>' + data.data.result[i].createTime + '</td>';
						data.data.result[i].remark == null ? tab += '<td  class="content_2" style="display:none"></td>'
								: tab += '<td  class="content_2" style="display:none">' + data.data.result[i].remark + '</td>';
						tab += '</tr>';
						$("#rowsPerPage").val(data.data.result[i].rowsPerPage);
						document.getElementById("streamBuy").innerHTML = data.data.result[i].sumRevenue;
						document.getElementById("streamTo").innerHTML = data.data.result[i].sumExpenses;
					}
					if (tab != '') {
						$("#dataStreamTable").html(tab);
						showList('billidcheckbox', 0);
						showList('jynamecheckbox', 1);
						showList('remark', 2);

					} else {
						$("#dataStreamTable").html(
								'<tr><td colspan="12">没有符合条件的记录！</td></tr>');
					}
					$("#dataStreamTable tr").hover(function() {
						$(this).addClass("over");
					}, function() {
						$(this).removeClass("over");
					});
					//加入分页的绑定
					var current_page = pageno - 1;
					$("#PaginationFinance").pagination(total, {
						callback : pagefinanceCallback,
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

function bindStreamData() {
	var conditions = "&agentsCode=" + ecode($("#agents_code").val()) ;
	conditions += "&serial=" + $("#serial").val();
	conditions += "&financeType=" + chk();
	conditions += "&startTime=" + $("#starttime").val();
	conditions += "&endTime=" + $("#endtime").val();
	return conditions;
}

function chk() {
	var obj = document.getElementsByName("financeType");
	var finacecheck = '';
	for ( var i = 0; i < obj.length; i++) {
		if (obj[i].checked) {
			finacecheck += obj[i].value + ',';
		}
	}
	return finacecheck.substring(0, finacecheck.length - 1);
}

function replace(str) {
	re = new RegExp("\"", "g");
	return str.replace(re, "'");
}

function ecode(value) {
	return encodeURI(encodeURI(value));
}

function doChkclick(chkid) {
	var zwflag = "";
	if (chkid == 0) {
		if ($("#show_all").attr("checked") == true) {
			$("#show_from0").attr("checked", "checked");
			$("#show_from1").attr("checked", "checked");
			$("#show_from2").attr("checked", "checked");
			$("#show_to0").attr("checked", "checked");
			$("#show_to1").attr("checked", "checked");
			$("#show_to2").attr("checked", "checked");
			$("#show_to3").attr("checked", "checked");
			$("#show_to4").attr("checked", "checked");
			$("#show_from9").attr("checked", "checked");
			  $("#show_to10").attr("checked", "checked");
	            $("#show_to11").attr("checked", "checked");
		} else {
			$("#show_from0").removeAttr("checked");
			$("#show_from1").removeAttr("checked");
			$("#show_from2").removeAttr("checked");
			$("#show_to0").removeAttr("checked");
			$("#show_to1").removeAttr("checked");
			$("#show_to2").removeAttr("checked");
			$("#show_to3").removeAttr("checked");
			$("#show_to4").removeAttr("checked");
			$("#show_from9").removeAttr("checked");
			  $("#show_to10").removeAttr("checked", "checked");
	            $("#show_to11").removeAttr("checked", "checked");
		}
	} else {
		$("#show_all").removeAttr("checked");
	}
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

#tabCot_product_2 {
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}

#count {
	height: 74px;
	float: left;
}

#count ul {
	width: 800px;
}

#count li {
	width: 400px;
	float: left;
	display: block;
}
</style>

<div id="tabCot_product_2" class="tabCot" style="display: none;">
	<input type="hidden" id="rowsPerPage" />
	<div>
		<ul class="formul" style="margin-left: 10px;">
			<li>
				<ul>
					<li>
					<span><label>交易流水号:</label><input type="text" name="serial" id="serial" value="" /></span>
					<span><label>代理商:</label> 
			 <select id="agents_code" name="agents_code" style="width: 143px;">
			 <option value="">
							---全部---
						</option>
						<c:forEach items="${childsAgentsMap}" var="childsAgentsMap">
							<option value="${childsAgentsMap.key}">
								${childsAgentsMap.value}
							</option>
						</c:forEach>
					</select>
					
					</span>
					<input id="financeSumbit" type="button" class="Partorange" value="查询"/>
					</li>
				</ul>
			</li>
		</ul>

		<div class="blockcommon pusht"
			style="margin-left: 10px; margin-right: 10px;">
			<li id="queryDate">

			</li>
		</div>
		<div class="blockcommon pusht"
			style="margin-left: 10px; margin-right: 10px;">
			<strong>类别：</strong>
			<span> <input type="checkbox" id="show_all" name="show_all"
					class="showColumn" value=" " onclick="doChkclick(0);"
					checked="checked" /> <label for="showallradio">
					全部
				</label> </span>
			<span> <input type="checkbox" id="show_from0"
					name="financeType" class="showColumn" value="2"
					onclick="doChkclick(3);" checked="checked" /> <label
					for="showturnradio">
					转出记录
				</label> </span>
			<span> <input type="checkbox" id="show_to1" name="financeType"
					class="showColumn" value="1" onclick="doChkclick(2);"
					checked="checked" /> <label for="showinradio">
					转入记录
				</label> </span>
			<span> <input type="checkbox" id="show_from1"
					name="financeType" class="showColumn" value="6"
					onclick="doChkclick(5);" checked="checked" /> <label
					for="showturnradio">
					加点记录
				</label> </span>
			<span> <input type="checkbox" id="show_from9"
					name="financeType" class="showColumn" value="5"
					onclick="doChkclick(9);" checked="checked" /> <label
					for="showturnradio">
					扣点记录
				</label> </span>
			<span> <input type="checkbox" id="show_from2"
					name="financeType" class="showColumn" value="4"
					onclick="doChkclick(6);" checked="checked" /> <label
					for="showturnradio">
					消费
				</label> </span>
			<span> <input type="checkbox" id="show_to0" name="financeType"
					class="showColumn" value="3" onclick="doChkclick(1);"
					checked="checked" /> <label for="showoutradio">
					充值
				</label> </span>
			<span> <input type="checkbox" id="show_to3" name="financeType"
					class="showColumn" value="7" onclick="doChkclick(7);"
					checked="checked" /> <label for="showturnradio">
					下级返点
				</label> </span>
			<span> <input type="checkbox" id="show_to2" name="financeType"
					class="showColumn" value="8" onclick="doChkclick(4);"
					checked="checked" /> <label for="showturnradio">
					加保证金
				</label> </span>
			<span> <input type="checkbox" id="show_to4" name="financeType"
					class="showColumn" value="9" onclick="doChkclick(8);"
					checked="checked" /> <label for="showturnradio">
					减保证金
				</label> </span>
				<span> <input type="checkbox" id="show_to10" name="financeType"
						class="showColumn" value="10" onclick="chkclick(10);"
						checked="checked" /> <label for="showturnradio">
						还点
				</label> </span>
				<span> <input type="checkbox" id="show_to11" name="financeType"
						class="showColumn" value="11" onclick="chkclick(11);"
						checked="checked" /> <label for="showturnradio">
						退利
				</label> </span>
		</div>
		<div class="blockcommon pusht"
			style="margin-left: 10px; margin-right: 10px;">
			<strong>是否显示：</strong>
			<span> <input type="checkbox" name="showtyperecord"
					id="billidcheckbox" value="0"
					onclick="showList('billidcheckbox',0);" /> <label
					for="billidcheckbox">
					交易流水号
				</label> </span>
			<span> <input type="checkbox" name="showtyperecord"
					id="jynamecheckbox" value="1"
					onclick="showList('jynamecheckbox',1);" /> <label
					for="jynamecheckbox">
					店铺类型
				</label> </span>
			<span> <input type="checkbox" name="showtyperecord"
					id="remark" value="2" onclick="showList('remark',2);" /> <label
					for="remark">
					备注
				</label> </span>
		</div>

		<div style="width: 100%;" id="autoTime">
			<div class="block" style="width: 100%;">
				<form name="frm1" method="post">
					<table class="tablelist pusht"
						style="margin-top: 20px; width: 100%;">
						<tr style="width: 100%;">
							<th height="23" class="title_0" style="display: none"
								style="width: 9%;">
								交易流水号
							</th>
							<th style="width: 8%;">
								变更编号
							</th>
							<th style="width: 9%;">
								代理商编号
							</th>
							<th style="width: 8%;">
								交易类型
							</th>
							<th style="width: 7%;">
								用户名
							</th>
							<th class="title_1" style="display: none" style="width: 8%;">
								店铺类型
							</th>
							<th style="width: 7%;">
								收入(元)
							</th>
							<th style="width: 7%;">
								支出(元)
							</th>
							<th style="width: 9%;">
								加减保证金(元)
							</th>
							<th style="width: 10%;">
								账户余额(元)
							</th>
							<th style="width: 14%;">
								时间
							</th>
							<th class="title_2" style="display: none" style="width: 7%;">
								备注
							</th>
						</tr>
						<tbody id="dataStreamTable" style="text-align: center">
						</tbody>
						<td colspan="12" align="center" id="selectFinanceFactor">
							请选择查询条件
						</td>
					</table>
				</form>
			</div>
		</div>
		<div id="pages">
			<div id="PaginationFinance" class="pagination"></div>
		</div>
		<div class="tabletoolbar" id="downlist" style="margin-top: -30px;">
			<a href="javascript:void(0)" onClick="downList();return false;"><span>导出列表</span>
			</a>
		</div>
		<div class="blockcommon pusht" style="margin: 0px, 10px, 0px, 10px;">
			<ul class="formul column2">
				<li style="width: 800px; margin-top: -20px;">
					<li style="width: 400px">
						<label>
							收入合计：
						</label>
						<span id="streamBuy"></span>
					</li>
					<li style="width: 400px">
						<label>
							支出合计：
						</label>
						<span id="streamTo"></span>
					</li>
				</li>
			</ul>
		</div>
	</div>
	<div class="clear"></div>
</div>

