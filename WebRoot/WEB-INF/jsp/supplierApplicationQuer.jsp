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

#tabCot_product_3{
border-left:1px solid #d6d6d6;
border-right:1px solid #d6d6d6;
margin-right: 1px;
}
</style>

<script type="text/javascript">

var pageno = 1;
var pagesize = 5;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	supplierApplicationQuery(pageno_id);
	return false;
}
$(document).ready(function() {
	parent.resetTime(); 
	$("#supplierApplicationQueryBut").click(function() {
			var startTime = document.getElementById("buystarttime").value;
			var endTime = document.getElementById("buyendtime").value;
			startTime = startTime.replace(/-/g, "/");
			endTime = endTime.replace(/-/g, "/");
			var d1 = new Date(startTime);
			var d2 = new Date(endTime);
			if (d2.getTime() - d1.getTime() < 0) {
				alert("时间有错，起始时间不能大于结束时间！");
				return false;
			}
			
			supplierApplicationQuery(1);	
		
	});
	
});
function supplierApplicationCancelOrder(supplyOrderNo) { 
	parent.resetTime(); 
	$.ajax({
		url:'${ctx}/supplier/supplierCancelOrder.do?supplyOrderNo='+supplyOrderNo,
		type:'post',
		dataType:'json',
		cache : false,
		async : false,
		error : function(request) {
			$("#supplierdataTable3").html('<tr><td colspan="14" class="red">撤销出错，请刷新后重试！</td></tr>');
			$("#selectsupplierFactor3").css("display", "none");
		},
		success : function(datas) {
				alert(datas.message);
				window.location.reload();
		}
	})
}
function supplierApplicationQuery(pageno) {
	var startTime = document.getElementById("buystarttime").value;
	var endTime = document.getElementById("buyendtime").value;
	parent.resetTime(); 
	
	var status = $("#status ").val(); 
			$.ajax({
				url:'${ctx}/supplier/supplierApplicationQuery.do',
				type:'post',
				dataType:'json',
				cache : false,
				async : false,
				data:{"pageno":pageno,"pagesize":pagesize,"startTime":startTime,"endTime":endTime,"status":status},
				error : function(request) {
					$("#supplierdataTable3").html('<tr><td colspan="14" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectsupplierFactor3").css("display", "none");
				},
				success : function(datas) {
					if(datas.retcode=="1"){
						$("#supplierdataTable3").html('<tr><td colspan="14" class="red">查询出错，请刷新后重试！</td></tr>');
						$("#selectsupplierFactor3").css("display", "none");
					}else{
						var data = datas.data;
						var total = data.totalCount;
						var pagesize= data.pageSize;
						var goodcode;
						var code;
						$("#selectsupplierFactor3").css("display", "none");
						var tab = '';
						var result = new Array();
						 result = data.result;
							for ( var i = 0; i <result.length; i++) {
								tab += '<tr>';
								tab += '<td align="left">' + result[i].supplyOrderNo + '</td>';
								tab += '<td align="left">' + result[i].acceptAgentCode + '</td>';
								tab += '<td align="left">' + result[i].goodsCode + '</td>';
								tab += '<td align="left">' + result[i].goodsName + '</td>';
								tab += '<td align="left" >' + result[i].supplyNumber + '</td>';
								if(result[i].type == '0'){
									tab += '<td align="left" style="color: blue">' + result[i].trans_type + '</td>';
								}else if(result[i].type == '1'){
									tab += '<td align="left" style="color: red">' + result[i].trans_type + '</td>';
								}
								tab += "<td align='left'  style='font-size:9px;'>" + result[i].createTime + '</td>';
								tab += '<td align="left">' + result[i].remark + '</td>';
								if(result[i].status == '2'){
									tab += '<td align="left">' + result[i].failReasonMessage+'</td>';
								}else{
									tab += '<td align="left">' + result[i].status_trans + '</td>';
								}
								if(result[i].status == '0'){//'订单状态(0生成，1订单交易成功，2订单交易失败,3下级取消订单，4上级取消定单,5处理中',
									tab += "<td>";
									tab += "<a href='javascript:void(0)'onClick="+"javascript:supplierApplicationCancelOrder('"+result[i].supplyOrderNo+"')><span style='color: #ff4500;margin-left: 5px;'>撤销</span></a>";
									tab +=  "</td>";
								}else{
									tab += '<td ><a href="javascript:void(0)"><span style="color: gray;">已处理</span></a></td>';
								}
								tab += '</tr>';
							}
							
						if (tab != '') {
							$("#supplierdataTable3").html(tab);
						} else {
							$("#supplierdataTable3").html('<tr><td colspan="14">没有符合条件的记录！</td></tr>');
						}
						$("#supplierdataTable3 tr").hover(function() {
							$(this).addClass("over");
						}, function() {
							$(this).removeClass("over");
						});
						// $("#supplierQueryTable tr:even").addClass("alt");
						//加入分页的绑定
						var current_page = pageno - 1;
						$("#Pagination3").pagination(total, {
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
<div id="tabCot_product_3" class="tabCot" style="display: none;">
					<ul class="formul" style="margin-left: 10px;">
					<li>
							<span style="margin-left: 66px;"> <label>
														订单状态 :
													</label> <select name="status" id="status" style="width: 142px;">
														<option value="-1" selected="selected">
															---全部---
														</option>
														<option value="0">
															生成
														</option>
														<option value="1">
															成功
														</option>
														<option value="2">
															失败
														</option>
														<option value="3">
															下级取消
														</option>
														<option value="4">
															上级取消
														</option>
													</select>
							 </span>
						<input id="supplierApplicationQueryBut" type="button"  class="Partorange" style="width: 80px;" value="查询">
					</li>
					</ul>
				
			<div class="blockcommon pusht" style="margin-left: 10px;margin-right: 10px;">
			<li >
							<label>
								时间：
							</label>
					<input  id="begin_Date" name="start" type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_Date\')}' ,minDate:'#F{$dp.$D(\'end_Date\',{M:-3})||\'%y-%MM-%d\'}'})"   style="height:15px; width:80px; font-size:10pt; display: none"/>
			   		 <input id="buystarttime" name="buystarttime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
			   		至<input id="buyendtime" name="buyendtime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
					</li>
			</div>
		<div style="width: 100%;" id="autoTime" >
			<div class="block" style="width: 100%;">
					<form name="frm1" method="post">
					<table class="tablelist pusht" style="margin-top: 20px; width: 100%;" >
					<tr style="width: 100%;">
								<th style="width: 10%;">
									定单编号
								</th>
								<th style="width: 9%;">
									上级编号
								</th>
								<th style="width: 9%;">
									商品编号
								</th>
								<th style="width: 13%;">
									商品名称
								</th>
								<th style="width: 5%;">
									 数量
								</th>
								<th style="width: 8%;">
									 订单类型
								</th>
								<th style="width: 13%;">
									创建时间
								</th>
								<th style="width: 6%;">
									备注
								</th>
									<th style="width: 8%;">
									订单状态
								</th>
									<th style="width: 8%;">
									操作
								</th>
						</tr>
						<tbody id="supplierdataTable3" style="text-align: center">
					
					
						</tbody>
						<td colspan="12" align="center" id="selectsupplierFactor3">请选择查询条件</td>
					</table>
					</form>
			</div>
		</div>
						<div id="pages">
								<div id="Pagination3" class="pagination"></div>
						</div>
		<div class="clear"></div>
</div>

