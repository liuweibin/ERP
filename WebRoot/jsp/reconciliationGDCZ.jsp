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
	 correctOrderfactorquery(pageno_id);
	return false;
 }
$(function(){
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
	init();
     dataPicker.initPicker();
     correctOrderfactorquery(1);
})  
 function init(){
	$.ajax({
		url : "<%=basePath%>accountRecord.do?type=gdCzTjInit",
		type : 'post',
		dataType : 'json',
		async:false,
		success : function(data) {
			if(data.retcode==0){ 
			var 	dataMap = data.data;
				var html ="";
				$("#agents_code").empty();
				$.each(dataMap, function(i, attr) {
					var key = i;
					var value = attr;
					$("#agents_code").prepend("<option value='"+key+"'>" +value + "</option>");
				});
			}
		},
		error : function(error) {
		 alert(error.status);
		}
	});
}
function correctOrderfactorquery(pageno) {
	var url_ = "<%=basePath%>accountRecord.do?type=gdCzTjSum";
	url_ = url_+bindLargeData_();
	$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : url_,
				dataType : 'json',
				error : function(request) {
					$("#databuyTable").html('<tr><td colspan="4" class="red">查询出错，请刷新后重试！</td></tr>');
				},
				success : function(data) {
					if(data.retcode=="1"){
						$("#databuyTable").html('<tr><td colspan="4">查询出错！</td></tr>');
						return false;
					}
					var total = data.data.totalCount;
					var pageno = data.data.pageNo;
					var pagesize = data.data.pageSize;
					var tab = '';
					$.each(data.data,function (i,attr){
						tab += '<tr>';
						tab += '<td align="center">' + $("#agents_code  option:selected").text() + '</td>';
						tab += '<td align="center">' + attr.name + '</td>';
						tab += '<td align="center">' + attr.rebates_point/100 + '</td>';
						tab += '<td align="center">' + attr.par_value/100 + '</td>';
						tab += '</tr>';
					});
					if (tab != '<tr></tr>') {
						$("#databuyTable").html(tab);
					} else {
						$("#databuyTable").html('<tr><td colspan="4">没有符合条件的记录！</td></tr>');
					}
					$("#Pagination tr").hover(function() {
						$(this).addClass("tbover");
					}, function() {
						$(this).removeClass("tbover");
					});

				}
			});

}


 

function bindLargeData_() {
	var queryStr = "";
	queryStr += "&startTime="+ $.trim($("#starttime").val());
	queryStr += "&endTime="+$.trim($("#endtime").val());
	queryStr += "&agentsCode=" + $.trim($("#agents_code").val());
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
          <div class="nyTit">对账管理</div>
          <div class="gamenamebox">
              <jsp:include page="reconciliationTitle.jsp" flush="false">
			 		 <jsp:param name="num" value="0" /> 
				</jsp:include>
            <div class="gamename">
	              <div class="spcxtj" id="con_subpcx_11">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz">代理商：</td>
						    <td> 
						     <select name="agents_code" class="input6" id="agents_code" class="userid">
							    </select>
						    </td>
						    <td></td>
						  </tr>
			   			 <tr>  
						 	 <td class="wz">时间：</td>
					   		<td id="queryDate" colspan="2"></td>
						  </tr>
						  <tr>
						    <td colspan="8" align="center">
						    <input name="button" type="submit" class="an_input2" id="button" value="查询" onclick="correctOrderfactorquery(1)" />
						    </td>
						    </tr>
						</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="200" class="wz">代理商</td>
	                    <td width="131" class="wz">充值渠道</td>
	                    <td width="133" class="wz">利润总额（元）</td>
	                    <td width="136" class="wz">充值总额（元）</td>
	          
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
