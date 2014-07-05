<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


 <style type="text/css">
.tab #tabCot{
padding:20px 15px 10px 15px;
border-left:1px solid #d6d6d6;
border-right:1px solid #d6d6d6;
}
#tabCot_product_1{
border-left:1px solid #d6d6d6;
border-right:1px solid #d6d6d6;
}
#tabCot_product_1 ul  li  label{width: 100px;}

    </style>
<div
	id="tabCot_product_1" class="tabCot" style="padding: 20px 0px;">
	<ul class="formul" style="width: 100%">
	
		<li style="width: 100%">
			<label>
				代理商：
			</label>
			 <select id="userid" name="userid" style="width: 143px;">
			 <option value="">
							---全部---
						</option>
						<c:forEach items="${childsAgentsMap}" var="childsAgentsMap">
							<option value="${childsAgentsMap.key}">
								${childsAgentsMap.value}
							</option>
						</c:forEach>
					</select> 
		</li>
		<li style="width: 100%">
			<div style="" id="autoTime">

				<label>
					注册时间段：
				</label>
					<span>(<label style="color: blue;width: 86px;" 
						onclick="changeTimePanel('2');">
						手动选择时间
					</label>)</span>
				<br>
				<div style="margin-left: 30px;padding-top: 10px;">
				<span class="checkLab">
					 <input type="radio" name="timeRange" id="t" value="-1" checked /> 
					 <label for="t" style="width: 40px;color: black;">
						全部
					</label> 
				</span>
				<span> 
					<input type="radio" name="timeRange" id="t0" value="0" />
					<label for="t0" style="width: 40px;color: black;">
						当天
					</label> 
				</span>

				<span> 
					<input type="radio" name="timeRange" id="t1" value="1" />
					<label for="t1" style="width: 40px;color: black;">
						当月
					</label> 
				</span>

				<span> <input type="radio" name="timeRange" id="t2" value="2" />
					<label for="t2" style="width: 90px;color: black;">
						最近一个星期
					</label> </span>

				<span> <input type="radio" name="timeRange" id="t3" value="3" />
					<label for="t3" style="width: 80px;color: black;">
						最近一个月
					</label> </span>

				<span> <input type="radio" name="timeRange" id="t4" value="4" />
					<label for="t4" style="width: 80px;color: black;">
						最近三个月
					</label> </span>
			</div>

			</div>
			<div style="display: none;" id="handTime">
				<label>
					注册时间段：
				</label>
				<span>(<label style="color: blue;width: 38px;"
						onclick="changeTimePanel('1');">
						自动
					</label>)</span><br><div style="margin-left: 30px;padding-top: 13px;">
			<input type="text" id="agentstarttime" name="agentstarttime" style="width: 140px;height: 25px;" 
							class="Wdate middle" value="" 
							onFocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
							<span>至</span>
						<input type="text" id="agentendtime" name="agentendtime" class="Wdate middle" style="width: 140px;height: 25px;" 
						value=""
						onFocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
				</div>
			</div>
		</li>

		<li class="btnarea">
			<input type="submit" id="submitbtn" class="Partorange" value="查询" style="border: 0px;"/>
		</li>
	</ul>
	
	<div style="" id="autoTime">
				<div class="block" style="padding: 10px 0;">
									<form name="frm1" method="post">
	<table class="tablelist pusht" style="margin-top: 50px; width: 100%;">
			<tr style="width: 100%">
				<th style="width: 9%;">
					代理商编号
				</th>
				<th style="width: 9%;">
					代理商名称
				</th>
				<th style="width: 8%;">
					店铺类型
				</th>
				<th style="width: 8%;">
					审核状态
				</th>
				<th style="width: 9%;">
					类别
				</th>
				<th style="width: 9%;">
					上级代理商
				</th>
				<th style="width: 12%;">
					信用点余额（元）
				</th>
				<th style="width: 7%;">
					保证金(元)
				</th>
				<th style="width: 9%;">
					余额告警(元)
				</th>
				<th style="width: 7%;">
					手机号码
				</th>
				<th style="width: 14%;">
					注册时间
				</th>
			</tr>
			<tbody id="dataTable" style="text-align: center">
				</tbody>
				<td colspan="11" align="center" id="selectfactor">
					请选择查询条件
				</td>
		</table>
		</form>
								</div>
							</div>
		<div id="pages">
				<div id="Pagination" class="pagination"></div>
			</div>
	

<div class="clear"></div>
</div>

