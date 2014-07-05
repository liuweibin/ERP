<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="/commons/taglibs.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String queryTime =request.getParameter("queryTime");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>交易记录查询</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=basePath%>themes/common/titletab.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/esales.style.css">
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/common/style.css" 	media="screen">
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/common/button.css" 	media="screen">
<style type="text/css">
.ellipsis{
      white-space: nowrap;
      overflow: hidden;             
      -o-text-overflow: ellipsis;    /* Opera */
      text-overflow:    ellipsis;    /* IE, Safari (WebKit) */
}
ol, ul {list-style: none;}
.discontrol,.discontrol li {float: left;}
.discontrol li input {margin-top: -2px;margin-right: 2px;vertical-align: middle;}
.discontrol li label {cursor: pointer;margin-right: 10px;}
table tr td{font-family: Tahoma,Helvetica,Arial,Simsun,sans-serif;font-size: 12px;height: 29px;}
#linkTable tr th {font-size: 12px;padding: 0 5px 0 15px;width: 50px;}
.input
{
    /*background-color:expression(this.type=="text"?'#FFC':'');*/
   height: 25px;
    line-height: 25px;
    font-size: 16px;
    font-weight: 700;
    border-left:0px;border-top:0px;border-right:0px;border-bottom:2px solid black;
}

    
</style>
<script type="text/javascript" src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
<script type="text/javascript" language="JavaScript" src="<%=basePath%>js/jquery.pagination.js"></script>
<!-- Load data to paginate -->
<script src="<%=basePath%>js/My97DatePicker/WdatePicker.js"	type="text/javascript"></script>
<script src="<%=basePath%>js/My97DatePicker/namespace.js"	type="text/javascript"></script>
<script src="<%=basePath%>js/My97DatePicker/datePicker_AutoSetDay.js"	type="text/javascript"></script>
	<script type="text/javascript">
	var temp = 0;
	var pageno = 1; 
	var pagesize = 10; 
  function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1;
	queryPage(pageno_id,"linkTable");
	return false;
  }
	$().ready(function(){
		parent.resetTime(); 
		var queryTime = $("#queryTime").val();
		if(queryTime!=""&&queryTime!="all"){
			queryPage(1,3,"linkTable");
		}
	});
	 function customerPoints(orderCode) {
		var url = "customUser.do?type=customerReturnPoint&orderCode="+orderCode;
		var title = "选择要返积分的客户";
		var width = 950;
		var height = 450;
		parent.LightBox(url, title, width, height);
	}
	
function queryPage(pageno,divclass){
	parent.resetTime(); 
	var tbody = "";
	pagesize = 10;
	var gameno = $("#gameno").val();
	var orderNo = $("#orderNo").val();
	$.ajax({
		url:'tradingRecord/getTradeRecord.do',
		dataType:'json',
		type:'post',
		data:{'orderStatus':$('#orderStatus').val(),'integrationStatus':$('#integrationStatus').val()
			,'categoryLargeId':$("#cardtype").find("option:selected").val()
			,'startTime':$("#d4321").val(),'endTime':$("#d4322").val(),'orderNo':orderNo,'gameno':gameno,
			'pageno':pageno,'pagesize':pagesize},
		success:function(datas){
		$("#"+divclass+" tbody").empty();
		$("#linkTable_hide tbody").empty();
		//查询之后保留查询参数 保证导出数据和查询列表数据一致
		$('#orderStatusTemp').val($('#orderStatus').val());
		$('#integrationStatusTemp').val($('#integrationStatus').val());
		$('#categoryIdTemp').val($("#cardtype").find("option:selected").val());
		$('#timeTemp').val($('#time').val());
		$('#startTimeTemp').val($('#d4321').val());
		$('#endTimeTemp').val($('#d4322').val());
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
						     tbody+='<td align="center"    ><div style="width:100px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;">'+dlist.goodsName+'</div></td>';
						     tbody+='<td align="center">'+dlist.rechargeAccount+'</td> ';
						     tbody+='<td align="center"> '+dlist.rechargeNumber+' </td> '; 
						     tbody+='<td align="center">'+dlist.inPrice/100.0+'</td> ';
						     tbody+='<td class="content_2" style="display: '+ ($("#checkbox22").attr("checked")=="checked"?'':'none') +';">'+dlist.batchPrice/100.0+'</td> '; 
						     tbody+='<td align="center">'+dlist.sellPrice/100.0+'</td> ';
						     tbody+='<td class="content_3" style="display: '+ ($("#checkbox33").attr("checked")=="checked"?'':'none') +';" align="center">'+dlist.profit/100.0+'</td> ';
						     tbody+='<td class="content_4" style="display: '+ ($("#checkbox44").attr("checked")=="checked"?'':'none') +';" align="center">'+dlist.sellPrice/1000.0*dlist.rechargeNumber+'</td> ';
						     tbody+='<td align="center" style="font-size:10px;">'+dlist.createTime+'</td> ';
						     tbody+='<td class="content_5" style="display: '+ ($("#checkbox55").attr("checked")=="checked"?'':'none') +';" align="center"><div>'+dlist.handleTime+'</div></td> ';
						     tbody+=' <td align="center"><span >'+dlist.orderStatusString+'</span></td>';
						     tbody+=' <td align="center"><span  >'+dlist.profitStatusString+'</span></td>';
						     /*   tbody+=' <td align="center"><span >'+dlist.integrationStatusString+'</span></td>';
					        tbody+=' <td align="center">';
							     if(dlist.orderStatus!='2'&&dlist.integrationStatus=='0'){
							    	 tbody+='<span class="gray">返积分</span>';
							    	 //tbody+="<span style='color: #ff4500;'><a title=\'点击查看详单\' href='${ctx}/tradingRecord/gameInfoDesc.do?orderCode="+dlist.orderCode+"'>详单</a></span>";
							     }else if(dlist.integrationStatus=='1'){
							     	tbody+='<span class="gray">已设积分</span>';
							     }else if(dlist.orderStatus=='2'&&dlist.integrationStatus=='0'){
							      	tbody+='<a href="javascript:void(0)" onclick="javascript:customerPoints('+"'"+dlist.orderCode+"'"+');"><span style="color: #ff4500;">返积分</span></a><br><span style="color: #ff4500;">';
							     }
					      tbody+='</td>';*/
						tbody += "</tr>";
				});
			}else if(datas.retcode==1){
				alert(datas.message);
			}
			if (tbody != '') {
					   	$("#linkTable_hide tbody").html(tbody);
						$("#"+divclass+" tbody").html(tbody);
			} else {
				$("#"+divclass+" tbody").html('<tr><td colspan="14" align="center">没有符合条件的记录！</td></tr>');
				$("#linkTable_hide tbody").html('<tr><td colspan="14" align="center">没有符合条件的记录！</td></tr>');
			}
			$(".tablelist tr").hover(function() {
				$(this).addClass("over");
			}, function() {
				$(this).removeClass("over");
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

			parent.document.getElementById("mmain").style.height=  "1500px";
			parent.document.getElementById("main").style.height=  "1500px";
		},
		error:function(error){alert(error.status);}
	});
	
}

function showList(id){
	$(".title_"+id).toggle();
	$(".content_"+id).toggle();
}
function check(){
if($("#checkbox22").attr("checked")=="checked"){
		$('#showbatch').val('1');
		}
		if($("#checkbox33").attr("checked")=="checked"){
		$('#showProfit').val('1');
		}
		if($("#checkbox44").attr("checked")=="checked"){
		$('#showRecord').val('1');
		}
		if($("#checkbox55").attr("checked")=="checked"){
		$('#showDealTime').val('1');
		}
		return true;
}

function reset_(){
	$('#queryForm')[0].reset();
	displayToggle($(".title_2"));
	displayToggle($(".title_3"));
	displayToggle($(".title_4"));
	displayToggle($(".title_5"));
	displayToggle($(".content_2"));
	displayToggle($(".content_3"));
	displayToggle($(".content_4"));
	displayToggle($(".content_5"));
	
}
function displayToggle(obj){
	$.each(obj,function(i,attr){
		if(attr.style.display=='block'||attr.style.display==''){
				attr.style.display='none';	
		}
	});
};
function more(){
	$("#order").toggle();
	$("#hide").toggle();
	$("#more").toggle();
}
</script>
<style type="text/css">
body{
margin: 10px 20	px;
}
.checkLab{
	background:#dc143c;
	color:#fff;
	padding-top:3px;
	padding-bottom:3px;
	height:25px;
	line-heigth:25px;
	border:1px solid #f0e68c;
	
}
.blockcommon{
padding: 10px
}
.queryForm li{
padding: 5px 0;
vertical-align: middle;
}
#form tr td{
width: 280
}
.queryform{font-size: 15px;}
table {border-collapse: collapse;border-spacing: 0;}
</style>
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
  </head>
   
   <body >
   	<div id="wrapper" style="width: auto">

		<div id="container">
			<div class="block">

				<div id="wrap" style="width: 100%">
					<div id="body" style="width: 100%">
						<div id="main" style="overflow: hidden; width: 100%;">
   
	<div id="tabCot_product" class="tabCot" style="display: block;" >
		<div class="tabContainer" style="width: 100%">
										<ul class="tabHead" id="tabCot_product-li-currentBtn-">
											<li class="currentBtn">
											<a href="${ctx}/tradingRecord.do?queryTime=all"	title="商品进价查询" rel="1">交易记录查询</a></li>
										</ul>
		</div>
	 <div class="blockcommon" style="height: 130px;border-top: 0">
		<form action="tradingRecord/exportOrder.do" method="post" id="queryForm" onsubmit="return check()" >
				<input type="hidden" id="queryTime" value="${queryTime}">
				<ul class="queryform" >
				<li>
				<label>订单编号：</label><input class="input" maxlength="20" id="orderNo">
				<label>充值账号：</label><input class="input" maxlength="20" id="gameno">
				<span id="more" style="float: right;font-weight : 700;" onclick="more()">更多</span>
				<span id="hide" style="float: right;font-weight : 700;display: none;" onclick="more()" >隐藏</span>
				</li>
					<li id="queryTime" ><label >订单时间：</label>
	                   <input type="text" class="Wdate startTime" value="${startTime}" name="startTime" id="d4321" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-01',maxDate:'#F{$dp.$D(\'d4322\',{d:-1});}'})"/>
	                    <span>至</span>
	      			 <input type="text" class="Wdate endTime" name="endTime" value="${endTime}" id="d4322" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%ld',minDate:'#F{$dp.$D(\'d4321\',{d:1});}'})"/>
						<strong>(注:不能进行跨月查询) </strong>
						
						
                    </li>

					<li id="order" style="display: none;">
						<label>
							订单状态：
						</label>
						<select name="orderStatus" id="orderStatus">
							<option value="" selected="selected">
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
						<div style="display: none;">
							<label >
								积分状态：
							</label>
							<select name="integrationStatus" id="integrationStatus">
								<option value="">
									---全部---
								</option>
								<option value="0">
									未设积分
								</option>
								<option value="1">
								已设积分
								</option>
							</select>
						</div>
						<label>
							商品类型：
						</label>
						<select name="cardtype" id="cardtype">
							<option selected="selected" value="">
								---全部---
							</option>
							<option value="1">
								游戏充值类
							</option>
							<option value="2">
								话费充值类
							</option>
						</select>
					</li>
				</ul>
				<ul class="form_ul" style="display: block;">
					<li style="text-align: center;height: 28px;">
						<input type="button" class="Partorange" onclick="queryPage(1,'linkTable')" value="查询"/>
						<input type="button" class="Partgreen" onclick="reset_();" value="重置"/>
					</li>
				</ul>
		
</div>
<div class="blockcommon pusht" style="border: 1px solid #d6d6d6;vertical-align: middle;padding-top: 10px;margin-top: 10px;font-size: 14px;height: 25px;">
			<ul class="discontrol">
				<li class="bold">
					是否显示：
				</li>
				<li>
					<input type="checkbox" id="checkbox22" name="checkbox22" class="showColumn" 
						onClick="showList(2)">
					<label for="checkbox22">
						显示批价
					</label>
				</li>
				<li>
					<input type="checkbox" id="checkbox33" name="checkbox33" class="showColumn" 
						onClick="showList(3)">
					<label for="checkbox33">
						显示利润
					</label>
				</li>
				<li style="display: none">
					<input type="checkbox" id="checkbox44" name="checkbox44" class="showColumn"
						onClick="showList(4)">
					<label for="checkbox44">
						显示积分
					</label>
				</li>
				<li>
					<input type="checkbox" id="checkbox55" name="checkbox55" class="showColumn"
						onClick="showList(5)">
					<label for="checkbox55">
						显示处理时间
					</label>
				</li>
			</ul>
			<div style="float: right;border: 1px solid #EECBAD;width: 200;height: 25px;font-size: 20px;">
				<lable>总利润：</lable><span id="totalProfit"></span>
			</div>
		</div>
	<div id="container">
	 <div id='page1'  style='width:100%;height:auto;'>
  <div class="block" > 
	 <table class="tablelist pusht" id="linkTable" style="margin-top: 10px;width: 100%;float: left;">
		<thead>
				<tr class="" style="height: 20px;">
					<th width="150">订单号</th>
					<th>商品名</th>
					<th class="title_1">充值帐号</th>
					<th width="20">数量</th>
					<th>面值(元)</th>
					<th width="60" class="title_2" style="display: none;">批价(元)</th>
					<th>售价(元)</th>
					<th class="title_3" style="display: none;">利润(元)</th>
					<th class="title_4" style="display: none;">积分</th>
					<th width="100px">订单时间</th>
					<th class="title_5" style="display: none;">处理时间</th>
					<th>订单状态</th>
					<th>返利状态</th>
					<th style="display: none;">积分状态</th>
					<th style="display: none;">操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>  
	</div>
	<div id="pages" style="float: right;font-size: 12px;">
			<div id="Pagination" class="pagination"></div>
	</div>
		<div class="tabletoolbar" id="downlist" > 
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
				<input type="submit"  class="Partorange" style="padding-top: 5px;border: 0;"  value="导出列表" >
		    <input type="button" class="Partgreen" value="打印当前页" onClick="doPrint()">
		</div>
	
	</div>
</form>
</div>
</div>
</div>
</div>
</div>
</div>
</div>


</body>
</html>
