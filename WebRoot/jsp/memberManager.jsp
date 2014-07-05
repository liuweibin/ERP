<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
.time ul li{float: left; list-style-type: none;margin: 0 15px;}
.show ul li a:LINK { color: green; }
.show ul li a:VISITED { color: blue; }
.show ul li a:active { color: red; }
.show ul li a:HOVER { color: red; }
.select  {background-color: #C8E2B1;}
</style>
<script type="text/javascript">
var pageno = 1;
var pagesize = 5;
function pageselectCallback(page_id, jq) {
	var pageno_id = page_id + 1
	agentsManager(pageno_id);
	return false;
}
$(function(){
	$(".show ul li a").click(function (e) {
		var className	= $(this)[0].className;
			if(className=="select"){
				$(this).removeAttr("class");
			}else{
				 $(this).addClass("select").parent().siblings().find("a").removeAttr("class");
			}
    });
	init();
	agentsManager(1);
})
function init(){
	$.ajax({
		url : '<%=basePath%>agentsManage.do?type=memberManagerInit',
		type : 'post',
		dataType : 'json',
		async:false,
		success : function(data) {
			if(data.retcode==0){ 
				data = data.data;
				var map  = data[0].childsAgentsMap;
				var html ="";
				$("#userid").empty();
				$("#userid").prepend("<option value='' selected>——全部——</option>");
				$.each(map, function(i, attr) {
					var key = i;
					var value = attr;
					$("#userid").prepend("<option value='"+key+"'>" +value + "</option>");
				});
			}
		},
		error : function(error) {
		 alert(error.status);
		}
	});
	$("#timeUnit").val("-1");
	$("#type").val("2");
}
function changeTimePanel(type){
	$(".show").toggle();
	$(".hide").toggle();
	$("#type").val(type);
} 


function agentsManager(pageno) {
	var userid = $("#userid").val();
	var timeUnit = $("#timeUnit").val();
	var path ="<%=basePath%>"; 
	var url =  path+"agentsManage.do?type=agentsInfo";
	var type = $("#type").val();
	if(type==1){ 
		var starttime = document.getElementById("agentstarttime").value;
		var endtime = document.getElementById("agentendtime").value;
		url +=  "&startTime=" + starttime + "&endTime=" + endtime;
	}else if(type==2){
		url +=  "&timeUnit="+timeUnit;
	}
	url += "&agentsCode=" +userid+"&pagesize="+pagesize+"&pageno="+pageno;
	$.ajax( {
				cache : true,
				type : "POST",
				async : false,
				url : url,
				dataType : 'json',
				error : function(request) {
					$("#dataTable").html( '<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectfactor").css("display", "none");
				},
				success : function(data) {
					if (data.retcode == "1") {
						$("#dataTable")
								.html( '<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
						$("#selectfactor").css("display", "none");
						return false;
					}

					var total = data.data.totalCount;
					var pageno = data.data.pageNo;
					var pagesize = data.data.pageSize;

					$("#selectfactor").css("display", "none");
					var tab = '';
					for ( var i = 0; i < data.data.result.length; i++) {
						tab += '<tr>';
						tab += '<td>' + data.data.result[i].agentsCode + '</td>';
						tab += '<td>' + data.data.result[i].name + '</td>';
						tab += '<td>' + data.data.result[i].shoptype + '</td>';
						//if (data.data.result[i].auditstatus == 0) {
						//	tab += '<td>未审核</td>';
						//} else if (data.data.result[i].auditstatus == 1) {
						//	tab += '<td>审核通过</td>';
						//} else if (data.data.result[i].auditstatus == 2) {
						//	tab += '<td>审核未通过</td>';
						//} else {
						//	tab += '<td>删除</td>';
						//}
						if (data.data.result[i].type == 1) {
							tab += '<td>直属经销商</td>';
						} else {
							tab += '<td>非直属经销商</td>';
						}
					 	tab += "<td><a href='javascript:void(0)' onclick='findAgentsUpDown(\""+data.data.result[i].agentsCode+"\")'>绑定</a></td>";
						tab += '<td>' + data.data.result[i].balance + '</td>';
						tab += '<td>' + data.data.result[i].bail + '</td>';
						tab += '<td>' + data.data.result[i].balanceAlarm + '</td>';
						tab += '<td>' + data.data.result[i].mobile_phone + '</td>';
						tab += "<td style='font-size:9px;'>" + data.data.result[i].registeredtime + '</td>';
						tab += '</tr>';
					}
					if (tab != '') {
						$("#dataTable").html(tab);
					} else {
						$("#dataTable").html( '<tr><td colspan="11">没有符合条件的记录！</td></tr>');
					}
					$("#dataTable tr").hover(function() {
						$(this).addClass("tbover");
					}, function() {
						$(this).removeClass("tbover");
					});
					//加入分页的绑定
				
					var current_page = pageno - 1;
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
function setValue(value){
	$("#timeUnit").val(value);
}

function findAgentsUpDown(agentsCode) {
var url = "<%=basePath%>jsp/agentsBingOTP.jsp?agentsCode="+agentsCode;
	var title = "绑定动态口令";
	var width = 550;
	var height = 250;
	parent.LightBox(url, title, width, height);
}
</script>
</head>

<body>
<div class="main">
<input  type="hidden" id="timeUnit" />
<input  type="hidden" id="type" />

<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
         
        <div class="nyRight">
          <div class="nyTit">下级</div>
          <div class="gamenamebox">
             <jsp:include page="memberManagerTitle.jsp" >
			  <jsp:param name="num" value="0" /> 
			</jsp:include>
            <div class="gamename">
	              <div class="spcxtj" id="con_spcx_1">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz" style="width: 25%;">代理商：</td>
						    <td style="width: 25%;">
							    <select name="userid" class="input6" id="userid" class="userid">
							      <option>——全部——</option>
							    </select>
						    </td>
						    <td  style="width: 25%;"></td>
						    <td style="width: 25%;"></td>
						  </tr>
						  <tr class="show">
						    <td class="wz">注册时间段：</td>
						    <td>
						    <span>(<label style="color: blue;width: 86px;"  onclick="changeTimePanel('1');"> 手动选择时间 </label>)</span>
						    </td>
						      <td></td>
						    <td></td>
						  </tr>
						  <tr class="hide" style="display: none;">
						    <td class="wz">注册时间段：</td>
						    <td>
						    <span>(<label style="color: blue;width: 86px;"  onclick="changeTimePanel('2');"> 自动选择时间 </label>)</span>
						    </td>
						      <td></td>
						    <td></td>
						  </tr>
						  <tr class="show">  
						  	<td></td>
						    <td class="time" colspan="2">
								<ul >
								<li><a href="javascript:void(0)"  class="select"  onclick="setValue('-1')">全部</a></li>
								<li><a href="javascript:void(0)" onclick="setValue('0')">当天</a></li>
								<li><a href="javascript:void(0)" onclick="setValue('1')">当月</a></li>
								<li><a href="javascript:void(0)" onclick="setValue('2')">最近一周</a></li>
								<li><a href="javascript:void(0)" onclick="setValue('3')">最近一月</a></li>
								<li><a href="javascript:void(0)" onclick="setValue('4')">最近三月</a></li>
								</ul>
						     </td>
						    <td></td>
						  </tr>
						  <tr class="hide" style="display: none;">  
						  	<td></td>
						    <td class="time" colspan="2">
							 <input type="text" id="agentstarttime" name="agentstarttime" style="width: 140px;height: 25px;" 
							class="Wdate middle" value="" 
							onFocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
							<span>至</span>
						<input type="text" id="agentendtime" name="agentendtime" class="Wdate middle" style="width: 140px;height: 25px;" 
						value=""
						onFocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
						     </td>
						    <td></td>
						  </tr>
						  <tr>
						    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" onclick="agentsManager(1)" value="查询" /></td>
						    </tr>
						</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="348" class="wz">代理商编号</td>
	                    <td width="348" class="wz">代理商名称</td> 
	                    <td width="348" class="wz">店铺类型</td>
	                     <%--<td width="348" class="wz">审核状态</td>
	                    --%><td width="348" class="wz">类别</td> 
	                    <td width="348" class="wz">动态令牌</td>
	                     <td width="348" class="wz">信用点余额（元）</td>
	                    <td width="348" class="wz">保障金（元）</td>
	                    <td width="348" class="wz">余额告警（元）</td>
	                    <td width="348" class="wz">手机号</td>
	                    <td width="348" class="wz">注册时间</td>
	                  </tr>	
	                  <tbody id="dataTable" style="text-align: center">
		                  <tr>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                    <td>&nbsp;</td>
		                  </tr>
					  </tbody>
					  <td colspan="10" align="center" id="selectfactor">
							请选择查询条件
						</td>
	                </table>
	              </div>
	              <div id="pages">
					<div id="Pagination" class="pagination"></div>
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
