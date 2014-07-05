<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script type="text/javascript">
function pageGoodCallback(page_id, jq) {
	var pageno_id = page_id + 1
	goodQuery(pageno_id);
	return false;
}

$(document).ready(function() {
	parent.resetTime(); 
	var size = $("select[name=agents_code_good] option").size(); 
	var code = $.trim($("#agents_code_good").val()); 
	if (size == 0) {
		$("#agents_code_good").css("display", "none");
	}
	$('#goodbtn').click(function() {
		goodQuery(0);
	});
});

function goodQuery(pageno) {
	var goodtype = $("#agents_goods").val();
	var code = $.trim($("#agents_code_good").val());
	if (goodtype == 1 && code != "") {//实体
		// $('#signupForm').submit();
		var url_ = "agentsManage.do?type=agentsGood&fromBrowser=true&agentCode="
				+ code + "&";
		url_ += bindLargeData_();
		url_ += "&pageno=" + pageno;
		url_ += "&pagesize=" + pagesize;
		$
				.ajax( {
					cache : true,
					type : "POST",
					async : false,
					url : url_,
					dataType : 'json',
					error : function(request) {
						$("#dataGoodTable")
								.html(
										'<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
						$("#selectGoodFactor").css("display", "none");
					},
					success : function(data) {

						if (data.retcode == "1") {
							$("#dataGoodTable")
									.html(
											'<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
							$("#selectGoodFactor").css("display", "none");
							return false;
						}

						var total = data.data.totalCount;
						var pageno = data.data.pageNo;
						var pagesize = data.data.pageSize;

						$("#selectGoodFactor").css("display", "none");
						$("#snumber").css("display", "block");
						var tab = '';
						for ( var i = 0; i < data.data.result.length; i++) {
							total = data.data.result[i].totalCount;
							pagesize = data.data.result[i].pageSize;
							pageno = data.data.result[i].pageNo;
							tab += '<tr>';
							tab += '<td>' + data.data.result[i].agentsCode + '</td>';
							tab += '<td>' + data.data.result[i].goodCode + '</td>';
							tab += '<td>' + data.data.result[i].name + '</td>';
							tab += '<td>' + data.data.result[i].supplierName + '</td>';
							tab += '<td>' + data.data.result[i].parValue + '</td>';
							tab += '<td>' + data.data.result[i].inPrice + '</td>';
							tab += '<td>' + data.data.result[i].stockNumber + '</td>';
							tab += '</tr>';
							$("#rowsPerPage").val(
									data.data.result[i].rowsPerPage);
						}
						if (tab != '') {
							$("#dataGoodTable").html(tab);
						} else {
							$("#dataGoodTable")
									.html(
											'<tr><td colspan="10">没有符合条件的记录！</td></tr>');
						}
						$("#dataGoodTable tr").hover(function() {
							$(this).addClass("over");
						}, function() {
							$(this).removeClass("over");
						});
						//加入分页的绑定
						var current_page = pageno - 1;
						$("#PaginationGood").pagination(total, {
							callback : pageGoodCallback,
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
	} else if (goodtype == 0 && code != "") {//虚拟
		// $('#signupForm').submit();
		var url_ = "agentsManage.do?type=agentVirtualGoods&fromBrowser=true&agentCode="
				+ code + "&json=";
		url_ += bindLargeData_();
		url_ += "&pageno=" + pageno;
		url_ += "&pagesize=" + pagesize;
		$
				.ajax( {
					cache : true,
					type : "POST",
					async : false,
					url : url_,
					dataType : 'json',
					error : function(request) {
						$("#dataGoodTable")
								.html(
										'<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
						$("#selectGoodFactor").css("display", "none");
					},
					success : function(data) {
						if (data.retcode == "1") {
							$("#dataGoodTable")
									.html(
											'<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
							$("#selectGoodFactor").css("display", "none");
							return false;
						}

						var total = data.data.totalCount;
						var pageno = data.data.pageNo;
						var pagesize = data.data.pageSize;

						$("#selectGoodFactor").css("display", "none");
						$("#snumber").css("display", "none");
						var tab = '';
						for ( var i = 0; i < data.data.result.length; i++) {
							total = data.data.result[i].totalCount;
							pagesize = data.data.result[i].pageSize;
							pageno = data.data.result[i].pageNo;
							tab += '<tr>';
							tab += '<td>' + data.data.result[i].agentsCode + '</td>';
							tab += '<td>' + data.data.result[i].goodCode + '</td>';
							tab += '<td>' + data.data.result[i].name + '</td>';
							tab += '<td>' + data.data.result[i].supplierName + '</td>';
							tab += '<td>' + data.data.result[i].parValue + '</td>';
							tab += '<td>' + data.data.result[i].inPrice + '</td>';
							tab += '</tr>';
							$("#rowsPerPage").val(
									data.data.result[i].rowsPerPage);
						}
						if (tab != '') {
							$("#dataGoodTable").html(tab);
						} else {
							$("#dataGoodTable")
									.html(
											'<tr><td colspan="10">没有符合条件的记录！</td></tr>');
						}
						$("#dataGoodTable tr").hover(function() {
							$(this).addClass("over");
						}, function() {
							$(this).removeClass("over");
						});
						//加入分页的绑定
						var current_page = pageno - 1;
						$("#PaginationGood").pagination(total, {
							callback : pageGoodCallback,
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
	} else {
		$("#selectGoodFactor").css("display", "none");
		$("#dataGoodTable").html('<tr><td colspan="10">没有符合条件的记录！</td></tr>');
	}
	parent.resetTime(); 
}
function ecode(value) {
	return encodeURI(encodeURI(value));
}

function bindLargeData_() {
	var goodsCode = select_good_type(1);
	var goodsName = select_good_type(2);
	//var goodtype=$("#agents_goods").val();
	var stock_number = "";
	//if(goodtype==1){
	//	stock_number = -1;
	//}

	var queryStr = "&goodsType=" + $("#agents_goods").val();
	queryStr += "&goodsCode=" + encodeURI($.trim(goodsCode));
	queryStr += "&goodsName=" + encodeURI($.trim(goodsName));
	queryStr += "&supplierId=" + ecode($.trim($("#suppliername").val()));
	queryStr += "&goodsCategoryLargeId="
			+ ecode($.trim($("#goodsCategoryLarge").val()));
	queryStr += "&goodsCategorySmallId="
			+ ecode($.trim($("#goodsCategorySmall").val()));
	return queryStr;
}

function select_good_type(type) {
	var type_ = $("#agent_good_type").val();
	if (type_ == type) {
		return $("#input_good_text").val();
	} else {
		return "";
	}
}
function replace(str) {
	re = new RegExp("\"", "g");
	return str.replace(re, "'");
}

function selectgood() {
	var selectvalue = document.getElementById("goodsCategoryLarge").value;
	if (selectvalue != "") {
		$.ajax( {
			type : "POST",
			async : false,
			url : "agentsManage.do?type=agentsGoodSmall&selectvalue="
					+ selectvalue,
			dataType : "text",
			success : function(data) {
				var jsondate = data.split("$$$$$")[1];
				var goodsCategorySmallDate = eval('(' + jsondate + ')');
				var selectAdd = document.getElementById("goodsCategorySmall");
				//checkedIndexAll();
			$("#goodsCategorySmall").empty();
			for ( var i = 0; i < goodsCategorySmallDate.length; i++) {
				var op = document.createElement("OPTION");
				op.value = goodsCategorySmallDate[i].id;
				op.innerHTML = goodsCategorySmallDate[i].name;
				selectAdd.appendChild(op);
			}
		}
		});
	} else if (selectvalue == "") {
		$("#goodsCategorySmall").empty();
		$("#goodsCategorySmall").append('<option value="">---全部---</option>');
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
}
</style>
<div id="tabCot_product_3" class="tabCot" style="display: none;">
	<input type="hidden" id="rowsPerPage" />
	<input type="hidden" id="good_parent_id" value="${parent_id}" />
	<input type="hidden" id="good_audit_status" value="${audit_status}" />
	<div>
		<ul class="formul" style="width: 100%">

			<li style="width: 100%">
				<label>
					商品类别：
				</label>
				<span> <select id="agents_goods" name="agents_goods"
						style="width: 143px;">
						<option value="0">
							虚拟商品
						</option>
						<option value="1">
							实体商品
						</option>
					</select> </span>

				<span id="agent_none"> <label> 代理商： </label> 
				    <select id="agents_code_good" name="agents_code_good" style="width: 143px;">
						<c:forEach items="${childsAgentsMap}" var="childsAgentsMap">
							<option value="${childsAgentsMap.key}">
								${childsAgentsMap.value}
							</option>
						</c:forEach>
					</select> </span>
			</li>
		
		
			<li style="width: 100%">
				<label> 商品大类： </label>
				<span> <select id="goodsCategoryLarge"
						name="goodsCategoryLarge" style="width: 142px;"
						onchange="selectgood();">
						<option value="">
							---全部---
						</option>
						<c:forEach items="${goodsCategoryLargeTblList}"
							var="goodsCategoryLargeTblList">
							<option value="${goodsCategoryLargeTblList.id}">
								${goodsCategoryLargeTblList.name}
							</option>
						</c:forEach>
					</select> 
				</span>

				<span> <label> 商品小类： </label>
				 <select id="goodsCategorySmall" name="goodsCategorySmall"
						style="width: 142px;">
						<option value="" selected="selected">
							---全部---
						</option>
					</select> </span>
			</li>
			<li style="width: 100%">
				<label>
					商品类型：
				</label>
				<span > <select name="agent_good_type" id="agent_good_type" style="width: 140px;">
						<option value="0" selected="selected">
							---全部---
						</option>
						<option value="1">
							商品编号
						</option>
						<option value="2">
							商品名称
						</option>
					</select> </span>
				<span> <input type="text" id="input_good_text" class="_form" /> </span>
						
			</li>
			
			<li style="width: 100%">
				<label> 供货商： </label>
				  <span>  <select id="suppliername" name="suppliername"
						style="width: 142px;">
						<option value="">
							---全部---
						</option>
						<c:forEach items="${supplierTblList}" var="supplierTblList">
							<option value="${supplierTblList.id}">
								${supplierTblList.name}
							</option>
						</c:forEach>
					</select> </span>
						<input id="goodbtn" type="button" class="Partorange" value="查询"/>
			</li>

		</ul>
		<div style="" id="autoTime">
			<div class="block">
				<form name="frm1" method="post">
					<table class="tablelist pusht" style="margin-top: 30px;">
						<tr>
							<th>
								代理商编号
							</th>
							<th>
								商品编号
							</th>
							<th>
								商品名称
							</th>
							<th>
								供货商
							</th>
							<th>
								面值(元)
							</th>
							<th>
								进价(元)
							</th>
							<th id="snumber" style="display: none">
								库存数量
							</th>
						</tr>
						<tbody id="dataGoodTable" style="text-align: center">
						</tbody>
						<td colspan="10" align="center" id="selectGoodFactor">
							请选择查询条件
						</td>
					</table>
				</form>
			</div>
		</div>

		<div id="pages">
			<div id="PaginationGood" class="pagination"></div>
		</div>


	</div>
	<div class="clear"></div>
</div>

