<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"	isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"			+ request.getServerName() + ":" + request.getServerPort()			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'queryGoodsPrice.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="<%=basePath%>themes/common/titletab.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/of.global.100518.css">
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/esales.style.css">
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/common/button.css" 	media="screen">
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.pagination.js"></script>
<script type="text/javascript">
	var pageno = 1;
	var pagesize = 5;
	function pageselectCallback(page_id, jq) {
		var pageno_id = page_id + 1;
		getPrice(pageno_id);
		return false;
	}
	$().ready(function() {
		parent.resetTime(); 
		$(".tablelist tr").hover(function() {
			$(this).addClass("over");
		}, function() {
			$(this).removeClass("over");
		});
		//---------------商品类型选择框	
		init();
		//getPrice(1);
	});
	function init() {
		$.ajax({
			url : 'goodsManager/goods.do',
			type : 'POST',
			dataType : 'json',
			timeout : 5000,
			async : false,
			error : function() {
				alert('获取数据失败！');
			},
			success : function(datas) {
				if(datas.retcode==0){
					var json = datas.data;
					$.each(json, function(a, b) {
						var value = b.name;
						var id = b.id;
						$("#cardtype").prepend(
								"<option value='"+id+"'>" + value + "</option>");
					});
				}
				

			}
		});
	}
	function getPrice(pageno) {
		parent.resetTime(); 
		var tbody = "";
		$.ajax({
					url : 'goodsManager/goodsPriceTbl/getByParams.do',
					type : 'POST',
					dataType : 'json',
					timeout : 5000,
					data : {
						'cardtype' : $("#cardtype").val(),
						'goodsName' : $("#goodsName").val(),
						'pageno' : pageno,
						'pagesize' : pagesize,
						'goodsCode':$("#goodsCode").val()
					},
					async : false,
					success : function(datas) {
						if(datas.retcode=="1"){
							alert(datas.message);
						}else{
							datas = datas.data;
							$(".tablelist tbody").empty();
							var pageNo = datas.pageNo;
							var total = datas.totalCount;
							var pageno = datas.currentPageNo;
							var pagesize = datas.pageSize;
							var list = datas.result;
							$.each(list, function(index, data) {
								tbody += "<tr>";
								tbody += '<td align="center">' + data.goodsCode
										+ '</td> ';
								tbody += '<td align="center">' + data.goodsName
										+ '</td> ';
								tbody += '<td align="center">' + data.parValue
										/ 100 + '</td> ';
								tbody += '<td align="center">' + data.price / 100
										+ '</td> ';
								tbody += "</tr>";
							})
						}
						
						if (tbody != '') {
							$(".tablelist tbody").html(tbody);
						} else {
							$(".tablelist tbody")
									.html('<tr><td colspan="14" align="center">没有符合条件的记录！</td></tr>');
						}
						$(".tablelist tr").hover(function() {
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

						parent.document.getElementById("main").style.height= window.document.body.clientHeight+20+"px";
					},
					error : function(error) {
						alert(error.status)
					}
				});

	}
	function load(){ 
		　　parent.document.getElementById("main").style.height = window.document.body.clientHeight+"px"; 
	     　} 
</script>
<style type="text/css">
body {
	margin: 0px 20 px;
}

.blockcommon {
	padding: 2px 10px 10px 10px;
}
#queryTable tr td {
	padding: 0px 50px;
}
.tab #tabCot {
	padding: 20px 0px 10px 0px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
</style>

</head>
<body onload="load()">
	<div id="wrapper" style="width: auto">

		<div id="container">
			<div class="block">
				<div id="wrap" style="width: 100%">
					<div id="body" style="width: 100%">
						<div id="main" style="overflow: hidden; width: 100%;">
							<div id="tabCot_product" class="tab" style="width: 100%">
								<div class="tabContainer" style="width: 100%">
									<ul class="tabHead" id="tabCot_product-li-currentBtn-">
										<li class="currentBtn">
										<a href="<%=basePath%>goodsManager/goodsPriceTbl/getByParamsPage.do"		title="商品进价查询" rel="1">商品进价查询</a></li>

									</ul>
								</div>
								<div id="tabCot" style="padding-top: 10px;">

									<div style="" id="autoTime">

										<div class="block" style="padding: 0;margin: 0;">
											<form id="queryForm">
												<ul class="formul" style="width: 90%">
													<li style="width: 100%">
													<span style="margin-left: 0px;">
													 <label>商品名称：</label>
													 <input	type="text" name="goodsName" id="goodsName" value="" /> 
													 </span>
														<span style="margin-left: 78px;"> <label>商品大类：</label>
															<select name="cardtype" id="cardtype" style="width: 130px;">
																<option selected="selected" value="">---全部---</option>
														</select> </span>
													</li>
												</ul>
													<ul class="formul" style="width: 90%">
													<li>
													<span style="margin-left: 0px;"> <label>商品编码：</label>
															<input	type="text" name="goodsCode" id="goodsCode" value="" />
															 </span>
													
													</li>
												</ul>
												<ul style="height: 10px">
													<li style="margin-left: 120px">
														<input type="button" class="Partorange" onclick="getPrice(1);" value="查询"  />
													</li>
													<li>
														<input type="reset" class="Partgreen" onclick="$('#queryForm')[0].reset()" value="重置"/>
													</li>
												</ul>
												<table class="tablelist pusht" style="margin-top: 30px;">
													<thead>
														<tr>
															<th>商品编号</th>
															<th width="185px">商品名称</th>
															<th width="185px">面值(元)</th>
															<th width="175px">进价(元)</th>
														</tr>
													</thead>
													<tbody>

													</tbody>
												</table>
											</form>
										</div>
										<!--end: block -->
										<div id="pages">
											<div id="Pagination" class="pagination"></div>
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
			</div>
</body>
</html>
