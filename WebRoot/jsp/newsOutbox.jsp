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
function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1;
	processData(pageno_id);
	return false;
}
$(function(){
	init();
	processData(1);
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


function ecode(value){
	return encodeURI(encodeURI(value));
}

function processData(pageno) { 
	queryString = "&starttime=" +  $("#starttime").val() + "&endtime="
			+ $("#endtime").val() +  "&pageno=" + pageno + "&pagesize=" + $("#pagesize").val();
	$.ajax( {
				type : "POST",
				url : "<%=basePath%>informationManage.do?type=sendMessagedate",
				cache : false,
				timeout : 15000,
				data : queryString,
				dataType : 'json',
				error : function(request) {
					alert("Connection error");
				},
				success : function(data) {
					var total=0;
					var pageno=0;
					var pagesize;
					$("#selectsendfactor").css("display", "none");
					var tab = '';
					for ( var i = 0; i < data.length; i++) {
						total=data[i].totalCount;
						pagesize=data[i].pageSize;
						pageno=data[i].pageNo;
						var id= data[i].id;
						tab += '<tr>';
						tab += '<td>' + data[i].agentsCode + '</td>';
						tab += '<td>' + data[i].title + '</td>';
						tab += '<td>' + data[i].content + '</td>';
						//tab += '<td>' + data[i].status + '</td>';
						tab += '<td>' + data[i].sendTime + '</td>';
						tab += '<td><a href="javascript:void(0)" onclick="del('+id+');"><span style="color: #ff4500;">删除</span></a></td>';
						tab += '</tr>';
					}
					if (tab != '') {
						$("#senddataTable").html(tab);

					} else {
						$("#senddataTable").html(
								'<tr><td colspan="11">没有符合条件的记录！</td></tr>');
					}
					$("#senddataTable tr").hover(function() {
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
function reset_(){
	$("#queryForm")[0].reset();
	init();
} 

function del(id) {
	var bo = false;
	if(confirm('是否确认删除?')){
		bo = true;
	}
	if(bo){ 
			$.ajax({
				type : "POST",
				url : "<%=basePath%>informationManage.do?type=deleteMesage",
				cache : false,
				timeout : 15000,
				data : {'messageid':id},
				dataType : 'json',
				error : function(request) {
					alert("Connection error");
				},
				success : function(data) {
					if(data.retcode==0){
						alert(data.message);
					}else if(data.retcode==1){
						alert(data.message);
					}
					processData(1);
				}
			});
		}
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
          <div class="nyTit">我的消息</div>
          <div class="gamenamebox">
              <jsp:include page="newsTitle.jsp" >
			 		 <jsp:param name="num" value="1" /> 
				</jsp:include>
            <div class="gamename">
	               <div class="spcxtj" id="con_subpcx_2">
	               <form id="queryForm">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz">时间：</td>
					   		<td id="queryDate" colspan="2"></td>
						  </tr>
						  <tr>
						    <td width="100%"  colspan="3" >
						    <strong>每页显示数量：</strong>
							<span> <select name="pagesize"  class="input6" id="pagesize">
									<option value="10"  >
										10
									</option>
									<option value="15" selected="selected">
										15
									</option>
									<option value="20">
										20
									</option>
									<option value="25">
										25
									</option>
									<option value="30">
										30
									</option>
								</select>
						   		 <input   type="button" class="an_input2" id="button" onclick="processData(1)" value="查询" />
						    	<input   type="button" class="an_input2" id="button" onclick="reset_()" value="重置" />
						    </td>
						    </tr>
						</table></form>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                   <tr>
	                    <td width="248" class="wz">接收代理商</td>
	                    <td width="180" class="wz">消息标题</td>
	                    <td width="133" class="wz">状态</td>
	                    <td width="216" class="wz">发送时间</td>
	                    <td width="116" class="wz">操作</td>
	                  </tr>
	                 <tbody id="senddataTable" align="center"></tbody>
	                </table>
	                <div id="pages">
	<div id="Pagination" class="pagination"></div>
	</div>
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
