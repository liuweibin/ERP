<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <base href="<%=basePath%>">
    
    <title>转移信用点</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

 <link href="<%=basePath%>themes/common/button.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>themes/common/titletab.css" rel="stylesheet" type="text/css" />
 <style type="text/css">
 body{  font-family:  "微软雅黑","Arial Narrow";  margin:0; padding:0;}
 .hide{ display: block;}
 #tbody{
 margin-left: 100px;
 }
 #table_{
 font-size:14px; font-family:Verdana, Arial, Helvetica, sans-serif;
 display: block;
 width: 95%;
 text-align: center;
 }
  #table_ tr td{
 	text-align: right;
  }
/* #tbody tr td input[type="text"],  #tbody tr td input[type="password"]{
	height: 22px;
 }*/ 

#center {
	padding: 20px 0px 10px 0px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
.currentBtn a{color: #434142;font-size: 14px;font-weight: bold;}
a:HOVER{text-decoration: none;}
#table_ tr td input,textarea{float: left;}
#table_ tr td label{
	float:right;
	display: block; 
	width: 200px;
	color: #D86201;
	font-size: 22px;
    font-weight: bold;
    height: 44px;
    line-height: 44px;
    font-family:  "微软雅黑","Arial Narrow";
    margin-right: 5px;
}
#table_ tr td span{float: left;}
 </style>


<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>

	<script type="text/javascript" src="<%=basePath%>js/common/jquery.paginate.js"></script>
<script type="text/javascript" src="<%=basePath%>js/hm/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=basePath%>js/jquery.tableui.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/thickbox.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.form.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="JavaScript"	src="<%=basePath%>js/jquery.metadata.js"></script>
		
<script type="text/javascript" src="<%=basePath%>js/jquery.md5.js"></script>
		

<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidatorRegex.js"></script>
<script type="text/javascript" src="<%=basePath%>js/formValidator/formValidator-4.1.3.js"></script>
 <script type="text/javascript">
$(document).ready(function(){
	parent.resetTime();    
	   $.formValidator.initConfig({
		 formID:"trans",
		 submitOnce:true,
		 onSuccess:function(){
			//	alert("校验组1通过验证，不过我不给它提交");
				 creatOrderAjax();
		 },onError:function(){
			 alert("具体错误，请看网页上的提示");
		 }
	 });
	$("#agentsCode").formValidator({onFocus:"至少1个长度",onCorrect:"转帐账号合法"})
	.inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:"不能有空符号"},
	onError:"不能为空"});
	$("#code2").formValidator({onShow:"请确认转账账号",onCorrect:"转帐账号一致"})
	.inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:"不能有空符号"},
	onError:"不能为空"}).compareValidator({desID:"code",operateor:"=",onError:"账号不一致"});
	$("#money").formValidator({onShow:"请输入转帐金额",onFocus:"正整数",onCorrect:"转帐金额合法"})
	.inputValidator({min:1,onError:"不能为空"}).regexValidator({regExp:"intege1",dataType:"enum",onError:"转帐金额格式不正确"});
	$("#chkmoney").formValidator({onShow:"请确认转账金额",onFocus:"",onCorrect:"转帐金额一致"})
	.inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:"有空符号"},
	onError:"不能为空"}).compareValidator({desID:"money",operateor:"=",onError:"2次转帐金额不一致,请确认"});
	
	/*
		$("#tradepassword").formValidator({onShow:"请输入交易密码",onFocus:"至少8位字符或数字",onCorrect:"交易密码正确"}).
		inputValidator({min:8,max:20,onError:"你输入的交易密码不正确,请确认"})
	    .ajaxValidator({
		dataType : "json",
		data:{'tradepassword':$("#tradepassword").val()},
		async : true,
		url : "account.do?name=checkSupperPassword",
		success : function(data){
            if(data.retcode == "0") return true;
			return "超级密码 不正确";
		},
		buttons: $("#button"),
		error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
		onError : "交易密码不正确",
		onWait : "正在对交易密码进行校验，请稍候..."
	});
	*/
	
		$("#tradepassword").formValidator({onShow:"请输入交易密码",onFocus:"至少8位字符或数字",onCorrect:"交易密码格式正确"}).
		inputValidator({min:8,max:20,onError:"交易密码至少8位"});
		
		
});
	
 function findAgentsUpDown() {
		var url = "account.do?name=findAgentsUpDown";
		var title = "选择转给账号";
		var width = 550;
		var height = 250;
		parent.LightBox(url, title, width, height);
	}
function textToggle(step){ 
	$(".code2").html($("#code").val());
	$(".name").html($("#name").val()+"("+$("#account").val()+")");
	$(".money2").html($("#money").val());
	$(".remark2").html($("#remark").val());
	displayToggle($(".show"));
	displayToggle($(".hide"));
	
	
	var a = $("#findAjax")[0].style.display = "none";
	reflush(step);
}
function reflush(step){
	$("#process_lc_img").attr("src","<%=basePath%>images/step/process_lc_img"+step+".jpg");
}
 function transPointAjax(){
	 showMask();
	 $("#submit02").attr("disabled","disabled");
	   $("#submit02").value="";
	   $("#submit02").value="正在提交...";
	$.ajax({url:'account.do?type=transPoint',
	type:'post',
	dataType:'json',
	timeout:"120000",
	data:$("#trans").serialize(),
	success:function(data){
		if(data.retcode=="0"){
			reflush(3);
			var table_ = $("#table_");
			var success = $("#success");
			displayToggle(table_);
			displayToggle(success);
			$("#mask").hide();
			parent.ajaxAccount();
		}else{
			reflush(3);
			$("#errorMessage").html(data.message);
			displayToggle($("#table_"));
			displayToggle($("#error"));
			parent.ajaxAccount();
			$("#mask").hide();
		}
		 
	},
	error:function(error){
		if(error.status==0){
			reflush(3);
			$("#errorMessage").html("订单超时！请查看转点记录");
			displayToggle($("#table_"));
			displayToggle($("#error"));
			parent.ajaxAccount();
		}else{
		alert(error.status);
		}
		$("#mask").hide();
	}});

}
function creatOrderAjax(){
	var data = $("#trans").serialize();
		var i = data.lastIndexOf("&")
		var sub = data.substr(i,data.length);
		var tradepassword = $("#tradepassword").val();
		data = data.replace(sub,"&tradepassword="+$.md5(tradepassword))
		$.ajax({
		 url:'account.do?type=creatTransOrder',
		 type:'post',
		 dataType:'json',
		 data:data,
		 success:function(data){
		 	if(data.retcode=="0"){
		 			textToggle(2);
		 			$("#orderidOut").val(data.data.codeOut);
		 			$("#orderidIn").val(data.data.codeIn);
		 			var button2 = $("#button2");
		 			var button1 = $("#button1");
		 			displayToggle(button1);
		 			displayToggle(button2);
		 			//$("#tbody").attr('text-align','-moz-center !important');
		 	}else if(data.retcode=="1"){
		 		alert(data.message);
		 	}
		 },
		 error:function(error){
		 	alert("error");
		 }
		
		});
}


function displayToggle(obj){
	$.each(obj,function(i,attr){
		if(attr.style.display=='block'){
				attr.style.display='none';	
		}else if(attr.style.display=='none'){
			attr.style.display='block';
		}
	});
}
 function refresh(){
  parent.location.href="<%=basePath%>user/mainForm.do";
}
  function load(){ 
	　　parent.document.getElementById("main").style.height = "560px"; 
     　} 
  
//兼容火狐、IE8
  function showMask(){
  	$("#mask").css("height",300);
  	$("#mask").css("width",$(document).width());
  	$("#mask").show();
  }
 </script>
  </head>
  <body onload="load();">
 
   <div id="mask" class="mask" style="margin-top: 100px;line-height:300px;display: none">订单处理中请稍后。。。</div>
  				<div id="tabCot_product" class="tab" style="width: 100%">
					  <div class="tabContainer" style="width: 100%">
									<ul class="tabHead" id="tabCot_product-li-currentBtn-">
										<li class="currentBtn">
										<a href="<%=basePath%>account.do?type=transferPoint"		title="转点" rel="1">转移信用点</a></li>

									</ul>
					</div>
					</div>
      <div id="center" style="display: block;margin-left: auto;margin-right: auto;" align="center">
  		<div style="width: 100%; height: 32px; border-top-width: 10px; margin-top: 10px;text-align: center;" >
					<img alt="" id="process_lc_img" src="${ctx}/images/step/process_lc_img1.jpg">
		</div>
		
      <form name="trans" id="trans" method="post" action="">
        <input type="hidden"  name="transOutOrder" id="orderidOut" value="">
        <input type="hidden"  name="transInOrder" id="orderidIn" value="">
        <input type="hidden"  name="name" id="name" value="${name}">
        <input type="hidden"  name="account" id="account" value="${account}">
        		<input type="hidden" name="token" value="${token}" />
      <table id="table_" style="display: block;" border="0" align="center" cellpadding="4" cellspacing="0">
	      <tbody id="tbody" >
	      <tr style="display: block;">
	          <td><label class="label">您的信用点&nbsp;：</label></td>
	          <td><font color="#FF6600" style="display: block;float: left;font-size: 22px;">${useableBalance}元</font></td>
	        </tr>
	        <tr class='hide' style="display: block;">
	          <td><label class="label">您转帐给&nbsp;：</label></td>
	          <td><input type="text" id="code" name="agentsCode"  class="input_l" readonly="readonly" value="${agentsCode}">
		          <input  id="findAjax" style="width:30px;;display:;margin-left: 3px;height: 22px;" type="button" class="Partorange"   value="..." onclick="findAgentsUpDown()">
		          <span id="codeTip" class=""></span>
	          </td>
	        </tr>
	        <tr id="code_tr" class='hide' style="display: block;">
	          <td  nowrap="nowrap" ><label class="label">确认转帐给&nbsp;：</label></td>
	          <td><input type="text" name="chktonickname"  class="input_l"  id="code2" value=""><span id="code2Tip" class="" ></span></td>
	        </tr>
	        <tr class='hide' style="display: block;">
	          <td><label class="label">转帐金额(元)：</label></td>
	          <td>
	          	<input type="text" maxlength=9   class="input_l"  value="${suggestRetailPrice}"  name="money" id="money" 
	          	onkeyup="if(value.match(/^\d{3}$/))value=value.replace(value,parseInt(value/10));value=value.replace(//./d*/./g,'.')" 
				 onKeyPress="if((event.keyCode<48 || event.keyCode>57) && event.keyCode!=46 && event.keyCode!=45 || value.match(/^\d{10}$/) || /\.\d{2}$/.test(value)){event.returnValue=false}">
				  <span id="moneyTip"   class=""></span>
			  </td> 
	        </tr>
	        <tr id="chkmoney_tr" class='hide' style="display: block;"> 
	          <td   nowrap="nowrap"><label class="label">确认转帐金额(元)&nbsp;：</label></td>
	          <td><input type="text" name="chkmoney"  class="input_l"  id="chkmoney">
	          <span id="chkmoneyTip"  class=""></span></td>
	        </tr>
	        <tr class='hide' style="display: block;">
	          <td><label class="label">备&nbsp;&nbsp;注&nbsp;：</label></td>
	          <td class="remark"><textarea name="remark" id="remark" cols="23" rows="3" style="font-size: 22px;"></textarea></td>
	        </tr>
	        <tr class="tradepassword hide" style="display: block;">
	          <td><label class="label">交易密码：</label></td>
	          <td><input type="password" id="tradepassword"  class="input_l"  name="tradepassword"   value="" />
	     	  <span id="tradepasswordTip"  class=""></span></td>
	        </tr>
	         <tr class='show' style="display: none;">
	          <td><label class="label">您转帐给&nbsp;：</label></td>
	          <td><span   class="code2" style="font-size: 22px;font-weight: 700;"></span></td>
	        </tr>
	         <tr class='show' style="display: none;">
	          <td><label class="label">代理商&nbsp;：</label></td>
	          <td><span   class="name" style="font-size: 22px;font-weight: 700;"></span></td>
	        </tr>
	         <tr   class='show' style="display: none">
	          <td  nowrap="nowrap" class="label"><label  class="label">转帐金额(元)&nbsp;：</label></td>
	          <td><span class='money2' style="font-size: 22px;font-weight: 700;"></span></td>
	        </tr>
	         <tr  class='show'  style="display: none">
	          <td  nowrap="nowrap"><label class="label">备  注&nbsp;：<label></td>
	          <td><span class='remark2' style="font-size: 15px;font-weight: 700;"></span></td>
	        </tr>
	        
	        <tr id="button1"  style="display: block;">
	         <td style="width: 300px;"></td>
	          <td> 
	            <input id="submit01" name="submit01" type="submit" class="Partorange" value="提交订单" style="border: 0;"/>
	        </td>
	        </tr>
	        <tr id="button2" style="display: none;" >
	            <td style="width: 300px;"> </td>
	            <td>
	            <input id="submit02" name="submit02" type="button" class="Partorange" onclick="transPointAjax()" value="确认转点"/>
					<div style="float: left;margin-left: 10px;padding-top : 12px;font-size: 12px;">
					<a  target="main" style="color: black;"  href="<%=basePath%>account.do?type=transferPoint" > 取消转点 </a>
					</div>
	          </td>
	        </tr>
	      </tbody>
      </table>
       </form>
         <div id="success" style="border: 0px solid green;text-align: center;height: 300px; display: none;">
	       <div style="height: 200px; margin-top: 100px;">
	       		<span style="border-top: 30px;"><strong style="color: red;font-size: 50px;">转点成功</strong></span>
	       				<a  target="main" style="color: black;"  href="<%=basePath%>account.do?type=transferPoint"><span style="font-weight: 700;font-size: 12px;">返回</span></a>
	       </div>
         </div>
         <div id="error" style="border: 0px solid green;text-align: center;height: 300px; display: none;">
	       <div style="height: 200px; margin-top: 100px;">
	       		<span style="border-top: 30px;"><strong style="color: red;font-size: 50px;" id="errorMessage">可用余额点不足！转点失败</strong></span>
	       				<a  target="main" style="color: black;"  href="<%=basePath%>account.do?type=transferPoint"><span style="font-weight: 700;font-size: 12px;">返回</span></a>
	       </div>
       </div>
       </div>
       
								<div class="modBottom">
									<span class="modABL"></span> <span class="modABR"></span>
								</div>
</body>
</html>
