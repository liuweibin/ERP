<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
.announcement   tr td{height: 20px;border-bottom:1px dotted #d1d1d1; width: 80%}
.announcement   tr td a:HOVER{color: red;}
.announcement   tr td:nth-child(2){height: 20px;border-bottom:1px dotted red;float: right;width: 20%; }

</style>
<script type="text/javascript">
var pageno = 1;     
var pagesize = 20;    
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	getPriceAdjust(pageno_id);
	return false;
}
$(function(){
	getPriceAdjust(1);
})
function getPriceAdjust(pageno){
	$.ajax({
	       type: "post",
	       dataType: "json",
	       url: '<%=basePath%>announcementTbl/getPriceAdjust.do?tenOrAll=all',
   		   data:{'pageno':pageno,"pagesize":pagesize},
	       timeout:30000,
	       error: function (xmlHttpRequest, error) {
	                       $("#table").html('<div class="red">查询出错，请刷新后重试！</div>');
	                 },
		   success:function(json) {	    			
	    	  if(json.result=='ok'){
	    	  var down = "<%=basePath%>images/icon_saleDown.jpg";
	    	  var up = "<%=basePath%>images/icon_saleUp.jpg";
	    	  	var ullist = "";
	    	  	var data = json.data;
	    	  	var pageNo = data.pageNo;
				var total = data.totalCount;
				var pageno = data.currentPageNo;
				var pagesize = data.pageSize;
				$.each(data.result,function(index,priceinfo){
	    	  	    ullist += "<tr>";
					ullist += "<td><cite>";
					ullist += priceinfo.createTime;
					ullist += "</cite>";
					ullist += priceinfo.upOrDown=="down"? "<image src="+down+"></image>"  : "<image src="+up+"></image>";
					ullist += priceinfo.content;
					ullist +="<s>"+priceinfo.oldPrice+"</s>";
					ullist +='/<Strong style="color: red">'+priceinfo.newPrice+'</Strong>';
					ullist += "</td>";
					ullist += "</tr>";
				});
				if (ullist != '') {
					$("#table").html(ullist);
				}else{
					ullist = '暂时没有t调价公告';
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
	        }//end success
	     });//end ajax	
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
          <div class="nyTit">商品调价通知列表</div>
          <div class="gamenamebox">
            
            <div class="gamename">
	               <div class="announcement" >
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx" id="table">
						 <tr><td>暂时没有调价通知</td></tr>
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
