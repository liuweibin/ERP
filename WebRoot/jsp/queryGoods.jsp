<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<%
String num= request.getParameter("num");
%>
<style type="text/css">
</style>
</head>

<script type="text/javascript">
var pageno = 1;
var pagesize = 5;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1;
	queryRealityGoods(pageno_id);
	return false;
}
function pageselectCallbackv(page_id, jq) {
	var pageno_id = page_id + 1;
	queryVirtualGoods(pageno_id);
	return false;
}
function pageselectCallbackIn(page_id, jq) {
	var pageno_id = page_id + 1;
	getPrice(pageno_id);
	return false;
}
function setTab(name,cursel,n){
	for(i=1;i<=n;i++){
		var menu=document.getElementById(name+i);
		var con=document.getElementById("con_"+name+"_"+i);
		menu.className=i==cursel?"hover":"";
		con.style.display=i==cursel?"block":"none";
		}
	if(cursel==3){
		area(0,"provinceIn");
	}else if(cursel==2){
		area(0,"province");
	}
}
var cursel = <%=num%>;
$(function(){
	setTab('spcx',cursel,3);
	if(cursel==3){
		area(0,"provinceIn");
	}else if(cursel==2){
		area(0,"province");
	}
	queryRealityGoods(1);
})
function findCity(name,id) {  
	if (id != null && id != "" && id != -1) {
		area(id, name);
	}else{
		$("#"+name).empty();
		$("#"+name).prepend("<option value='' selected>——全部——</option>");
	}
}
function findSmallGoodCategory(type,id) {  
		url_ = "<%=basePath%>goodsManager/findSmallGoodCategory.do?largeCategoryId=";
		if (id != null && id != "" && id != -1) {
			url_ += id;
			if(type=="in"){
				ajaxFindShowField(url_, "categorySmallIdIn");
			}else if(type=="v"){
				ajaxFindShowField(url_, "categorySmallIdv");
			}else if(type=="r"){
				ajaxFindShowField(url_, "categorySmallId");
			}
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
					$("#" + refreshId).append(createOptionElement("","——全部——",true));
					$.each(data,function(i,attr){
						var option = createOptionElement(attr.id,attr.name,false);
						$("#" + refreshId).append(option);
					})
				}else{
					alert("error:id=''");
				}
				
			},
			error : function(err) {
				alert(err.status);
		}
		});
	}
	function area(pid,clumId){
		//查询地市
		if(pid=="0"&&clumId=="city"){
			$("#" + clumId).empty();
			$("#"+clumId+"").prepend("<option value='' selected>——全部——</option>");
			return;
		}
		$.ajax({
			url : '<%=basePath%>goodsSales/getAreaByParentID.do',
			type : 'post',
			dataType : 'json',
			data : { "pid" : pid },
			success : function(data) {
				$("#" + clumId).empty();
				$("#" + clumId).prepend("<option value='' selected>——全部——</option>");
				if(clumId!="city"){
					$("#city").prepend("<option value='' selected>——全部——</option>");
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
		var bo = false;
		var id = "gamelbnr";
			$.ajax({
					url : '<%=basePath%>goodsSales/getAgentsGoodsList.do',
					dataType : 'json',
					cache : false,
					//async : false,
					data : {
					 categoryLargeId: $('#categoryLargeId').find('option:selected').val(),
					categorySmallId: $('#categorySmallId').find('option:selected').val(),
					goodsType: '1',
					pageno:pageno,
					pagesize:pagesize,
					goodsCode:$("#goodsCode").val(),
					city:$("#city").find("option:selected").val(),
					province:$("#province").find("option:selected").val(),
					parValue:$("#parValue").val(),
					goodsName:$("#goodsName").val()
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
							$("#"+id).empty();
							$ .each( data, function(i, attr) {
								tbody += "<li><dl>"; 
								tbody += "<dt><img src=${picture_path}"+attr.goodsPicture+" width='125' height='94' /></dt>";
								tbody += "<dd class='dd1'><img alt='"+attr.remark+"' src=<%=basePath%>images/images/zhang.gif width='16' height='16' /> <a href='#'>"+  attr.goodsName+ "</a></dd>";
								tbody += "<dd>物品类型： 实体物品</dd>";
								//tbody += "<dd>游戏区服： 倩女幽魂2 /笑苍穹 /水龙吟</dd></dl>";
								tbody += "<dd>建议零售价： "+attr.suggestRetailPrice+"元</dd></dl>";
								tbody += "<div class='xs'><a href=<%=basePath%>jsp/realitySales.jsp?stockId="+attr.stockId+"><img src=<%=basePath%>images/images/xs.gif width='64' height='23' /></a></div>";
								tbody += "<div class='sl'>"+attr.quantity+"</div>";
								tbody += "<div class='jj'>"+attr.goodsBatchPrice+"元</div>";
								tbody += "</li>";
								/*
								tbody += "<dl><div  class='img_box'><a href='javascript:void(0)'  onmouseover='showPreview(event);' onmouseout='hidePreview(event);'>"+
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
										tbody += "<td> <div class='suggest' >"	+ attr.suggestRetailPrice	+ "</div> <div  class='su_button'> <input type='button'  value='销售'  disabled='disabled' class='buy_button Partblue'> </div></td>";
								}
								tbody += "<td  class='batch'>"+ attr.goodsBatchPrice+ "</td>";
								tbody += "<td>" + attr.quantity+ "</td>";
								tbody += "</tr>";
								*/
								 });
						} else {
							$("#"+id).html("<li><div  style='text-align: center;' class='red'>查询出错，请刷新后重试！</div></li>");
						}
						if (tbody != '') {
							$("#"+id).html(tbody);
						} else {
							$("#"+id).html("<li><div  style='text-align: center;'>没有符合条件的记录！</div></li>");
						}
						$("#"+id+" li").hover(function() {
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
					},
					error : function(error) {
						$("#supplierdataTable").html('<tr><td colspan="5" class="red">查询出错，请刷新后重试！</td></tr>');
					}
				});
	}
	 
	function queryVirtualGoods(pageno) { 
		var tbody = '';
		var bo = false;
		var id = "gamelbnrv";
		var goodsSellPath = "<%=basePath%>jsp/sjcz.jsp?num=0&goodsCode=";
		var basePath = "<%=basePath%>";
			$.ajax({
					url : '<%=basePath%>goodsSales/getAgentsGoodsList.do',
					dataType : 'json',
					cache : false,
					//async : false,
					data : {
					categoryLargeId: $('#categoryLargeIdv').find('option:selected').val(),
					categorySmallId: $('#categorySmallIdv').find('option:selected').val(),
					goodsType: '0',
					pageno:pageno,
					pagesize:pagesize,
					goodsCode:$("#goodsCodev").val(),
					city:$("#city").find("option:selected").val(),
					province:$("#province").find("option:selected").val(),
					parValue:$("#parValuev").val(),
					goodsName:$("#goodsNamev").val()
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
							$("#"+id).empty();
							$ .each( data, function(i, attr) {
								if(attr.categorySmallTblId=="2"){//话费
									if(attr.isFull=="0"){
										goodsSellPath = "<%=basePath%>jsp/sjcz.jsp?num=0&goodsCode=";
									}else if(attr.isFull=="1"){
										goodsSellPath = "<%=basePath%>jsp/sjcz.jsp?num=1&goodsCode=";
									}
								}else if(attr.categorySmallTblId=="5"){//固话
									goodsSellPath = "<%=basePath%>jsp/ghcz.jsp?goodsCode=";
								}else if(attr.categorySmallTblId=="1"){//游戏
									goodsSellPath = "<%=basePath%>jsp/gameCzForm.jsp?goodsCode=";
								}
								tbody += "<li class='tbover'><dl>"; 
								tbody += "<dt><img src=${picture_path}"+attr.goodsPicture+" width='125' height='94' /></dt>";
								tbody += "<dd class='dd1'><img alt='"+attr.remark+"' src='"+basePath+"images/images/zhang.gif' width='16' height='16' /> <a href='"+goodsSellPath+attr.goodsCode+"'>"+  attr.goodsName+ "</a></dd>";
									tbody += "<dd>物品类型： 虚拟物品</dd>";
								//tbody += "<dd>游戏区服： 倩女幽魂2 /笑苍穹 /水龙吟</dd></dl>";
								
								tbody += "<dd>建议零售价： "+attr.suggestRetailPrice+"元</dd></dl>";
								tbody += "<div class='xs'><a href='"+goodsSellPath+attr.goodsCode+"'><img src=<%=basePath%>images/images/xs.gif width='64' height='23' /></a></div>";
								tbody += "<div class='sl'>"+attr.quantity+"</div>";
								tbody += "<div class='jj'>"+attr.goodsBatchPrice+"元</div>";
								tbody += "</li>";
								 });
						} else {
							$("#"+id).html("<li><div  style='text-align: center;' class='red'>查询出错，请刷新后重试！</div></li>");
						}
						if (tbody != '') {
							$("#"+id).html(tbody);
						} else {
							$("#"+id).html("<li><div  style='text-align: center;'>没有符合条件的记录！</div></li>");
						}
						$(".gamelbnr li").hover(function() {
							$(this).addClass("tbover"); 
						}, function() {
							$(this).removeClass("tbover");
						});
						var current_page = pageno - 1;
							$("#Paginationv").pagination(total, {
								callback : pageselectCallbackv,
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
						$("#supplierdataTable").html('<li colspan="5" class="red">查询出错，请刷新后重试！</li>');
					}
				});
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
	/*商品进价查询*/
	function getPrice(pageno) {
		var tbody = "";
		$.ajax({
					url : '<%=basePath%>goodsManager/goodsPriceTbl/getByParams.do',
					type : 'POST',
					dataType : 'json',
					timeout : 5000,
					data : {
						'cardtype' : $("#categoryLargeIdIn").find("option:selected").val(),
						'categorySmallId' : $("#categorySmallIdIn").find("option:selected").val(),
						'goodsName' : $("#goodsNameIn").val(),
						'parValue' : $("#parValueIn").val(),
						'city' : $("#cityIn").val(),
						'province' : $("#provinceIn").val(),
						'pageno' : pageno,
						'pagesize' : pagesize,
						'goodsCode':$("#goodsCodeIn").val()
					},
					async : false,
					success : function(datas) {
						if(datas.retcode=="1"){
							alert(datas.message);
						}else{
							datas = datas.data;
							$("#databuyTable").empty();
							var pageNo = datas.pageNo;
							var total = datas.totalCount;
							var pageno = datas.currentPageNo;
							var pagesize = datas.pageSize;
							var list = datas.result;
							$.each(list, function(index, data) {
								tbody += "<tr>";
								tbody += '<td align="center">' + data.goodsCode + '</td> ';
								tbody += '<td align="center">' + data.goodsName + '</td> ';
								tbody += '<td align="center">' + data.cityName+ '</td> ';
								tbody += '<td align="center">' + data.parValue / 100 + '</td> ';
								tbody += '<td align="center">' + data.price / 100 + '</td> ';
								tbody += "</tr>";
							})
						}
						
						if (tbody != '') {
							$("#dataTable").html(tbody);
						} else {
							$("#dataTable") .html('<tr><td colspan="14" align="center">没有符合条件的记录！</td></tr>');
						}
						$("#dataTable tr").hover(function() {
							$(this).addClass("tbover");
						}, function() {
							$(this).removeClass("tbover");
						});
						var current_page = pageno - 1;
						$("#PaginationIn").pagination(total, {
							callback : pageselectCallbackIn,
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
						alert(error.status)
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
          <div class="nyTit">商品查询</div>
          <div class="gamenamebox">
            <ul class="tit">
              <li class="hover" id="spcx1" onclick="setTab('spcx',1,3)">实体商品查询</li>
              <li id="spcx2" onclick="setTab('spcx',2,3)">虚拟商品查询</li>
              <li id="spcx3" onclick="setTab('spcx',3,3)">商品进价查询</li>
            </ul>
            <div class="gamename" style="width: 968px;padding: 20px 0; ">
              <div class="spcxtj" id="con_spcx_1">
		                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
							  <tr>
							    <td class="wz">产品大类：</td>
							    <td><select   class="input6"   id="categoryLargeId" name="categoryLargeId" onchange="findSmallGoodCategory('r',this.value)" >
							      <option value="">——全部——</option>
							      <option value="1">游戏充值类</option>
								<option  value="2">话费充值类</option>
							    </select></td>
							    <td class="wz">产品小类：</td>
							    <td><select   class="input6" id="categorySmallId" name="categorySmallId">
							      <option  value="">——全部——</option>
							    </select></td>
							    <td class="wz">产品编码：</td> 
							    <td><input name="textfield" type="text" class="input6" id="textfield" /></td>
							    <td class="wz">商品名称：</td>
							    <td><input name="textfield2" type="text" class="input6" id="textfield2" /></td>
							  </tr>
							  <tr>
							    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2"  onclick="queryRealityGoods(1)" id="button" value="查询" /></td>
							  </tr>
						</table>
		               <div class="gamelb" >
				            <div class="gamelbTit">
				              <h1>充值类型</h1>
				              <h4>销售</h4>
				              <h2>数量</h2>
				              <h3>进价</h3>
				            </div>
				            <ul class="gamelbnr" id="gamelbnr">
				            <%--
				              <li>
				                <dl>
				                  <dt><img src="../images/images/img2.jpg" width="125" height="94" /></dt>
				                  <dd class="dd1"><img src="../images/images/zhang.gif" width="16" height="16" /> <a href="#">倩女幽魂[账号]A530-83级女射手有白虎坐骑</a></dd>
				                  <dd>物品类型： 游戏账号</dd>
				                  <dd>游戏区服： 倩女幽魂2 /笑苍穹 /水龙吟</dd>
				                </dl>
				                <div class="xs"><a href="#"><img src="../images/images/xs.gif" width="64" height="23" /></a></div>
				                <div class="sl">10</div>
				                <div class="jj">20.0元</div>
				              </li>
				            --%>
				            </ul>
		          		</div>    
		          		<div id="pages">
									<div id="Pagination" class="pagination"></div>
						</div>
              </div>
              <div class="spcxtj" id="con_spcx_2" style="display:none">
               		 <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
              	<form id="vform">
               		 		  <tr>
							    <td class="wz">省份：</td>
							    <td><select  class="input6" id="province" name="province" onchange="findCity('city',this.value)">
							      <option  value="">——全部——</option>
							    </select>
							    </td>
							    <td class="wz">城市：</td>
							    <td><select   class="input6"  id="city" name="city" >
							      <option  value="">——全部——</option>
							    </select></td>
							    <td class="wz">面值：</td>
							    <td><select id="parValuev" name="parValuev"   class="input6" >
												<option value="">--全部--</option>
												 <c:forEach var="data" items="${sys_googsprice}">
													<option  value= "${data}" >${data}</option>
										          </c:forEach>
												</select></td>
							    <td class="wz">&nbsp;</td>
							    <td>&nbsp;</td>
							  </tr>
						  <tr>
						    <td class="wz">产品大类：</td>
						    <td><select class="input6"  id="categoryLargeIdv" name="categoryLargeIdv" onchange="findSmallGoodCategory('v',this.value)" >
							      <option value="">——全部——</option>
							      <option value="1">游戏充值类</option>
								<option  value="2">话费充值类</option>
							    </select></td>
						    <td class="wz">产品小类：</td>
						   <td><select   class="input6" id="categorySmallIdv" name="categorySmallIdv">
							      <option value="">——全部——</option>
							    </select></td>
						    <td class="wz">产品编码：</td>
						    <td><input type="text" class="input6"  id="goodsCodev" name="goodsCodev" /></td>
						    <td class="wz">商品名称：</td>
						    <td><input   type="text" class="input6" id="goodsNamev" name="goodsNamev"  /></td>
						  </tr>
						  <tr>
						    <td colspan="8" align="center"><input name="button" type="button" class="an_input2" onclick="queryVirtualGoods(1)" id="button" value="查询" />
						    <input type="button" class="an_input2" onclick="$('#vform')[0].reset();" value="重置"/> 
						    </td>
						    </tr>
					</form>
					</table>
			             <div class="gamelb" >
				            <div class="gamelbTit">
				              <h1>充值类型</h1>
				              <h4>销售</h4>
				              <h2>数量</h2>
				              <h3>进价</h3>
				            </div>
				            <ul class="gamelbnr" id="gamelbnrv">
				               
				            </ul>
			             </div>    
		          <div id="pages">
									<div id="Paginationv" class="pagination"></div>
						</div>
              </div>
              <div class="spcxtj" id="con_spcx_3" style="display:none;width: 100%" >
               		 <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
              	<form id="Inform">
               		 		  <tr>
							    <td class="wz">省份：</td>
							    <td><select  class="input6" id="provinceIn" name="provinceIn" onchange="findCity('cityIn',this.value)">
							      <option  value="">——全部——</option>
							    </select>
							    </td>
							    <td class="wz">城市：</td>
							    <td><select   class="input6"  id="cityIn" name="cityIn" >
							      <option  value="">——全部——</option>
							    </select></td>
							    <td class="wz">面值：</td>
							    <td><select id="parValueIn" name="parValueIn"   class="input6" >
												<option value="">--全部--</option>
												 <c:forEach var="data" items="${sys_googsprice}">
													<option  value= "${data}" >${data}</option>
										          </c:forEach>
												</select></td>
							    <td class="wz">&nbsp;</td>
							    <td>&nbsp;</td>
							  </tr>
						  <tr>
						    <td class="wz">产品大类：</td>
						    <td><select name="select" class="input6"  id="categoryLargeIdIn" name="categoryLargeIdIn" onchange="findSmallGoodCategory('in',this.value)" >
							      <option value="">——全部——</option>
							      <option value="1">游戏充值类</option>
								<option  value="2">话费充值类</option>
							    </select></td>
						    <td class="wz">产品小类：</td>
						   <td><select name="select2" class="input6" id="categorySmallIdIn" name="categorySmallIdIn">
							      <option value="">——全部——</option>
							    </select>
							</td>
						    <td class="wz">产品编码：</td>
						    <td><input type="text" class="input6"  id="goodsCodeIn" name="goodsCodeIn" /></td>
						    <td class="wz">商品名称：</td>
						    <td><input   type="text" class="input6" id="goodsNameIn" name="goodsNameIn"  /></td>
						  </tr>
						  <tr>
						    <td colspan="8" align="center"><input name="button" type="button" class="an_input2" onclick="getPrice(1)" id="button" value="查询" />
						    <input type="button" class="an_input2" onclick="$('#Inform')[0].reset();" value="重置"/> 
						    </td>
						    </tr>
					</form>
					</table>
	                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="150" class="wz">商品编号</td>
	                    <td width="200" class="wz">商品名称</td>
	                    <td width="200" class="wz">地市</td>
	                    <td width="133" class="wz">面值（元）</td>
	                    <td width="136" class="wz">进价（元）</td>
	                  </tr>	
	                  <tbody id="dataTable" style="text-align: center">
	                
					  </tbody>
	                </table>
		          <div id="pages">
									<div id="PaginationIn" class="pagination"></div>
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
