<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>


 <script type="text/javascript">
 $(document).ready(function(){
	 
		 $.formValidator.initConfig({
			 formID:"transForm",
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
		
			/*$("#tradepassword").formValidator({onShow:"请输入交易密码",onFocus:"至少8位字符或数字",onCorrect:"交易密码格式正确"}).
			inputValidator({min:8,max:20,onError:"交易密码至少8位"});*/
		var Verification_Code = ${Verification_Code}; 
		if(Verification_Code==0){
			$("#tradepassword").formValidator({onShow:"请输入交易密码",onFocus:"至少8位字符或数字",onCorrect:"交易密码格式正确"}).
			inputValidator({min:8,max:20,onError:"交易密码至少8位"});
			$(".password").show();
			$(".kl").hide();
		}else if(Verification_Code==1){
			$("#kl").formValidator({onShow:"请输入口令",onFocus:"请输入口令",onCorrect:"口令格式正确"}).
			inputValidator({min:6,max:6,onError:"口令为6位数字"});
			$(".password").hide();
			$(".kl").show();
		}
			init();
});

 
function step(num){
	document.getElementById("czbzTit").className = "czbzTit0"+num;
}

function init(){
	$.ajax({
		url:"<%=basePath%>account.do?name=getToken",
		type:'post',
		dataType:'json',
		success:function(data){
			var token = data.data.token;
			$("#token").val(token);
		},error:function(e){
			alert(e.status);
		}
	})
}
 function findAgentsUpDown() {
		var url = "<%=basePath%>account.do?name=findAgentsUpDown&type=new";
		var title = "选择转给账号";
		var width = 550;
		var height = 250;
		parent.LightBox(url, title, width, height);
	}
function textToggle(num){ 
	$(".code2").html($("#code").val());
	$(".name").html($("#name").val());
	$(".money2").html($("#money").val());
	$(".remark2").html($("#remark").val());
	 $(".show").show();
	$(".hide").hide();
	step(num);
}
 
 function transPointAjax(){
	 showMask();
	$.ajax({url:'<%=basePath%>account.do?type=transPoint',
	type:'post',
	dataType:'json',
	timeout:"120000",
	data:$("#transForm").serialize(),
	success:function(data){
		if(data.retcode=="0"){
			step(3);
		 	$(".czxx").hide();
			$("#mask").hide();
	 		$("#success").show();
			 ajaxAccount();
		}else{
			step(3);
			$("#errorMessage").html(data.message);
			$(".czxx").hide();
			$("#mask").hide();
	 		$("#error").show();
			 ajaxAccount();
		}
		 
	},
	error:function(error){
		if(error.status==0){
			step(3);
			$("#errorMessage").html("订单超时！请查看转点记录");
			$(".czxx").hide();
	 		$("#error").show();
			 ajaxAccount();
		}else{
		alert(error.status);
		}
		$("#mask").hide();
	}});

}
 
function creatOrderAjax(){ 
		var tradepassword = $("#tradepassword").val();
		var kl = $("#kl").val();
		var agentsCode = $("#code").val();
		var remark = $("#remark").val();
		var money = $("#money").val();
		$.ajax({
		 url:'<%=basePath%>account.do?type=creatTransOrder',
		 type:'post',
		 dataType:'json', 
		 data:{"agentsCode":agentsCode,"remark":remark,"money":money,"tradepassword":MD5(tradepassword),"kl":kl},
		 success:function(data){
		 	if(data.retcode=="0"){
		 			textToggle(2);
		 			$("#orderidOut").val(data.data.codeOut);
		 			$("#orderidIn").val(data.data.codeIn);
		 	 
		 	}else if(data.retcode=="1"){
		 		alert(data.message);
		 	}
		 },
		 error:function(error){
		 	alert("error");
		 }
		
		});
}
 
//兼容火狐、IE8
function showMask(){
	$("#mask").css("height",400);
	$("#mask").css("width",860);
	$("#mask").show();
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
          <div class="nyTit">财务管理&gt; 转信用点</div>
          <div class="sjczBox">
            <div id="mask" class="mask" style="height:400px;position:absolute; top:258px; left:360px;line-height: 300px;width: 860px;display: none" >订单处理中请稍后。。。</div>
   
            <div class="czbzTit01" id="czbzTit">
              <h2>一：提交订单</h2>
              <h3>二：确认转点</h3>
              <h4>三：转点成功</h4>
            </div>
        <div class="czxx">
         	<form id="transForm" method="post" action=""> 
         	
	        <input type="hidden"  name="transOutOrder" id="orderidOut" value="">
	        <input type="hidden"  name="transInOrder" id="orderidIn" value="">
	        <input type="hidden"  name="name" id="name" value="">
	        <input type="hidden"  name="account" id="account" value="">
       			<input type="hidden" name="token" id="token" />
				           <table width="806" border="0" cellspacing="0" cellpadding="0" style="margin:  0 auto;">
						 	  <tr class="hide">
							    <td  class="wz">您的信用点：</td>
							    <td class="t1" style="text-indent: 15px;">${useableBalance}</td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="hide">
							    <td width="232"  class="wz">您转账给：</td>
							    <td width="332"><input name="textfield" type="text" readonly="readonly" class="input5" id="code" name="agentsCode"  />
							    <input type="button" value="..." class="input5" onclick="findAgentsUpDown()" style="width: 90px;height: 42px;background: #ffebd1"/>
							    </td>
							    <td width="242">&nbsp;</td>
							  </tr>
							  <tr class="hide">
							    <td class="wz">确认转账给：</td>
							    <td><input name="textfield2" type="text" class="input1" ame="chktonickname"     id="code2" />
							    </td>
							    <td><span id="code2Tip" class="" ></span></td>
							  </tr>
							  <tr class="hide">
							    <td class="wz">转账金额（元）：</td>
							    <td><input name="textfield4"  maxlength=9  type="text" class="input1"  name="money" id="money"   >
							    
							    </td>
							    <td><span id="moneyTip"   class=""></span></td>
							  </tr>
							  <tr class="hide">
							    <td class="wz">确认转账金额（元）：</td>
							    <td><input name="chkmoney" type="text" class="input1" id="chkmoney" />
							    </td>
							    <td> <span id="chkmoneyTip"  class=""></span></td>
							  </tr>
							  <tr class="hide">
							    <td class="wz">备注：</td>
							    <td><textarea name="textarea" cols="45" rows="5" class="input7" name="remark" id="remark" ></textarea></td>
							    <td>&nbsp;</td>
							  </tr>
							  <tr class="hide password">
							    <td class="wz">交易密码：</td>
							    <td><input   type="password" class="input1" id="tradepassword" maxlength="8" name="tradepassword"  /></td>
							    <td><span id="tradepasswordTip"  class=""></span></td>
							  </tr>
							  <tr class="hide kl">
							    <td class="wz">口令：</td>
							    <td><input   type="text" class="input1" id="kl" maxlength="6" name="kl"  /></td>
							    <td><span id="klTip"  class=""></span></td>
							  </tr>
							  <tr class="hide">
							    <td>&nbsp;</td>
							    <td><input   type="submit" class="an_input1"   value="提交订单" />
							    </td>
							    <td>&nbsp;</td>
							  </tr>
							  
							   <tr class="show" style="display: none;">
							     <td class="wz">您的信用点</td>
							    <td><span     style="font-size: 22px;font-weight: 700;">${useableBalance}</span></td>
							    <td>&nbsp;</td>
							  </tr>
							   <tr class="show" style="display: none;">
							     <td class="wz">您转帐给：</td>
							    <td><span   class="code2" style="font-size: 22px;font-weight: 700;"></span></td>
							    <td>&nbsp;</td>
							  </tr>
							   <tr class="show" style="display: none;">
							     <td class="wz">代理商：</td>
							    <td><span   class="name" style="font-size: 22px;font-weight: 700;"></span></td>
							    <td>&nbsp;</td>
							  </tr>
							   <tr class="show" style="display: none;">
							     <td class="wz">转帐金额(元)：</td>
							    <td><span   class="money2" style="font-size: 22px;font-weight: 700;"></span></td>
							    <td>&nbsp;</td>
							  </tr>
							   <tr class="show" style="display: none;">
							     <td class="wz">备  注：</td>
							    <td><span   class="remark2" style="font-size: 22px;font-weight: 700;"></span></td>
							    <td>&nbsp;</td>
							  </tr>
							  
							  <tr class="show" style="display: none;">
							    <td>&nbsp;</td>
							    <td><input   type="button" class="an_input1" id="submit02" value="确认转点" onclick="transPointAjax()" />
							    <a    style="color: black;"  href="<%=basePath%>jsp/transferPoint.jsp" > 取消转点 </a>
							    </td>
							    <td>&nbsp;</td>
							  </tr>
					</table>
		</form>
            </div>
				    <div id="success" style="border:1px solid #a7d3ff;text-align: center;height: 300px;display: none;">
					       <div style="height: 200px; margin-top: 100px;">
					       		<span style="border-top: 30px;"><strong style="color: red;font-size: 50px;">转点成功</strong></span>
					       				<a   style="color: black;"   href="<%=basePath%>jsp/transferPoint.jsp" ><span style="font-weight: 700;font-size: 12px;">返回</span></a>
					       </div>
			         </div>
			         <div id="error" style="border:1px solid #a7d3ff;text-align: center;height: 300px; display: none;">
					       <div style="height: 200px; margin-top: 100px;">
					       		<span style="border-top: 30px;"><strong style="color: red;font-size: 50px;" id="errorMessage">可用余额点不足！转点失败</strong></span>
					       				<a   style="color: black;"    href="<%=basePath%>jsp/transferPoint.jsp" ><span style="font-weight: 700;font-size: 12px;">返回</span></a>
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
