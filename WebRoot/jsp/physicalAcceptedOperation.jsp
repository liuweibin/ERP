<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">

#queryDate label{display: none;}
</style>
<script type="text/javascript">
var pageno = 1;
var pagesize = 10;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1
	supplierAcceptedQuery(pageno_id);
	return false;
}
$(function(){
	init();
})
function init(){
	var dataPicker;
	var otherDay = '';
	if(''=='prv')
		otherDay = 'Yesterday';
	else// if(''=='cur')
		otherDay = 'Today';
	if(''!=''){
		if(''!='')
			dataPicker = new OfCard.DatePicker({title:'',endnum:'',otherDay:otherDay});
		else
			dataPicker = new OfCard.DatePicker({otherDay:otherDay});
	}else{
		if(''!='')
			dataPicker = new OfCard.DatePicker({title:'',otherDay:otherDay});
		else
			dataPicker = new OfCard.DatePicker({otherDay:otherDay});
	}
     dataPicker.initPicker();
     supplierAcceptedQuery(1);
}
 

function handleGoodOrder(type,supplyOrderNo) { 
	var title = "";
	if(type=="0"){
		title ="商品供货受理";
	}else if(type=="1"){
		title = "商品退货受理";
	}
	var url = "<%=basePath%>supplier/acceptedGoodOrder.do?supplyOrderNo="+ supplyOrderNo+"&type="+type ;
	var width = 500;
	var height = 400;
	parent.LightBox(url, title, width, height);
}
function supplierCancelOrder(supplyOrderNo) {
	var bo = false;
	  if(confirm("确定要撤销?")){
			bo=true;
		}
	if(bo){
		$.ajax({
			url:'<%=basePath%>supplier/supplierCancelOrder.do?supplyOrderNo='+supplyOrderNo,
			type:'post',
			dataType:'json',
			cache : false,
			async : false,
			error : function(request) {
				$("#dataTable").html('<tr><td colspan="14" class="red">撤销出错，请刷新后重试！</td></tr>');
			},
			success : function(datas) {
					alert(datas.message);
					supplierAcceptedQuery(1);
			}
		})
	}
}
function supplierAcceptedQuery(pageno) {
				var buystarttime = $("#starttime").val();
				var buyendtime =$("#endtime").val();
				var status = $("#status2").val();
				var type = $("#type").val();
			$.ajax({
				url:'<%=basePath%>supplier/supplierAcceptedQuery.do',
				type:'post',
				dataType:'json',
				async : false,
				data:{"pageno":pageno,"pagesize":pagesize,"startTime":buystarttime,"endTime":buyendtime,"status":status,"type":type},
				error : function(request) {
					$("#dataTable").html('<tr><td colspan="14" class="red">查询出错，请刷新后重试！</td></tr>');
				},
				success : function(datas) {
					if(datas.retcode=="1"){
						$("#dataTable").html('<tr><td colspan="14" class="red">查询出错，请刷新后重试！</td></tr>');
					}else{
						var data = datas.data;
						var total = data.totalCount;
						var pagesize= data.pageSize;
						var goodcode;
						var code;
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
								tab += '<td align="left" style="font-size:9px;">' + result[i].createTime + '</td>';
								tab += '<td align="left" style="font-size:9px;">' + result[i].modifyTime + '</td>';
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
							$("#dataTable").html(tab);
						} else {
							$("#dataTable").html('<tr><td colspan="14">没有符合条件的记录！</td></tr>');
						}
						$("#dataTable tr").hover(function() {
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
			  <jsp:param name="num" value="2" /> 
			</jsp:include>
            <div class="gamename">
	              <div class="spcxtj" id="con_spcx_1">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz" style="width: 25%;">订单类型：</td>
						    <td style="width: 25%;">
							    <select name="agent_good_type" id="agent_good_type"  class="input6" >
														<option value="0" selected="selected">
															---全部---
														</option>
														<option value="1"> 商品编号 </option>
														<option value="2"> 	商品名称 </option>
								</select> 
						    </td>
						    <td class="wz" style="width: 25%;">订单状态：</td>
						    <td  >
						    <select name="status" id="status" class="input6">
													<option value="-1" selected="selected">
														---全部---
													</option>
													<option value="0"> 处理中 </option>
													<option value="1"> 成功 </option>
													<option value="2"> 失败 </option>
													<option value="3"> 下级取消 </option>
													<option value="4"> 上级取消 </option>
							</select>
						    </td>
						  </tr>
							 <tr>
							   <td class="wz">时间：</td>
							   <td id="queryDate" colspan="3" ></td>
							 </tr>
					 
						  <tr>
						    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" onclick="supplierAcceptedQuery(1)" value="查询" /></td>
						    </tr>
						</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="200" class="wz">编号</td>
	                    <td width="120" class="wz">代理商编号</td>
	                    <td width="128" class="wz">商品编号</td>
	                    <td width="348" class="wz">商品名称</td>
	                    <td width="100" class="wz">数量</td>
	                    <td width="200" class="wz">创建时间</td>
	                    <td width="200" class="wz">订单修改时间</td>
	                    <td width="100" class="wz">备注</td>
	                    <td width="150" class="wz">订单状态</td>
	                    <td width="248" class="wz">操作</td>
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
