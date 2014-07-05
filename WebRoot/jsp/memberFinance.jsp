<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
.time ul{width: 600px;}
.time ul li{float: left; list-style-type: none;margin: 0 15px;white-space:nowrap}
.select  {background-color: #C8E2B1;}

#queryDate{padding-left: 10px;}
#queryDate label{display: none;}
</style>
<script language="javaScript">
var pageno = 1;     
var pagesize = 10;
function pagestreamCallback(page_id, jq){
	 var pageno_id=page_id+1;
	streamquery(pageno_id);
	return false;
 }
$(function(){
     init();
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
     
     
	$(".financeType ul li a").click(function (e) {
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
	$(".isShow ul li a").click(function (e) {
		var className	= $(this)[0].className;
		var id	= $(this)[0].id;
			if(className=="select"){
					 $(this).removeAttr("class");
			}else{
					 $(this).addClass("select");
			}
    });
	$(".financeType ul li a").addClass("select");
	
	//streamquery(1);
})



function streamquery(pageno){
			var url_ = "<%=basePath%>agentsManage.do?type=agentFinance&";
		
								url_ += bindStreamData();
								url_ += "&pageno=" + pageno;
								url_ += "&pagesize=" + pagesize;
									$.ajax( {
												cache : true,
												type : "POST",
												async : false,
												url : url_,
												dataType : 'json',
												error : function(request) {
													$("#dataStreamTable").html('<tr><td colspan="11" class="red">查询出错，请刷新后重试！</td></tr>');
												},
												success : function(datas) {
												var page=datas.data;
												var data=page.result;
													var total = page.totalCount;
													var pageno = page.pageNo;
											    	var pagesize;
													var tab = '';
													for ( var i = 0; i < data.length; i++) {
														total=data[i].totalCount;
														pagesize=data[i].pageSize;
														pageno=data[i].pageNo;
														tab += '<tr>';
														tab += '<td class="content_0" style="display:none">' + data[i].serial + '</td>';
														tab += '<td >' + data[i].code + '</td>';
														if(data[i].type==1){
															tab += '<td style="color:purple;">转入</td>';
														}else if(data[i].type==2){
															tab += '<td style="color:purple;">转出</td>';
														}else if(data[i].type==3){
															tab += '<td style="color:purple;">充值</td>';
														}else if(data[i].type==4){
															tab += '<td style="color:purple;">消费</td>';
														}else if(data[i].type==5){
															tab += '<td style="color:purple;">扣点</td>';
														}else if(data[i].type==6){
															tab += '<td style="color:purple;">加点</td>';
														}else if(data[i].type==7){
															tab += '<td style="color:purple;">返点</td>';
														}else if(data[i].type==8){
															tab += '<td style="color:purple;">加保证金</td>';
														}else if(data[i].type==9){
															tab += '<td style="color:purple;">减保证金</td>';
														}else if(data[i].type==10){
															tab += '<td style="color:purple;">还点</td>';
														}else if(data[i].type==11){
														tab+='<td style="color:purple;">退点</td>'
														}
														data[i].userName==null ? tab += '<td></td>' : tab += '<td>' + data[i].userName + '</td>';
														tab += '<td class="content_1" style="display:none">' + data[i].shoptype + '</td>';
														tab += '<td style="color: blue;">' + data[i].revenue + '</td>';
														tab += '<td style="color: red;">' + data[i].expenses + '</td>';
														tab += '<td style="color: green;">' + data[i].bail + '</td>';
														tab += '<td style="color: #ff4500;">' + data[i].balance + '</td>';
														tab +="<td style='font-size: 9px;'>" + data[i].createTime + '</td>';
														var remark  = data[i].remark;
														if(remark==null){
															tab += '<td class="content_2" style="display:none">11</td>';
														}else{
															tab += '<td class="content_2" style="display:none">'+remark+'</td>';
														}
														tab += '</tr>';
													}
													if (tab != '') {
														$("#dataStreamTable").html(tab);
													} else {
														$("#dataStreamTable") .html( '<tr><td colspan="11">没有符合条件的记录！</td></tr>');
													}
													$("#dataStreamTable tr").hover(
																	function() { $(this).addClass( "tbover");
																	},
																	function() { $(this).removeClass( "tbover");
																	});
													 //加入分页的绑定
														 var current_page=pageno-1;
														$("#Pagination").pagination(total, {
															callback: pagestreamCallback,
												            prev_text: '上一页',       //上一页按钮里text  
												            next_text: '下一页',       //下一页按钮里text  
												            items_per_page: pagesize,  //显示条数  
												            num_display_entries: 6,    //连续分页主体部分分页条目数  
												            current_page: current_page,   //当前页索引  
												            num_edge_entries: 2        //两侧首尾分页条目数  
														});

												}
											});
									parent.resetTime();   
}

function bindStreamData() {

	var conditions = "agentsCode=" + ecode($("#agents_code").val()) ;
	conditions += "&serial=" + $("#serial").val();
	conditions += "&financeType=" + getValue();
	conditions += "&startTime=" + $("#starttime").val();
	conditions += "&endTime=" + $("#endtime").val();
	return conditions;
		
}

function ecode(value) {
	return encodeURI(encodeURI(value));
}
function getValue(){
    var o = $(".financeType ul li a");
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
function showTitle(num){
	$(".title_"+num).toggle();
	$(".content_"+num).toggle();
}


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
			
				$("#agents_code").empty();
				//$("#agents_code_good").prepend("<option value='' selected>——全部——</option>");
				$.each(map, function(i, attr) {
					var key = i;
					var value = attr;
					$("#agents_code").prepend("<option value='"+key+"'>" +value + "</option>");
				});
				
			}
		},
		error : function(error) {
		 alert(error.status);
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
          <div class="nyTit">下级</div>
          <div class="gamenamebox">
           <jsp:include page="memberManagerTitle.jsp" >
			  <jsp:param name="num" value="1" /> 
			</jsp:include>
            <div class="gamename">
	              <div class="spcxtj" id="con_spcx_2">
	                             <form action="" class="queryForm" id="queryForm">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz" style="width: 30%">交易流水号：</td>
						    <td style="width: 25%"><input name="serial" type="text" class="input1" id="serial"/></td>
						     <td class="wz"style="width: 5%" >代理商：</td>
						    <td style="width: 45%">  
							    <select id="agents_code" name="agents_code"  class="input6">
								 <option value=""> 	---全部--- </option>
								</select>
							</td>
						  </tr>
						  <tr>
						  <td class="wz">时间：</td>
						  <td id="queryDate" colspan="2"></td>
						  <td></td>
						  </tr>
						   <tr class="sType financeType">  
						  	<td class="wz">类别：</td>
						       <td class="time" colspan="2">
								<ul >
								<li><a href="javascript:void(0)" id="all" name="-1"   >全部</a></li>
								<li><a href="javascript:void(0)" name="1"  >转出记录</a></li>
								<li><a href="javascript:void(0)" name="2"  >转入记录</a></li>
								<li><a href="javascript:void(0)" name="3"  >加点记录</a></li>
								<li><a href="javascript:void(0)" name="4"  >扣点记录</a></li>
								<li><a href="javascript:void(0)" name="5"  >消费</a></li>
								<li><a href="javascript:void(0)" name="6"  >充值</a></li>
								<li><a href="javascript:void(0)" name="7"  >下级返点</a></li>
								<li><a href="javascript:void(0)" name="8"  >加保障金</a></li>
								<li><a href="javascript:void(0)" name="9"  >减保障金</a></li>
								<li><a href="javascript:void(0)" name="10"  >还点</a></li>
								<li><a href="javascript:void(0)" name="11"  >退利</a></li>
								</ul>
						     </td>
						     <td></td>
						  </tr>
						   <tr class="sType isShow">  
						  	<td class="wz">是否显示：</td>
						       <td class="time" colspan="2">
								<ul>
								<li><a href="javascript:void(0)"  id="all" name="-1"  onclick="showTitle(0)"  >交易流水号</a></li>
								<li><a href="javascript:void(0)" name="0"  onclick="showTitle(1)">店铺类型</a></li>
								<li><a href="javascript:void(0)" name="1" onclick="showTitle(2)" >备注</a></li>
								</ul>
						     </td>
						     <td></td>
						  </tr>
						  <tr>
						    <td colspan="8" align="center">
						    <input name="button" type="button" class="an_input2" id="button" value="查询" onclick="streamquery(1);" />
						    <input name="button" type="submit" class="an_input2" id="button" value="重置" onclick="$('#queryForm')[0].reset();" />
						    </td>
						    </tr>
						</table></form>
	              
	              
	        
	              <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="248" class="wz title_0" style="display: none;">交易流水号</td>
	                    <td width="248" class="wz">变更编号</td>
	                    <td width="131" class="wz">交易类型</td>
	                    <td width="133" class="wz">用户名</td>
	                    <td width="133" class="wz title_1"  style="display: none;">店铺类型</td>
	                    <td width="116" class="wz">输入（元）</td>
	                    <td width="116" class="wz">支出（元）</td>
	                    <td width="166" class="wz">加减保障金（元）</td>
	                    <td width="116" class="wz">账户余额（元）</td>
	                    <td width="216" class="wz">时间</td>
	                    <td width="116" class="wz title_2"  style="display: none;">备注</td>
	                  </tr>
	        		<tbody id="dataStreamTable" style="text-align: center">
	        		
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
    </div>
    <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
