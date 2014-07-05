<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>客户返点</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->


<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/of.global.100518.css">
<link rel="stylesheet" type="text/css"	href="<%=basePath%>themes/sales/home/esales.style.css">
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.pagination.js"></script>
<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/thickbox.js"></script>
   <SCRIPT LANGUAGE="JavaScript">
   var pageno = 1;     
 var pagesize = 10; 
  function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1;
	customerQuery(pageno_id);
	return false;
  }
  
  
$(document).ready(function() {
	customerQuery(0);
		$('#cusPointSumbit').click(function() {
								// $('#signupForm').submit();
									customerQuery(0);
								});
				});
   
   function customerQuery(pageno){
									var url_ = "customUser.do?type=customPoint";
									url_ += "&pageno=" + pageno;
									url_ += "&pagesize=" + pagesize;
									url_ += "&customname=" + encodeURI($("#customname").val());
									url_ += "&phone=" + encodeURI($("#phone").val());
									$
											.ajax( {
												cache : true,
												type : "POST",
												async : false,
												url : url_,
												dataType : 'json',
												error : function(request) {
													alert("Connection error");
												},
												success : function(data) {
													var total=0;
											    	  var pageno=0;
											    	  var pagesize;
													//$("#selectfactor").css("display","none");
													var tab = '';
													for ( var i = 0; i < data.length; i++) {
														total=data[i].totalCount;
														pagesize=data[i].pageSize;
														pageno=data[i].pageNo;
														tab += '<tr>';
														tab += '<td>' + data[i].agentsCode + '</td>';
														tab += '<td>' + data[i].customName + '</td>';
														tab += '<td>' + data[i].fixedPhone + '</td>';
														tab += '<td>' + data[i].mobilePhone + '</td>';
														tab += '<td>' + data[i].qq + '</td>';
														tab += '<td>' + data[i].email + '</td>';
														tab += '<td>' + data[i].address + '</td>';
														tab += '<td>' + data[i].integration + '</td>';
														tab += '<td>' + data[i].remark + '</td>';
														tab += '<td>' + data[i].createTime + '</td>';
														tab += '<td><a href="javascript:void(0)"  onClick="javascript:sure('+data[i].id+');"><span style="color: #ff4500;">确定</span></a></td>';
														tab += '</tr>';
													}
													if (tab != '') {
														$("#dataTable").html(
																tab);
													} else {
														$("#dataTable")
																.html(
																		'<tr><td colspan="11">没有符合条件的记录！</td></tr>');
													}
													$("#dataTable tr").hover(
																	function() {
																		$(this).addClass(
																						"over");
																	},
																	function() {
																		$(this).removeClass(
																						"over");
																	});
													//加入分页的绑定
													 var current_page=pageno-1;
														$("#PaginationCusPoint").pagination(total, {
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
   
   $("document").ready(function(){
   });
  function sure(id){
  	$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : "customUser.do?type=customerPointOperat&customid="+id,
				data : $('#form').serialize(),
				error : function(error) {
					alert(error.status);
				},
				success : function(data) {
				var s= data.model.status;
				if(s=="100"){
					alert("积分兑换成功");
					closeWinNoLoad();
				}else if(s=="101"){
				 	alert("积分兑换失败！请重试");
				}else if(s=="102"){
					alert("订单积分已经兑换！请不要多次兑换");
					closeWinNoLoad();
				}
			}
			});
  }
function closeWinNoLoad(hasFlush, timeout) {
	if (hasFlush) {
		if (!timeout) {
			var timeout = 2000;
		}
		setTimeout(function() {
			try {
				tb_remove();
			} catch (e) {
			}
		}, timeout);
	} else {
		tb_remove();
		refresh();
	}
}
  function refresh(agentsCode){
  main.location.href="<%=basePath%>/tradingRecord.do?queryTime=all";

}
  </SCRIPT>
  <style type="text/css">
  </style>
 </HEAD>
 <BODY>

	<table class="tablelist pusht" style="margin-top: 30px;">
	<div style="text-align:"><lable>客户名称:</lable><input type="text" id="customname" name="customname"/> <lable>手机号码:</lable><input type="text" id="phone" name="phone"/><button id="cusPointSumbit" type="button" class="small">
							查询
						</button></div>
	<div style="text-align: center;color: red;"><c:out  value="积分兑换规则：10元=1积分"></c:out></div>
 <form id="form">
 <input type="hidden" name="orderCode" value="${orderCode}">
											<th style="text-align: center;">
												代理商编号
											</th>
											<th style="text-align: center;">
												客户名称
											</th>
											<th style="text-align: center;">
												固定电话
											</th>
											<th style="text-align: center;">
												手机
											</th>
											<th style="text-align: center;">
												QQ号码
											</th>
											<th style="text-align: center;">
												邮件地址
											</th>
											<th style="text-align: center;">
												详细地址
											</th>
											<th style="text-align: center;">
												当前积分
											</th>
											<th style="text-align: center;">
												备注
											</th>
											<th style="text-align: center;">
												添加时间
											</th>
											<th style="text-align: center;">
												返积分操作
											</th>
										</tr>
	 	<%--<c:forEach items="${customUserTblList}" var="customUserTblList">
 <tr>
 <td class="txt_c">${customUserTblList.customName}</td>
 <td class="txt_c">	${customUserTblList.customName}</td>
<td class="txt_c">${customUserTblList.fixedPhone}</td>
											<td class="txt_c">
												${customUserTblList.mobilePhone}
											</td>
											<td class="txt_c">
												${customUserTblList.qq}
											</td>
											<td class="txt_c">
												${customUserTblList.email}
											</td>
											<td class="txt_c">
												${customUserTblList.address}
											</td>
											<td class="txt_c">
												${customUserTblList.integration}
											</td>
											<td class="txt_c">
												${customUserTblList.remark}
											</td>
											<td>
												${customUserTblList.createTime}
											</td>
 
	<td class="txt_c" style="color:red;text-align: center;">
	<a href="javascript:void(0)"  onClick="javascript:sure('${customUserTblList.id}');"><span style="color: #ff4500;">确定</span></a>
	</td>
	 </tr></c:forEach>
 --%>
 <tbody id="dataTable" style="text-align: center">
		</tbody>
 </table>
	 <div id="pages">
			<div id="PaginationCusPoint" class="pagination"></div>
		</div>
 </form>
 </BODY></html>
