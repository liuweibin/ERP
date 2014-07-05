<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>My JSP 'myAccount.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" type="text/css"
			href="${ctx}/themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"
			href="${ctx}/themes/sales/home/esales.style.css">
			
		<link href="${ctx}/themes/common/button.css" rel="stylesheet"			type="text/css" />
			<script type="text/javascript" language="javascript"
			src="${ctx}/js/jquery.min.js">
</script>
		
		<script type="text/javascript" language="javascript"
			src="${ctx}/js/jquery.tableui.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.pagination.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/thickbox.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.form.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.validate.min.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.metadata.js">
</script>
<script src="${ctx}/js/My97DatePicker/WdatePicker.js"
			type="text/javascript">
</script>
		<script type="text/javascript">
var pageno = 1;     
  function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1;
	processData(pageno_id);
	return false;
  }
  
function ecode(value){
	return encodeURI(encodeURI(value));
}

function del() {
	return confirm('是否确认删除?');
}

function processData(pageno) {
	parent.resetTime(); 
	queryString = "&starttime=" +  $("#starttime").val() + "&endtime="
			+  $("#endtime").val() +  "&pageno=" + pageno + "&pagesize=" + $("#pagesize").val();
	$
			.ajax( {
				type : "POST",
				url : "informationManage.do?type=sendMessagedate",
				cache : false,
				timeout : 15000,
				data : queryString,
				dataType : 'json',
				error : function(request) {
					alert("Connection error");
				},
				success : function(data) {
					var total=0;
					var pageno=0;
					var pagesize;
					$("#selectsendfactor").css("display", "none");
					var tab = '';
					for ( var i = 0; i < data.length; i++) {
						total=data[i].totalCount;
						pagesize=data[i].pageSize;
						pageno=data[i].pageNo;
						tab += '<tr>';
						tab += '<td>' + data[i].agentsCode + '</td>';
						tab += '<td>' + data[i].title + '</td>';
						tab += '<td>' + data[i].content + '</td>';
						//tab += '<td>' + data[i].status + '</td>';
						tab += '<td>' + data[i].sendTime + '</td>';
						tab += '<td><a href="informationManage.do?type=senddelete&id='+data[i].id+'" onclick="return del();"><span style="color: #ff4500;">删除</span></a></td>';
						tab += '</tr>';
					}
					if (tab != '') {
						$("#senddataTable").html(tab);

					} else {
						$("#senddataTable").html(
								'<tr><td colspan="11">没有符合条件的记录！</td></tr>');
					}
					$("#senddataTable tr").hover(function() {
						$(this).addClass("over");
					}, function() {
						$(this).removeClass("over");
					});
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
$(document).ready(function() {
	parent.resetTime(); 
		processData(0);
	$("#sendQueryBtn").click(function() {
			var startTime = document.getElementById("starttime").value;
		var endTime = document.getElementById("endtime").value;
		startTime = startTime.replace(/-/g, "/");
		endTime = endTime.replace(/-/g, "/");
		var d1 = new Date(startTime);
		var d2 = new Date(endTime);
		if (d2.getTime() - d1.getTime() < 0) {
			alert("时间有错，起始时间不能大于结束时间！");
			return false;
		}
		processData(0);
	});
});

$(document).ready(
		function() {
			$("input[type=radio]").click(
					function() {
						var name = ($(this).attr('name'));
						var id = ($(this).attr('id'));

						$("input[type=radio][name=" + name + "]").parent()
								.removeClass('checkLab');

						$("#" + id).parent().addClass('checkLab');
					});
		});
	
</script>


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

.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}

</style>

	</head>

	<body>
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab"
						style="width: 100%; height: 30px">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="javascript:void(0)" title="消息中心" rel="1">消息中心</a>
								</li>

							</ul>
						</div>
						<div id="tabCot">

							<div style="" id="autoTime">

								<div class="block">

									<%--<div class="blockcommon">
									--%>
									<div class="subnav">
										<a href="informationManage.do?type=IfMessage" target="_self"
											class="current"> <span>收件箱</span> </a>
										<a href="informationManage.do?type=sendMessage" target="_self"> <span>发件箱</span>
										</a>
										<a href="${ctx}/informationManage.do?type=writeMessage" target="_self"> <span>发消息</span>
										</a>
										</div>

								</div>
							</div>


							<div class="clear"></div>
						</div>

						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>
					</div>

					<%-- form页面 --%>
					<div style="color:red">${fail}</div>
					<form name="queryFrm1" id="queryFrm1" method="post">
				<!-- 
				<div class="blockcommon pusht mp ">
					<div class="" id="queryDate">
					</div>
				</div>
				 -->
				<div class="blockcommon pusht">
				<li style="width: 100%">
			
			<div id="selectHandTime">
				<label>
					发送时间：
				</label>
				<input  id="begin_Date" name="start" type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_Date\')}' ,minDate:'#F{$dp.$D(\'end_Date\',{M:-3})||\'%y-%MM-%d\'}'})"   style="height:15px; width:80px; font-size:10pt; display: none"/>
				 <input id="starttime" name="starttime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>
				至<input id="endtime" name="endtime" class="Wdate middle" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_Date\')}',maxDate: '#F{$dp.$D(\'begin_Date\',{M:3})||\'%y-%MM-%d\'}'})"  style="width:140px;"/>		
						
			</div>
		</li>
		</div>
				<div class="blockcommon pusht">
					<strong>每页显示数量：</strong>
					<span> <select name="pagesize" id="pagesize">
							<option value="10">
								10
							</option>
							<option value="15" selected="selected">
								15
							</option>
							<option value="20">
								20
							</option>
							<option value="25">
								25
							</option>
							<option value="30">
								30
							</option>
						</select>
			<input type="button" id="sendQueryBtn"   class="Partorange" value="查询"/>
					  </span>
				</div>
		<table class="tablelist pusht">
			<tr>
				<th>
					接收代理商
				</th>
				<th>
					消息标题
				</th>
				<th>
					消息内容
				</th>
				<th>
					发送时间
				</th>
				<th>
					操作
				</th>
			</tr>
			<tbody id="senddataTable" align="center"></tbody>
			<td colspan="11" align="center" id="selectsendfactor">
					请选择查询条件
				</td>
		</table>
   <!--  <a href='#' onclick='$.message.delMsg();'><span style="color: #ff4500;">删除消息</span></a>
	分页开始 -->
	<div id="pages">
	<div id="Pagination" class="pagination"></div>
	</div>
	<!-- 分页结束 -->				
</form>
				</div>
			</div>


			<div class="clear"></div>
		</div>
		</div>
		<div class="noprint">
			<script type="text/javascript" language="jscript">
function tab(o, s, cb, ev) {//tab切换类
	var $ = function(o) {
		return document.getElementById(o)
	};
	var css = o.split((s || '_'));
	if (css.length != 4)
		return;
	this.event = ev || 'onclick';
	o = $(o);
	if (o) {
		this.ITEM = [];
		o.id = css[0];
		var item = o.getElementsByTagName(css[1]);
		var j = 1;
		for ( var i = 0; i < item.length; i++) {
			if (item[i].className.indexOf(css[2]) >= 0
					|| item[i].className.indexOf(css[3]) >= 0) {
				if (item[i].className == css[2])
					o['cur'] = item[i];
				item[i].callBack = cb || function() {
				};
				item[i]['css'] = css;
				item[i]['link'] = o;
				this.ITEM[j] = item[i];
				item[i]['Index'] = j++;
				item[i][this.event] = this.ACTIVE;
			}
		}
		return o;
	}
}
tab.prototype = {
	ACTIVE : function() {
		var $ = function(o) {
			return document.getElementById(o)
		};
		this['link']['cur'].className = this['css'][3];
		this.className = this['css'][2];
		try {
			$(this['link']['id'] + '_' + this['link']['cur']['Index']).style.display = 'none';
			$(this['link']['id'] + '_' + this['Index']).style.display = 'block';
		} catch (e) {
		}
		this.callBack.call(this);
		this['link']['cur'] = this;
	}
}

new tab('tabCot_product-li-currentBtn-', '-');
</script>
		</div>

	</body>
</html>