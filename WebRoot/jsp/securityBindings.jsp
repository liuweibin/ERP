<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<style type="text/css">
#ipvalue input[type='text']{width: 80px;}
</style>
<script type="text/javascript" charset="gb2312" src="http://counter.sina.com.cn/ip/"></script>
<script type="text/javascript">
$(function(){
	init();
})
 
function init(){
	$("#radio").change(function() {
        var isChecked = $("input[name='radioName']:checked").val();           // 获取当前选中radio的值
        if(isChecked=="on"){
        	var ip = ILData[0];
			var strs= new Array(); //定义一数组
				strs = ip.split('.');
			$("#ip1").val(strs[0]);
			$("#ip2").val(strs[1]);
			$("#ip3").val(strs[2]);
			$("#ip4").val(strs[3]);
		         	
        }
    });
	$("#safeBoundForm").validate( {
		rules : {
			ip1 : {
				required : true,
				digits:true
			},
			ip2 : {
				required : true,
				digits:true
			},
			ip3 : {
				required : true,
				digits:true
			},
			ip4 : {
				required : true,
				digits:true
			}
		},
		messages : {
			ip1 : {
				required : "请输入完整的ip地址",
				digits:"请输入数字"
			},
			ip2 : {
				required : "请输入完整的ip地址",
				digits:"请输入数字"
			},
			ip3 : {
				required : "请输入完整的ip地址",
				digits:"请输入数字"
			},
			ip4 : {
				required : "请输入完整的ip地址",
				digits:"请输入数字"
			}
		}
	});
	$.ajax({
		url:'<%=basePath%>user/safeBoundInit.do',
		dataType:'json',
		type:"POST",
		async :false,
		success:function(data){
			if(data.retcode=="0"){
				var dataTemp = data.data;
				var btype=dataTemp.bandtype;
				var bvalue=dataTemp.bandvalue;
				var mtype=dataTemp.mobileBindType;
				var mvalue=dataTemp.mobileBindValue;
				var arr=new Array(); 
				if(btype==1){
					$("#pc_bind_type").find("option[value='1']").attr("selected",true);
					arr=bvalue.split(".");
					for(var i=0;i<arr.length;i++)
						{
							var ip1=arr[0];
							var ip2=arr[1];
							var ip3=arr[2];
							var ip4=arr[3];
							$("#ip1").val(ip1);
							$("#ip2").val(ip2);
							$("#ip3").val(ip3);
							$("#ip4").val(ip4);
						}
				}else if(btype==2){
					$("#pc_bind_value").val(bvalue);
					$("#pc_bind_type").find("option[value='2']").attr("selected",true);
				}else {
					$("#pc_bind_type").find("option[value='0']").attr("selected",true);
				}
				if(mtype==1){
					$("#mobile_bind_type").find("option[value='1']").attr("selected",true);
					$("#mobile_bind_value").val(mvalue);
				}else if(mtype==2){
					$("#mobile_bind_type").find("option[value='2']").attr("selected",true);
					$("#macmobile_value").val(mvalue);
				}else{
					$("#mobile_bind_type").find("option[value='0']").attr("selected",true);
				}
				
			}else if(data.retcode=="1"){
				alert(data.message);
			}
		},error:function(){
		}
	})
	selectype();
	selectMoblieType();
	$("#btn_safe").click(function() {
		var pctype=$("#pc_bind_type").val();
		var moblietype=$("#mobile_bind_type").val();
		if(pctype==2&&moblietype==1){
				testvalue();
				testmb();
			 if(testvalueresult&&testphone){
				processData();
				}
		}else if(pctype==2&&moblietype==2){
				testvalue();
				testmbmac();
			 if(testvalueresult&&testmac){
				processData();
				}
		}else if(pctype==1&&moblietype==1){
				testmb();
				$("#pcmac_value").css("display","none");
			 if($("#safeBoundForm").valid()&&testphone){
				processData();
				}
		}else if(pctype==1&&moblietype==2){
				testmbmac();
				$("#pcmac_value").css("display","none");
			 if($("#safeBoundForm").valid()&&testmac){
				processData();
				}
		}else if(pctype==0&&moblietype==1){
				testmb();
				 if(testphone){
				processData();
				}
		}else if(pctype==0&&moblietype==2){
				testmbmac();
				 if(testmac){
				processData();
				}
		}else if(moblietype==0&&pctype==2){
				testvalue();
				 if(testvalueresult){
				processData();
				}
		}else if(moblietype==0&&pctype==1){
				 if($("#safeBoundForm").valid()){
				processData();
				}
		}
		 if (pctype==0&&moblietype==0){
			processData();
		}
		});
}
function selectype(){ 
	var pctype=$("#pc_bind_type").val();
	if(pctype==2){
		$("#ipvalue").hide();
		$("#mac_value").css("display","block");
	}
	if(pctype==1){
		$("#ipvalue").css("display","block");
		$("#mac_value").css("display","none");
		$("#pcmac_value").css("display","none");
	}
	if(pctype==0){
		$("#ipvalue").css("display","none");
		$("#mac_value").css("display","none");
		$("#pcmac_value").css("display","none");
	}
	
}
function testvalue(){
	var pcvalue=$("#pc_bind_value").val();
	if(pcvalue==""){
				$("#pcmac_value").css("display","block");
				document.getElementById("pcmac_value").innerHTML = '<font color="red">请输入要绑定的PC mac 地址</font>';
				}else {
				$("#pcmac_value").css("display","none");
				testvalueresult=true;
				}
}

function testmb(){
	var moblievalue=$("#mobile_bind_value").val();
	var macmobilevalue=$("#mobile_bind_value").val();
	var moblietype=$("#mobile_bind_type").val();
	if(moblietype==1&&macmobilevalue==""){
		$("#ph_value").css("display","block");
		$("#ph_mac_value").css("display","none");
			document.getElementById("ph_value").innerHTML = '<font color="red">请输入要绑定的 设备编号</font>';
	}else{
			$("#ph_value").css("display","none");
			testphone=true;
	}
}


function testmbmac(){
	var moblievalue=$("#mobile_bind_value").val();
		var macmobilevalue=$("#macmobile_value").val();
		var moblietype=$("#mobile_bind_type").val();
	if(moblietype==2&&macmobilevalue==""){
			$("#ph_mac_value").css("display","block");
			$("#ph_value").css("display","none");
			document.getElementById("ph_mac_value").innerHTML = '<font color="red">请输入要绑定的手机mac地址</font>';
		}else{
			$("#ph_mac_value").css("display","none");
			testmac=true;
		}
}

function selectMoblieType(){
	var moblietype=$("#mobile_bind_type").val();
	if(moblietype==1){
		$("#moblie_values").css("display","block");
		$("#mac_moblie_value").css("display","none");
		$("#ph_mac_value").css("display","none");
	}
	if(moblietype==2){
		$("#mac_moblie_value").css("display","block");
		$("#moblie_values").css("display","none");
		$("#ph_value").css("display","none");
	}
	if(moblietype==0){
		$("#mac_moblie_value").css("display","none");
		$("#moblie_values").css("display","none");
		$("#ph_mac_value").css("display","none");
		$("#ph_value").css("display","none");
	}
}


function processData() {
	var queryString = "&pc_bind_type=" + $("#pc_bind_type").val() + "&ip1="
			+ $("#ip1").val() + "&ip2="+ $("#ip2").val() + "&ip3="+ $("#ip3").val()+ "&ip4="+ $("#ip4").val()
			+ "&pc_bind_value="+ $("#pc_bind_value").val()+"&mobile_bind_type="+ $("#mobile_bind_type").val()+"&mobile_bind_value="+ $("#mobile_bind_value").val()+"&macmobile_value="+ $("#macmobile_value").val();
	var url_="<%=basePath%>user/safeBoundInfo.do";
	$.ajax( {
		type : "POST",
		url : url_,
		cache : false,
		timeout : 15000,
		data : queryString,
		dataType : 'text',
		success : function(msg) {
			var result="";
			if(jQuery.trim(msg) == "202"){
				var result = "<img src='${ctx}/images/button/ok.gif'>添加绑定方式成功！";
				$("input[type=text]").val("");
			}else if(jQuery.trim(msg) == "101"){
				result = "<img src='${ctx}/images/bg_btn3.gif'>添加绑定方式失败！";
			} 
			$("#message").html(result);
			showbox();
		},
		error : function() {
			$("#message").html("<img src='${ctx}/images/bg_btn3.gif'>添加绑定方式失败！");
			showbox();
	}
	});
}
function showbox(){
	$("#message").hide().fadeIn("slow");
	setTimeout("hidebox()",3000);
}
function hidebox(){
	$("#message").hide();
}
</script>
</head>
<body>
<div class="main">


<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
        <div class="nyRight">
          <div class="nyTit">安全设置</div>
          <div class="gamenamebox">
              <jsp:include page="securitySetTitle.jsp" >
			 		 <jsp:param name="num" value="2" /> 
				</jsp:include>
            <div class="gamename">
            		<div id="ajaxmsg" class="blockremarknone">
				<span id="message"></span>
			</div>
	               <div class="spcxtj" id="con_subpcx_2">
	               	<form name="safeBoundForm" id="safeBoundForm" method="post">
				<input type="hidden" name="mode" id="mode" value="updTradePwd">
				<input type="hidden" name="settype" id="settype" value="">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
	                  <tr><td colspan="4" style="font-weight: 700">PC绑定</td></tr>
						  <tr>
						    <td class="wz" width="25%">选择PC绑定方式：</td>
						    <td width="25%"> 
						    	<select id="pc_bind_type" name="pc_bind_type"  class="input6" onchange="selectype();">
									<option value="0" selected="selected">不绑定PC</option>
									<option value="1" >IP地址绑定</option>
									<option value="2">mac地址绑定</option>
								</select>
						    </td>
						    <td width="25%"> </td>
						    <td width="25%"></td>
						  </tr>
						  <tr>
						  <td></td>
						    <td colspan="3"> 
					    	    <div id="ipvalue">
									<label id="pcvalues"> <em style="color: red;margin-right: 5px">*</em>绑定值： </label>
									<input type="text" name="ip1" id="ip1" class="input6"   maxlength="3" /><span>.</span><input type="text" name="ip2" id="ip2" class="input6" style="width:45" maxlength="3" /><span>.</span><input type="text" name="ip3" id="ip3" class="input6" style="width:40" maxlength="3" /><span>.</span><input type="text" name="ip4" id="ip4" class="input6" style="width:40" maxlength="3" />
									自动获取:<input type="radio" id="radio"  name="radioName"> 
								</div>
								<div id="mac_value" style="display: none">
									<label id="pcvalues"> <em style="color: red;margin-right: 5px;">*</em>绑定值： </label>
									<input type="text" id="pc_bind_value"   class="input6" name="pc_bind_value" onblur="testvalue();">
								</div>
								<span id="pcmac_value" style="display: none;margin: 3px,10px,0px,200px;"></span>
						    </td>
						  </tr>
						      <tr><td colspan="4" style="font-weight: 700">手机绑定</td></tr>
						  <tr>
						    <td class="wz">选择手机绑定方式：</td>
						    <td>
						    <select id="mobile_bind_type" name="mobile_bind_type" class="input6"   onchange="selectMoblieType();">
								<option value="0" selected="selected">不绑定手机</option>
								<option value="1" >设备编号绑定</option>
								<option value="2">mac地址绑定</option>
							</select>
						    </td>
						      <td></td>
						    <td></td>
						  </tr>
						  <tr>
						   <td></td>
							  <td colspan="3"> 
							    <div id="moblie_values">
								<label> <em style="color: red;margin-right: 5px">*</em>绑定值： </label>
								<input type="text" id="mobile_bind_value" name="mobile_bind_value" class="input6" onblur="testmb();"><span id="ph_value" style="display: none;margin: 3px,10px,0px,200px;"></span>
								</div>
								<div id="mac_moblie_value" style="display: none">
								<label id="pcvalues"><em style="color: red;margin-right: 5px">*</em>绑定值： </label>
								<input type="text" id="macmobile_value" name="macmobile_bind_value"  class="input6"  onblur="testmbmac();"></div><span id="ph_mac_value" style="display: none;margin: 3px,10px,0px,200px;"></span>
							  </td>
						  </tr>
						  
						  <tr>
						    <td colspan="8" align="center"><input name="button" type="button" class="an_input2" id="btn_safe" value="保存" /></td>
						    </tr>
						</table></form>
						<blockquote>
			<p>
				<strong>说明（目前只支持IP绑定，不支持mac绑定）：</strong>
			</p>
			<p style="margin-left: 40px;">
				一、登录器登录时，可以选择绑定网卡。
			</p>
			<p style="margin-left: 40px;">
				二、为了加强安全，有固定IP地址的代理商请填写自己的IP地址。
			</p>
			<p style="margin-left: 40px;">
				三、没有固定IP地址的代理商，请不要绑定IP地址。
			</p>
			<p style="margin-left: 40px;">
				四、手机设备编码获取方式 手机直接拨号 *#06# 获取（注：有字母的字母要小写）
			</p>
		</blockquote>
	              </div>
   
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
