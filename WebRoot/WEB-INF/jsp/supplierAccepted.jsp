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

#tabCot_product_2{
border-left:1px solid #d6d6d6;
border-right:1px solid #d6d6d6;
margin-right: 8px;

}
</style>

<script type="text/javascript">

var pageno = 1;
var pagesize = 5;
function pageselectCallback2(page_id, jq) {
	var pageno_id = page_id + 1;
	supplierAcceptedQuery(pageno_id);
	return false;
}
$(document).ready(function() {
	parent.resetTime(); 
	$('#supplierAcceptedQueryBut').click(function() {
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
		supplierAcceptedQuery(1);
	});
	
	
	var pid = ${praentId};
	if(pid==-1){
		displayToggle($("#tabCot_product_2"));
	}
});
function handleGoodOrder(type,supplyOrderNo) { 
	var title = "";
	if(type=="0"){
		title ="商品供货受理";
	}else if(type=="1"){
		title = "商品退货受理";
	}
	var url = "supplier/acceptedGoodOrder.do?supplyOrderNo="+ supplyOrderNo+"&type="+type ;
	var width = 500;
	var height = 400;
	parent.LightBox(url, title, width, height);
}
function supplierCancelOrder(supplyOrderNo) {
	parent.resetTime(); 
	$.ajax({
		url:'${ctx}/supplier/supplierCancelOrder.do?supplyOrderNo='+supplyOrderNo,
		type:'post',
		dataType:'json',
		cache : false,
		async : false,
		error : function(request) {
			$("#supplierdataTable2").html('<tr><td colspan="14" class="red">撤销出错，请刷新后重试！</td></tr>');
			$("#selectsupplierFactor2").css("display", "none");
		},
		success : function(datas) {
				alert(datas.message);
				window.location.reload();
				supplierAcceptedQuery(1);
		}
	})
}
function supplierAcceptedQuery(pageno) {
	parent.resetTime(); 
				var buystarttime = $("#stime").val();
				var buyendtime =$("#etime").val();
				var status = $("#status2").val();
				var type = $("#type").val();
			$.ajax({
				url:'${ctx}/supplier/supplierAcceptedQuery.do',
				type:'post',
				dataType:'json',
				async : false,
				data:{"pageno":pageno,"pagesize":pagesize,"startTime":buystarttime,"endTime":buyendtime,"status":status,"type":type},
				error : function(request) {
					$("#supplierdataTable2").html('<tr><td colspan="14" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectsupplierFactor2").css("display", "none");
				},
				success : function(datas) {
					if(datas.retcode=="1"){
						$("#supplierdataTable2").html('<tr><td colspan="14" class="red">查询出错，请刷新后重试！</td></tr>');
						$("#selectsupplierFactor2").css("display", "none");
					}else{
						var data = datas.data;
						var total = data.totalCount;
						var pagesize= data.pageSize;
						var goodcode;
						var code;
						$("#selectsupplierFactor2").css("display", "none");
						var tab = '';
						var result = new Array();
						 result = data.result;
							for ( var i = 0; i <result.length; i++) {
								tab += '<tr>';
								tab += '<td align="left">' + result[i].supplyOrderNo + '</td>';
								tab += '<td align="left">' + result[i].requestAgentCode + '</td>';
								tab += '<td align="left">' + result[i].goodsCode + '</td>';
								tab += '<td align="left">' + result[i].goodsName + '</td>';
								tab += '<td align="left">' + result[i].supplyNumber + '</td>';
								tab += '<td align="left">' + result[i].createTime + '</td>';
								tab += '<td align="left">' + result[i].modifyTime + '</td>';
								tab += '<td align="left">' + result[i].remark + '</td>';
								if(result[i].status == '2'){
									tab += '<td align="left">' + result[i].failReasonMessage +'</td>';
								}else{
									tab += '<td align="left">' + result[i].status_trans + '</td>';
								}
								
								if(result[i].status == '0'){//0生成
									if(result[i].type=='0'){
									tab += "<td ><a href='javascript:void(0)' onClick="+"javascript:handleGoodOrder('"+result[i].type+"','"+result[i].supplyOrderNo+"')><span style='color: #ff4500;'>审批供货</span></a>";
									}else if(result[i].type=='1'){
									tab += "<td ><a href='javascript:void(0)' onClick="+"javascript:handleGoodOrder('"+result[i].type+"','"+result[i].supplyOrderNo+"')><span style='color: #ff4500;'>审批退货 </span></a>";
									}
									tab += "<a href='javascript:void(0)'onClick="+"javascript:supplierCancelOrder('"+result[i].supplyOrderNo+"')><span style='color: #ff4500;margin-left: 5px;'>撤销</span></a>";
									tab +=  "</td>";
								}else{
									tab += '<td ><a href="javascript:void(0)"><span style="color: gray;">已处理</span></a></td>';
								}
								tab += '</tr>';
							}
						if (tab != '') {
							$("#supplierdataTable2").html(tab);
						} else {
							$("#supplierdataTable2").html('<tr><td colspan="14">没有符合条件的记录！</td></tr>');
						}
						$("#supplierdataTable2 tr").hover(function() {
							$(this).addClass("over");
						}, function() {
							$(this).removeClass("over");
						});
						// $("#databuyTable tr:even").addClass("alt");
						//加入分页的绑定
						var current_page = pageno - 1;
						$("#Pagination2").pagination(total, {
							callback : pageselectCallback2,
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


function getbrowse(){ //判断当前浏览器是何种浏览器
    var str="";
    // 包含「Opera」文字列
    Agent=navigator.userAgent;
    if(Agent.indexOf("Opera") != -1) {
        str='Opera';
    }
    // 包含「MSIE」文字列
    else if(Agent.indexOf("MSIE") != -1) {
        str='MSIE';
    }
    // 包含「Firefox」文字列
    else if(Agent.indexOf("Firefox") != -1) {
        str='Firefox';
    }
    // 包含「Netscape」文字列
    else if(Agent.indexOf("Netscape") != -1) {
        str='Netscape';
    }
    // 包含「Safari」文字列
    else if(Agent.indexOf("Safari") != -1) {
        str='Safari';
    }
    else{  
    }  
    return str;
}
</script>
<div id="tabCot_product_2" class="tabCot" style="display: none;">
				<ul class="formul" style="margin-left: 10px;">
					<li>
						<span style="margin-left: 66px;"> <label>
														订单类型 :
													</label> <select name="type" id="type"
														style="width: 142px;">
														<option value="-1" selected="selected">
															---全部---
														</option>
														<option value="0">
															供货
														</option>
														<option value="1">
															退货
														</option>
													</select>
													 <label>
														订单状态:
													</label> 
													<select name="status2" id="status2"
														style="width: 142px;">
														<option value="-1" selected="selected">
															---全部---
														</option>
														<option value="0">
															处理中
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
								<input id="supplierAcceptedQueryBut" type="button"  class="Partorange" style="width: 80px;" value="查询">
					</li>
					</ul>
				
			<div class="blockcommon pusht" style="margin-left: 10px;margin-right: 10px;">
			<li >
							<label>
								时间：
							</label>
						<input  id="begin_Date" name="start" type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_Date\')}' ,minDate:'#F{$dp.$D(\'end_Date\',{M:-3})||\'%y-%MM-%d\'}'})"   style="height:15px; width:80px; font-size:10pt; display: none"/>
			   		 <input id="stime" name="stime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
			   		至<input id="etime" name="etime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
					</li>
			</div>
		<div style="width: 100%;" id="autoTime" >
			<div class="block" style="width: 100%;">
					<form name="frm1" method="post">
					<table class="tablelist pusht" style="margin-top: 20px; width: 100%;" >
					<tr style="width: 100%;">
								<th style="width: 10%;">
									编号
								</th>
								<th style="width: 9%;">
									代理商编号
								</th>
								<th style="width: 9%;">
									商品编号
								</th>
								<th style="width: 13%;">
									商品名称
								</th>
								<th style="width: 6%;">
									 数量
								</th>
								<th style="width: 13%;">
									创建时间
								</th>
								<th style="width: 13%;">
									订单修改时间
								</th>
								<th style="width: 6%;">
									备注
								</th>
									<th style="width: 6%;">
									订单状态
								</th>
									<th style="width: 11%;">
									操作
								</th>
						</tr>
						<tbody id="supplierdataTable2" style="text-align: center">
					
					
						</tbody>
						<td colspan="12" align="center" id="selectsupplierFactor2">请选择查询条件</td>
					</table>
					</form>
			</div>
		</div>
						<div id="pages">
								<div id="Pagination2" class="pagination"></div>
						</div>
		<div class="clear"></div>	
</div>

