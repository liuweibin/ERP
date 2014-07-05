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
//var pagesize = 10;    
function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1
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


function processData(pageno) {
	queryString = "&starttime=" +  $("#starttime").val() + "&endtime="
			+   $("#endtime").val() + "&messageStatus="
			+  $("#messageStatus").val() +  "&pageno=" + pageno + "&pagesize=" + $("#pagesize").val();
	$.ajax( {
				type : "POST",
				url : "<%=basePath%>informationManage.do?type=receiveMessage",
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
					$("#selectmessagefactor").css("display", "none");
					var tab = '';
					for ( var i = 0; i < data.length; i++) {
						total=data[i].totalCount;
						pagesize=data[i].pageSize;
						pageno=data[i].pageNo;
						var id = data[i].id;
						tab += "<tr style='height: 20px;'>";
						tab += '<td>' + data[i].agentsCode + '</td>';
						tab += '<td>' + data[i].title + '</td>';
						//tab += '<td>' + data[i].content + '</td>';
						if(data[i].status==0)
							tab += '<td>未读</td>';
						else if(data[i].status==1){
							tab += '<td>已读</td>';
						}
						tab += '<td>' + data[i].sendTime + '</td>';
						tab += '<td><a <a href="javascript:void(0)" onclick="querymessage('+id+');"><span style="color: #ff4500;">消息详情</span></a><a href="javascript:void(0)" onclick="return del('+id+');"><span style="color: #ff4500;">  删除</span></a></td>';
						tab += '</tr>';
					}
					if (tab != '') {
						$("#messagedataTable").html(tab);

					} else {
						$("#messagedataTable").html(
								'<tr><td colspan="5">没有符合条件的记录！</td></tr>');
					}
					$("#messagedataTable tr").hover(function() {
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

function querymessage(messageid) {
	var url = "<%=basePath%>informationManage.do?type=receiveMessageQuery&messageid="+messageid;
	var title = "查看消息";
	var width = 450;
	var height = 250;
	parent.LightBox(url, title, width, height);
	 setTimeout(function a(){notReadMessage();},1000);  
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
				async:false,
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
			 		 <jsp:param name="num" value="0" /> 
				</jsp:include>
            <div class="gamename">
	               <div class="spcxtj" id="con_subpcx_1">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						   <tr>
						    <td class="wz">消息状态:：</td>
						    <td> 
						    <select id="messageStatus" class="input6">
										<option value=""> 	——全部—— </option>
										<option value="0"> 未读 </option>
										<option value="1"> 已读 </option>
							</select>
						    </td>
						    <td class="wz">&nbsp;</td>
						  </tr>
						  <tr>
						    <td class="wz">时间：</td>
					   		<td id="queryDate" colspan="2"></td>
						  </tr>
						  <tr>
						    <td colspan="2" width="70%" align="center">
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
						    </td>
						    <td width="30%"></td>
						    </tr>
						</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="248" class="wz">发送代理商</td>
	                    <td width="231" class="wz">消息标题</td>
	                    <td width="133" class="wz">状态</td>
	                    <td width="216" class="wz">发送时间</td>
	                    <td width="116" class="wz">操作</td>
	                  </tr>
	                 <tbody id="messagedataTable" align="center">
						 
					 </tbody>
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
