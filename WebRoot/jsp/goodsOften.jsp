<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<script type="text/javascript">
var pageno = 1;
var pagesize = 12;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	getCommonGoods(pageno_id);
	return false;
}
$(function(){
	init();
	getCommonGoods(1);
})
function init(){
	 
	
}
 
/*查询常用商品*/
function getCommonGoods(pageno) { 
	var tbody = '';
	var bo = false;
	var id = "gamelbnrv";
	var basePath = "<%=basePath%>";
	var goodsSellPath = basePath+"jsp/sjcz.jsp?num=0&goodsCode=";
		$.ajax({
				url : basePath+'goodsManager/getCommonGoods.do',
				dataType : 'json',
				cache : false,
				//async : false,
				data : {
				pageno:pageno,
				pagesize:pagesize 
				},
				type : "post",
				success : function(datas) {
					if (datas.retcode == 0) { 
						 tbody = '';
							var page = datas.data;
							var pageNo = page.pageNo;
							var total = page.totalCount;
							var pageno = page.currentPageNo;
							var pagesize = page.pageSize;
							var data = page.result;
						$(".cplbul").empty();
						$ .each( data, function(i, attr) {
							var  goodsName = attr.goodsName;
							var smallId = attr.goodsCategorySmallId;
							if(goodsName.length>15){
								goodsName = goodsName.substring(0,15)+"...";
							}
							if(smallId=="2"){//话费
								if(attr.isFull=="0"){//0：地区
									goodsSellPath = basePath+"jsp/sjcz.jsp?num=0&goodsCode=";
								}else if(attr.isFull=="1"){
									goodsSellPath = basePath+"jsp/sjcz.jsp?num=1&goodsCode=";
								}
							}else if(smallId=="5"){//固话
								goodsSellPath = basePath+"jsp/ghcz.jsp?goodsCode=";
							}else if(smallId=="1"){//游戏
								goodsSellPath = basePath+"jsp/gameCzForm.jsp?goodsCode=";
							}
							tbody +="<li>"; 
							tbody +="<a href='#'><img alt='"+attr.goodsName+"'  src=${picture_path}"+attr.goodsPicture+"  width='75' height='127' /></a>"; 
							tbody +="<h1>"+goodsName+"</h1>"; 
							tbody +="<h2>批价：<font class='ppj'>￥"+attr.goodsBatchPrice+"</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;面值：<font class='mz'>￥"+attr.goodsParValue+"</font></h2>"; 
							tbody +="<h3>库存："+attr.quantity+"</h3>"; 
							if(attr.quantity!="不限"){
								tbody +="<h4><a href='"+goodsSellPath+attr.goodsCode+"'>立即购买</a></h4>"; 
							}else{
									tbody +="<h4><a href='"+goodsSellPath+attr.goodsCode+"'>立即购买</a></h4>"; 
						   }
							
							tbody +="</li>"; 
							 });
					} else {
						$(".cplbul").html("<li><div  style='text-align: center;' class='red'>查询出错，请刷新后重试！</div></li>");
					}
					if (tbody != '') {
						$(".cplbul").html(tbody);
					} else {
						$(".cplbul").html("<li><div  style='text-align: center;'>没有符合条件的记录！</div></li>");
					}
					$(".cplbul li").hover(function() {
						$(this).addClass("over");
					}, function() {
						$(this).removeClass("over");
					});
					$("#total").html(total);
					var current_page = pageno - 1;
						$("#Paginationv").pagination(total, {
							callback : pageselectCallback,
							prev_text : '上一页', //上一页按钮里text  
							next_text : '下一页', //下一页按钮里text  
							items_per_page : pagesize, //显示条数  
							num_display_entries : 6, //连续分页主体部分分页条目数  
							current_page : current_page, //当前页索引  
							num_edge_entries : 2
						//两侧首尾分页条目数  
						});
						$(".cplbul li").hover(function() {
							$(this).addClass("tbover");
						}, function() {
							$(this).removeClass("tbover");
						});
				},
				error : function(error) {
					$(".cplbul").html('<li colspan="5" class="red">查询出错，请刷新后重试！</li>');
				}
			});
} 
</script>
<style type="text/css">
/*.mzxs_1 a:visited  {color:red;}
.dqxs a:visited  {color: #9C9900;}*/
.select  {background-color: #C8E2B1;}
</style>
</head>

<body>
<div class="main">
<input type="hidden" id="city"/>
<input type="hidden" id="parValue"/>
  <%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
        <%@include file="./menu.jsp" %>
        <div class="nyRight">
          <div class="nyTit">常用商品</div>
        <div class="cplb">
          <div class="cpsltit">合共：<span id="total"></span>个产品</div>
          <ul class="cplbul">
            <%--<li><a href="#"><img src="<%=basePath%>images/images/img1.jpg" width="75" height="127" /></a>
              <h1>Samsung 三星 i9128V</h1>
              <h2>批价：<font class="ppj">￥9.8</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;面值：<font class="mz">￥10</font></h2>
              <h3>库存：100</h3>
              <h4><a href="#">立即购买</a></h4>
            </li>
            --%> 
          </ul>
        </div>
          <div id="pages" >
									<div id="Paginationv" class="pagination" style="margin-top: 10px;"></div>
						</div>
        </div>
        
        
        
        
        
      </div>
    </div>
    <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
