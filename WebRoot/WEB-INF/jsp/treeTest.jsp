<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
<base href="<%=basePath%>">
		<title>My JSP 'treeTest.jsp' starting page</title>
		<link  rel="stylesheet" type="text/css"         href="${ctx}/js/tree/jquery.tree.css"/>
		<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" language="javascript"    src="${ctx}/js/tree/js/jquery.tree.js"></script>
		
<style type="text/css">
	.bbit_tree_node_cb_span_s{
background: blue;
}

.bbit_tree_node_cb_span_c{
background: white;
}
</style>
<script type="text/javascript">
$().ready(function(){
		var o = {
				theme: "bbit-tree-lines", //三种风格备选bbit-tree-lines ,bbit-tree-no-lines,bbit-tree-arrows
				showcheck : true,
				cascadecheck: true,//是否启用级联
				theme : "bbit-tree-lines", //bbit-tree-lines ,bbit-tree-no-lines,bbit-tree-arrows
				icons : [ "radio_0.gif", "radio_1.gif", "checkbox_2.gif" ],
				oncheckboxclick : function(item) {
					//$("#tree").clear();
					var s = item.checkstate != 1 ? 1 : 0;
					$("#tree").nodeclick(item, s);
					clickCheckedNode(item.checkstate);
					return true;
				}
			};
		$.ajax({
			url : '${ctx}/empManage.do?type=queryResourceTree',
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
			},error:function(e){alert(e.status)}
		});
	
		$("#showchecked").click(function(e) {
			var s = $("#tree").getTSVs();
			if (s != null)
				alert(s.join(","));
			else
				alert("NULL");
		});
});


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
</script>

	</head>
	<body>
		
					
<div style="border-bottom: #c3daf9 1px solid; border-left: #c3daf9 1px solid; width: 250px; height: 500px; overflow: auto; border-top: #c3daf9 1px solid; border-right: #c3daf9 1px solid;">
	<div id="tree">
	
	</div>
</div>

	</body>
</html>