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

		<title>My JSP 'commonGoods.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
<link rel="stylesheet" type="text/css"			href="${path}themes/sales/home/of.global.100518.css">
<link rel="stylesheet" type="text/css"			href="${path}themes/sales/home/esales.style.css">
<style type="text/css">
body{margin:0; background:#666;list-type:none;}



</style>
<script type="text/javascript" language="javascript"			src="${path}js/common/jquery-1.8.0.min.js"></script>
<script type="text/javascript" language="javascript"			src="${path}js/jquery.tableui.js"></script>
<script type="text/javascript" language="JavaScript"			src="${path}js/jquery.pagination.js"></script>
<script type="text/javascript" language="JavaScript"			src="${path}js/members.js"></script>
<script type="text/javascript" language="JavaScript"			src="${path}js/thickbox.js"></script>
<script type="text/javascript" language="JavaScript"			src="${path}js/jquery.form.js"></script>

<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.validate.min.js" charset="UTF8"></script>
		<script type="text/javascript">
$(document).ready(function() {
	
	 $("#czForm").validate({
			meta: "validate",
		  submitHandler: function(form) {
			//alert("校验通过验证，不过我不给它提交");
		   cz()
		  }
		 });
						 
	// 手机号码验证   
	   jQuery.validator.addMethod("isMobile", function(val, element) {   
	     var length = val.length; 
	     var bo = this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/.test(val));
	     if(bo){
	    	 var result = isOk();
	    	 if(result==1){
	    		 $("#gamenoTip").text("号码不在可充值范围或号码信息未知");
	    		 return false;
	    	 }else{
	    		 $("#gamenoTip").text(result);
					    return true;
	    	 }
	     }else{
	    	 $("#gamenoTip").text("号码不在可充值范围或号码信息未知");
		     return bo;   
	     }
	   }, "");   
});

function isOk(){
	var gameno = $('#gameno').val();
	var result = '';
	if(gameno.length==11){
	 var bo = false;
	 $.ajax({
		 dataType:'json',
		 type:'post',
		 url:'goodsSales/verifyGameno.do',
		 async:false,
		 data:{'gameno':gameno},
		 success:function(datas){
					bo = true;  
				if(datas.retcode==1){
					result =  1;
				}else{
					result = datas.message;
					var data = datas.data;
					$("#carrierCode").val(data.carrierCode);
					$("#areaCode").val(data.areaCode);
					$("#areaName").val(data.areaName);
					$("#carrierName").val(data.carrierName);
					goodsPrice(data.carrierCode,data.areaCode);
				}
		 },error : function(error) {
				alert(error.status);
			}
	 });
	 
	   if(bo){
		   return result;
	   } 	
	}
}
function cz() {
	var parValue = $('input:radio:checked').val();
	var goodsCode = parValueId.split(',')[1];
	var gameno = $("#gameno").val();
	var carrierName = $("#carrierName").val();
	var carrierCode = $("#carrierCode").val();
	var areaName = $("#areaName").val();
	var areaCode = $("#areaCode").val();
	if (areaCode == ''||gameno == ''||carrierCode == ''||parValue=='') {
		alert("请填写充值号码");
	}else if (!goodsCode) {
		alert("请选择面值或没有可销售的商品");
	} else {
		var url = "goodsSales/mobile/SJCZ_info.do?carrierName="
				+ encodeURI(carrierName + "&areaName=" + areaName
						+ "&goodsCode=" + goodsCode + "&areaCode="
						+ areaCode + "&carrierCode="
						+ carrierCode+"&gameno="+gameno);
		$("#cz").attr('href', url);
	}
}
function goodsPrice(carrierCode,areaCode){
	$.ajax({
		url:'goodsSales/goodsPrice.do',
		dataType:'json',
		type:'post',
		data:{code:carrierCode,chargeZone:areaCode},
		success:function(datas){
			if(datas.retcode=="1"){
				alert(datas.message);
			}else{
				var praValue = $("#praValue");
				praValue.html(''); 
				var data = datas.data;
				$.each(data,function(i,attr){
					$("#praValue").append("<input type='radio' id='"+attr.goodsCode+"' class='money' name='money' value='"+attr.parValue/100.0+"'  />"+attr.parValue/100.0); 
				})
			}
		},
		error:function(e){
			alert("游戏商品加载出错"+e.status)
		}
	});
}
function cz_submit(){
	$("#czForm").submit();
}

</script>

<style type="text/css">
.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
	height: 600px;
}
#mobelCZ table ,.font{font-size: 24px;font-family: "微软雅黑" , "Arial Narrow";font-variant: inherit;color: #EE7621;font-weight:bold; }
#mobelCZ {height: 500px;margin: 10px 30px;text-align: center;}
#mobelCZ table tr td{float:left; margin:0 3px; list-style:none; border:0px solid #999; height:50px;  text-align:center; background:#FFF;}
#mobelCZ table {vertical-align: bottom;}
input[type="text"]{
height: 40px;width: 250px;vertical-align:middle;line-height:40px;     
overflow:hidden; font-size: 24px;font-family: "微软雅黑" , "Arial Narrow";font-variant: inherit;color: #EE7621;font-weight:bold; 
float: left;
 }

table{margin-top: 30px;width: 650px;}
table lable{float: right;}
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
									<a href="javascript:void(0)" title="手机充值" rel="1">手机充值</a>
								</li>

							</ul>
						</div>
						<div id="tabCot">
							<div style="border: 1px solid #dadada;" id="mobelCZ">
							<form id="czForm">
									<input type="hidden" name="loginType" value="0">
									<input type="hidden" name="goodsName" value="">
									<input type="hidden" name="goodsCode" value="">
									<input type="hidden" id="carrierCode" name="carrierCode" value="">
									<input type="hidden" id="areaCode" name="areaCode" value="">
									<input type="hidden" id="areaName" name="areaName" value="">
									<input type="hidden" id="carrierName" name="carrierName" value="">
								<table>
									<tr style="">
										<td style="width: 40%;"><lable>手机号码:</lable></td>
										<td  style="width: 60%;padding: auto 0;">
												<input type="text" class="{validate:{required: true,isMobile: true,  messages:{required:'请输入手机号'}}}" maxlength="11"  id="gameno">
												<span id="gamenoTip" style="color: red;float: right;font-size: 12px;"></span>
										</td>
									</tr>
									<tr>
										<td  style="width: 40%;"><lable>确认手机号码:</lable></td>
										<td  style="width: 60%;">
										<input type="text"   class="{validate:{required: true, equalTo:'#gameno',messages:{required:'',equalTo:'两次号码不一致'}}}" maxlength="11"  id="gamenoD">
														<span id="gamenoDTip" style="color: red;float: right;font-size: 9px;"></span>
										</td>
									</tr>
									<tr style="white-space: nowrap;">
										<td  style="width: 40%;"><lable>面值:</lable></td>
										<td  style="width: 60%; white-space: nowrap;"  id="praValue"  >
										</td>
									</tr>
									<tr>
										<td colspan="2" style="text-align: inherit;">
										<a href="javascript:void(0)"  id="cz" onclick="$('#czForm').submit();">点此充值&gt;&gt;</a>
										</td>
									</tr>
								</table>
								</form>
							</div>
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
		</div>
	</body>
</html>