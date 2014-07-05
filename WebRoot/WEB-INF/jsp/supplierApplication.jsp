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

#tabCot_product_1{
border-left:1px solid #d6d6d6;
border-right:1px solid #d6d6d6;
margin-right: 1px;
}
</style>

<script type="text/javascript">
var pageno = 1;
var pagesize = 4;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	supplierfactorquery(pageno_id);
	return false;
}
function supplierGood(type,good,stockNumber,CurrentStockNumber) {
	var title = "";
	if(type=="application"){
		title ="商品供货申请";
	}else if(type=="cancel"){
		title = "商品退货申请";
	}
	
	var url = "supplier/agentSupplierGood.do?goodsCode="+ good+"&stockNumber="+stockNumber+"&CurrentStockNumber="+CurrentStockNumber+"&type="+type;
	var width = 550;
	var height = 500;
	parent.LightBox(url, title, width, height);
}
$(document).ready(function() {
	parent.resetTime(); 
	$('#supplierfactorbtn').click(function() {
		supplierfactorquery(1);
		});
	
	supplierfactorquery(1);
});

function supplierfactorquery(pageno) {
	parent.resetTime(); 
			$.ajax({
				url:'${ctx}/goodsManager/getAgentsHasRealGoods.do',
				type:'post',
				dataType:'json',
				cache : true,
				async : false,
				data:{"pageno":pageno,"pagesize":pagesize,"agentGoodType":$("#agent_good_type ").val(),"inputGoodText":$("#input_good_text").val()},
				error : function(request) {
					$("#supplierdataTable1").html('<tr><td colspan="8" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectsupplierFactor1").css("display", "none");
				},
				success : function(datas) {
					if(datas.retcode=="1"){
						$("#supplierdataTable1").html('<tr><td colspan="8" class="red">查询出错，请刷新后重试！</td></tr>');
						$("#selectsupplierFactor1").css("display", "none");
					}else{
						var data = datas.data;
						var total = data.totalCount;
						var pagesize= data.pageSize;
						var goodcode;
						var code;
						$("#selectsupplierFactor1").css("display", "none");
						var tab = '';
						result = data.result;
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
							tab += "<td ><a href='javascript:void(0)' onClick="+"javascript:supplierGood('application','"+result[i].goodsCode+"','"+result[i].stockNumber+"','"+result[i].CurrentStockNumber+"')><span style='color: #ff4500;'>申请供货</span></a>";
							tab += " <a href='javascript:void(0)' onClick="+"javascript:supplierGood('cancel','"+result[i].goodsCode+"','"+result[i].stockNumber+"','"+result[i].CurrentStockNumber+"')><span style='color: #ff4500;'>申请退货</span></a></td>";
							tab += "</tr>";
						}
						if (tab != '') {
							$("#supplierdataTable1").html(tab);
						} else {
							$("#supplierdataTable1").html('<tr><td colspan="8">没有符合条件的记录！</td></tr>');
						}
						$("#supplierdataTable1 tr").hover(function() {
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
					}
				}
			});

}
function displayToggle(obj){
	$.each(obj,function(i,attr){
		if(attr.style.display=='block'||attr.style.display==''){
				attr.style.display='none';	
		}else if(attr.style.display=='none'){
			var BrowseType="";
			if(getbrowse()=="MSIE"){
			    BrowseType="block";
			}
			else{
			    BrowseType="table-row";
			}
		attr.style.display=BrowseType;
		}
	});
};
</script>
<div id="tabCot_product_1" class="tabCot"  >
							<div style="" id="autoTime">
								<div class="block">
									<form name="frm1" method="post">
										<ul class="formul" style="width: 100%">

											<li style="width: 100%">
												<span style="margin-left: 66px;"> <label>
														商品类型：
													</label> <select name="agent_good_type" id="agent_good_type"
														style="width: 142px;">
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
												<span> <input type="text" id="input_good_text"	class="_form" /> </span>
								<input id="supplierfactorbtn" type="button"  class="Partorange" style="width: 80px;" value="查询">
											</li>
										</ul>
										
										<table class="tablelist pusht" style="margin-top: 10px;"> 
											<tr>
												<th width="12px;">
													商品编号
												</th >
												<th width="12px;">
													商品名称
												</th>
												<th width="12px;">
													供货商
												</th>
												<th width="12px;">
													面值 (元)
												</th>
												<th width="12px;">
													进价(元)
												</th>
												<th width="12px;">
													建议零售价(元)
												</th>
												<th width="12px;">
													上级库存 
												</th>
												<th width="12px;">
													操作
												</th>
											</tr> 
											<tbody id="supplierdataTable1" style="text-align: center;display: ;">
									
											
											</tbody>
											<td colspan="8" align="center" id="selectsupplierFactor1" class="selectsupplierFactor1" style="display: none;">
												请选择查询条件 
											</td>
										</table>
										
									</form>
								</div>
							</div>
							<div id="pages">
								<div id="Pagination" class="pagination"></div>
							</div>

							<div class="clear"></div>
						</div>

