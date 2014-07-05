<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>

<script type="text/javascript">
$().ready(function () {
	$("#writeMessageQueryForm").validate( {
		rules : {
			title : {
				required:true
			},
			messagecontent : {
				required : true
			}
		},
		messages : {
			title : {
				required:"请输入消息标题"
			},
			messagecontent : {
				required : "请输入消息内容"
			}
		}
	});
});
$(function(){
	init();
})
function init(){
	$.ajax({
		url:'<%=basePath%>informationManage.do?type=writeMessageInit',
		dataType:'json',
		type:'POST',
		success:function(data){
			if(data.retcode==0){
				
			$(".agents").html();
			var html = "";
			html += "<select id='receive_agent' name='receive_agent' style='width: 160px;height:30px;font-size:13px;'>";
			$.each(data.data,function(i,attr){
				var key = i;
				var value = attr;
				html +="<option value="+key+">"+value+"</option>";
			})
			html += "</select>";
			$(".agents").html(html);
			}else if(data.retcode==1){
				alert(data.message);
			}
			
		},error:function(e){
			alert(e.status);
		}
	})
	$('#replyebtn').click(function() {
		if($("#writeMessageQueryForm").valid()){
		var queryString = "&title="+encodeURI($("#title").val())+"&receiveagent="+encodeURI($("#receive_agent").val())+"&messagecontent="+$.trim($("#messagecontent").val());
			$.ajax({    
				type: "POST",
				url: "<%=basePath%>informationManage.do?type=saveReplyMessage",
				cache: false,
				timeout: 15000,
				data: queryString,
				dataType :"text",
				success: function(msg) {
					if(jQuery.trim(msg)=="101"){
						var result = "<img src='<%=basePath%>images/button/ok.gif'>信息发送成功！";
						$("input[type=text]").val("");
						$("textarea[id=messagecontent]").val("");
					}else if(jQuery.trim(msg)!="101"){
						result = "<img src='<%=basePath%>images/bg_btn3.gif'>信息发送失败！";
					} 
					$("#message").html(result);
					$("#message").show(200).delay(3000).hide(200);
				},
				error: function(){
					$("#message").html("<img src='<%=basePath%>images/bg_btn3.gif'>信息发送失败 ！");
					//alert("登录密码修改失败");
					$("#message").show(200).delay(3000).hide(200);
				}
		});
			}
		});
}
function ecode(value) {
	return encodeURI(encodeURI(value));
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
          <div class="nyTit">我的消息</div>
          <div class="blockremarknone" id="message" style="clear: both;"></div>
          <div class="gamenamebox">
              <jsp:include page="./newsTitle.jsp" >
			 		 <jsp:param name="num" value="2" /> 
				</jsp:include>
            <div class="gamename">
	               <div class="spcxtj" id="con_subpcx_3">
	               <form action="" id="writeMessageQueryForm">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz">消息标题：</td>
						    <td> 
						    	  <input name="title" type="text" class="input1" id="title" style="text-indent: 0;"/>
						    </td>
						  </tr>
						  <tr>
						    <td class="wz">接收代理商：</td>
						    <td class="agents"> 
						    	  
						    </td>
						  </tr>
						  <tr>
						    <td class="wz">消息内容：</td>
						    <td> 
						    	 <textarea rows="5" cols="30" id="messagecontent" name="messagecontent">
						    	 
								</textarea>
						    </td>
						  </tr>
						  <tr>
						    <td colspan="8" align="center"><input type="button" id="replyebtn"  type="submit" class="an_input2"   value="发送" /></td>
						    </tr>
						</table></form>
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
