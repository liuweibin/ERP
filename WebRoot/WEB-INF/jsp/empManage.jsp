<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <base href="<%=basePath%>"/>
		<title>My JSP 'empManage.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link  rel="stylesheet"	type="text/css" href="<%=basePath%>themes/common/titletab.css"/>
		<link rel="stylesheet" type="text/css"		href="<%=basePath%>themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"		 href="<%=basePath%>themes/sales/home/esales.style.css">
		<script type="text/javascript" language="javascript"			src="<%=basePath%>js/common/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" language="javascript"			src="<%=basePath%>js/jquery.tableui.js"></script>
		<script type="text/javascript" language="JavaScript"			src="<%=basePath%>js/jquery.pagination.js"></script>
		<script type="text/javascript" language="JavaScript"			src="<%=basePath%>js/thickbox.js"></script>
		<script type="text/javascript" language="JavaScript"			src="<%=basePath%>js/jquery.form.js"></script>
		<script type="text/javascript" language="JavaScript"			src="<%=basePath%>js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="<%=basePath%>js/jquery.metadata.js"></script>
		<script type="text/javascript">
var pageno = 1; 
var pagesize = 15; 
  function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1;
	empData(pageno_id);
	return false;
  }

$(document).ready(function() {
		empData(0);
});
 function empData(pageno) {
	queryString ="&pageno=" + pageno + "&pagesize=" + pagesize;
	$.ajax( {
				type : "POST",
				url : "empManage.do?type=empManageQuery",
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
					var tab = '';
					for ( var i = 0; i < data.length; i++) {
						total=data[i].totalCount;
						pagesize=data[i].pageSize;
						pageno=data[i].pageNo;
						tab += '<tr>';
						tab += '<td>' + data[i].realName + '</td>';
						tab += '<td>' + data[i].username + '</td>';
						if(data[i].userType ==1){
							tab += '<td>普通操作员工</td>';
						}else{
							tab += '<td></td>';
						}
						tab += '<td>' + data[i].groupName + '</td>';
						if(data[i].status==1){
							tab += '<td>正常使用</td>';
						}else if(data[i].status==0){
							tab += '<td>冻结</td>';
						}
						tab += '<td>' + data[i].createTime + '</td>';
						//tab += '<td>' + data[i].remark + '</td>';
						tab += '<td colspan="2"><a href="<%=basePath%>user/tradePwd.do" style="color: #ff4500;" target="main">使用主帐号安全设置</a></td>';
						if(data[i].status==0){
							tab += '<td ><a href="javascript:void(0)" onClick="javascript:edit(\''+data[i].id+'\');"><span style="color: #ff4500;">修改权限</span></a><a href="empManage.do?type=empstatus&id='+data[i].id+'&statusid='+data[i].status+'" ><span style="color: #ff4500;">   解冻</span></a><a href="empManage.do?type=delete&id='+data[i].id+'"  onclick="return del();"><span style="color: #ff4500;">   删除</span></a></td>';
					
						}else if(data[i].status==1){
							tab += '<td ><a href="javascript:void(0)" onClick="javascript:edit(\''+data[i].id+'\');"><span style="color: #ff4500;">修改权限</span></a><a href="empManage.do?type=empstatus&id='+data[i].id+'&statusid='+data[i].status+'" ><span style="color: #ff4500;">   冻结</span></a><a href="empManage.do?type=delete&id='+data[i].id+'"  onclick="return del();"><span style="color: #ff4500;">   删除</span></a></td>';
						}
						tab += '</tr>';
					}
					if (tab != '') {
						$("#empdataTable").html(tab);
					} else {
						$("#empdataTable").html(
								'<tr><td colspan="15">没有员工记录！</td></tr>');
					}
					$("#empdataTable tr").hover(function() {
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
	$(".tablelist tr").hover(function() {
		$(this).addClass("over");
	}, function() {
		$(this).removeClass("over");
	});
});

function add() {
	var url = "empManage.do?type=empManageAdd";
	var title = "增加员工账号";
	var width = 600;
	var height = 500;
	parent.LightBox(url, title, width, height);
}
function edit(userid) {
	var url = "empManage.do?type=empManageEdit&empmanageid="+userid;
	var title = "修改员工权限";
	var width = 550;
	var height = 450;
	parent.LightBox(url, title, width, height);
}

function del() {
	return confirm('是否确认删除?');
}

function load(){ 
	　　parent.document.getElementById("main").style.height = window.document.body.clientHeight+"px"; 
    　} 
</script>

<style type="text/css">

.tab #tabCot{padding:20px 15px 10px 15px;border-left:1px solid #d6d6d6;border-right:1px solid #d6d6d6;}
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
									<a href="javascript:void(0)" title="下属员工管理" rel="1">下属员工管理</a>
								</li>

							</ul>
						</div>
						<div id="tabCot" >

							<div style="" id="autoTime">

								<div class="block">
								<div style="color:red">${fail}</div>
									<form name="frm1" method="post">
				<table class="tablelist pusht">
					<tr>
						<th>
							真实姓名
						</th>
						<th>
							登录名
						</th>
						<th>
							用户类型
						</th>
						<th>
							员工组
						</th>
						<th>
							状态
						</th>
						<th>
							添加时间
						</th>
						<th>
							IP绑定
						</th>
						<th>
							网卡绑定
						</th>
						<th>
							操作
						</th>
					</tr>
					<tbody id="empdataTable" align="center"></tbody>
					</table>
					<div id="pages">
					<div id="Pagination" class="pagination"></div>
					</div>
				<div class="tabletoolbar">
					<a href="javascript:void(0)" onClick="javascript:add();"><span style="font-size: 13px;">增加员工帐号</span>
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