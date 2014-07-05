<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<style type="text/css">
#num{
    border:1px solid #E1E1E1;
    heigth: 5px;
    text-align:center;
    background-color: #CD0000;
    color: white;  
    border-top-left-radius:3px;
    border-top-right-radius:3px;
    border-bottom-right-radius:3px;
    border-bottom-left-radius:3px;text-decoration: none;
    padding-left: 5px;padding-right: 5px;
    margin-left: 3px;
}
.logo_wz ul li a:HOVER {color: white; text-decoration: none;}
</style>
<script type="text/javascript">
<!--
$(function(){
	resetTime();
	notReadMessage();
})
//刷新未读消息数
	function notReadMessage(){ 
		$.ajax({
			url:'<%=basePath%>informationManage.do?type=notReadMessageQuery',
			async:false,
			cache:false,
			dataType:'json',
			type:'post',
			success:function(data){
				var mess = data.data;
				if(mess==0){
					$("#num").html(mess);
				}else{
					$("#num").html(mess);
				}
				
			},
			error:function(error){alert("未读消息刷新失败,请重试.:"+error.status);}
		});
	}
//-->
</script>
<div class="top_1">
    <div class="top">      
      <div class="logo_wz">
        <div class="logo"><img src="<%=basePath%>images/images/index_04.jpg" width="270" height="55" /></div>
        <div class="welecome">
        		欢迎您，代理商 <span class="a1"><a href="#">${username}</a></span><br>
      			离线倒计时：<span id="showTimes" class="orange" style="color: orange;">04:00:00</span> 
		</div>
        <ul class="logoin_mu"> 
          <li><a href="<%=basePath%>jsp/newsManage.jsp" style="padding-right: 5px;">我的消息<span id="num"></span></a>│</li>
          <li><a href="<%=basePath%>jsp/securitySet.jsp">安全设置</a>│</li>
          <li><a href="javascript:void(0);" onclick="IsExit('${ctx}')" >退出系统</a></li>
        </ul>
      </div>
   </div>
  </div>
