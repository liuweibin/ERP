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
	queryAllGoods(pageno_id);
	return false;
}
$(function(){
	init();
	queryAllGoods(1);
})
function init(){
	area();
	$(".mzxs_1 ul li a").click(function (e) {
		var className	= $(this)[0].className;
			if(className=="select"){
				$(this).removeAttr("class");
			}else{
				 $(this).addClass("select").parent().siblings().find("a").removeAttr("class");
			}
    });
	$(".dqxsbox ul li a").click(function (e) {
		var className	= $(this)[0].className;
		if(className=="select"){
			 $(this).removeAttr("class");
		}else{
			 $(this).addClass("select").parent().parent().parent().siblings().find("a").removeAttr("class");
			 $(this).addClass("select").parent().siblings().find("a").removeAttr("class");
		}
    });
	
	
}
/*查询所有商品*/
function queryAllGoods(pageno) { 
	var tbody = '';
	var bo = false;
	var id = "gamelbnrv";
	var basePath = "<%=basePath%>";
	var goodsSellPath = basePath+"jsp/sjcz.jsp?num=0&goodsCode=";
		$.ajax({
				url : basePath+'goodsSales/getAgentsGoodsList.do',
				dataType : 'json',
				cache : false,
				//async : false,
				data : {
				categoryLargeId: 2,
				categorySmallId: 2,
				goodsType: '0',
				pageno:pageno,
				pagesize:pagesize,
				//goodsCode:$("#goodsCodev").val(),
				city:$("#city").val(),
				//province:$("#province").find("option:selected").val(),
				parValue:$("#parValue").val()
				//goodsName:$("#goodsNamev").val()
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
							if(goodsName.length>15){
								goodsName = goodsName.substring(0,15)+"...";
							}
							if(attr.categorySmallTblId=="2"){//话费
								if(attr.isFull=="0"){
									goodsSellPath = basePath+"jsp/sjcz.jsp?num=0&goodsCode=";
								}else if(attr.isFull=="1"){
									goodsSellPath = basePath+"jsp/sjcz.jsp?num=1&goodsCode=";
								}
							}else if(attr.categorySmallTblId=="5"){//固话
								goodsSellPath = basePath+"jsp/ghcz.jsp?goodsCode=";
							}
							tbody +="<li>"; 
							tbody +="<a href='#'><img alt='"+attr.goodsName+"'  src=${picture_path}"+attr.goodsPicture+"  width='75' height='127' /></a>"; 
							tbody +="<h1>"+goodsName+"</h1>"; 
							tbody +="<h2>批价：<font class='ppj'>￥"+attr.goodsBatchPrice+"</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;面值：<font class='mz'>￥"+attr.goodsParValue+"</font></h2>"; 
							tbody +="<h3>库存："+attr.quantity+"</h3>"; 
							tbody +="<h4><a href='"+goodsSellPath+attr.goodsCode+"'>立即购买</a></h4>"; 
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
function city(o){
	var value = o.name;
	var city = $("#city").val();
	if(city){
		if(value==city){
			$("#city").val("");
		}else{
			$("#city").val(value);
		}
	}else{
		$("#city").val(value);
	}
	queryAllGoods(1);
}
function parValue(o){
	var value = o.name;
	var parValue = $("#parValue").val();
	if(parValue){
		if(value==parValue){
			$("#parValue").val("");
		}else{
			$("#parValue").val(value);
		}
	}else{
		$("#parValue").val(value);
	}
	queryAllGoods(1);
}
function area(){ 
	$.ajax({
		url : '<%=basePath%>goodsSales/getAreaByParentID.do',
		type : 'post',
		dataType : 'json',
		async:false,
		data : { "pid" : 0 },
		success : function(data) {
			var html ="";
			$.each(data, function(i, attr) {
				var id = attr.id;
				var value = attr.name;
				if(value.length==3){
					value = value.substring(0,2);
				}else if(value.length>3){
					value = value.substring(0,3);
				}
				if(i==16){
					$(".dqxs_1 .czxzul").html(html);
					html = "";
				}
				html +="<li><a href='javascript:void(0)' onclick='city(this)' name='"+id+"'>"+value+"</a></li>";
				if(i==(data.length-1)){
					$(".dqxs_2 .czxzul").html(html);
				}
			});
		},
		error : function(error) {
		 alert(error.status);
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
          <div class="nyTit">产品列表</div>
          <div class="czBox">
            <div class="czxz"><span>充值方式：</span>
              <ul class="czxzul">
                <li><a href="#" class="select">直充</a></li>
              </ul>
            </div>
            <div class="czxz"><span>面值：</span>
               <div class="mzxs_1">
	              <ul class="czxzul">
	              <c:forEach items="${sys_googsprice }" var="googs">
	                <li><a href="javascript:void(0)" onclick="parValue(this);" name="${googs}">${googs}元</a></li>
	              </c:forEach>
	              </ul>
              </div>
            </div>
            <div class="czxz"><span>地区：</span>
              <div class="dqxsbox">
                <div class="dqxs_1 dqxs">
                  <ul class="czxzul"><%--
                     <li><a href="#" >全国</a></li>
                    <li><a href="#" onclick="city(this)" name="1">广东</a></li>
                    <li><a href="#" onclick="city(this)" name="2">浙江</a></li>
                    <li><a href="#">山东</a></li>
                    <li><a href="#">江苏</a></li>
                    <li><a href="#">河南</a></li>
                    <li><a href="#">四川</a></li>
                    <li><a href="#">湖北</a></li>
                    <li><a href="#">广西</a></li>
                    <li><a href="#">上海</a></li>
                    <li><a href="#">福建</a></li>
                    <li><a href="#">河北</a></li>
                    <li><a href="#">甘肃</a></li>
                    <li><a href="#">海南</a></li>
                    <li><a href="#">宁夏</a></li>
                    <li><a href="#">青海</a></li>
                   --%></ul>
                </div>
                
              <div class="showmore"><a href="#"><span>▼</span></a></div>
              
              <div class="dqxs_2 dqxs">
                <ul class="czxzul"><%--
                    <li><a href="#">全国</a></li>
                    <li><a href="#">广东</a></li>
                    <li><a href="#">浙江</a></li>
                    <li><a href="#">山东</a></li>
                    <li><a href="#">江苏</a></li>
                    <li><a href="#">河南</a></li>
                    <li><a href="#">四川</a></li>
                    <li><a href="#">湖北</a></li>
                    <li><a href="#">广西</a></li>
                    <li><a href="#">上海</a></li>
                    <li><a href="#">福建</a></li>
                    <li><a href="#">河北</a></li>
                    <li><a href="#">甘肃</a></li>
                    <li><a href="#">海南</a></li>
                    <li><a href="#">宁夏</a></li>
                    <li><a href="#">青海</a></li>
                    <li><a href="#">广东</a></li>
                    <li><a href="#">浙江</a></li>
                    <li><a href="#">山东</a></li>
                    <li><a href="#">江苏</a></li>
                    <li><a href="#">河南</a></li>
                    <li><a href="#">四川</a></li>
                    <li><a href="#">湖北</a></li>
                    <li><a href="#">广西</a></li>
                    <li><a href="#">上海</a></li>
                    <li><a href="#">福建</a></li>
                    <li><a href="#">河北</a></li>
                    <li><a href="#">甘肃</a></li>
                    <li><a href="#">海南</a></li>
                    <li><a href="#">宁夏</a></li>
                    <li><a href="#">青海</a></li>
                   --%></ul>
              </div>
              <div class="cler"></div>
            </div>
            <script>
$(".showmore a span").click(function(e){
  $(this).html(["▼", "▲"][this.hutia^=1]);
  $(this.parentNode.parentNode).next().toggle();
  e.preventDefault();
});
</script>
          </div>
        </div>
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
