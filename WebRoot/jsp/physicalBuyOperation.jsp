<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
.time ul li{float: left; list-style-type: none;margin: 0 15px;}
.show ul li a:LINK { color: green; }
.show ul li a:VISITED { color: blue; }
.show ul li a:active { color: red; }
.show ul li a:HOVER { color: red; }
.select  {background-color: #C8E2B1;}
</style>
<script type="text/javascript">
var pageno = 1;
var pagesize = 10;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1
	agentsManager(pageno_id);
	return false;
}
$(function(){
	 
	init();
})
function init(){
	supplierfactorquery();
}
function supplierGood(type,good,stockNumber,CurrentStockNumber) {
	var title = "";
	if(type=="application"){
		title ="商品供货申请";
	}else if(type=="cancel"){
		title = "商品退货申请";
	}
	
	var url = "<%=basePath%>supplier/agentSupplierGood.do?goodsCode="+ good+"&stockNumber="+stockNumber+"&CurrentStockNumber="+CurrentStockNumber+"&type="+type;
	var width = 550;
	var height = 500;
	parent.LightBox(url, title, width, height);
}
function supplierfactorquery(pageno) {
			$.ajax({
				url:'<%=basePath%>goodsManager/getAgentsHasRealGoods.do',
				type:'post',
				dataType:'json',
				cache : true,
				async : false,
				data:{"pageno":pageno,"pagesize":pagesize,"agentGoodType":$("#agent_good_type ").val(),"inputGoodText":$("#input_good_text").val()},
				error : function(request) {
					$("#dataTable").html('<tr><td colspan="8" class="red">查询出错，请刷新后重试！</td></tr>');
				},
				success : function(datas) {
					if(datas.retcode=="1"){
						$("#dataTable").html('<tr><td colspan="8" class="red">查询出错，请刷新后重试！</td></tr>');
					}else{
						var data = datas.data;
						var total = data.totalCount;
						var pagesize= data.pageSize;
						var goodcode;
						var code;
						var tab = '';
						result = data.result;
						var agentsCode = "${agentsCode}";
						for ( var i = 0; i <total; i++) {
							tab += "<tr>";
							tab += "<td align='left'>"+ result[i].goodsCode + "</td>";
						//	tab += '<td align="left">' + result[i].goodsCategoryLargeTbl + '</td>';
					//		tab += '<td align="left">' + result[i].goodsCategorySmallTbl + '</td>';
							//tab += '<td align="left">' + result[i].contentname + '</td>';
							tab += "<td align='left'>" + result[i].goodsName + "</td>";
							tab += "<td align='left'>" + result[i].SupplierName + "</td>";
							tab += "<td align='left'>" + result[i].parValue + "</td>";
							tab += "<td align='left'>" + result[i].inPrice +"</td>";
							tab += "<td align='left'>" + result[i].suggestRetailPrice + "</td>";
							tab += "<td align='left'>" + result[i].stockNumber + '</td>';
							if(agentsCode=="A0000001"){
								tab += "<td ><a><span style='color: gray;'>申请供货</span></a>";
								tab += " <a><span style='color: gray;'>申请退货</span></a></td>";
							}else{
								tab += "<td ><a href='javascript:void(0)'  onClick="+"javascript:supplierGood('application','"+result[i].goodsCode+"','"+result[i].stockNumber+"','"+result[i].CurrentStockNumber+"')><span style='color: #ff4500;'>申请供货</span></a>";
								tab += " <a href='javascript:void(0)' onClick="+"javascript:supplierGood('cancel','"+result[i].goodsCode+"','"+result[i].stockNumber+"','"+result[i].CurrentStockNumber+"')><span style='color: #ff4500;'>申请退货</span></a></td>";
							}
							tab += "</tr>";
						}
						if (tab != '') {
							$("#dataTable").html(tab);
						} else {
							$("#dataTable").html('<tr><td colspan="8">没有符合条件的记录！</td></tr>');
						}
						$(".cxjg tr").hover(function() {
							$(this).addClass("tbover");
						}, function() {
							$(this).removeClass("tbover");
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
					}
				}
			});

}
</script>
</head>

<body>
<div class="main">
<input  type="hidden" id="timeUnit" />
<input  type="hidden" id="type" />

<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
         
        <div class="nyRight">
          <div class="nyTit">实物商城</div>
          <div class="gamenamebox">
             <jsp:include page="physicalBuyTitle.jsp" >
			  <jsp:param name="num" value="1" /> 
			</jsp:include>
            <div class="gamename">
	              <div class="spcxtj" id="con_spcx_1">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz" style="width: 25%;">商品类型：</td>
						    <td style="width: 50%;">
							    <select name="agent_good_type" id="agent_good_type"  class="input6" >
														<option value="0" selected="selected">
															---全部---
														</option>
														<option value="1"> 商品编号 </option>
														<option value="2"> 	商品名称 </option>
								</select> 
							    <input type="text" class="input6"  id="input_good_text" name="input_good_text" />
						    </td>
						  </tr>
					 
					 
						  <tr>
						    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" onclick="supplierfactorquery(1)" value="查询" /></td>
						    </tr>
						</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="200" class="wz">商品编号</td>
	                    <td width="348" class="wz">商品名称</td>
	                    <td width="200" class="wz">供货商</td>
	                    <td width="100" class="wz">面值（元）</td>
	                    <td width="100" class="wz">进价（元）</td>
	                    <td width="200" class="wz">建议零售价（元）</td>
	                    <td width="100" class="wz">上级库存</td>
	                    <td width="348" class="wz">操作</td>
	                  </tr>	
	                  <tbody id="dataTable" style="text-align: center">
		                  
					  </tbody>
	                </table>
	              </div>
	              <div id="pages">
					<div id="Pagination" class="pagination"></div>
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
