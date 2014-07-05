<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>My JSP 'supplierManageNew.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">
 		<link href="${ctx}/themes/common/button.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.metadata.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.form.js"></script>
		<script type="text/javascript" src="${ctx}/js/jquery.pagination.js"></script>
		<script src="${ctx}/js/My97DatePicker/WdatePicker.js"			type="text/javascript"></script>
		<script src="${ctx}/js/My97DatePicker/namespace.js"			type="text/javascript"></script>
		<script src="${ctx}/js/My97DatePicker/datePicker_AutoSetDay.js"			type="text/javascript"></script>
		<script type="text/javascript">
		function load(){ 
			　　parent.document.getElementById("main").style.height =  "700px"; 
		   　} 
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

		<body onload="load();">
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%;">
					<div id="tabCot_product" class="tab" style="margin-right: 10px;">
						<div class="tabContainer" style="width: 100%">
						<c:if test="${praentId==-1}">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
									<li>
										<a href="javascript:void(0)" title="供货/退货受理" rel="2">供货/退货受理</a>
									</li>
								</ul>
							</div>
							
							<%@include file="supplierAccepted.jsp"%>
						</c:if>
						<c:if test="${praentId!=-1}">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
									<li class="currentBtn">
										<a href="javascript:void(0)" title="供货/退货申请" rel="1">供货/退货申请</a>
									</li>
									<li>
										<a href="javascript:void(0)" title="供货/退货受理" rel="2">供货/退货受理</a>
									</li>
									<li>
										<a href="javascript:void(0)" title="供货/退货查询" rel="3">供货/退货查询</a>
									</li>
								</ul>
							</div>
							<%@include file="supplierApplication.jsp"%>
							
							<%@include file="supplierAccepted.jsp"%>
							
							<%@include file="supplierApplicationQuer.jsp"%>
						</c:if>

						<div class="modBottom">
							<span class="modABL"></span>
							<span class="modABR"></span>
						</div>	
					</div>

				</div>
			</div>

			<div class="clear"></div>
		</div>
		</div>
		<div class="noprint">
			<script type="text/javascript" language="jscript">
function tab(o, s, cb, ev) {//tab切换类
	parent.resetTime(); 
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
