<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>My JSP 'writeMessage.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" type="text/css"
			href="${ctx}/themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"
			href="${ctx}/themes/sales/home/esales.style.css">
			
		<link href="${ctx}/themes/common/button.css" rel="stylesheet"			type="text/css" />
			<script type="text/javascript" language="javascript"
			src="${ctx}/js/jquery.min.js">
</script>
		
		<script type="text/javascript" language="javascript"
			src="${ctx}/js/jquery.tableui.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.pagination.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/thickbox.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.form.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.validate.min.js">
</script>
		<script type="text/javascript" language="JavaScript"
			src="${ctx}/js/jquery.metadata.js">
</script>
<script src="${ctx}/js/My97DatePicker/WdatePicker.js"
			type="text/javascript">
</script>

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
function ecode(value) {
	return encodeURI(encodeURI(value));
}
$(document).ready(function() {
	$('#replyebtn').click(function() {
		if($("#writeMessageQueryForm").valid()){
		var queryString = "&title="+encodeURI($("#title").val())+"&receiveagent="+encodeURI($("#receive_agent").val())+"&messagecontent="+$.trim($("#messagecontent").val());
			$.ajax({    
				type: "POST",
				url: "informationManage.do?type=saveReplyMessage",
				cache: false,
				timeout: 15000,
				data: queryString,
				dataType :"text",
				success: function(msg) {
					if(jQuery.trim(msg)=="101"){
						var result = "<img src='./images/button/ok.gif'>信息发送成功！";
						$("input[type=text]").val("");
						$("textarea[id=messagecontent]").val("");
					}else if(jQuery.trim(msg)!="101"){
						result = "<img src='./images/bg_btn3.gif'>信息发送失败！";
					} 
					$("#message").html(result);
					$("#message").show(200).delay(3000).hide(200);
				},
				error: function(){
					$("#message").html("<img src='./images/bg_btn3.gif'>信息发送失败 ！");
					//alert("登录密码修改失败");
					$("#message").show(200).delay(3000).hide(200);
				}
		});
			}
		});
});
</script>

<style type="text/css">
.checkLab {
	background: #dc143c;
	color: #fff;
	padding-top: 3px;
	padding-bottom: 3px;
	height: 25px;
	line-heigth: 25px;
	border: 1px solid #f0e68c;
}

.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}

</style>

	</head>

	<body>
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%; height: 60%;">
					<div id="tabCot_product" class="tab"
						style="width: 100%; height: 30px">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
									<a href="javascript:void(0)" title="消息中心" rel="1">消息中心</a>
								</li>

							</ul>
						</div>
						<div id="tabCot">

							<div style="" id="autoTime">

								<div class="block">

									<%--<div class="blockcommon">
									--%>
									<div class="subnav">
										<a href="informationManage.do?type=IfMessage" target="_self"
											class="current"> <span>收件箱</span> </a>
										<a href="informationManage.do?type=sendMessage" target="_self"> <span>发件箱</span>
										</a>
										<a href="${ctx}/informationManage.do?type=writeMessage" target="_self"> <span>发消息</span>
										</a>
										</div>

								</div>
							</div>


							<div class="clear"></div>
						</div>

						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>
					</div>

					<%-- form页面 --%>
					<div class="blockremarknone" id="message"></div>
						<div class="blockcommon pusht">
						<form id="writeMessageQueryForm" method="post" action="">
				<table width="100%">
					<tr>
						<td align="right">
							<label for="customName">
								消息标题 <em>*</em>：
							</label>
						</td>
						<td style="width: 70%">
							<input type="text" id="title" name="title"/>
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="fixedPhone">
								接收代理商<em>*</em>：
							</label>
						</td>
						<td >
						<select id="receive_agent" name="receive_agent" style="width: 160px">
						<c:forEach var="agentitems" items="${agentmap}">
						<option value="${agentitems.key}">${agentitems.value}</option>
						</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label for="mobilePhone">
								消息内容<em>*</em>：
							</label>
						</td>
						<td style="width: 70%">
						<textarea rows="5" cols="30" id="messagecontent" name="messagecontent">
						</textarea>
						</td>
					</tr>
					<tr>
						<td>
							</br>
						</td>
					</tr>
				</table>
				<ul style="margin:10px,0px,0px,160px;">
					<li class="btnarea" style="text-align: center;">
			<input type="button" id="replyebtn"   class="Partorange" value="发送"/>
					</li>
				</ul>
			</form>
						</div>
				</div>
			</div>


			<div class="clear"></div>
		</div>
		</div>
		<div class="noprint">
			<script type="text/javascript" language="jscript">
function tab(o, s, cb, ev) {//tab切换类
	var $ = function(o) {
		return document.getElementById(o)
	};
	var css = o.split((s || '_'));
	if (css.length != 4)
		return;
	this.event = ev || 'onclick';
	o = $(o);
	if (o) {
		this.ITEM = [];
		o.id = css[0];
		var item = o.getElementsByTagName(css[1]);
		var j = 1;
		for ( var i = 0; i < item.length; i++) {
			if (item[i].className.indexOf(css[2]) >= 0
					|| item[i].className.indexOf(css[3]) >= 0) {
				if (item[i].className == css[2])
					o['cur'] = item[i];
				item[i].callBack = cb || function() {
				};
				item[i]['css'] = css;
				item[i]['link'] = o;
				this.ITEM[j] = item[i];
				item[i]['Index'] = j++;
				item[i][this.event] = this.ACTIVE;
			}
		}
		return o;
	}
}
tab.prototype = {
	ACTIVE : function() {
		var $ = function(o) {
			return document.getElementById(o)
		};
		this['link']['cur'].className = this['css'][3];
		this.className = this['css'][2];
		try {
			$(this['link']['id'] + '_' + this['link']['cur']['Index']).style.display = 'none';
			$(this['link']['id'] + '_' + this['Index']).style.display = 'block';
		} catch (e) {
		}
		this.callBack.call(this);
		this['link']['cur'] = this;
	}
}

new tab('tabCot_product-li-currentBtn-', '-');
</script>
		</div>

	</body>
</html>