<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>My JSP 'editPwd.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link href="${ctx}/themes/common/titletab.css" rel="stylesheet"			type="text/css" />
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/of.global.100518.css">
		<link rel="stylesheet" type="text/css"			href="${ctx}/themes/sales/home/esales.style.css">
 		<link href="${ctx}/themes/common/button.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" language="javascript"			src="${ctx}/js/common/jquery-1.8.0.min.js"></script>
		<script type="text/javascript" language="javascript"			src="${ctx}/js/jquery.tableui.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.pagination.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/thickbox.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.form.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.validate.min.js"></script>
		<script type="text/javascript" language="JavaScript"			src="${ctx}/js/jquery.metadata.js"></script>
<script src="${ctx}/js/My97DatePicker/WdatePicker.js"	type="text/javascript"></script>
	<script src="${ctx}/js/My97DatePicker/namespace.js"			type="text/javascript"></script>
<script src="${ctx}/js/My97DatePicker/datePicker_AutoSetDay.js"			type="text/javascript">
</script>
	

<script language="javaScript">
$(document).ready(function() {
	var dataPicker;
	var otherDay = '';
	if(''=='prv')
		otherDay = 'Yesterday';
	else// if(''=='cur')
		otherDay = 'Today';
	if(''!=''){
		if(''!='')
			dataPicker = new OfCard.DatePicker({title:'',endnum:'',otherDay:otherDay});
		else
			dataPicker = new OfCard.DatePicker({otherDay:otherDay});
	}else{
		if(''!='')
			dataPicker = new OfCard.DatePicker({title:'',otherDay:otherDay});
		else
			dataPicker = new OfCard.DatePicker({otherDay:otherDay});
	}
     dataPicker.initPicker();

	if(''!=''&&''!=''){
		var type = $('#t3').attr("type");
		if(type=="radio"){
			$('#t3').click();
			$("input[type=radio][name=timeRange]").parent().removeClass('checkLab');
			$('#t3').parent().addClass('checkLab');
		}else{
			$('#t3').attr('selected','selected');
			$('#timeRange').change();
		}
		$('#starttime').val('');
		$('#endtime').val('');
	}
	 
	//$("input[type=radio]").click(
	//function(){
		//var name=($(this).attr('name'));
		//$("input[type=radio][name="+name+"]").parent().removeClass('checkLab');
		//$(this).parent().addClass('checkLab');
	//});

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
</style>
<script type="text/javascript">
var pageno = 1;     
  function pageselectCallback(page_id, jq){
	 var pageno_id=page_id+1
	loginfactor(pageno_id);
	return false;
  }

function loginfactor(pageno){
	//var logstarttime = $.trim($("#logstarttime").val());
	//var logendtime = $.trim($("#logendtime").val());
	var url_ = "account.do?type=loginLogQuery&logstime="+$.trim($("#starttime").val())+"&logetime="+$.trim($("#endtime").val())+"&pageno=" + pageno + "&pagesize=15";
	$
			.ajax( {
				type : "POST",
				url : url_,
				cache : false,
				timeout : 15000,
				dataType : 'json',
				error : function(request) {
					$("#logdataTable").html('<tr><td colspan="12" class="red">查询出错，请刷新后重试！</td></tr>');
					$("#selectlogfactor").css("display", "none");
				},
				success : function(data) {
					var total=0;
					var pageno=0;
					var pagesize;
					$("#selectlogfactor").css("display", "none");
					var tab = '';
					for ( var i = 0; i < data.length; i++) {
						total=data[i].totalCount;
						pagesize=data[i].pageSize;
						pageno=data[i].pageNo;
						tab += '<tr>';
						tab += '<td>' + data[i].agentsUserName + '</td>';
						tab += '<td>' + data[i].logDesc + '</td>';
						tab += '<td>' + data[i].ipAddress + '</td>';
						tab += '<td>' + data[i].createTime + '</td>';
						tab += '</tr>';
					}
					if (tab != '') {
						$("#logdataTable").html(tab);

					} else {
						$("#logdataTable").html(
								'<tr><td colspan="11">没有符合条件的记录！</td></tr>');
					}
					$("#logdataTable tr").hover(function() {
						$(this).addClass("over");
					}, function() {
						$(this).removeClass("over");
					});
					 var current_page=pageno-1;
					$("#Pagination").pagination(total, {
						callback: pageselectCallback,
						prev_text: '上一页',       //上一页按钮里text  
						next_text: '下一页',       //下一页按钮里text  
						items_per_page: pagesize,  //显示条数  
						num_display_entries: 6,    //连续分页主体部分分页条目数  
						current_page: current_page,   //当前页索引  
						num_edge_entries: 2        //两侧首尾分页条目数  
					});
					parent.document.getElementById("main").style.height= window.document.body.clientHeight+70+"px";
				}
			});
}

$(document).ready(function() {
		loginfactor(0);
	$("#loginSubmit").click(function() {
			loginfactor(0);
	});
});

</script>





<script language="javascript">
<!--
	var t = 0;
	$(document).ready(function() {
		
		changeTabStyle();
		
		//ie6 resize bug 解决
		if($.browser.msie) {
				$(window).resize(function() {
			    var now = new Date();
          now = now.getTime();
					if (now - t> 300) {
							t = now;
							changeTabStyle();
					}
         });
		}else{
			$(window).resize(function() {
			   changeTabStyle();
      });
		}//end if

  });//end ready
	
	function changeTabStyle(){
	
		try{
			var w=getPageW();
			if(Number(w)<960&&$("#tab").children().size()>5){
				$("#tab").attr("id","tab-qq");
			}else{
				$("#tab-qq").attr("id","tab");
			}
		
		}catch(e){
			
		}
	}
	
	function getPageW(){
            
            if($.browser.msie){
                return document.compatMode == "CSS1Compat"? document.documentElement.clientWidth :
                         document.body.clientWidth;
            }else{
                return self.innerWidth;
            }
	}//end fun
	
	
	
//-->
	function load(){
		//　　parent.document.getElementById("main").style.height = window.document.body.clientHeight+"px"; 
		　parent.document.getElementById("main").style.height =  "800px"; 
	     　} 
</script>




<style type="text/css">
.tab #tabCot {
	padding: 20px 15px 10px 15px;
	border-left: 1px solid #d6d6d6;
	border-right: 1px solid #d6d6d6;
}
.checkLab {
	background: #dc143c;
	color: #fff;
	padding-top: 3px;
	padding-bottom: 3px;
	height: 25px;
	line-heigth: 25px;
	border: 1px solid #f0e68c;
}


.checkLab {
	background: #dc143c;
	color: #fff;
	padding-top: 3px;
	padding-bottom: 3px;
	height: 25px;
	line-heigth: 25px;
	border: 1px solid #f0e68c;
}

</style>

	</head>

	<body onload="load()"> 
		<div id="wrap" style="width: 100%">
			<div id="body" style="width: 100%">
				<div id="main" style="overflow: hidden; width: 100%; ">
					<div id="tabCot_product" class="tab" style="width: 100%;height: 120px">
						<div class="tabContainer" style="width: 100%">
							<ul class="tabHead" id="tabCot_product-li-currentBtn-">
								<li class="currentBtn">
								<a href="${ctx}/account.do?type=loginLog" title="账户管理" rel="1">账户管理</a>
								</li>

							</ul>
						</div>
						<div id="tabCot" style="height:57px;">

							<div style="" id="autoTime">

								<div class="block">
								
								<%--<div class="blockcommon">
									--%><div class="subnav">
										<a href="account.do?type=baseInfoPage" target="_self"
											class="current"> <span>基本资料</span> </a>
										<a href="account.do?type=editPwd" target="_self"> <span>修改密码</span>
										<a href="account.do?type=loginLog" target="_self">
											<span>登录日志</span> </a>

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
			<form name="queryFrm1" id="queryFrm1" method="post">
			<input type="hidden" name="pageno" id="pageno" value="0" />
			<div class="blockcommon pusht mp " style="margin-top: 10px;">
				<li class="" id="queryDate"></li>
		</div>
			<div class="blockcommon pushts" style="text-align: center;">
				<input id="loginSubmit" type="button"  class="Partorange" style="width: 80px;" value="查询">
					</span>
			</div>
			
			<table class="tablelist pusht">
				<thead>
					<tr>
						<th>
							登录者
						</th>
						<th>
							登录信息
						</th>
						<th>
							登录ip
						</th>
						<th>
							登录时间
						</th>
					</tr>
				</thead>
				<tbody id="logdataTable" style="text-align: center"></tbody>
					<tr><td align="center" colspan="10" id="selectlogfactor">没有符合条件的记录！</td></tr>
			</table>
			<!-- 分页开始 -->
			<div id="pages">
				<div id="Pagination" class="pagination"></div>
			</div>
			<!-- 分页结束 -->
		</form>




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
