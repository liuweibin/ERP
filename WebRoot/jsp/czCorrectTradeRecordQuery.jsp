<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<%
String num= request.getParameter("num");
%>
<style type="text/css">
.time ul{width: 600px;}
.time ul li{float: left; list-style-type: none;margin: 0 15px;white-space:nowrap}
#queryDate{padding-left: 10px;}
#queryDate label{display: none;}
#queryDate input {height: 20px;font-size: 13px;}
.spcxtj tr td select{width: 150px;height : 20px;size: 10px;}
.select  {background-color: #C8E2B1;}
.input
{
    /*background-color:expression(this.type=="text"?'#FFC':'');*/
   height: 25px;
    line-height: 25px;
    font-size: 16px;
    font-weight: 700;
    border-left:0px;border-top:0px;border-right:0px;border-bottom:2px solid #a7d3ff;
}
.over {background-color: red}
</style>
<script type="text/javascript">
var pageno = 1;
var pagesize = 5;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	correctOrderfactorquery(pageno_id);
	return false;
}
	var dataPicker;
$(function(){
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
     
 	 
}) 
 
function correctOrderfactorquery(pageno) {
	var url_ = "<%=basePath%>correctOrder/correctOrderList.do?fromBrowser=true&pageno=" + pageno + "&pagesize=" + pagesize;
	url_+=bindLargeData_();
	$ .ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : url_,
				dataType : 'json',
				error : function(request) {
					$("#dataCorrectTable") .html( '<tr><td colspan="14" class="red">查询出错，请刷新后重试！</td></tr>');
				},
				success : function(data) {
					if(data.retcode=="1"){
						$("#correctOrderdataTable").html('<tr><td colspan="14">查询出错！</td></tr>');
						return false;
					}
					var total = data.data.totalCount;
					var pageno = data.data.pageNo;
					var pagesize = data.data.pageSize;
					
					var tab = '';
					
					for ( var i = 0; i < data.data.result.length; i++) {
						tab += '<tr>';
						tab += '<td align="left">' + data.data.result[i].correctOrderCode + '</td>';
						tab += '<td align="left">' + data.data.result[i].orderCode + '</td>';
						tab += '<td align="left">' + data.data.result[i].rechargeCode + '</td>';
						tab += '<td align="left">' + data.data.result[i].goodsName + '</td>';
						tab += '<td align="left">' + data.data.result[i].mobileNo + '</td>';
						tab += '<td align="left">' + data.data.result[i].operationId + '</td>';
						tab += '<td align="left">' + data.data.result[i].amount + '</td>';
						tab += '<td align="left" style="font-size:10px">' + data.data.result[i].orderModifyTime + '</td>';
						tab += '<td align="left">' + data.data.result[i].order_status + '</td>';
						tab += '</tr>';
					}
					if (tab != '') {
						$("#dataCorrectTable").html(tab);
					} else {
						$("#dataCorrectTable").html('<tr><td colspan="14">没有符合条件的记录！</td></tr>');
					}
					$("#dataCorrectTable tr").hover(function() {
						$(this).addClass("tbover"); 
					}, function() { 
						$(this).removeClass("tbover");
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
			});

}

function bindLargeData_() {
	var queryStr = "";
	queryStr += "&startTime="+ $.trim($("#starttime").val());
	queryStr += "&endTime="+$.trim($("#endtime").val());
	queryStr += "&orderStatus="+$.trim($("#orderStatus").val());
	queryStr += "&operationId="+$.trim($("#operationId").val());
	queryStr += "&correctOrderCode="+$.trim($("#correctOrderCode").val());
	queryStr += "&orderCode="+$.trim($("#orderCode").val());
	queryStr += "&goodsCategoryLargeTblId="+$.trim($("#cardtype").val());
	queryStr += "&mobileNo="+$.trim($("#mobileNo").val()); 
	return queryStr;
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
          <div class="nyTit">充值缴费 &gt; 冲正记录查询</div>
          <div class="gamenamebox">
          
            <div class="gamename" style="width: 968px;padding: 20px 0; ">
              <div class="spcxtj" id="con_spcx_1">
              <form  action="<%=basePath%>tradingRecord/exportOrder.do" method="post" id="queryForm">
		                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
							  <tr>
							    <td class="wz" >冲正订单编号：</td>
							       <td><input name="correctOrderCode" type="text" class="input" id="correctOrderCode" /></td>
							    <td class="wz" >充值订单编号：</td>
							       <td><input name="orderCode" type="text" class="input" id="orderCode" /></td>
							  </tr>
						  	  <tr>
						  	  <td class="wz">时间：</td>
									  <td id="queryDate" colspan="3"></td></tr>
							  <tr>
							       <td class="wz">充值账号：</td>
							       <td><input name="gameno" type="text" class="input" id="gameno" /></td>
							        <td class="wz">商品类型：</td>
								    <td><select name="cardtype" id="cardtype">
										<option selected="selected" value="">
											---全部---
										</option>
										<option value="1">
											游戏充值类
										</option>
										<option value="2">
											话费充值类
										</option>
									</select></td>
							  </tr>
							  <tr>
								     <td class="wz">订单状态：</td>
								    <td>
									    <select name="orderStatus" id="orderStatus">
											<option value="" selected="selected" multiple="multiple">
												---全部---
											</option>
											<option value="1"> 处理中 </option>
											<option value="2"> 成功 </option>
											<option value="3"> 处理失败 </option>
											<option value="4"> 未付款 </option>
											<option value="5"> 撤销 </option>
										</select>
								    </td>
								    <td class="wz">运营商</td>
								    <td>
									    <select name="operationId" id="operationId">
											<option value="" selected="selected" multiple="multiple"> ---全部--- </option>
											<option value="01"> 移动 </option>
											<option value="02"> 联通 </option>
											<option value="03"> 电信 </option>
										</select>
									</td>
								    
							  </tr>
							  <tr>
							    <td colspan="8" align="center">
							    <input name="button" type="button" class="an_input2"  onclick="correctOrderfactorquery(1)" id="button" value="查询" />
							  	<input name="button" type="button" class="an_input2"  onclick="$('#queryForm')[0].reset();dataPicker.initPicker(); " id="button" value="重置" />
							    </td>
							  </tr>
						</table>
		               <table width="970" border="0" cellspacing="0" cellpadding="0" id="tablelist" class="tablelist cxjg"> 
		                <thead>
			                  <tr>
			                   	<td width="348" class="wz">冲正订单编号</td>
			                    <td width="231" class="wz">充值订单编号</td>
			                    <td width="233" class="wz">充值工单编号</td>
			                    <td width="116" class="wz">商品名称</td>
			                    <td width="116" class="wz">电话号码</td>
			                    <td width="116" class="wz">运营商</td>
			                    <td width="116" class="wz">金额（元）</td>
			                    <td width="116" class="wz">处理时间</td>
			                    <td width="116" class="wz">状态</td>
			                  </tr>
		                  </thead>
	                	<tbody id="dataCorrectTable" style="text-align: center" class="dataCorrectTable">
					   </tbody>
	                </table>
		          		<div id="pages">
									<div id="Pagination" class="pagination"></div>
						</div>
							</form>
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
