<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.01 transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'agentSupplier.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" language="javascript"
			src="${ctx}/js/jquery.min.js">
</script>
		
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.validate.min.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/thickbox.js">
</script>
<style type="text/css">
.suppliertable tr td{
font-size: 15px;
	height: 30px;
}

.fontstyle{
	color: #ff4500;
}
#line { 
	 border-bottom:solid 1px green; 
 	border-left:solid 1px gray; 
	 border-right:solid 1px blue; 
 	border-top:solid 1px red;
}
.supplierli {
	float:left;
	font-size: 15px;
}
</style>

<script type="text/javascript">
$().ready(function() {
});

/*
 * 供货退货处理
 */
	function handleOrder() {
	
	var applicationNumber =${applicationNumber};
	var stockNumber = ${stockNumber};
	var CurrentStockNumber= ${CurrentStockNumber};
	var type= '${type}';
	if(type=="0"){
		if(applicationNumber>CurrentStockNumber){
			alert("目前没有那么多货!");
			return false;
		}
	}else if(type=="1"){
		if(applicationNumber>stockNumber){
			alert("下级库存不足无法退货!");
			return false;
		}
	}
	if (confirm("确认提交审批${title}!")) {
		var supplyOrderNo = $("#supplyOrderNo").val();
		var type = $("#type").val();
		$.ajax( {
			type : "post",
			//cache : false,
			timeout:"120000",
			//async : false,
			url:'${ctx}/supplier/supplierAccepted.do',
			dataType : "json",
			data:{"supplyOrderNo":supplyOrderNo,"type":type},
			success : function(datas) {
				if(datas.retcode=="1"){
					alert(datas.message);
				}else{
					alert(datas.message);
				}
			},
			error : function(e) {
				if(e.status==0){
					alert("${title}审批超时,请查看记录"+e.status);
				}else{
					alert("${title}审批失败"+e.status);
				}
			}
		});
		closeWinNoLoad();
		}
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
		tb_remove();
	}
	refresh();
}

function refresh() {
	main.location.href = "<%=basePath%>supplier/supplierManageNew.do";
}
</script>

	</head>

	<body>
		<input style="display: none" id="supplyOrderNo" name="supplyOrderNo" value="${supplyOrderNo}"/>
		<input style="display: none" id="type" name="type" value="${type}"/>
		<form id="supplierForm" method="post" action="">
			<table width="60%" class="suppliertable">
				<tr>
					<td rowspan="4" align="center" width="15%">
						商品信息
					</td>
					<td width="20%" class="fontstyle">
						商品名称：
					</td>
					<td align="left" width="30%">
						${goodname}
					</td>
				</tr>
				<tr>
					<td width="20%" class="fontstyle">
						商品编号：
					</td>
					<td align="left" width="30%">
						${goodsCode}
					</td>
				</tr>
				<tr>
					<td width="20%" class="fontstyle">
						当前库存数量：
					</td>
					<td align="left" width="30%">
						${CurrentStockNumber}
					</td>
				</tr>
				<tr>
					<td width="20%" class="fontstyle">
						 面值(元)：
					</td>
					<td align="left" width="30%">
						${parValue} 
					</td>
				</tr>
				<tr>
				<td colspan="3" >
				<div id="line"></div>
				</td>
				</tr>
				<tr>
					<td rowspan="3" align="center">
						下级代理商  
					</td>
					<td class="fontstyle">
						代理商名称：
					</td>
					<td align="left">
						${agentName}
					</td>
				</tr>
				<tr>
					<td class="fontstyle">
						代理商编号：
					</td>
					<td align="left">
						${agentCode}
					</td>
				</tr>
					<tr>
					<td class="fontstyle">
						下级库存数量：
					</td>
					<td align="left">
						${stockNumber}
					</td>
				</tr>
				<tr>
				<td colspan="3" >
				<div id="line"></div>
				</td>
				</tr>
				<tr>
					<td rowspan="3" align="center">
						${title}申请信息
					</td>
					<td class="fontstyle">
						申请数量：
					</td>
					<td align="left">
						${applicationNumber}
					</td>
				</tr>
				
			</table>
			
			<div style="  margin-top: 20px;text-align: center;" >
					<input style="color: green; width: 50px;" class="small"
						type="button" id="submitbtn" value="审批"  onclick="handleOrder();"/>
					<a href="javascript:void(0)" onClick="javascript:closeWinNoLoad();"><span>关闭</span>
					</a>
			</div>
		</form>
	</body>
</html>
