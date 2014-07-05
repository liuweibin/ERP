<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String tabNum= request.getParameter("num");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
.time ul li{float: left; list-style-type: none;margin: 0 15px;}
.select  {background-color: #C8E2B1;}
#queryDate label{display: none;}
</style>
<script type="text/javascript">
var pageno = 1;     
var pagesize = 10; 
 function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1
	 changeCreditsQuery(pageno_id);
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
}
 function changeData() {
	var jsonData = {
		agentsCode :  "${agentsCode}",
		registerUsername :  $.trim($("#acceptAgentAccount").val()),
		type : "2",
		status : "1",
		startTime : $.trim($("#stime").val()),
		endTime : $.trim($("#etime").val())
	};
	return replace(JSON.stringify(jsonData));
}
function replace(str) {
	re = new RegExp("\"", "g");
	return str.replace(re, "'");
}
function changeCreditsQuery(pageno){
	var url_ = "<%=basePath%>accountRecord.do?type=changeCreditQuery&pageno=" + pageno+"&pagesize=" + pagesize+"&stime="+$.trim($("#stime").val())+"&etime="+$.trim($("#etime").val())+"&acceptAgentAccount="+$.trim($("#acceptAgentAccount").val())+"&json=";
								url_ += changeData();
									$.ajax( {
												cache : true,
												type : "POST",
												async : false,
												url : url_,
												dataType : 'json',
												error : function(request) {
													$("#databuyTable").html('<tr><td colspan="11" class="red">查询出错，请刷新后重试！</td></tr>');
												},
												success : function(data) {
													var total=0;
											    	var pageno=0;
											    	var pagesize;
													var tab = '';
													var number='';
													for ( var i = 0; i < data.length; i++) {
														total=data[i].totalCount;
														pagesize=data[i].pageSize;
														pageno=data[i].pageNo;
														tab += '<tr>';
														tab += '<td>' + data[i].code + '</td>';
														tab += '<td>' + data[i].serial + '</td>';
														tab += '<td>' + data[i].registerUsername + '</td>';
														tab += '<td>' + data[i].money + '</td>';
														tab += '<td>' + data[i].balance + '</td>';
														tab += "<td style='font-size: 9px;'>" + data[i].createTime + '</td>';
														tab += '<td class="content_1">' + data[i].remark + '</td>';
														tab += '</tr>';
													}
													if (tab != '') {
														$("#databuyTable").html(tab);
													} else {
														$("#databuyTable") .html( '<tr><td colspan="10">没有符合条件的记录！</td></tr>');
														 document.getElementById("changeCount").innerHTML="";
													}
													$("#databuyTable tr").hover(
																	function() {
																		$(this).addClass("tbover");
																	},
																	function() {
																		$(this).removeClass("tbover");
																	});
													//加入分页的绑定
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
												}
											});
}

function reset_(){
	$("#queryForm")[0].reset();
	init();
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
          <div class="nyTit">财务管理</div>
          <div class="gamenamebox">
              <jsp:include page="financialTitle.jsp" flush="false">
			 		 <jsp:param name="num" value="2" /> 
				</jsp:include>
            <div class="gamename">
	              <div class="spcxtj" id="con_subpcx_11">
	              <form action="" id="queryForm">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz">接受代理商帐户名：</td>
						    <td> 
						    <input name="acceptAgentAccount" type="text" class="input5" id="acceptAgentAccount" />
						    </td>
						    <td></td>
						  </tr>
			   			 <tr>  
						 	 <td class="wz">时间：</td>
					   		<td id="queryDate" colspan="2"></td>
						  </tr>
						  <tr>
						    <td colspan="8" align="center">
						    <input name="button" type="button" class="an_input2" id="button" value="查询" onclick="changeCreditsQuery(1)" />
						    <input name="button" type="button" class="an_input2" id="button" value="重置" onclick="reset_()" />
						    </td>
						    </tr>
						</table></form>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="200" class="wz">转出编号</td>
	                    <td width="131" class="wz">序列号</td>
	                    <td width="133" class="wz">接受人账户</td>
	                    <td width="136" class="wz">转出点数(元)</td>
	                    <td width="116" class="wz">代理商余额(元)</td>
	                    <td width="116" class="wz">转出时间</td>
	                    <td width="206" class="wz">备注</td>
	                  </tr>
	                
	                  	<tbody id="databuyTable" style="text-align: center">
		                  	 
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
