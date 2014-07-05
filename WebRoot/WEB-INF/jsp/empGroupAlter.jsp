<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
<base href="<%=basePath%>">
		<title>My JSP 'empGroupAlter.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=basePath%>themes/common/titletab.css" rel="stylesheet"			type="text/css" />
		<link  rel="stylesheet" type="text/css"         href="<%=basePath%>js/tree/jquery.tree.css"/>
		
		<link href="<%=basePath%>themes/common/button.css" rel="stylesheet" />
		<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
		<script type="text/javascript" language="javascript"    src="<%=basePath%>js/tree/js/jquery.tree.js"></script>
		
<style type="text/css">
.bbit_tree_node_cb_span_s{
background: blue;
}

.bbit_tree_node_cb_span_c{
background: white;
}
</style>
		<script type="text/javascript">
$(document).ready(function() {
	var title = "${title}";
	if(title=='查看'){
		getTree("${groupRole.id}");
	}else{
		getTree("no");
	}
	

	$("#showchecked").click(function(e) {
		var s = $("#tree").getTSVs();
		if (s != null)
			alert(s.join(","));
		else
			alert("NULL");
	});

});
function getTree(groupId){
	var o = {
			showcheck : true,
			theme : "bbit-tree-lines", //bbit-tree-lines ,bbit-tree-no-lines,bbit-tree-arrows
			icons : [ "radio_0.gif", "radio_1.gif", "checkbox_2.gif" ],
			oncheckboxclick : function(item) {
				//$("#tree").clear();
				var s = item.checkstate != 1 ? 1 : 0;
				$("#tree").nodeclick(item, s);
				//clickCheckedNode(item.checkstate);
				return true;
			}
		};
	$.ajax( {
		url : 'empManage.do?type=queryResourceTree&groupId='+groupId,//&groupId=${groupRole.id}
		dataType:'json',
		type:'post',
		async:false,
		success : function(data) {
			var th = '';
			$.each(data,function(i,attr){
				th += attr.id;
			});
			o.data = data;
			$("#tree").treeview(o);
		}
	});
	
}
 
function bbit_tree_node_cb_span_o(this_,s){
	if(s==0){
		//bbit_tree_node_cb_span_o_c(this_);
	}
	if(s==1){
		//bbit_tree_node_cb_span_o_s(this_);
	}
}

function bbit_tree_node_cb_span_o_s(this_){
	$(this_).addClass("bbit_tree_node_cb_span_s");
}

function bbit_tree_node_cb_span_o_c(this_){
	$(this_).addClass("bbit_tree_node_cb_span_c");
}


/**
*添加员工组//'groupName':$("#groupName").val()
*/
function alterEmpGroup(id){
	if(!$("#groupName").val()){
		alert("员工组名称不能为空");
		return;
	}
	
	var chk_value = $("#tree").getTSVs();
	var temp = 'edit';
	var tempTitle = '编辑';
	
	if(!id){
		temp = 'add';
		tempTitle='添加';
	}
	 if(chk_value.length==0){
		 	alert("你还没有为改组添加任何权限！");
		 	return;
 	 }
 	  var operate_value = chk_value.toLocaleString();
	$.ajax({
		url:'empManage.do?type='+temp+'Group',
		dataType:'json',
		type:'post',
		//async:false,
		data:{'groupName':$("#groupName").val(),'remark':$('#remark').val(),'id':$("#id").val(),'roleIds':operate_value},
		success:function(data){
		if(data=='100'){
		alert(tempTitle+"成功！");
		}else if(data=='101'){
		alert(tempTitle+"失败！");
		};
		closeWinNoLoad();
		},error:function(error){
		alert(error.status);
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
		refresh_();
		tb_remove();
	}
}

  function refresh_(){
  main.location.href="<%=basePath%>empManage.do?type=empGroupPage";

}
</script>

<style type="text/css">
#empGroupForm tr td label{margin-bottom: 10px;
line-height: 25px;
height: 25px;
font-size: 12px;
font-weight: 400;
}
.tab #tabCot{padding:20px 15px 10px 15px;border-left:1px solid #d6d6d6;border-right:1px solid #d6d6d6;}
</style>

	</head>
	<body>
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab" style="width: 100%">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="javascript:void(0)" title="${title}员工组" rel="1">${title}员工组</a>
								</li>
							</ul>
						</div>
						<div id="tabCot" >
								<div class="block" style="float: right;width: 50%">
								<table>
									<form id="empGroupForm"> 
									<input type="hidden" name="id" id="id" value="${groupRole.id}"/>
									<tr>
										<td><label for="groupName" style="float: right;margin-right: 5px;">员工组名称:</label> </td>
										<td><input type="text" id="groupName" name="groupName" value="${groupRole.groupName}" /></td>
									</tr>
									<tr>
										<td><label for="remark" style="float: right;margin-right: 5px;">备注:</label> </td>
										<td><textarea id="remark" name="remark" >${groupRole.remark}</textarea></td>
									</tr>
									<tr style="text-align: center;margin-top: 6px;">
										<td colspan="2">
											<c:if test="${title!='查看'}">
									<input type="button"    id="sbutton"   value="${title}"  class="Partorange" onclick="alterEmpGroup('${groupRole.id}')" style="margin-top: 10px;">
											</c:if>
										</td>
									</tr>
									
									</form>
								</table> 
								</div>
						<div style="border-bottom: #c3daf9 1px solid; border-left: #c3daf9 1px solid; width: 250px; height: 500px; overflow: auto; border-top: #c3daf9 1px solid; border-right: #c3daf9 1px solid;float: left;">
									选择员工组权限
										<div id="tree">
										
										</div>
										</div>

						</div>

					</div>

				</div>
			</div>
		</div>
	</body>
</html>