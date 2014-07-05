<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
.announcement   tr td{height: 20px;border-bottom:1px dotted #d1d1d1;  }
.announcement   tr td a:HOVER{color: red;}
.announcement   tr td:nth-child(2){height: 20px;border-bottom:1px dotted red;width:160px; }

</style>
<script type="text/javascript">
var pageno = 1;     
var pagesize = 20;    
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	getAllInit(pageno_id);
	return false;
}
$(function(){
	getAllInit(1);
})
function getAllInit(pageno){
	 $.ajax({
		 url:'<%=basePath%>announcementTbl/getAllInit.do',
		 type:'POST',
		 dataType:'json',
		 data:{"pageno":pageno , "pagesize": pagesize},
		 success:function(data){
			 var html = "";
			 var table = $("#table").html("");
			 if(data.retcode==0){
				 data = data.data;
					var pageNo = data.pageNo;
					var total = data.totalCount;
					var pageno = data.currentPageNo;
					var pagesize = data.pageSize;
				 $.each(data.result,function(i,attr){
						 html += "<tr><td><a  target='_blanck' href='<%=basePath%>announcementTbl/getDetail.do?id="+attr.id+"'>"+attr.title+"</a></td><td>"+attr.createTime+"</td></tr>";
				 })  
				 
				if (html != '') {
					 $("#table").html(html);
				} else {
					$("#table") .html('<tr><td colspan="2" align="center">没有公告！</td></tr>');
				}
				$("#table tr").hover(function() {
					$(this).addClass("tbover");
				}, function() {
					$(this).removeClass("tbover");
				});
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
		 },error:function(e){
			 alert(e.status);
		 }
		 
	 })
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
          <div class="nyTit">平台公告列表</div>
          <div class="gamenamebox">
            
            <div class="gamename">
	               <div class="announcement" >
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx" id="table">
					 
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
