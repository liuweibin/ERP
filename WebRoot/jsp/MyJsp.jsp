<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String a= request.getParameter("pass");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page<%=a%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="<%=basePath%>js/jquery-1.8.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
function showAnnouncement(){
	$.ajax({
	    type: "post",
	    dataType: "json",
	    url: '<%=basePath%>announcementTbl/getTopTenAnnouncement.do',
	    timeout:30000,
	    error: function (xmlHttpRequest, error) { 
	                    $("showAnnouncement").innerHTML= "<p style='text-align:center;border:0;>查询出错，请刷新后重试！</p>"
	              },
		   success:function(json) {	    			
	 	  if(json.result=='ok'){
	 	  
	 	  
	 	  	var ullist = '<>';
	 	  	
				$.each(json.data,function(index,announcement){
					ullist += '<li><a href=\"announcementTbl/getDetail.do?id='+announcement.id+'\" target=\"_blank\">';
					ullist += announcement.title
					var time=announcement.createTime;
					ullist += '</a></p><span style=float:right;margin:3px;><cite>'+time.substring(0, 10)+'</cite></span></li';
				});
				
				if ( ullist == '' ) {
					ullist = "<p style='text-align:center;border:0;'>暂时没有公告</p>";
				}
			
				$("#showAnnouncement").html(ullist);
			  }			
	     }//end success
	  });//end ajax	
}
//showAnnouncement();
})
</script>
<style type="text/css">
ul li {list-style-type: none;}
.test_title{float: l}
</style>
  </head>
  
  <body>
  <div class="newsnr" style="width: 500px;height: 100px;border: 1px solid red;">
  	dddddddd
  <div style="z-index: 9990;border: 2px solid green;width: 300px;height: 50px;position:absolute; top:25px; left:75px;margin-left : 10px">aaaaaaaaa</div>
  
  sss
    </div>
	
  </body>
</html>
