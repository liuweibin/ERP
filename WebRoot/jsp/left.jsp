<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%--<link href="<%=basePath%>css/css.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/tab.js"></script>
--%><script type="text/javascript">
/*刷新余额*/	
function ajaxAccount(){
	$.ajax({
		url:'<%=basePath%>account.do?name=getUserBalance',
		async:false,
		cache:false,
		dataType:'json',
		type:'post',
		success:function(data){
			
			if(data.retcode=="0"){
				data = 	data.data;
				$("#useableBalance").html(data.useableBalance);
				$("#balance").html(data.balance);
				$("#bail").html(data.bail);
			}else if(data.retcode=="1"){
				alert(data.message);
			}else if(data.retcode=="2"){
				alert("session过期请重新登录");
				window.location.replace("<%=basePath%>jsp/login.jsp");
			}
		},
		error:function(error){
			alert("余额刷新失败,请重试.:"+error.status);
		}
	});
}
ajaxAccount();
/*刷新余额 end*/
 /*
$.ajaxSetup({
	contentType : "application/x-www-form-urlencoded;charset=utf-8",
	complete : function(XMLHttpRequest, textStatus) {
		// 通过XMLHttpRequest取得响应头，sessionstatus
		var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");
		if (sessionstatus == "sessionOut") {
			// 这里怎么处理在你，这里跳转的登录页面
			alert("timeout");
			window.location ="<%=basePath%>jsp/login.jsp";
		}
	}
});
*/

</script>
<div class="content_nrleft">
        <div class="kjcz">
          <strong>快捷操作</strong>
          <ul class="kjcz_ul">
            <li><a href="<%=basePath%>jsp/sjcz.jsp?num=0">本省充值</a></li>
            <li class="bodernor"><a href="<%=basePath%>jsp/gameCzForm.jsp?goodsCode=qq">Q币充值</a></li>
            <li><a href="<%=basePath%>jsp/sjcz.jsp?num=1">全国充值</a></li>
            <li class="bodernor"><a href="<%=basePath%>jsp/gamecz.jsp">游戏充值</a></li>
            <li class="bodernob"><a href="<%=basePath%>jsp/ghcz.jsp?num=2">固话充值</a></li>
            <li class="bodernor bodernob"><a href="<%=basePath%>jsp/index.jsp">放号</a></li>
            <!--  class="bodernor bodernob" -->
          </ul>
        </div>
        <div class="gncd">
          <strong>功能菜单</strong>
          <ul class="gncd_ul" id="suckertree1">
            <li><a href="<%=basePath%>jsp/czCorrectTradeRecordQuery.jsp">充值缴费</a>
              <dl>
                <dt><img src="<%=basePath%>images/images/bg05.png" width="9" height="13" /></dt><%--
                <dd><a href="<%=basePath%>jsp/sjcz.jsp?num=0&goodsCode=G0000001">广东省充值</a></dd>
                <dd><a href="<%=basePath%>jsp/sjcz.jsp?num=1">全国充值</a></dd>
                <dd><a href="<%=basePath%>jsp/ghcz.jsp">固话充值</a></dd>
                <dd><a href="<%=basePath%>jsp/gameCzForm.jsp">Q币充值</a></dd>
                <dd><a href="<%=basePath%>jsp/gamecz.jsp">游戏币充值</a></dd>
                <dd><a href="<%=basePath%>jsp/sjcz.jsp?num=5">支付宝充值</a></dd>
                --%>
                <dd><a href="<%=basePath%>jsp/sjCorrect.jsp?num=0">冲正</a></dd>
                <dd><a href="<%=basePath%>jsp/czCorrectTradeRecordQuery.jsp">冲正记录查询</a></dd>
                <dd><a href="<%=basePath%>jsp/czTradeRecordQuery.jsp">交易记录查询</a></dd>
              </dl>
            </li>
            <li><a href="<%=basePath%>jsp/physicalBuyOperation.jsp">实物商城</a>
              <dl>
                <dt><img src="<%=basePath%>images/images/bg05.png" width="9" height="13" /></dt>
                <dd><a href="<%=basePath%>jsp/physicalBuyOperation.jsp">采购</a></dd>
                <dd><a href="<%=basePath%>jsp/physicalAcceptedOperation.jsp?num=2">供货/退货受理</a></dd>
                <dd><a href="<%=basePath%>jsp/physicalOperationQuery.jsp?num=3">供货/退货查询</a></dd>
              </dl>
            </li>
            <li><a href="<%=basePath%>jsp/queryGoods.jsp?num=1">商品查询</a>
              <dl>
                <dt><img src="<%=basePath%>images/images/bg05.png" width="9" height="13" /></dt>
                <dd><a href="<%=basePath%>jsp/queryGoods.jsp?num=1">实体商品查询</a></dd>
                <dd><a href="<%=basePath%>jsp/queryGoods.jsp?num=2">虚拟商品查询</a></dd>
                <dd><a href="<%=basePath%>jsp/queryGoods.jsp?num=3">商品进价查询</a></dd>
              </dl>
            </li>
            <li><a href="<%=basePath%>jsp/financialBuyPointQuery.jsp">财务管理</a>
              <dl>
                <dt><img src="<%=basePath%>images/images/bg05.png" width="9" height="13" /></dt>
                <dd><a href="<%=basePath%>jsp/buypoint.jsp">购买信用点</a></dd>
                <dd><a href="<%=basePath%>jsp/transferPoint.jsp">信用点转账</a></dd>
                <dd><a href="<%=basePath%>jsp/financialBuyPointQuery.jsp">购买信用点查询</a></dd>
                <dd><a href="<%=basePath%>jsp/financialStreamQuery.jsp">账务流水查询</a></dd>
                <dd><a href="<%=basePath%>jsp/financialFlowsQuery.jsp">转出信用点查询</a></dd>
                <dd><a href="<%=basePath%>jsp/financialInflowsQuery.jsp">转入信用点查询</a></dd>
              </dl>
            </li>
             <li><a href="<%=basePath%>jsp/memberManager.jsp">下级</a> 
             <dl>
                <dt><img src="<%=basePath%>images/images/bg05.png" width="9" height="13" /></dt>
                <dd><a href="<%=basePath%>jsp/memberManager.jsp">下级基本信息</a></dd>
                <dd><a href="<%=basePath%>jsp/memberFinance.jsp">下级账务</a></dd>
                <dd><a href="<%=basePath%>jsp/memberGoods.jsp">下级商品</a></dd>
                <dd><a href="<%=basePath%>jsp/memberOrder.jsp">下级订单</a></dd>
                <dd><a href="<%=basePath%>jsp/memberRegister.jsp">下级注册</a></dd>
              </dl>
              </li>          
             <li><a href="<%=basePath%>jsp/reconciliationGDCZ.jsp">对账管理</a>
            	 <dl>
                <dt><img src="<%=basePath%>images/images/bg05.png" width="9" height="13" /></dt>
                <dd><a href="<%=basePath%>jsp/reconciliationGDCZ.jsp">本省充值统计</a></dd>
                <dd><a href="<%=basePath%>jsp/reconciliationDay.jsp">日对账</a></dd>
              	</dl>
               </li>          
             <li><a href="<%=basePath%>jsp/memberManager.jsp">我的账户</a> 
	              <dl>
		                <dt><img src="<%=basePath%>images/images/bg05.png" width="9" height="13" /></dt>
		                <dd><a href="<%=basePath%>jsp/myAccountBasicInfo.jsp">基本资料</a></dd>
		                <dd><a href="<%=basePath%>jsp/myAccountChangePWD.jsp">修改密码</a></dd>
		                <dd><a href="<%=basePath%>jsp/myAccountLoginLog.jsp">登录日志</a></dd>
              	  </dl>
              </li>          
          </ul>
        </div>
        <div class="lx_qb">
          <ul>
            <li class="hover" id="lxqb1" onclick="setTab('lxqb',1,2)">联系我们</li>
            <li id="lxqb2" onclick="setTab('lxqb',2,2)">我的钱包</li>
          </ul>
          <div class="lx_qbnr">
            <div id="con_lxqb_1">
            <c:forEach items="${list}" var="config">
					<c:choose >
					<c:when test="${config.nameEn=='Join_Hotline'}">
					<span>${config.nameCn}:${config.value}</span> <br>
					</c:when>
					<c:when test="${config.nameEn=='qq'}">
					<span style="display: block;"> ${config.nameCn}:${config.value}</span>  
					</c:when>
					<c:when test="${config.nameEn=='National_Hotline'}">
					<span>  ${config.nameCn}:${config.value} </span> 
					</c:when>
					</c:choose>
			   </c:forEach>
            </div>
            <div id="con_lxqb_2">
            钱包余额：<span id="balance">${balance}</span> 元<br>
            可用额度：<span id="useableBalance">${useableBalance}</span> 元<br>
            冻结资金： <span id="bail">${bail}</span> 元 <font class="a2"><a onclick="ajaxAccount();" href="javascript:void(0)">[刷新]</a></font></div>
          </div>
        </div>
      </div>
