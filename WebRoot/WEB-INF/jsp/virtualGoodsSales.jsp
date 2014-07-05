<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>商品查询</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=basePath%>themes/common/titletab.css" rel="stylesheet"	type="text/css" />
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/of.global.100518.css">
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/esales.style.css">
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/common/button.css" 	media="screen">
<link rel="stylesheet" type="text/css"			href="<%=basePath%>js/PreviewPicture/previewPicture.css">
<style type="text/css">
#tablelist tr td{height: 100px;border: 0px solid #d6d6d6;width: 250px;border-bottom: 1px solid #d6d6d6;text-align: center;}
#tablelist tr{margin-top: 2px;}
#tablelist{border: 0px solid red; }
#tablelist tr th {border-right-width: 0px;}
.img_box{float: left;width: auto; }
.img_box img{width: auto;height: auto;float: left;}
.buy_button{width: 100%;height: 25px;}
.suggest{width:50%;float: left; }
.su_button{width: 30%;float: right;}
.Partblue{border: 0;}
#supplierdataTable input{width: 50px;height: 25px;line-height: 25px;}
</style>
<script type="text/javascript" language="javascript"	src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/thickbox.js"></script>
<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.validate.min.js"></script>
<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.metadata.js"></script>
<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.pagination.js"></script>

<script type="text/javascript" language="JavaScript"			src="<%=basePath%>js/PreviewPicture/previewPicture.js"></script>
<script type="text/javascript">
	var pageno = 1;
	var pagesize = 5;
	function pageselectCallback(page_id, jq) {
		var pageno_id = page_id + 1;
		queryRealityGoods(pageno_id);
		return false;
	}
	$(document).ready(function() {
		parent.resetTime();    
		queryRealityGoods(1);
		$(".tablelist tr").hover(function() {
			$(this).addClass("over");
		}, function() {
			$(this).removeClass("over");
		});
		init("");
	});

	function init(id) { 
		$.ajax({
			url : 'goodsSales/getRealGoodsContents.do',
			type : 'post',
			dataType : 'json',
			data : {
				"categorySmallId" : $('categoryId').val(),
				"id" : id
			},
			success : function(data) {
				var data = data.model.data;
				$.each(data, function(i, attr) {
					var id = attr.categorySmallId;
					var value = attr.name;
					$("#categorySmallId").prepend(
							"<option value='"+id+"'>" + value + "</option>");
				});
			},
			error : function(error) {
			 alert(error.status);
			}
		});
		area(0,"province");
	}
function area(pid,clumId){
	//查询地市
	if(pid=="0"&&clumId=="city"){
		$("#" + clumId).empty();
		$("#"+clumId+"").prepend("<option value='' selected>---全部---</option>");
		return;
	}
	$.ajax({
		url : 'goodsSales/getAreaByParentID.do',
		type : 'post',
		dataType : 'json',
		data : { "pid" : pid },
		success : function(data) {
			$("#" + clumId).empty();
			$("#" + clumId).prepend("<option value='' selected>---全部---</option>");
			if(clumId!="city"){
				$("#city").prepend("<option value='' selected>---全部---</option>");
			}
			$.each(data, function(i, attr) {
				var id = attr.id;
				var value = attr.name;
				$("#"+clumId+"").prepend("<option value='"+id+"'>" +value + "</option>");
			});
		},
		error : function(error) {
		 alert(error.status);
		}
	});
	
}
	function queryRealityGoods(pageno) { 
		var tbody = '';
		$ .ajax({url : 'goodsSales/getAgentsGoodsList.do',
					dataType : 'json',
					cache : false,
					//async : false,
					data : {
						'categoryLargeId' : $("#categoryLargeId").find("option:selected").val(),
						'categorySmallId' : $("#categorySmallId").find("option:selected").val(),
						'goodsType' : $("#goodsType").val(),
						'pageno' : pageno,
						'pagesize' : pagesize,
						'goodsCode':$("#goodsCode").val(),
						'city': $("#city").find("option:selected").val(),
						'province': $("#province").find("option:selected").val(),
						'parValue':$("#parValue").val(),
						'goodsName':$("#goodsName").val()
					},
					type : "post",
					success : function(datas) {
						if (datas.retcode == 0) {
							var page = datas.data;
							var pageNo = page.pageNo;
							var total = page.totalCount;
							var pageno = page.currentPageNo;
							var pagesize = page.pageSize;
							var data = page.result;
							$("#supplierdataTable").empty();
							$ .each( data, function(i, attr) {
								
								tbody += "<tr>";
								tbody += "<td style='width:15%' ><div  class='img_box'><a href='javascript:void(0)'  onmouseover='showPreview(event);' onmouseout='hidePreview(event);'>"+
								"<img alt='"+attr.remark+"' pic-link='/' height='100px'  large-src=${picture_path}"+attr.goodsPicture+"    border='0' width='100'  src=${picture_path}"+attr.goodsPicture+">"+
								"</a></div></td>";
								tbody += "<td style='width:35%'> <span>"+  attr.goodsName+ "</span> </td>";
								if (attr.isSell == 1) {
									if(attr.categoryLargeTblId == "1"){
										if(attr.quantity!="不限"){
											tbody += "<td>  <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div>  <div class='su_button'> <input type='button'  value='销售' onclick='buy_real_fun("+attr.stockId+")' class='buy_button Partblue'>   	</div></td>";
										}else{
											tbody += "<td> <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div> <div  class='su_button'> <input type='button'  value='销售' onclick= buy_vir_game_fun('"+attr.goodsContentId+"','"+attr.goodsCode+"')  class='buy_button Partblue'></div> </td>";
										}
									}else if(attr.categoryLargeTblId == "2"){
										if(attr.quantity!="不限"){
											tbody += "<td>  <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div>  <div class='su_button'> <input type='button'  value='销售' onclick='buy_real_fun("+attr.stockId+")' class='buy_button Partblue'>   	</div></td>";
										}else{
											tbody += "<td> <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div> <div  class='su_button'> <input type='button'  value='销售' onclick=buy_vir_fun('"+attr.goodsCode+"') class='buy_button Partblue'></div> </td>";
										}
									}
								
								}else{
										tbody += "<td> <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div> <div  class='su_button'> <input type='button'  value='--'  disabled='disabled' class='buy_button Partblue'> </div></td>";
								}
								tbody += "<td  class='batch'>"+ attr.goodsBatchPrice+ "</td>";
								tbody += "<td>" + attr.quantity+ "</td>";
								tbody += "</tr>";
								 });
						} else {
							$("#supplierdataTable").html('<tr><td colspan="5" class="red">查询出错，请刷新后重试！</td></tr>');
						}
						if (tbody != '') {
							$("#supplierdataTable").html(tbody);
						} else {
							$("#supplierdataTable").html('<tr > <td colspan="5" >没有符合条件的记录！</td></tr>');
						}
						$("#supplierdataTable tr").hover(function() {
							$(this).addClass("over");
						}, function() {
							$(this).removeClass("over");
						});
						load();
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
					},
					error : function(error) {
						$("#supplierdataTable").html('<tr><td colspan="5" class="red">查询出错，请刷新后重试！</td></tr>');
					}
				});
		parent.resetTime();    
	}
	function buy_vir_game_fun(goodsContentId,goodsCode){  
		location.href ="<%=basePath%>goodsSales/games/gameInfo.do?goodsCode="+goodsCode;
	}
	function buy_vir_fun(goodsCode){  
		location.href ="<%=basePath%>goodsSales/mobile/sjzcByGoodsCodePage.do?goodsCode="+goodsCode;
	}
	function buy_real_fun(stockId){ 
		location.href = "<%=basePath%>goodsSales/realitySales.do?stockId="+stockId;
	}
	
	
	　function load(){ 
		　　parent.document.getElementById("main").style.height = "900px"; 
		　　parent.document.getElementById("mmain").style.height = "900px"; 
　         　} 
	
	function findCity(id) { 
		if (id != null && id != "" && id != -1) {
			area(id, "city");
		}
	}
	function findSmallGoodCategory(id) { 
		url_ = "goodsManager/findSmallGoodCategory.do?largeCategoryId=";
		if (id != null && id != "" && id != -1) {
			url_ += id;
			ajaxFindShowField(url_, "categorySmallId");
		}
	}
	function createOptionElement(value, innerHTML,defaul) { 
		var option = document.createElement("OPTION");
		option.value = value;
		option.innerHTML = innerHTML;
		option.selected = defaul;
		return option;
	}
	function ajaxFindShowField(url_, refreshId) { 
		$.ajax( {
			type : "get",
			async : true,
			cache:false,
			url : url_,
			dataType : 'json',
			success : function(data) {
				if(data.retcode == 0){
					var data = data.data;
					$("#" + refreshId).empty();
					var options = "";
					$("#" + refreshId).append(createOptionElement("","---全部---",true));
					$.each(data,function(i,attr){
						var option = createOptionElement(attr.id,attr.name,false);
						$("#" + refreshId).append(option);
					})
				}else{
					alert("error:id=''");
				}
				
				//$("#categorySmallId").prepend("<option value='"+id+"'>" + value + "</option>");
			},
			error : function(err) {
				alert(err.status);
		}
		});
	}
</script>
<style type="text/css">
.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
</style>
</head>
<body onload="load();">
<div id="PreviewBox" onmouseout="hidePreview(event);">
  <div class="Picture" onmouseout="hidePreview(event);">
   <span></span>
   <div>
    <a id="previewUrl" href="javascript:void(0)" target="_blank">
    <img oncontextmenu="return(false)" id="PreviewImage" src="about:blank" border="0" onmouseout="hidePreview(event);" />
    </a>
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
			<div id="main" style="width: 100%;">
				<div id="tabCot_product" class="tab" style="width: 100%">
					<div class="tabContainer" style="width: 100%">
						<ul class="tabHead" id="tabCot_product-li-currentBtn-">
							<li class="currentBtn"><a href="<%=basePath%>goodsSales/virtualGoodsSalesPage.do"	title="商品销售" rel="1">虚拟商品查询</a></li>
						</ul>
					</div>
					<div id="tabCot" >
						<div style="text-align: center;" id="autoTime">
							<div class="block" >
							
								<form id="queryForm">
							<input type="hidden" id="goodsType" name="goodsType" value="0" > 
									<ul class="formul" style="text-align: center;">
										<li>
										 商品大类：  <span>
												<select id="categoryLargeId" name="categoryLargeId" onchange="findSmallGoodCategory(this.value)" style="width: 143px;height: 25px;line-height: 25px;">
													<option value="" selected>---全部---</option>
													<option value="1">游戏充值类</option>
													<option  value="2">话费充值类</option>
											</select>
											</span>
												 商品小类：  <span>
												<select id="categorySmallId" name="categorySmallId"  style="width: 143px;height: 25px;line-height: 25px;">
													<option value="" selected>---全部---</option>
											</select>
											</span>
											商品编码:<input type="text" id="goodsCode" name="goodsCode" style="height: 25px;"> 
											
										</li>
									</ul>
									<ul class="formul"   >
										<li>
										  省份：  <span>
												<select id="province" name="province" tyle="width: 143px;height: 25px;line-height: 25px;"  onchange="findCity(this.value)">
											</select>
											</span>
										  地市：  <span>
												<select id="city" name="city" style="width: 143px;height: 25px;line-height: 25px;">
											</select>
											</span>
											商品名称:<input type="text" id="goodsName" name="goodsName" style="height: 25px;"> 
										</li>
									</ul>
									<ul class="formul"   >
										<li>
										  面值(元)：  <span>
												<select id="parValue" name="parValue" tyle="width: 143px;height: 25px;line-height: 25px;" >
												<option value="">--全部--</option>
												 <c:forEach var="data" items="${sys_googsprice}">
													<option  value= "${data}" >${data}</option>
										          </c:forEach>
												</select>
											</span>
										</li>
									</ul>
												<ul style="height: 10px">
													<li style="margin-left: 120px">
														<input type="button" class="Partorange" onclick="queryRealityGoods(1)" value="查询"/> 
													</li>
													<li>
														<input type="button" class="Partgreen" onclick="$('#queryForm')[0].reset();parent.resetTime();" value="重置"/> 
													</li>
												</ul>
									<table class="tablelist pusht"  id="tablelist">
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
								</form>
								<div id="pages">
									<div id="Pagination" class="pagination"></div>
								</div>
							</div>
						</div>


					</div>
						<div class="modBottom">
							<span class="modABL"></span> <span class="modABR"></span>
						</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>