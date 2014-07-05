<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	
		<script type="text/javascript" language="javascript"
			src="${path}js/common/jquery-1.8.0.min.js">
</script>-->
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
	$("#supplierForm").validate( {
		rules : {
			supplierNumber :{
				required : true,
				digits:true
			}
		},
		messages : {
			supplierNumber : {
				required :"请输入商品数量!",
				digits:	"数量必须是正整数"
			}
		}
	});
});


	function supplierSave() {
	if ($.trim($("#supplierNumber").val()) == "") {
		alert("请输入商品${title}申请数量!");
		return false;
	}
	var re = /^[1-9]\d*$/;
	var supplierNumber =  $.trim($("#supplierNumber").val());
	if (!re.test($.trim($("#supplierNumber").val()))) {
		alert("申请 ${title}数量必须是正整数!");
		return false;
	}
	var CurrentStockNumber= ${CurrentStockNumber};
	var type= '${type}';
	if(type=="cancel"){
		if(supplierNumber>CurrentStockNumber){
			alert("退货数量必须小于当前库存!");
			return false;
		}
	}
	if (confirm("确认提交${title}申请!")) {
		$.ajax( {
			type : "post",
			async : false,
			url :  "<%=basePath%>supplier/supplierApplication.do",
			dataType : "json",
			data:{"message":$("#message").val(),"supplierNumber":$("#supplierNumber").val(),"goodsCode":$("#hidden_goods_code").val(),"type":type},
			success : function(datas) {
				if(datas.retcode=="1"){
					alert(datas.message);
				}else{
					alert(datas.message);
				}
			},
			error : function(e) {
				alert("进货申请失败"+e.status);
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
}
 
</script>

	</head>

	<body>
		<input style="display: none" id="hidden_goods_code" name="hidden_goods_code" value="${goodsCode}"/>
		<input style="display: none" id="cagentcode" name="cagentcode" value="${agentCode}"/>
		<input style="display: none" id="agentname" name="agentname" value="${agentName}"/>
		<input type="hidden"  id="type" name="type" value="${type}"/>
		<form id="supplierForm" method="post" action="">
			<table width="60%" class="suppliertable">
				<tr>
					<td rowspan="3" align="center" width="15%">
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
				<td colspan="3" >
				<div id="line"></div>
				</td>
				</tr>
				<tr>
					<td rowspan="3" align="center">
						上级代理商  
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
						上级库存数量：
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
						代理商信息
					</td>
					<td class="fontstyle">
						可用信用点：
					</td>
					<td align="left">
						${canUserPoint}
					</td>
				</tr>
				
			</table>
			
			<ul style="width: 100%; margin-top: 20px;" >
				<li style="width: 30%; margin-left: 10px;" class="supplierli">
					<label> 批价(元):</label>${batchPrice}
				</li>
				<li style="width: 40%;" class="supplierli">
					 <label for="supplierNumber">
								${title }数量：
							</label>
					 <input style="width: 100px;" onkeyup="if(value.match(/^\d{3}$/))value=value.replace(value,parseInt(value/10));value=value.replace(//./d*/./g,'.')"  type="text" id="supplierNumber"  onKeyPress="if((event.keyCode<48 || event.keyCode>57) && event.keyCode!=46 && event.keyCode!=45 || value.match(/^\d{10}$/) || /\.\d{2}$/.test(value)){event.returnValue=false}" name="supplierNumber"/>
				</li>
				<li style="width: 25%;" class="supplierli">
					<input style="color: green; width: 50px;" class="small"
						type="button" id="submitbtn" value="申请"  onclick="supplierSave();"/>
					<a href="javascript:void(0)" onClick="javascript:closeWinNoLoad();"><span>关闭</span>
					</a>
				</li>
			</ul>
		<ul style="width: 100%; margin-top: 20px;" >
				<li style="width: 30%; margin-left: 10px;" class="supplierli">
				</li>
				<li style="width:50%;" class="supplierli">
					 <label for="supplierNumber">
								留言：
							</label>
					 <input style="width: 150px;" id="message" name="message"/>
				</li>
			</ul>
		</form>
	</body>
</html>
