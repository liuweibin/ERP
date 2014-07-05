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

		<title>编辑通联账号</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${ctx}/themes/common/button.css" rel="stylesheet" />	
		<script type="text/javascript" language="javascript"	src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" language="JavaScript"	src="${ctx}/js/thickbox.js"></script>
		<script type="text/javascript" language="JavaScript"		src="${ctx}/js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.metadata.js"></script>

		<script type="text/javascript">
jQuery.validator.addMethod("isMobile", function(value, element) {   
  var length = value.length;   
  return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(14[5]{1})|(14[7]{1}))+\d{8})$/.test(value));   
}, "请正确填写您的手机号码");   

$().ready(function() {
	$("#signupForm").validate( {
		rules : {
			acct : "required"
			/*mobile : "required"
			day_max_succ_cnt : "required",
			day_max_succ_amt : "required",
			mon_max_succ_cnt : "required",
			mon_max_succ_cnt : "required",
			agrdeadline : "required"*/
		},
		messages : {
			acct : "银行卡号不能为空"
			/*	mobile : "手机号不能为空"
			day_max_succ_cnt : "日成功交易笔数限制不能为空",
			day_max_succ_amt : "日成功交易金额限制不能为空",
			mon_max_succ_cnt : "月成功交易笔数限制不能为空", 
			agrdeadline : "交易期限不能为空"*/ 
		}
	});
});


 function closeWinNoLoad(hasFlush,timeout){
				if(hasFlush){
					if(!timeout){
						var timeout=2000;
					}
					setTimeout(function(){try{tb_remove();}catch(e){}},timeout);
				}else{
					tb_remove();
				}
				refresh();
			}

 $(document).ready(function(){ 
	$('#submitbtn').click(function() {
   if($("#signupForm").valid()){
   $.ajax({ 
                cache: true, 
                type: "POST",
                async: false,
                url:"allinpay/saveOrUpdate.do", 
                data:$('#signupForm').serialize(), 
                dataType:'json',
                error: function(request) { 
                		alert("保存失败！");
                }, 
                success: function(datas) { 
					var result="";
					if(datas.retcode=='0'){
						alert("保存成功！");
						closeWinNoLoad();
					}else{
						alert("保存失败！"+datas.message);
						refresh();
					}
                } 
            });
   }
  }); 
});
 

function refresh(){
	window.parent.queryPage;
}
 
function change(){
	$("#idno").val("");
}
</script>
<style type="text/css">
body { margin:0px; padding:0px;margin-top:10px;   font-family: "微软雅黑","Arial Narrow";font-size: 12px;}
ul  {list-style-type:none}
.table tr td{margin : 5px;}
.table tr td label{
display:block;
width: 150px;
font-size: 11px;
}
.error{color: red;font-size: 10px;}
</style>
	</head>
		<form id="signupForm" method="post" action="" style="text-align: center;" >
			<input id="id"  type="hidden" name="id" value="${tlAgentsBankBind.id}" /> 
			<table width="50%"  class="table">
				<tr style="margin:10px; ">
					<td align="right">
						<label>
							<font color="red">*</font>银行卡号:
						</label>
					</td>
					<td style="float: left;">
						<input id="acct" name="acct" value="${tlAgentsBankBind.acct}"  readonly="readonly"  /> 
					</td>
					<td align="right">
						<label for="bank_code">
							银行编码 :
						</label>
					</td>
					<td>
						<input id="bank_code" name="bank_code"  value="${tlAgentsBankBind.bankCode}"   />
					</td>
				</tr>	 
				<tr>
					<td align="right">
						<label for="bank_name">
							开户行名称 :
						</label>
					</td>
					<td>
						<input id="bank_name" name="bank_name" value="${tlAgentsBankBind.bankName}" />
					</td>
					<td align="right">
						<label for="ac_name">
							账户名:
						</label>
					</td>
					<td style="float: left;" >
						<input type="text" id="ac_name" name="ac_name" value="${tlAgentsBankBind.acName}" />
					</td>
				</tr>	 
				<tr>
					<td align="right">
						<label for="province">
							开户省份:
						</label>
					</td>
					<td style="float: left;" >
						<input type="province" id="province" name="province" value="${tlAgentsBankBind.province}"/>
					</td>
					<td align="right">
						<label for="rightname">
							开户市:
						</label>
					</td>
					<td style="float: left;">
						<input id="city" name="city" value="${tlAgentsBankBind.city}"/>
					</td>
				</tr>	 
				<tr>
					<td align="right">
						<label for="accountType">
							账户类型:
						</label>
					</td>
					<td style="float: left;">
					<select id="account_type" name="account_type"  style="width: 170px;">
						<option value="00" <c:if test="${tlAgentsBankBind.accountType==00}">selected="selected"</c:if>>银行卡</option> 
						<option value="01" <c:if test="${tlAgentsBankBind.accountType==00}">selected="selected"</c:if>>存折</option>
						<option value="02" <c:if test="${tlAgentsBankBind.accountType==00}">selected="selected"</c:if>>信用卡</option>
					</select>
					</td>
					<td align="right">
						<label for="account_prop">
							账户属性:
						</label>
					</td>
					<td style="float: left;">
						<select id="account_prop" name="account_prop"  style="width: 170px;">
						<option value="0" <c:if test="${tlAgentsBankBind.accountProp==0}">selected="selected"</c:if>>私人</option> 
						<option value="1" <c:if test="${tlAgentsBankBind.accountProp==1}">selected="selected"</c:if>>公司</option>
					</select>
					</td>
				</tr>	 
				<tr>
					<td align="right">
						<label for="id_type">
							证件类型:
						</label>
					</td>
					<td style="float: left;">
					<select id="id_type" name="id_type" onchange="change()" >
						<option value="0">身份证或企业经营证件</option>
						<option value="1">户口簿</option>
						<option value="2">护照</option>
						<option value="3">军官证</option>
						<option value="4">士兵证</option>
						<option value="5">港澳居民来往内地通行证</option>
						<option value="6">台湾同胞来往内地通行证</option>
						<option value="7">临时身份证</option>
						<option value="8">外国人居留证</option>
						<option value="9">警官证</option>
						<option value="X">其他证件</option>
					</select>
					</td>
					<td align="right">
						<label for="idno">
							证件号:
						</label>
					</td>
					<td style="float: left;">
					<input id="idno" name="idno"  value="${tlAgentsBankBind.idno}" />
					</td>
				</tr>	 
				<!-- 
				<tr>
					<td align="right">
						<label for="max_Singleamt">
							<font color="red">*</font> 单笔限额（分）:
						</label>
					</td>
					<td style="float: left;">
					<input id="max_Singleamt" name="max_Singleamt" value="${tlAgentsBankBind.maxSingleamt}"   />
					</td>
					<td align="right">
						<label for="day_max_succ_cnt">
							<font color="red">*</font>日成功交易笔数:
						</label>
					</td>
					<td style="float: left;">
					<input id="day_max_succ_cnt" name="day_max_succ_cnt" value="${tlAgentsBankBind.dayMaxSuccCnt}"   />
					</td>
				</tr>	 
				<tr>
					<td align="right">
						<label for="day_max_succ_amt">
							<font color="red">*</font>日成功交易金额限制 （分）:
						</label>
					</td>
					<td style="float: left;">
					<input id="day_max_succ_amt" name="day_max_succ_amt" value="${tlAgentsBankBind.dayMaxSuccAmt}"   />
					</td>
					<td align="right">
						<label for="mon_max_succ_cnt">
							<font color="red">*</font>月成功交易笔数限制:
						</label>
					</td>
					<td style="float: left;">
					<input id="mon_max_succ_cnt" name="mon_max_succ_cnt" value="${tlAgentsBankBind.monMaxSuccCnt}"  />
					</td>
				</tr>
					 
				<tr>
					<td align="right">
						<label for="mon_max_succ_amt">
							<font color="red">*</font>月成功交易金额限制（分）:
						</label>
					</td>
					<td style="float: left;">
					<input id="mon_max_succ_cnt" name="mon_max_succ_amt" value="${tlAgentsBankBind.monMaxSuccAmt}"  /> 
					</td>
					<td align="right">
						<label for="agrdeadline">
							<font color="red">*</font>交易期限(yyyyMMddhhmmdd):
						</label>
					</td>
					<td style="float: left;">
					<input id="agrdeadline" name="agrdeadline" value="${tlAgentsBankBind.agrdeadline}"   />
					</td>
				</tr>
				 -->
				<tr>
					<td align="right">
						<label for="mon_max_succ_amt">
							 手机号
						</label>
					</td>
					<td style="float: left;">
					<input id="mobile" name="mobile" value="${tlAgentsBankBind.mobile}"  /> 
					</td>
					<c:if test="${type=='edit'}">
					<td align="right">
						<label for="agrdeadline">
							 签约状态:
						</label>
					</td>
					<td style="float: left;">
					${tlAgentsBankBind.signStatusTrans}
					</td>
					</c:if>
				</tr>
				<tr>
					<td align="right">
						<label for="mon_max_succ_amt">
							 备注
						</label>
					</td>
					<td style="float: left;">
					${tlAgentsBankBind.remark}
					</td>
				</tr>
			</table>
			<ul style="text-align: center;margin-top: 10px;">
				<li class="btnarea">
						<input type="button" id="submitbtn" class="Partorange" value="保存" style="margin-top: 10px;">
						<input type="button"   onClick="javascript:closeWinNoLoad();" class="Partgreen" value="关闭" style="margin-top: 10px;">
				</li>
			</ul>
		</form>
	</body>
</html>
