<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>My JSP 'empGroupManage.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">
		<script type="text/javascript" language="javascript"			src="${ctx}/js/common/jquery-1.8.0.min.js"></script>
		<script type="text/javascript">
$(document).ready(function() {
	$(".tablelist tr").hover(function() {
		$(this).addClass("over");
	}, function() {
		$(this).removeClass("over");
	});
	queryEmpgroup();
});
function deleteEmpGroup(id){
$.ajax({
		url:'empManage.do?type=deleteEmpGroup',
		dataType:'json',
		type:'post',
		data:{'id':id},
		success:function(data){
		if(data=='100'){
			alert('员工组删除成功');
			queryEmpgroup();
		}else if(data=='101'){
			alert("删除失败！请重试");
		}else if(data=='102'){
		alert("该组员工数不为空，不能删除！");
		}
		},
		error:function(error){alert(error.status);}
	});

}
function queryEmpgroup(){
	var tbody ='';
	var groupId = $('#groupId').val();
	$.ajax({
		url:'empManage.do?type=queryEmpGroup',
		dataType:'json',
		type:'post',
		success:function(data){
		$(".tablelist tbody").empty();
		$.each(data,function(i,attr){
			tbody += "<tr>"; 
			tbody += "<td  style='display: none'>"+attr.groupCode+"</td>"; 
			tbody += "<td>"+attr.groupName+"</td>"; 
			tbody += "<td>"+attr.remark+"</td>"; 
			tbody += "<td>"+attr.createTime+"</td>"; 
		    tbody+='<td  style="text-align: center;">';
		    if(attr.agentsCode=='-1'||attr.agentsCode=='-2'||attr.id==groupId){
		    tbody+='<a href="javascript:void(0)" onclick="javascript:alterEmpGroup('+"'query',"+"'"+attr.id+"'"+');"><span style="color: #ff4500;">查看</span></a>';
		    }else{
		    tbody+='<a href="javascript:void(0)" onclick="javascript:alterEmpGroup('+"'edit',"+"'"+attr.id+"'"+');"><span style="color: #ff4500;">编辑 </span></a>';
	  	    tbody+='<a href="javascript:void(0)"  onclick="javascript:deleteEmpGroup('+"'"+attr.id+"'"+');"><span style="color: #ff4500;"> 删除</span></a>';
		    }
		    tbody+= "</td>";
			tbody += "</tr>"; 
		});
		$(".tablelist tbody").html(tbody);
		
		$(".tablelist tr").hover(function() {
			$(this).addClass("over");
		}, function() {
			$(this).removeClass("over");
		});
		},
		error:function(error){alert(error.status);}
	});
}
/**
*添加、编辑员工组
*/
function alterEmpGroup(type,param){
		var title = "添加员工组";
		if(type == 'edit'){
			title ="编辑员工组";
		}else if(type=='query'){
			title ="查看员工组";
		}
		var url = "empManage.do?type="+type+"EmpGroupPage&id="+param;
		var width = 850;
		var height = 550;
		parent.LightBox(url, title, width, height);
	//	location.href = url;
}


</script>

<style type="text/css">

.tab #tabCot{padding:20px 15px 10px 15px;border-left:1px solid #d6d6d6;border-right:1px solid #d6d6d6;}
</style>

	</head>
	<body>
	<input type="hidden" id="groupId" value="${groupId}">
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab" style="width: 100%">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="${ctx}/empManage.do?type=empGroupPage" title="下属员工管理" rel="1">员工组管理</a>
								</li>

							</ul>
						</div>
						<div id="tabCot" >

							<div style="" id="autoTime">

								<div class="block">
									<form name="frm1" method="post">
				<table class="tablelist pusht"><thead>
					<tr>
						<th  style="display: none">
							员工组编码
						</th>
						<th>
							员工组名称
						</th>
						<th>
							备注
						</th>
						<th>
							创建时间
						</th>
						<th>
							编辑
						</th>
					</tr></thead>
				<tbody>
				
				</tbody>
				</table>
				<div class="tabletoolbar">
					<a href="javascript:void(0)" onClick="javascript:alterEmpGroup('add','');"><span style="font-size: 13px;">增加员工组</span>
					</a>
				</div>
		</form>
								</div>
							</div>


						</div>
						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>
					</div>

				</div>
				
				
			</div>
		</div>
	</body>
</html>