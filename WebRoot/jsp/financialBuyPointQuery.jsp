<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String tabNum= request.getParameter("num");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
.time ul li{float: left; list-style-type: none;margin: 0 15px;}
.select  {background-color: #C8E2B1;}
#queryDate label{display: none;}
</style>
<script type="text/javascript">
var pageno = 1;     
var pagesize = 10; 
 function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1
	querycredit(pageno_id);
	return false;
 }
$(function(){
	$(".sType ul li a").click(function (e) {
		var className	= $(this)[0].className;
		var id	= $(this)[0].id;
			if(className=="select"){
				 if(id=="all"){
					 $(this).removeAttr("class").parent().siblings().find("a").removeAttr("class");
				 }else{
					 $(this).removeAttr("class");
					 $("#all").removeAttr("class");
				 }
			}else{
				 if(id=="all"){
					 $(this).addClass("select").parent().siblings().find("a").addClass("select");
				 }else{
					 $(this).addClass("select");
					 $("#all").removeAttr("class");
				 }
			}
    });
	$(".sType ul li a").addClass("select");
	init();
})
function init(){
	var dataPicker;
	var otherDay = '';
	if(''=='prv')
		otherDay = 'Yesterday';
	else// if(''=='cur')
		otherDay = 'Today';
	if(''!=''){
		if(''!='')
			dataPicker = new OfCard.DatePicker({title:'',endnum:'',otherDay:otherDay});
		else
			dataPicker = new OfCard.DatePicker({otherDay:otherDay});
	}else{
		if(''!='')
			dataPicker = new OfCard.DatePicker({title:'',otherDay:otherDay});
		else
			dataPicker = new OfCard.DatePicker({otherDay:otherDay});
	}
     dataPicker.initPicker();
}
function getValue(){
    var o = $(".sType ul li a");
    var re = "";
    $.each(o,function(i,element){
    	var className = $(element).attr('class');
    	var value = $(element).attr('name');
    	var id = $(element).attr('id');
    	if(className=="select"){
    		if(id=="all")return true;
    		re += value+",";
    	}
    })
    if(re!=""){ 
      re = re.substring(0, re.length-1);
    }
	//$("#financeType").val(re);
	return re;
}
function querycredit(pageno){
	var url_ = "<%=basePath%>accountRecord.do?type=buyCreditQuery&buyconditions=";
								url_ += buyStreamData();
								url_ += "&pageno=" + pageno;
								url_ += "&pagesize=" + pagesize;
									$.ajax( {
												cache : true,
												type : "POST",
												async : false,
												url : url_,
												dataType : 'json',
												error : function(request) {
													$("#databuyTable").html('<tr><td colspan="11" class="red">查询出错，请刷新后重试！</td></tr>');
													$("#selectbuyFactor").css("display","none");
												},
												success : function(data) {
													var total=0;
											    	var pageno=0;
											    	var pagesize;
													$("#selectbuyFactor").css("display","none");
													var tab = '';
													for ( var i = 0; i < data.length; i++) {
														total=data[i].totalCount;
														pagesize=data[i].pageSize;
														pageno=data[i].pageNo;
														tab += '<tr>';
														tab += '<td class="content_0" style="display:none">' + data[i].serial + '</td>';
														tab += '<td >' + data[i].otherCode + '</td>';
														if(data[i].type==6){
															tab += '<td style="color:purple;">加点</td>';
														}
														data[i].point==null ? tab += '<td></td>' : tab += '<td>' + data[i].point + '</td>';
														tab += '<td style="color: blue;">' + data[i].balance + '</td>';
														if(data[i].payment==0){
															tab += '<td style="color: red;">系统加点</td>';
														}else if(data[i].payment==1){
															tab += '<td style="color: red;">银行汇款</td>';
														}else if(data[i].payment==2){
															tab += '<td style="color: red;">借记卡</td>';
														}else if(data[i].payment==3){
															tab += '<td style="color: red;">支付宝</td>';
														}else if(data[i].payment==4){
															tab += '<td style="color: red;">财富通</td>';
														}else if(data[i].payment==5){
															tab += '<td style="color: red;">通联</td>';
														}else if(data[i].payment==6){
															tab += '<td style="color: red;">银联</td>';
														}else{
															tab += '<td style="color: red;"></td>';
														}
														if(data[i].status==0){
															tab += '<td style="color: #ff4500;">生成</td>';
														}else if(data[i].status==1){
															tab += '<td style="color: #ff4500;">成功</td>';
														}else if(data[i].status==2){
															tab += '<td style="color: #ff4500;">失败</td>';
														}else{
															tab += '<td style="color: #ff4500;"></td>';
														}
														tab += "<td style='font-size: 11px;'>" + data[i].createTime + '</td>';
														var remark = data[i].remark==null?"--":data[i].remark ;
														tab +="<td  class=/'content_2/' style=/'display:none/'>" + remark+ "</td>";
														tab += '</tr>';
													     //document.getElementById("buyCount").innerHTML=data[i].sumpoint;
													}
													if (tab != '') { 
														$("#databuyTable").html(tab);
													} else {
														$("#databuyTable") .html( '<tr><td colspan="11">没有符合条件的记录！</td></tr>');
													}
													$("#databuyTable tr").hover(
																	function() {
																		$(this).addClass( "over");
																	},
																	function() {
																		$(this).removeClass( "over");
																	});
													
														 //加入分页的绑定
														 var current_page=pageno-1;
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

function buyStreamData() {
	var conditions = "tranType=serial";
	conditions += "||othercode=" + $("#tranTypeVal").val();
	conditions += "||financeType=" + getValue();
	conditions += "||startTime=" + $("#starttime").val();
	conditions += "||endTime=" + $("#endtime").val();
	//tranType=serial||othercode=||financeType=0,1,2,3,4,5,6||startTime=||endTime=
	return conditions;
}

function reset_(){
	$("#queryForm")[0].reset();
	init();
} 
</script>
</head>
<body>
<div class="main">
<input id="financeType" type="hidden" value="0,1,2,3,4,5,6" name="financeType"/>

<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
        <div class="nyRight">
          <div class="nyTit">财务管理</div>
          <div class="gamenamebox">
              <jsp:include page="financialTitle.jsp" flush="false">
			 		 <jsp:param name="num" value="0" /> 
				</jsp:include>
            <div class="gamename">
	              <div class="spcxtj" id="con_subpcx_11">
	              <form action="" id="queryForm">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz">充值编号：</td>
						    <td> 
						    <input name="tranTypeVal" type="text" class="input1" id="tranTypeVal" />
						    </td>
						    <td></td>
						  </tr>
			   			 <tr>  
						 	 <td class="wz">时间：</td>
					   		<td id="queryDate" colspan="2"></td>
						  </tr>
			   			 <tr class="sType">  
						  	<td class="wz">类别：</td>
						       <td class="time" colspan="2">
								<ul>
								<li><a href="javascript:void(0)" id="all" name="-1"   >全部</a></li>
								<li><a href="javascript:void(0)" name="0"  >系统加点</a></li>
								<li><a href="javascript:void(0)" name="1"  >银行汇款</a></li>
								<li><a href="javascript:void(0)" name="2"  >借记卡</a></li>
								<li><a href="javascript:void(0)" name="3"  >支付宝</a></li>
								<li><a href="javascript:void(0)" name="4"  >财付通</a></li>
								<li><a href="javascript:void(0)" name="5"  >通联</a></li>
								<li><a href="javascript:void(0)" name="6"  >银联</a></li>
								</ul>
						     </td>
						  </tr>
						  <tr>
						    <td colspan="8" align="center">
						    <input name="button" type="button" class="an_input2" id="button" value="查询" onclick="querycredit(1)" />
						    <input name="button" type="button" class="an_input2" id="button" value="重置" onclick="reset_()" />
						    </td>
						    </tr>
						</table></form>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="200" class="wz">充值编号</td>
	                    <td width="131" class="wz">交易类型</td>
	                    <td width="133" class="wz">购买金额（元）</td>
	                    <td width="136" class="wz">信用点余额（元）</td>
	                    <td width="116" class="wz">支付方式</td>
	                    <td width="116" class="wz">交易状态</td>
	                    <td width="206" class="wz">时间</td>
	                    <td width="116" class="wz">备注</td>
	                  </tr>
	                
	                  	<tbody id="databuyTable" style="text-align: center">
		                  	  <tr>
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
