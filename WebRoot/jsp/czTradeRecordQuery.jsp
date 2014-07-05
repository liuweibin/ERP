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
</style>
<script type="text/javascript">
var pageno = 1;
var pagesize = 5;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	queryPage(pageno_id);
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
     
 	$(".sType ul li a").click(function (e) {
		var className	= $(this)[0].className;
		var id	= $(this)[0].id;
			if(className=="select"){
				 if(id=="all"){
					 $(this).removeAttr("class").parent().siblings().find("a").removeAttr("class");
				 }else{
					 $(this).removeAttr("class");
					 $("#all").removeAttr("class");
				 }
			}else{
				 if(id=="all"){
					 $(this).addClass("select").parent().siblings().find("a").addClass("select");
				 }else{
					 $(this).addClass("select");
					 $("#all").removeAttr("class");
				 }
			}
    });
}) 
function getValue(){
    var o = $(".sType ul li a");
    var re = "";
    $.each(o,function(i,element){
    	var className = $(element).attr('class');
    	var value = $(element).attr('name');
    	var id = $(element).attr('id');
    	if(className=="select"){
    		if(id=="all")return true;
    		re += value+",";
    	}
    })
    if(re!=""){ 
      re = re.substring(0, re.length-1);
    }
	//$("#financeType").val(re);
	return re;
}
	function queryPage(pageno,divclass){
		var isShow = getValue();
		var pj = isShow.indexOf("1");
		var lr = isShow.indexOf("2");
		var cl = isShow.indexOf("3");
		var tbody = "";
		pagesize = 10;
		var gameno = $("#gameno").val();
		var orderNo = $("#orderNo").val();
		$.ajax({
			url:'<%=basePath%>tradingRecord/getTradeRecord.do',
			dataType:'json',
			type:'post',
			data:{'orderStatus':$('#orderStatus').val()
				,'categoryLargeId':$("#cardtype").find("option:selected").val()
				,'startTime':$("#starttime").val(),'endTime':$("#endtime").val()
				,'orderNo':orderNo,'gameno':gameno,
				'pageno':pageno,'pagesize':pagesize},
			success:function(datas){
			$("#"+divclass+" tbody").empty();
			$("#linkTable_hide tbody").empty();
			//查询之后保留查询参数 保证导出数据和查询列表数据一致
			$('#orderStatusTemp').val($('#orderStatus').val());
			$('#integrationStatusTemp').val($('#integrationStatus').val());
			$('#categoryIdTemp').val($("#cardtype").find("option:selected").val());
			$('#timeTemp').val($('#time').val());
			$('#startTimeTemp').val($('#startTime').val());
			$('#endTimeTemp').val($('#endTime').val());
			$('#hasOrNoSearch').val('1');
			//---------保留参数结束-----------
			if(datas.retcode==0){
				var page = datas.data;
				var total= page.totalCount;
				var pageno=  page.currentPageNo;
				var pagesize = page.pageSize;
				var data = page.result;
				var totalProfit = datas.useableBalance;
				if(totalProfit=="null"){
					totalProfit = 0;
				}
				$("#totalProfit").html(totalProfit/100.0+"元");
					$.each(data, function(index,dlist) {
								 tbody += "<tr>";
								 if(dlist.categoryId==1){
		 							 tbody+="<td ><a title='点击打印订单' href='${ctx}/tradingRecord/gameInfoDesc.do?orderCode="+dlist.orderCode+"' style=' clear:right;color: blue; text-decoration: underline'>"+dlist.orderCode+"</a></td>";
								 }else{
		 							 tbody+="<td ><a title='点击打印订单' href='${ctx}/tradingRecord/printTest.do?orderCode="+dlist.orderCode+"' style=' clear:right;color: blue; text-decoration: underline'>"+dlist.orderCode+"</a></td>";
								 }
							     tbody+='<td align="center" ><div style="width:150px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;">'+dlist.goodsName+'</div></td>';
							     tbody+='<td align="center">'+dlist.rechargeAccount+'</td> ';
							     tbody+='<td align="center"> '+dlist.rechargeNumber+' </td> '; 
							     tbody+='<td align="center">'+dlist.inPrice/100.0+'</td> ';
							     tbody+='<td class="content_2 pj" style="display: '+ (pj!="-1"?'':'none')+';"  >'+dlist.batchPrice/100.0+'</td> '; 
							     tbody+='<td align="center" >'+dlist.sellPrice/100.0+'</td> ';
							     tbody+='<td class="content_3 lr" style="display: '+ (lr!="-1"?'':'none')+';"   align="center">'+dlist.profit/100.0+'</td> ';
							     tbody+='<td align="center"  >'+dlist.createTime+'</td> ';
							     tbody+='<td class="content_5 cl" style="display: '+ (cl!="-1"?'':'none')+';"  align="center"><div>'+dlist.handleTime+'</div></td> ';
							     tbody+=' <td align="center"><span >'+dlist.orderStatusString+'</span></td>';
							     tbody+=' <td align="center"><span  >'+dlist.profitStatusString+'</span></td>';
				 
							tbody += "</tr>";
					});
				}else if(datas.retcode==1){
					alert(datas.message);
				}
				if (tbody != '') {
							$("#downlist").show()
						   	$("#databuyTable").html(tbody);
				} else {
					$("#downlist").hide()
					$("#databuyTable").html('<tr><td colspan="14" align="center">没有符合条件的记录！</td></tr>');
				}
				$("#databuyTable tr").hover(function() {
					$(this).addClass("tbover");
				}, function() {
					$(this).removeClass("tbover");
				});
				 var current_page=pageno-1;
				$("#Pagination").pagination(total, {
					callback: pageselectCallback,
					prev_text: '上一页',       //上一页按钮里text  
					next_text: '下一页',       //下一页按钮里text  
					items_per_page: pagesize,  //显示条数  
					num_display_entries: 6,    //连续分页主体部分分页条目数  
					current_page: current_page,   //当前页索引  
					num_edge_entries: 2        //两侧首尾分页条目数  
				});

			},
			error:function(error){alert(error.status);}
		});
		
	}
	function showTd(id){
		$("."+id).toggle();
	}
</script>
</head>
 <!-- 插入打印控件 --> 
 <OBJECT  ID="jatoolsPrinter" CLASSID="CLSID:B43D3361-D075-4BE2-87FE-057188254255"                codebase="jatoolsPrinter.cab#version=5,7,0,0" style="display: none;"></OBJECT>
         <script>       
         function doPrint(how) {
          	myDoc = {
          		documents: document,
          		
          		copyrights: '杰创软件拥有版权  www.jatools.com'    
          	};
            			jatoolsPrinter.printPreview(myDoc );   // 打印预览
          }
         </script>
<body>
<div class="main">
<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
        <div class="nyRight">
          <div class="nyTit">充值缴费 &gt; 交易记录查询</div>
          <div class="gamenamebox">
          
            <div class="gamename" style="width: 968px;padding: 20px 0; ">
              <div class="spcxtj" id="con_spcx_1">
              <form  action="<%=basePath%>tradingRecord/exportOrder.do" method="post" id="queryForm">
		                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
							  <tr>
							    <td class="wz" style="width: 150px">订单编号：</td>
							       <td><input name="orderNo" type="text" class="input" id="orderNo" /></td>
							    <td class="wz">充值账号：</td>
							       <td><input name="gameno" type="text" class="input" id="gameno" /></td>
							  </tr>
						  	  <tr><td class="wz">时间：</td>
									  <td id="queryDate" colspan="3"></td></tr>
							  <tr>
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
								     <td class="wz">订单状态：</td>
								    <td>
								    <select name="orderStatus" id="orderStatus">
										<option value="" selected="selected" multiple="multiple">
											---全部---
										</option>
										<option value="1">
											处理中
										</option>
										<option value="2">
											成功
										</option>
										<option value="3">
											处理失败
										</option>
										<option value="4">
											未付款
										</option>
										<option value="5">
											撤销
										</option>
									</select>
								    </td>
							  </tr>
							  <tr class="sType">  
							  	<td class="wz">是否显示：</td>
							       <td class="time" colspan="3">
									<ul>
									<li><a href="javascript:void(0)" name="1" onclick="showTd('pj')" >显示批价</a></li>
									<li><a href="javascript:void(0)" name="2" onclick="showTd('lr')"  >显示利润</a></li>
									<li><a href="javascript:void(0)" name="3"  onclick="showTd('cl')" >显示处理时间</a></li>
									</ul>
							     </td>
						 	 </tr>
							  <tr>
							    <td colspan="8" align="center">
							    <input name="button" type="button" class="an_input2"  onclick="queryPage(1)" id="button" value="查询" />
							  	<input name="button" type="button" class="an_input2"  onclick="$('#queryForm')[0].reset();dataPicker.initPicker();" id="button" value="重置" />
							    </td>
							  </tr>
						</table>
						
						 <div style="float: right;border: 1px solid #EECBAD;width: 200;height: 25px;font-size: 20px;">
				<lable>总利润：</lable><span id="totalProfit"></span>
			</div>
		               <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="248" class="wz">订单编号</td>
	                    <td width="231" class="wz">商品名称</td>
	                    <td width="153" class="wz">充值账号</td>
	                    <td width="116" class="wz">数量</td>
	                    <td width="116" class="wz">面值（元）</td>
                		<td width="60" class="wz pj" style="display: none;">批价(元)</td>
	                    <td width="116" class="wz">售价(元)</td>
                    	<td width="116" class="wz lr" style="display: none;">利润(元)</td>
	                    <td width="206" class="wz">订单时间</td>
	                    <td width="200" class="wz cl" style="display: none;">处理时间</td>
	                    <td width="116" class="wz">订单状态</td>
	                    <td width="116" class="wz">返利状态</td>
	                  </tr>
	                	<tbody id="databuyTable" style="text-align: center">
					   </tbody>
	                </table>
		          		<div id="pages">
									<div id="Pagination" class="pagination"></div>
						</div>
						
							<div class="tabletoolbar" id="downlist" style="display: none" > 
								<input type="hidden" name="showbatch" id="showbatch" />
								<input type="hidden" name="showProfit" id="showProfit"/>
								<input type="hidden" name="showRecord" id="showRecord"/>
								<input type="hidden" name="showDealTime" id="showDealTime"/>
								<input type="hidden" name="startTimeTemp" id="startTimeTemp"/>
								<input type="hidden" name="timeTemp" id="timeTemp"/>
								<input type="hidden" name="endTimeTemp"/>
								<input type="hidden" name="goodsTypeTemp"/>
								<input type="hidden" name="orderStatusTemp" id="orderStatusTemp"/>
								<input type="hidden" name="integrationStatusTemp" id="integrationStatusTemp"/>
								<input type="hidden" name="categoryIdTemp"/>
								<input type="hidden" name="hasOrNoSearch" id="hasOrNoSearch" value=""/>
									<input type="submit"  style="padding-top: 5px;border: 0;"  class="an_input2" value="导出列表" >
							    <input type="button"   class="an_input2" value="打印当前页" onClick="doPrint()">
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
