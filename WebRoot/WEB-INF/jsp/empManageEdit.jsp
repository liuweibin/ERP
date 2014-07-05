<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'empManageEdit.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" language="javascript"
			src="${path}js/jquery.min.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${path}js/thickbox.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${path}js/jquery.validate.min.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${path}js/jquery.metadata.js">
</script>
<script type="text/javascript" language="JavaScript"
			src="${path}js/jquery.form.js">
</script>
		<script src="${ctx}js/jquery.bgiframe.min.js" type="text/javascript">
</script>
		<script src="${ctx}js/jquery.multiselect.js" type="text/javascript">
</script>
<script type="text/javascript">
function grouptypechange() {
	var selectvalue = document.getElementById("group").value;
	if (selectvalue != "") {
		$.ajax( {
			type : "POST",
			async : false,
			url : "empManage.do?type=groupname&groupid="
					+ selectvalue,
			dataType : "text",
			success : function(data) {
				var indexIfFactorObj = eval('(' + data + ')');
				var selectAddGroup = document.getElementById("userpermission");
			$("#userpermission").empty();
				var op = document.createElement("OPTION");
				op.value = indexIfFactorObj.id;
				op.innerHTML = indexIfFactorObj.remark;
				selectAddGroup.appendChild(op);

		}

		});
	}
}
$(document).ready(function() {
	grouptypechange();
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
$('#submiteditbtn').click(function() { 
	  var selectvalue = document.getElementById("group").value;
    var edituserid = document.getElementById("userid").value;
   $.ajax({ 
                cache: true, 
                type: "POST",
                async: false,
                url:"empManage.do?type=empManageUpdate&groupid="+selectvalue+"&edituserid="+edituserid, 
                data:$('#editForm').serialize(),// 你的formid 
                dataType:'text',
                error: function(request) { 
                	var result="";
                     result = "<img src='./images/bg_btn3.gif'>修改权限失败！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200); 
                }, 
                success: function(data) { 
                	var result="";
					 if(jQuery.trim(data)=="101"){
						 result = "<img src='./images/button/ok.gif'>修改权限成功！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200);
					 }else{
						 result = "<img src='./images/bg_btn3.gif'>修改权限失败！";
						$("#message").html(result);
						$("#message").show(200).delay(4000).hide(200);
					 }                	
                	closeWinNoLoad();
                } 
            });
  }); 
});

function refresh(){
   main.location.href="<%=basePath%>empManage.do?type=empManage";
}

</script>

  </head>
  
  <body>
		<input style="display: none" id="userid" name="userid" value="${userid}"/>
		<div class="blockremarknone" id="message" style="text-align: center;"></div>
		<form id="editForm" method="post" action="">
			<table width="40%">
				<tr>
					<td width="10%" align="right">
						<label for="firstname">
							代理商编号 ：
						</label>
					</td>
					<td >
					${agentsCode}
					</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
			<tr>
					<td align="right">
						<label for="password">
							真实姓名 ：
						</label>
					</td>
					<td>
						${realName}
						</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label for="rightname">
							登录名 ：
						</label>
					</td>
					<td>
						${username}
					</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label for="phone">
							手机号码 ：
						</label>
					</td>
					<td>
						${mobile}
					</td>
					
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
				
				<tr>
					<td>
						选择权限组 :
					</td>
				</tr>
				<tr>
					<td>
						<select name="group" id="group" style="width: 90px;"
							onchange="grouptypechange();">
						<c:forEach items="${agentsUserGroupTbl}" var="agentsUserGroupTbl">
						<c:if test="${agentsUserGroupTbl.id eq editGroupid}">
								<option value="${agentsUserGroupTbl.id}" selected="selected">
									${agentsUserGroupTbl.groupName}
								</option>
								</c:if>
						<c:if test="${agentsUserGroupTbl.id ne editGroupid}">
								<option value="${agentsUserGroupTbl.id}">
									${agentsUserGroupTbl.groupName}
								</option>
								</c:if>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<select name="userpermission" id="userpermission"
							multiple="multiple" style="width: 350px; height: 120px"><option>23123</option></select>
					</td>
				</tr>
				<tr>
					<td>
						</br>
					</td>
				</tr>
			</table>
			<ul>
				<li class="btnarea">
					<input style="color: green;width: 40px;" class="small" type="button" id="submiteditbtn" value="保存" />	
					<a href="javascript:void(0)" onClick="javascript:closeWinNoLoad();"><span>关闭</span> </a>
				</li>
			</ul>
		</form>
	</body>
</html>
