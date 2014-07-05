<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>My JSP 'customUser.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" language="javascript"			src="${ctx}/js/jquery.tableui.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.pagination.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/thickbox.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.form.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.metadata.js"></script>
		<script type="text/javascript">
var pageno = 1; 
var pagesize = 15; 
  function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1;
	cusData(pageno_id);
	return false;
  }

  $(document).ready(function() {
	  parent.resetTime(); 
		cusData(0);
});
 function cusData(pageno) {
	 parent.resetTime(); 
	queryString ="&pageno=" + pageno + "&pagesize=" + pagesize;
	$ .ajax( {
				type : "POST",
				url : "customUser.do?type=customUserQuery",
				cache : false,
				timeout : 15000,
				data : queryString,
				dataType : 'json',
				error : function(request) {
					alert("Connection error");
				},
				success : function(data) {
					if(data.retcode=="1"){
						$("#cusdataTable").html('<tr><td colspan="14">查询出错！</td></tr>');
						return false;
					}
					
					var total = data.data.totalCount;
					var pageno = data.data.pageNo;
					var pagesize = data.data.pageSize;
					
					var tab = '';
					for ( var i = 0; i < data.data.result.length; i++) {
						tab += '<tr>';
						tab += '<td>' + data.data.result[i].agentsCode + '</td>';
						tab += '<td>' + data.data.result[i].customName + '</td>';
						tab += '<td>' + data.data.result[i].fixedPhone + '</td>';
						tab += '<td>' + data.data.result[i].mobilePhone + '</td>';
						tab += '<td>' + data.data.result[i].qq + '</td>';
						tab += '<td>' + data.data.result[i].email + '</td>';
						tab += '<td>' + data.data.result[i].address + '</td>';
						tab += '<td>' + data.data.result[i].integration + '</td>';
						tab += '<td>' + data.data.result[i].remark + '</td>';
						tab += '<td style="font-size:11px;">' + data.data.result[i].createTime + '</td>';
						tab += '<td ><a href="javascript:void(0)" onClick="javascript:edit('+data.data.result[i].id+');"><span style="color: #ff4500;">   编辑</span></a><a href="javascript:void(0)"  onclick="return dele('+data.data.result[i].integration+','+data.data.result[i].id+');"><span style="color: #ff4500;">   删除</span></a></td>';
						tab += '</tr>';
					}
					if (tab != '') {
						$("#cusdataTable").html(tab);

					} else {
						$("#cusdataTable").html(
								'<tr><td colspan="15">没有客户记录！</td></tr>');
					}
					$("#cusdataTable tr").hover(function() {
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
					parent.document.getElementById("main").style.height= window.document.body.clientHeight+20+"px";
				}
			});
}
		
  
function add() {
	var url = "${ctx}/customUser.do?type=customUserForm";
	var title = "增加客户";
	var width = 550;
	var height = 400;
	parent.LightBox(url, title, width, height);
}

function edit(customid) {
	var url = "customUser.do?type=customUserForm&customid="+customid;
	var title = "修改客户信息";
	var width = 550;
	var height = 400;
	parent.LightBox(url, title, width, height);
}

function integrationvConvert(customid){
	var url = "customUser.do?type=customUserIntegration&customid="+customid;
	var title = "积分兑换";
	var width = 450;
	var height = 250;
	parent.LightBox(url, title, width, height);
}



function dele(integration,id){
	var bo =false;
	if(integration!=null&&integration!=0){
		if(confirm('该客户具有积分明细记录,是否确认删除?')){
			bo=true;
		}
	}else{
		if(confirm('是否确认删除?')){
			bo=true;
		}
	} 
		if(bo)	ajax_dele(id);
}
function ajax_dele(id){
	$.ajax({
		url:"customUser.do?type=customUserDel&userid="+id,
		type:'post',
		dataType:'json',
		success:function(data){
			if(data.status=="1"){ 
				alert(e.status);
			}
				cusData(1);
		},error:function(e){
			alert("删除失败请重试（"+e.status+")");
			cusData(1);
		}
		
	});
}
function load(){ 
	　　parent.document.getElementById("main").style.height = window.document.body.clientHeight+"px"; 
}
</script>

<style type="text/css">
.tab #tabCot{padding:20px 15px 10px 15px;border-left:1px solid #d6d6d6;border-right:1px solid #d6d6d6;}
.block{padding: 10px 0}
</style>

	</head>

	<body onload="load()">
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab" style="width: 100%">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="${ctx}/customUser.do?type=customUser" title="客户管理" rel="1">客户管理</a>
								</li>

							</ul>
						</div>
						<div id="tabCot" >

							<div style="" id="autoTime">

								<div class="block">
								<form name="frm1" method="post">
									<table class="tablelist pusht" >
										<tr>
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
											<th style="text-align: center;" colspan="3">
												操作
											</th>
										</tr>
										<tbody id="cusdataTable" align="center"></tbody>
										</table>
											<div id="pages">
											<div id="Pagination" class="pagination"></div>
											</div>
										<div class="tabletoolbar">
											<a href="javascript:void(0)" onClick="javascript:add();"><span style="font-size: 13px;">增加客户信息</span>
											</a>
											</div>
									</form>
								</div>
							</div>


							<div class="clear"></div>
						</div>

						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>
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