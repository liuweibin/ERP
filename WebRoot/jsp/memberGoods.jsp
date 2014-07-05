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
function pageGoodCallback(page_id, jq) {
	var pageno_id = page_id + 1
	goodQuery(pageno_id);
	return false;
}
$(function(){
	init();
	goodQuery(1);
})
function goodQuery(pageno){
	var url_ = "<%=basePath%>agentsManage.do?type=agentVirtualGoods&fromBrowser=true";
	url_ += bindLargeData_();
	url_ += "&pageno=" + pageno;
	url_ += "&pagesize=" + pagesize;
	$ .ajax({ 
				cache : true,
				type : "POST",
				async : false,
				url : url_,
				dataType : 'json',
				error : function(request) {
					$("#dataGoodTable") .html( '<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectGoodFactor").css("display", "none");
				},
				success : function(data) { 
					if (data.retcode == "1") {
						$("#dataGoodTable").html( '<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
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
						tab += '<td>' + data.data.result[i].stockNumber + '</td>';
						tab += '</tr>';
						$("#rowsPerPage").val(
								data.data.result[i].rowsPerPage);
					}
					if (tab != '') {
						$("#dataGoodTable").html(tab);
					} else {
						$("#dataGoodTable").html( '<tr><td colspan="10">没有符合条件的记录！</td></tr>');
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
				}
			});
	
}

function bindLargeData_() {
	var stock_number = "";
	var queryStr = "&goodsType=" + $("#agent_good_type").val();
	queryStr += "&agentCode=" +  $.trim($("#agents_code_good").val());
	queryStr += "&goodsCode=" +  $.trim($("#goodsCode").val());
	queryStr += "&goodsName=" +  $.trim($("#goodsName").val());
	queryStr += "&supplierId=" +  $.trim($("#suppliername").val());
	queryStr += "&goodsCategoryLargeId=" + $.trim($("#goodsCategoryLarge").val());
	queryStr += "&goodsCategorySmallId=" + $.trim($("#goodsCategorySmall").val());
	return queryStr;
}
function init(){
	$.ajax({
		url : '<%=basePath%>agentsManage.do?type=memberManagerInit',
		type : 'post',
		dataType : 'json',
		async:false,
		success : function(data) {
			if(data.retcode==0){ 
				data = data.data;
				var map  = data[0].childsAgentsMap;
				var goodsCategoryLargeTblList  = data[0].goodsCategoryLargeTblList;
				var supplierTblList  = data[0].supplierTblList;
				var html ="";
				$("#agents_code_good").empty();
				//$("#agents_code_good").prepend("<option value='' selected>——全部——</option>");
				$.each(map, function(i, attr) {
					var key = i;
					var value = attr;
					$("#agents_code_good").prepend("<option value='"+key+"'>" +value + "</option>");
				});
				$("#goodsCategoryLarge").empty();
				$("#goodsCategoryLarge").prepend("<option value='' selected>——全部——</option>");
				$.each(goodsCategoryLargeTblList, function(i, attr) {
					var key = i;
					var value = attr;
					$("#goodsCategoryLarge").prepend("<option value='"+key+"'>" +value + "</option>");
				});
				$("#suppliername").empty();
				$("#suppliername").prepend("<option value='' selected>——全部——</option>");
				$.each(supplierTblList, function(i, attr) {
					var key = i;
					var value = attr;
					$("#suppliername").prepend("<option value='"+key+"'>" +value + "</option>");
				});
			}
		},
		error : function(error) {
		 alert(error.status);
		}
	});
}

function selectgood() {
	var selectvalue = document.getElementById("goodsCategoryLarge").value;
	if (selectvalue != "") {
		$.ajax( {
			type : "POST",
			async : false,
			url : "<%=basePath%>agentsManage.do?type=agentsGoodSmall&selectvalue=" + selectvalue,
			dataType : "text",
			success : function(data) {
				var jsondate = data.split("$$$$$")[1];
				var goodsCategorySmallDate = eval('(' + jsondate + ')');
				var selectAdd = document.getElementById("goodsCategorySmall");
				//checkedIndexAll();
			$("#goodsCategorySmall").empty();
			$("#goodsCategorySmall").append("<option value='' selected>——全部——</option>");
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
			  <jsp:param name="num" value="2" /> 
			</jsp:include>
            <div class="gamename">
	              <div class="spcxtj" id="con_spcx_3" >
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
					  <tr>
					    <td class="wz">商品类别：</td>
					    <td>
					     	<select id="agent_good_type" name="agent_good_type" class="input6">
								<option value="">——全部—— </option>
								<option value="0"> 虚拟商品 </option>
								<option value="1"> 实体商品 </option>
							</select> 
					    </td>
					    <td class="wz">代理商：</td>
					    <td><select name="agents_code_good" class="input6" id="agents_code_good">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">商品大类：</td>
					    <td>
						    <select name="goodsCategoryLarge" class="input6" id="goodsCategoryLarge" onchange="selectgood();">
						      <option>——全部——</option>
						    </select> 
					    </td>
					    <td class="wz">商品小类：</td>
					    <td> 
						    <select name="goodsCategorySmall" class="input6" id="goodsCategorySmall">
						      <option  value="">——全部——</option>
						    </select> 
					    </td>
					  </tr>
					  <tr>
					    <td class="wz">供货商：</td>
					    <td><select name="suppliername" class="input6" id="suppliername">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">商品编码：</td>
					    <td> 
					    <input name="goodsCode" type="text" class="input6" id="goodsCode" />
					    </td>
					    <td class="wz">商品名称：</td>
					    <td><input name="goodsName" type="text" class="input6" id="goodsName" /></td>
					    <td class="wz"></td>
					    <td></td>
					  </tr>
					  <tr>
					    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" onclick="goodQuery(1)" value="查询" /></td>
					    </tr>
					</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="100" class="wz">代理商编号</td>
	                    <td width="100" class="wz">商品编号</td>
	                    <td width="233" class="wz">商品名称</td>
	                    <td width="116" class="wz">供货商</td>
	                    <td width="116" class="wz">面值（元）</td>
	                    <td width="116" class="wz">进价（元）</td>
	                    <td width="116" class="wz">库存数量</td>
	                  </tr>
	                  <tbody id="dataGoodTable" style="text-align: center">
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
					  </tbody>
						<td colspan="10" align="center" id="selectGoodFactor">
							请选择查询条件
						</td>
	                </table>
	              </div>
	              	<div id="pages">
						<div id="PaginationGood" class="pagination"></div>
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
