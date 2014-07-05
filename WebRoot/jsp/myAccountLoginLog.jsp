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
#queryDate label{display: none;}
</style>
<script type="text/javascript">
var pageno = 1;    
var pagesize = 10;
function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1
	loginfactor(pageno_id);
	return false;
}
$(function(){
	init();
	loginfactor(1);
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

function loginfactor(pageno){
	var url_ = "<%=basePath%>account.do?type=loginLogQuery&logstime="+$.trim($("#starttime").val())+"&logetime="+$.trim($("#endtime").val())+"&pageno=" + pageno + "&pagesize="+pagesize;
	$.ajax( {
				type : "POST",
				url : url_,
				cache : false,
				timeout : 15000,
				dataType : 'json',
				error : function(request) {
					$("#dataTable").html('<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
				},
				success : function(data) {
					var total=0;
					var pageno=0;
					var pagesize;
					var tab = '';
					for ( var i = 0; i < data.length; i++) {
						total=data[i].totalCount;
						pagesize=data[i].pageSize;
						pageno=data[i].pageNo;
						tab += '<tr>';
						tab += '<td>' + data[i].agentsUserName + '</td>';
						tab += '<td>' + data[i].logDesc + '</td>';
						tab += '<td>' + data[i].ipAddress + '</td>';
						tab += '<td>' + data[i].createTime + '</td>';
						tab += '</tr>';
					}
					if (tab != '') {
						$("#dataTable").html(tab);

					} else {
						$("#dataTable").html(
								'<tr><td colspan="11">没有符合条件的记录！</td></tr>');
					}
					$("#dataTable tr").hover(function() {
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
				}
			});
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
          <div class="nyTit">我的账户</div>
          <div class="gamenamebox">
              <jsp:include page="myAccountTitle.jsp" >
			 		 <jsp:param name="num" value="2" /> 
				</jsp:include>
            <div class="gamename">
	               <div class="spcxtj" id="con_subpcx_3">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						   <tr>
						  <td class="wz">时间：</td>
						  <td id="queryDate" colspan="2"></td>
						  </tr>
						  
						  <tr>
						    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button"  onclick="loginfactor(1)" value="查询" /></td>
						    </tr>
						</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="148" class="wz">登录者</td>
	                    <td width="231" class="wz">操作信息</td>
	                    <td width="200" class="wz">登录IP</td>
	                    <td width="116" class="wz">登录时间</td>
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
