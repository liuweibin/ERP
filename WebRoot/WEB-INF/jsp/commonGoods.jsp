<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String picturePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() +"/vgms/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'commonGoods.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">
<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">
<link rel="stylesheet" type="text/css"			href="${ctx}/js/PreviewPicture/previewPicture.css">

<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/common/button.css" 	media="screen">
<style type="text/css">
body{margin:0;list-type:none;}
#tablelist tr td{height: 100px;border: 0px solid #d6d6d6;border-bottom: 1px solid #d6d6d6;text-align: center;}
#tablelist tr{margin-top: 2px;}
#tablelist{border: 0px solid red;}
#tablelist tr th {border-right-width: 0px;}
.desc {line-height: 1.5px;font-family: Tahoma, Helvetica, Arial, "宋体", sans-serif;float: left;color: #404040;width: 180px;
display: inline;font-size: inherit;font-style: normal;height: 35px;
}
.img_box{float: left;width: auto; }
.img_box img{width: auto;height: auto;float: left;}
.suggest{width: 100px;}
.buy_button{width: 100%;height: 25px;}
.suggest{width:70%;float: left; }
.su_button{width: 30%;float: right;}
</style>
<style type="text/css">
div#PreviewBox{
  position:absolute;
  padding-left:6px;
  display: none;
  Z-INDEX:2006;
}
div#PreviewBox span{
  width:7px;
  height:13px;
  position:absolute;
  left:0px;
  top:9px;
  background:url() 0 0 no-repeat;
}
div#PreviewBox div.Picture{
  float:left;
  border:1px #666 solid;
  background:#FFF;
}
div#PreviewBox div.Picture div{
  border:4px #e8e8e8 solid;
}
div#PreviewBox div.Picture div a img{
  margin:19px;
  border:1px #b6b6b6 solid;
  display: block;
  max-height: 250px;
  max-width: 250px;
}
</style>

<script type="text/javascript" language="javascript"			src="${ctx}/js/common/jquery-1.8.0.min.js"></script>
<script type="text/javascript" language="javascript"			src="${ctx}/js/jquery.tableui.js"></script>
<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.pagination.js"></script>
<script type="text/javascript" language="JavaScript"			src="${ctx}/js/PreviewPicture/previewPicture.js"></script>
		<script type="text/javascript">
var pageno = 1;
var pagesize = 10;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	getCommonGoods(pageno_id);
	return false;
}

$(document).ready(function() {
	parent.resetTime();    
	   getCommonGoods("");
});

function getCommonGoods(pageno_){
	if(pageno_!=""){
		pageno = pageno_;
	}
	var tbody = '';
	$.ajax({
		type:'post',
		dataType:'json',
		url:'goodsManager/getCommonGoods.do',
		async:false,
		cache:false,
		data : {
			'pageno' : pageno,
			'pagesize' : pagesize
		},
		success:function(datas){
			if(datas.retcode=="1"){
				$("#supplierdataTable").html('<tr><td colspan="5" class="red">查询出错，请刷新后重试！</td></tr>');
			}else{	
				var page = datas.data;
				var pageNo = page.pageNo;
				var total = page.totalCount;
				var pageno = page.currentPageNo;
				var pagesize = page.pageSize;
				var data = page.result;
				$("#supplierdataTable").empty();
				$.each(data,function(i, attr) {
					tbody += "<tr>";
					tbody += "<td style='width:15%' ><div  class='img_box'><a href='javascript:void(0)'  onmouseover='showPreview(event);' onmouseout='hidePreview(event);'>"+
					"<img alt='"+attr.remark+"' pic-link='/' height='100px'  large-src=${picture_path}"+attr.goodsPicture+"    border='0' width='100'  src=${picture_path}"+attr.goodsPicture+">"+
					"</a></div></td>";
					tbody += "<td style='width:35%'>  <a href='javascript:void(0)'    title='"+  attr.goodsName+ "'>"+  attr.goodsName+ "</a></td>";
					if (attr.isSell == 1) {
						if(attr.quantity!="不限"){
							tbody += "<td>  <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div>  <div class='su_button'> <input type='button'  value='销售' onclick='buy_real_fun("+attr.stockId+")' class='buy_button Partblue'>   	</div></td>";
						}else{
							if(attr.goodsCategorySmallId=="1"){//游戏
								tbody += "<td>  <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div>  <div class='su_button'> <input type='button'  value='销售' onclick=buy_game_fun(&apos;"+attr.goodsCode+"&apos;)  class='buy_button Partblue'>   	</div></td>";
							}else if(attr.goodsCategorySmallId=="2"){//话费
								tbody += "<td>  <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div>  <div class='su_button'> <input type='button'  value='销售' onclick=buy_vir_fun(&apos;"+attr.goodsCode+"&apos;) class='buy_button Partblue'>   	</div></td>";
							}
					   }
					}else{
							tbody += "<td> <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div> <div  class='su_button'> <input type='button'  value='销售'  disabled='disabled' class='buy_button Partblue'> </div></td>";
					}
					tbody += "<td  class='batch'>"+ attr.goodsBatchPrice+ "</td>";
					tbody += "<td>" + attr.quantity+ "</td>";
					tbody += "</tr>";
								});
			}
			if (tbody != '') {
				$("#supplierdataTable").html(tbody);
			} else {
				$("#supplierdataTable").html('<tr ><td colspan="5">没有符合条件的记录！</td></tr>');
			}
			$("#supplierdataTable tr").hover(function() {
				$(this).addClass("over");
			}, function() {
				$(this).removeClass("over");
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
		},error:function(e){
			$("#supplierdataTable").html('<tr><td colspan="5" class="red">查询出错，请刷新后重试！</td></tr>');
		}
	});
}

function buy_vir_fun(goodsCode){ 
	location.href ="<%=basePath%>goodsSales/mobile/sjzcByGoodsCodePage.do?goodsCode="+goodsCode;
}
function buy_real_fun(stockId){ 
	location.href = "<%=basePath%>goodsSales/realitySales.do?stockId="+stockId;
}
function buy_game_fun(goodsCode){ 
	location.href = "<%=basePath%>goodsSales/games/gameInfo.do?goodsCode="+goodsCode;
}

function load(){ 
	　　parent.document.getElementById("main").style.height = "950px"; 
     　} 
</script>
		<style type="text/css">
.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
	text-align: center;
}
</style>
	</head>
	<body onload="load()">
<div id="PreviewBox" onmouseout="hidePreview(event);">
  <div class="Picture" onmouseout="hidePreview(event);">
   <span></span>
   <div>
    <a id="previewUrl" href="javascript:void(0)" target="_blank"><img oncontextmenu="return(false)" id="PreviewImage" src="about:blank" border="0" onmouseout="hidePreview(event);" /></a>
   </div>
  </div>
</div>
<script language="javascript" type="text/javascript">
var previewBox = document.getElementById('PreviewBox');
var previewImage = document.getElementById('PreviewImage');
var previewUrl = document.getElementById('previewUrl');
var previewFrom = null;
var previewTimeoutId = null;
var loadingImg = '<%=basePath%>images/pictures/loading.gif';
</script>
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab" style="width: 100%">
						<div class="tabContainer" style="width: 100%;">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="${ctx}/goodsManager/commonGoodsPage.do" title="供货管理" rel="1">常用商品</a>
								</li>

							</ul>
						</div>
						<div id="tabCot" >

							<div style="" id="autoTime">
								<div class="block">
										<table class="tablelist pusht" id="tablelist">
										<thead>
											<tr>
												<th colspan="2">
													商品
												</th>
												<th>
													建议零售价(元)
												</th>
												<th>
													批价(元)
												</th>
												<th>
													数量
												</th>
											</tr>
											</thead>
											<tbody id="supplierdataTable" style="text-align: center;" >
											
											
											</tbody>
										</table>
								</div>
							</div>
							
							<div id="pages">
								<div id="Pagination" class="pagination"></div>
							</div>

						</div>

						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>
					</div>

				</div>

			</div>
		</div>
	</body>
</html>