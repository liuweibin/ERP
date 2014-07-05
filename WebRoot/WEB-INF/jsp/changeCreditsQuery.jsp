<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script type="text/javascript">
 function pagesChangeCallback(page_id, jq){
	 var pageno_id=page_id+1
	changeCreditsQuery(pageno_id);
	return false;
  }

$(document).ready(function() {
	parent.resetTime();   
	$('#changeSumbit').click(function() {
		var startTime = document.getElementById("stime").value;
		var endTime = document.getElementById("etime").value;
		startTime = startTime.replace(/-/g, "/");
		endTime = endTime.replace(/-/g, "/");
		var d1 = new Date(startTime);
		var d2 = new Date(endTime);
		if (d2.getTime() - d1.getTime() < 0) {
			alert("时间有错，起始时间不能大于结束时间！");
			return false;
		}
		changeCreditsQuery(0);
									});
});

function changeCreditsQuery(pageno){
	var url_ = "accountRecord.do?type=changeCreditQuery&pageno=" + pageno+"&pagesize=" + pagesize+"&stime="+$.trim($("#stime").val())+"&etime="+$.trim($("#etime").val())+"&acceptAgentAccount="+ecode($.trim($("#acceptAgentAccount").val()))+"&json=";
								url_ += changeData();
									$.ajax( {
												cache : true,
												type : "POST",
												async : false,
												url : url_,
												dataType : 'json',
												error : function(request) {
													$("#dataChangeTable").html('<tr><td colspan="11" class="red">查询出错，请刷新后重试！</td></tr>');
													$("#selectChangeFactor").css("display","none");
												},
												success : function(data) {
													var total=0;
											    	var pageno=0;
											    	var pagesize;
													$("#selectChangeFactor").css("display","none");
													var tab = '';
													var number='';
													for ( var i = 0; i < data.length; i++) {
														total=data[i].totalCount;
														pagesize=data[i].pageSize;
														pageno=data[i].pageNo;
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
													    number=data[i].count;
													}
													if (tab != '') {
														$("#dataChangeTable").html(tab);
														 document.getElementById("changeCount").innerHTML=number;
														showList('remarkcheckbox',1);
													} else {
														$("#dataChangeTable")
																.html(
																		'<tr><td colspan="10">没有符合条件的记录！</td></tr>');
														 document.getElementById("changeCount").innerHTML="";
													}
													$("#dataChangeTable tr").hover(
																	function() {
																		$(this).addClass(
																						"over");
																	},
																	function() {
																		$(this).removeClass(
																						"over");
																	});
													//加入分页的绑定
														 var current_page=pageno-1;
														$("#PaginationChange").pagination(total, {
															callback: pagesChangeCallback,
												            prev_text: '上一页',       //上一页按钮里text  
												            next_text: '下一页',       //下一页按钮里text  
												            items_per_page: pagesize,  //显示条数  
												            num_display_entries: 6,    //连续分页主体部分分页条目数  
												            current_page: current_page,   //当前页索引  
												            num_edge_entries: 2        //两侧首尾分页条目数  
														});

														parent.document.getElementById("main").style.height= window.document.body.clientHeight+20+"px";
												}
											});
									parent.resetTime();   
}

function changeData() {
	 var changetemp=$("#tabCot_product_3").is(":visible");
	if(changetemp){
	var jsonData = {
		agentsCode : ecode($.trim($("#a_number").val())),
		registerUsername : encodeURI($.trim($("#acceptAgentAccount").val())),
		type : "2",
		status : "1",
		startTime : $.trim($("#stime").val()),
		endTime : $.trim($("#etime").val())
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
.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}

#tabCot_product_3 {
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
	margin-right: 8px;
}

#totalaccountli {
	float: left;
	width: 50%;
}

#change {
	width: 100%;
	height: 74px;
	float: left;
}

#change ul {
	width: 800px;
}

#change li {
	width: 400px;
	float: left;
	display: block;
}
#input {
background: url("${ctx}/images/img0001.png") repeat scroll 0 -876px rgba(0, 0, 0, 0);
    border: medium none;
    float: left;
    font-family: Arial,Helvetica,sans-serif;
    font-size: 32px;
    font-weight: bold;
    height: 30px;
    line-height: 30px;
    padding-left: 10px;
    width: 200px;
}

</style>
<div id="tabCot_product_3" class="tabCot" style="display: none;">
	<input type="hidden" id="rowsPerPage" />
	<input type="hidden" id="a_number" value="${agentCode}"/>
	<div>
		<ul class="formul">
			<li style="width: 100%;">
				<label>
								时间：
							</label>
				<input  id="begin_Date" name="start" type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_Date\')}' ,minDate:'#F{$dp.$D(\'end_Date\',{M:-3})||\'%y-%MM-%d\'}'})"   style="height:15px; width:80px; font-size:10pt; display: none"/>
			   		 <input id="stime" name="stime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
			   		至<input id="etime" name="etime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
				
			</li>
			<li style="width: 100%;">
				<label>
					接受代理商帐户名：
				</label>
				<input type="text" name="acceptAgentAccount" id="acceptAgentAccount" value=""
					class="middle" id="input">
			</li>
			<li class="btnarea">
			  <input id="changeSumbit" type="button" class="Partorange"  value="查询"/>
			</li>
		</ul>

		<div class="blockcommon pusht" style="margin: 0px,10px,0px,10px;">
			<ul class="discontrol">
				<li class="bold">
					是否显示：
				</li>
				<li>
					<input type="checkbox" id="remarkcheckbox" class="showColumn"
						value="1"
						onClick="showList('remarkcheckbox',1)" />
					<label for="remarkcheckbox">
						显示备注
					</label>
				</li>
			</ul>
		</div>

		<div style="" id="autoTime">
			<div class="block">
				<form name="frm1" method="post">
					<table class="tablelist pusht" style="margin-top: 20px;">
						<tr>
							<th>
								转出编号
							</th>
							<th>
								序列号
							</th>
							<th>
								接受人账户
							</th>
							<th>
								转出点数(元)
							</th>
							<th>
								代理商余额(元)
							</th>
							<th style="width: 14%">
								转出时间
							</th>
							<th class="title_1" style="display: none;">
								备注
							</th>
						</tr>
						<tbody id="dataChangeTable" style="text-align: center">
						</tbody>
						<td colspan="10" align="center" id="selectChangeFactor">
							请选择查询条件
						</td>
					</table>
				</form>
			</div>
		</div>

		<div id="pages">
			<div id="PaginationChange" class="pagination"></div>
		</div>
		<%--<div class="tabletoolbar" style="margin-top: -20px;">
			<a href="#" onClick="pageRedirct('changeremark')"><span>修改备注</span>
			</a>
		</div>
		--%><div class="blockcommon pusht" style="margin: 0px,10px,0px,10px;">
			<ul class="formul column2">
			<li style="width: 800px;margin-top: -20px;">
				<li style="width: 400px">
					<label>
						转出总额：
					</label>
					<span id="changeCount"></span>
				</li>
				</li>
			</ul>
		</div>

	</div>
	<div class="clear"></div>
</div>

