<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<HTML>
	<HEAD>
		<TITLE>购买信用点确认</TITLE>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=GBK">
		<link rel="stylesheet" type="text/css" href="/include/style.css">
		<link rel="stylesheet" type="text/css" href="/css/p.public.css">
	<script type="text/javascript" language="javascript"
			src="<%=basePath %>js/jquery.min.js">
</script>
<style type="text/css">
  *{
  padding:0px 0px 0px 0px;
  margin: 0px 0px 0px 0px;
  }
  .alipay_big{
   background-image: url("<%=basePath %>images/alipay_c_r.jpg");
   background-repeat: no-repeat;
  }
  
  .alipay_cs_confirm{
     border:0px;
     width: 87px;
     height: 31px;
     background-position: -10px -45px;
     text-align: center;
     color: white;
     font-size: 14px;
     cursor: pointer;
  }
  
    .alipay_hs_confirm{
     border:0px;
     width: 87px;
     height: 31px;
     background-position: -10px -9px;
     text-align: center;
     color: white;
     font-size: 14px;
     cursor: pointer;
  }
  
     .alipay_huis_confirm{
     border:0px;
     width: 87px;
     height: 31px;
     background-position: -170px -8px;
     text-align: center;
     color: orange;
     font-size: 14px;
     cursor: pointer;
  }
</style>

<script type="text/javascript">
function chargeClass(this_, removeclass, addclass){
	$(this_).removeClass(removeclass);
	$(this_).addClass(addclass);
}
</script>
	</HEAD>
	<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0
		MARGINHEIGHT=0 style="background-color: transparent;">
		<table width="100%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td valign="bottom">
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						background="<%=basePath %>images/list_top_bg1.gif">
						<tr>
							<td width="8"
								background="<%=basePath %>images/list_top_bg.jpg">
								<img
									src="<%=basePath %>images/list_top_left.jpg"
									width="6" height="25" />
							</td>
							<td width="118" nowrap="nowrap" align="left"
								background="<%=basePath %>images/list_top_bg.jpg"
								style="font-size: 12px; font-weight: bold; color: #ffffff; padding-top: 4px;">
								&middot;充值订单确认
							</td>
							<td width="47">
								<img
									src="<%=basePath %>images/list_top_right.gif"
									width="23" height="25" />
							</td>
							<td width="1049" class="t_font_gray">
								&nbsp;
							</td>
							<td width="29" align="right">
								<img
									src="<%=basePath %>images/list_top_right1.gif"
									width="8" height="25" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="85"
								style="background-image: url(<%=basePath %>images/list_mid_left.jpg); background-repeat: repeat-y; width: 6px;">
								<img
									src="<%=basePath %>images/list_mid_left.jpg"
									width="6" height="25" />
							</td>
							<td
								style="background-image: url(<%=basePath %>images/main_top_bg.gif); background-position: top right; background-repeat: repeat-x; padding: 0 15px; line-height: 28px;">
								<form  method="post" >
									  <input name="rechargeCode"  id="rechargeCode" type="hidden" value="${rechargeCode}">
									  <input name="unAmount" id="unAmount" type="hidden" value="${paymoney}">
									  <input name="id" id="id" type="hidden" value="${id}">
									<TABLE width="100%" height="181" border=1 cellPadding=6
										cellSpacing=0 borderColor=#e8e8e8
										style="BORDER-COLLAPSE: collapse">
										<TBODY>
											<TR bgcolor="#FFF9EE">
												<TD height=25 colspan="2">
													<font color="#FF0000">说明：</font>
													1、无论采取何种支付方式，充值金额都是实时到帐的，请注意查询。<font color="#FF0000">(0元至999元扣手续费1元/笔，1000元及以上不扣手续费)</font>
												</TD>
											</TR>
											<TR>
												<TD width="36%" height=30 align=right bgColor=#eef7ff>
													充值编号：
												</TD>
												<TD width="64%"
													style="font-size: 14px; font-family: Verdana;">
													<strong>
													<font color="#333333">${rechargeCode}</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													支付金额：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#F35229">${paymoney}元</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD height=30 align=right nowrap bgColor=#eef7ff>
													充值金额：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333">${rechargeMoney}点</font>
													</strong>
												</TD>
											</TR>
											<TR>
												<TD align=right bgColor=#eef7ff height=30>
													支付方式：
												</TD>
												<TD height=25 style="font-size: 14px; font-family: Verdana;">
													<strong><font color="#333333">银联支付</font>
													</strong>
												</TD>
											</TR>
											<TR style="display: none;" class="result">
												<TD align="center" bgColor=#eef7ff height=30 colspan="2">
													<span id="status"></span>
												</TD>
											</TR>

										</TBODY>
									</TABLE>
									<table width="100%" border="0" cellpadding="0" cellspacing="0"
										bordercolor="#eeeeee" style="border-collapse: collapse">
										<tr>
											<td height="30" align="center">
												<div align="center" style="padding: 20px;">
													<input type="button" class="alipay_big alipay_cs_confirm"   class="submitbt alipay_huis_confirm"
														value=确定付款 " onclick="unAjax()" id="submitbt"
														onmouseover="chargeClass(this,'alipay_cs_confirm','alipay_hs_confirm')";
														onmouseout="chargeClass(this,'alipay_hs_confirm','alipay_cs_confirm')";/>
													&nbsp;
													<input type="button" name="retbutton" class="alipay_big alipay_huis_confirm"
														onclick="document.location='<%=basePath%>credit/toBuyCredit.do'"
														style="cursor: pointer;"
														value="返   回">
												</div>
											</td>
										</tr>
									</table>

									<p>
										&nbsp;
									</p>
									<p>
										&nbsp;
									</p>
								</form>
							</td>
							<td
								style="background-image: url(<%=basePath %>images/list_mid_right.jpg); background-repeat: repeat-y; width: 8px;"
								align="right">
								<img
									src="<%=basePath %>images/list_mid_right.jpg"
									width="8" height="25" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0"
						background="<%=basePath %>images/list_bottom_bg.jpg">
						<tr>
							<td>
								<img
									src="<%=basePath %>images/list_bottom_left.jpg"
									width="6" height="5" />
							</td>
							<td></td>
							<td align="right">
								<img
									src="<%=basePath %>images/list_bottom_right.jpg"
									width="6" height="5" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>
<script language="javascript">
//window.parent.window.location.hash = "toptb";
function unAjax(){
	$("#submitbt").hide();
	 $(".result").show(); 
	var id = $("#id").val();
	var unAmount = $("#unAmount").val();
	var rechargeCode = $("#rechargeCode").val();
	$.ajax({ 
	    type: "POST",
	    timeout:"120000",
	    url:"<%=basePath%>unionpay/singleDaiFushi.do", 
	    data:{id:id,unAmount:unAmount,rechargeCode:rechargeCode},
	    dataType : 'json',
	    success: function(data) {
	    	var status = "";
	    	if(data.retcode=="0"){
	    		status = "代收成功"; 
	    	}else{
	    		status ="代收失败";
	    	}
	    	 parent.ajaxAccount();
	    	$("#status").html(status);
	    } ,
	    error: function(e) { 
	    	if(e.status==0){
	    		 parent.ajaxAccount();
	 	    	$("#status").html("请查看充值记录");
	    	}else{
		        alert("Connection error"); 
	    	}
	    }
	});
}
function displayToggle(obj){
	$.each(obj,function(i,attr){
		if(attr.style.display=='block'||attr.style.display==''){
				attr.style.display='none';	
		}else if(attr.style.display=='none'){
			var BrowseType="";
			if(getbrowse()=="MSIE"){
			    BrowseType="block";
			}
			else{
			    BrowseType="table-row";
			}
		attr.style.display=BrowseType;
		}
	});
};

function getbrowse(){ //判断当前浏览器是何种浏览器
    var str="";
    // 包含「Opera」文字列
    Agent=navigator.userAgent;
    if(Agent.indexOf("Opera") != -1) {
        str='Opera';
    }
    // 包含「MSIE」文字列
    else if(Agent.indexOf("MSIE") != -1) {
        str='MSIE';
    }
    // 包含「Firefox」文字列
    else if(Agent.indexOf("Firefox") != -1) {
        str='Firefox';
    }
    // 包含「Netscape」文字列
    else if(Agent.indexOf("Netscape") != -1) {
        str='Netscape';
    }
    // 包含「Safari」文字列
    else if(Agent.indexOf("Safari") != -1) {
        str='Safari';
    }
    else{  
    }  
    return str;
}
 
</script>
