<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<style type="text/css">
.checkLab {
	background: #dc143c;
	color: #fff;
	padding-top: 3px;
	padding-bottom: 3px;
	height: 25px;
	line-heigth: 25px;
	border: 1px solid #f0e68c;
}

#tabCot_product_1{
border-left:1px solid #d6d6d6;
border-right:1px solid #d6d6d6;
}
 #count{height:74px; float:left;}   
 #count ul{ width:800px;}   
 #count li{ width:400px; float:left; display:block;}  
 #databuyTable tr td{
 
 height: 35px;
 }
</style>

<script type="text/javascript">
var pageno = 1;     
 var pagesize = 10; 
  function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1
	querycredit(pageno_id);
	return false;
  }
$(document).ready(function() {
	parent.resetTime();   
	//querycredit(0);	
	$('#bySumbit').click(function() {
		var startTime = document.getElementById("buystarttime").value;
		var endTime = document.getElementById("buyendtime").value;
		startTime = startTime.replace(/-/g, "/");
		endTime = endTime.replace(/-/g, "/");
		var d1 = new Date(startTime);
		var d2 = new Date(endTime);
		if (d2.getTime() - d1.getTime() < 0) {
			alert("时间有错，起始时间不能大于结束时间！");
			return false;
		}
			querycredit(0);	
									});
});

function querycredit(pageno){
	var url_ = "accountRecord.do?type=buyCreditQuery&buyconditions=";
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
														tab += "<td style='font-size: 9px;'>" + data[i].createTime + '</td>';
														data[i].remark==null ? tab += '<td  class="content_2" style="display:none"></td>' : tab += '<td  class="content_2" style="display:none">' + data[i].remark + '</td>';
														tab += '</tr>';
													     document.getElementById("buyCount").innerHTML=data[i].sumpoint;
													}
													if (tab != '') {
														$("#databuyTable").html(tab);
														showList('remark',2);
														
													} else {
														$("#databuyTable")
																.html(
																		'<tr><td colspan="11">没有符合条件的记录！</td></tr>');
													}
													$("#databuyTable tr").hover(
																	function() {
																		$(this).addClass(
																						"over");
																	},
																	function() {
																		$(this).removeClass(
																						"over");
																	});
													
													// $("#databuyTable tr:even").addClass("alt");
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

														parent.document.getElementById("main").style.height= "900px";
														parent.document.getElementById("mmain").style.height= "900px";
												}
											});
									parent.resetTime();   
}

function buyStreamData() {
	 var buytemp=$("#tabCot_product_1").is(":visible");
	if(buytemp){
	var conditions = "tranType=serial";
	conditions += "||othercode=" + $("#tranTypeVal").val();
	conditions += "||financeType=" + buychk();
	conditions += "||startTime=" + $("#buystarttime").val();
	conditions += "||endTime=" + $("#buyendtime").val();
	return conditions;
	}
}

function buychk(){    
  var obj=document.getElementsByName("buyfinanceType");  
  var finacecheck='';    
  for(var i=0; i<obj.length; i++){ 
    if(obj[i].checked){ 
    	finacecheck+=obj[i].value+','; 
    	} 
  }
  return finacecheck.substring(0,finacecheck.length-1);
} 

function replace(str) {
	re = new RegExp("\"", "g");
	return str.replace(re, "'");
}

function ecode(value) {
	return encodeURI(encodeURI(value));
}


 function buyChkclick(chkid) {
    if (chkid == 0) {
        if ($("#buy_show_all").attr("checked") == true) {
            $("#buy_show_from1").attr("checked", "checked");
            $("#buy_show_to0").attr("checked", "checked");
            $("#buy_show_to1").attr("checked", "checked");
            $("#buy_show_to2").attr("checked", "checked");
            $("#buy_show_to3").attr("checked", "checked");
            $("#buy_show_to4").attr("checked", "checked");
            $("#buy_show_to5").attr("checked", "checked");
        } else {
            $("#buy_show_from1").removeAttr("checked");
            $("#buy_show_to0").removeAttr("checked");
            $("#buy_show_to1").removeAttr("checked");
            $("#buy_show_to2").removeAttr("checked");
            $("#buy_show_to3").removeAttr("checked");
            $("#buy_show_to4").removeAttr("checked");
            $("#buy_show_to5").removeAttr("checked");
        }
    } else {
        $("#buy_show_all").removeAttr("checked");
    }
}
 
 function showList(checkboxid,id) {
	if ( $("#"+checkboxid).attr("checked") == true ) {
		$(".title_"+id).show();
		$(".content_"+id).show();
	} else {
		$(".title_"+id).hide();
		$(".content_"+id).hide();
	}
}
 
 
 
</script>

<div id="tabCot_product_1" class="tabCot" style="width: 95%;">
							<div>
					<ul class="formul" style="margin-left: 10px;">
					<li>
						充值编号:
						<input type="text" name="tranTypeVal" id="tranTypeVal" value="" />
	           			 <input id="bySumbit"   type="button" class="Partorange" value="查询"/>
					</li>
				</ul>
				
			<div class="blockcommon pusht" style="margin-left: 10px;margin-right: 10px;">
			<li >
							<label>
								时间：
							</label>
					<input  id="begin_Date" name="start" type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_Date\')}' ,minDate:'#F{$dp.$D(\'end_Date\',{M:-3})||\'%y-%MM-%d\'}'})"   style="height:15px; width:80px; font-size:10pt; display: none"/>
			   		 <input id="buystarttime" name="buystarttime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
			   		至<input id="buyendtime" name="buyendtime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
					</li>
			</div>
			<div class="blockcommon pusht" style="margin-left: 10px;margin-right: 10px;">
				<strong>类别：</strong>
				<span> <input type="checkbox" id="buy_show_all" name="buy_show_all"
						class="showColumn" value=" " onclick="buyChkclick(0);"
						checked="checked" /> <label for="showallradio">
						全部
					</label> </span>
				<span> <input type="checkbox" id="buy_show_from1"
						name="buyfinanceType" class="showColumn" value="0"
						onclick="buyChkclick(1);" checked="checked" /> <label
						for="showturnradio">
						系统加点
					</label> </span>
				<span> <input type="checkbox" id="buy_show_to0" name="buyfinanceType"
						class="showColumn" value="1" onclick="buyChkclick(2);"
						checked="checked" /> <label for="showoutradio">
						银行汇款
					</label> </span>
					<span> <input type="checkbox" id="buy_show_to1" name="buyfinanceType"
						class="showColumn" value="2" onclick="buyChkclick(3);"
						checked="checked" /> <label for="showoutradio">
						借记卡
					</label> </span>
					<span> <input type="checkbox" id="buy_show_to2" name="buyfinanceType"
						class="showColumn" value="3" onclick="buyChkclick(4);"
						checked="checked" /> <label for="showoutradio">
						支付宝
					</label> </span>
					<span> <input type="checkbox" id="buy_show_to3" name="buyfinanceType"
						class="showColumn" value="4" onclick="buyChkclick(5);"
						checked="checked" /> <label for="showoutradio">
						财富通
					</label> </span>
					<span> <input type="checkbox" id="buy_show_to4" name="buyfinanceType"
						class="showColumn" value="5" onclick="buyChkclick(6);"
						checked="checked" /> <label for="showoutradio">
						通联
					</label> </span>
					<span> <input type="checkbox" id="buy_show_to5" name="buyfinanceType"
						class="showColumn" value="6" onclick="buyChkclick(7);"
						checked="checked" /> <label for="showoutradio">
						银联
					</label> </span>
			</div>
				<div class="blockcommon pusht" style="margin-left: 10px;margin-right: 10px;">
				<strong>是否显示：</strong>
				<span> <input type="checkbox" name="showtyperecord"
						id="remark" value="2"
						onclick="showList('remark',2);" /> <label
						for="remark">
						显示备注
				</label> </span>
			</div>
	<div style="width: 100%;" id="autoTime" >
		<div class="block" style="width: 100%;">
			<form name="frm1" method="post">
	<table class="tablelist pusht" style="margin-top: 20px; width: 100%;" >
		<tr style="width: 100%;">
						<th style="width: 10%;">
							充值编号
						</th>
						<th style="width: 9%;">
							交易类型
						</th>
						<th style="width: 15%;">
							购买金额（元）
						</th>
						<th style="width: 13%;">
							信用点余额（元）
						</th>
						<th style="width: 9%;">
							支付方式
						</th>
						<th style="width: 11%;">
							交易状态
						</th>
						<th style="width: 14%;">
							时间
						</th>
						 <th class="title_2" style="display: none" style="width: 10%;">
							    备注
						 </th>
		</tr>
		<tbody id="databuyTable" style="text-align: center">
		</tbody>
		<td colspan="12" align="center" id="selectbuyFactor">
					请选择查询条件
				</td>
	</table>
	</form>
								</div>
							</div>
	<div id="pages">
		<div id="Pagination" class="pagination"></div>
	</div>
	<div class="tabletoolbar" id="downlist" style="margin-top: -30px;">
			    <a href="#" onClick="downList();return false;"><span>导出列表</span></a>
	</div>
		<div class="blockcommon pusht" style="margin: 0px,10px,0px,10px;">
			<ul class="formul column2">
			<li style="width: 800px;margin-top: -20px;">
				<li style="width: 400px">
						<label>
							购买信用点总额：
						</label>
						<span id="buyCount" ></span>
				</li>
			</li>
			</li>
			</ul>
		</div>
							</div>
							<div class="clear"></div>
						</div>

