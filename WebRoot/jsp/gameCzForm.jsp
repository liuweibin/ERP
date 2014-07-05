<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp"%>
<%
	String goodsCode = request.getParameter("goodsCode");
%>
<style type="text/css">
.hidetxt{cursor:default;border: 0px solid #FF0000; }
.select {width: 285px;font-size: 25px;height:38px; line-height:38px;border:0px solid #a7d3ff;margin-left: 5px;}
</style>

<script type="text/javascript" src="<%=basePath%>js/game_props/gamePropstd.js">
</script>


<script type="text/javascript"> 
var cache;
var selectData ="";
  
function init(){
	 $.formValidator.initConfig({
		 formID:"form_",
		 submitOnce:true,
		 onSuccess:function(){
			 creatOrder();
				//alert("校验组1通过验证，不过我不给它提交");	
		 },onerror:function(msg,obj,errorlist){
				alert(msg);
			}
		});
		$("#sellPrice").formValidator({ tipid: "sellPriceTip",onShow:"默认为建议零售价",onFocus:"实际销售价格",onCorrect:""})
		  .regexValidator({regExp:"decmal6",dataType:"enum",onError: "请输入正确的价格"});
		
		 
			$("#id_gameAccount").formValidator({onShow:"请输入游戏账号",onFocus:"至少1个长度",onCorrect:"游戏账号合法"}).inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:"游戏账号两边不能有空符号"},onError:"游戏账号不能为空,请确认"});
			$("#confirm_gameAccount").formValidator({onShow:"再次输入游戏账号",onFocus:"至少1个长度",onCorrect:"游戏账号一致"}).inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:"重复游戏账号两边不能有空符号"},onError:"重复游戏账号不能为空,请确认"}).compareValidator({desID:"id_gameAccount",operateor:"=",onError:"2次游戏账号不一致,请确认"});
		 
	 
		$("#buyNum").formValidator({onShow:"请选择充值数量",onFocus:"充值数量必须选择",onCorrect:""})
		.inputValidator({empty:true,onError: "你是不是忘记选择充值数量了!"});
 
		
		$("#supperPassword").formValidator({onShow:"请输入交易密码",onFocus:"至少8位字符或数字",onCorrect:"交易密码格式正确"}).
		inputValidator({min:8,max:20,onError:"交易密码至少8位"});
}
//------games
function gameCzAjax(params){
params =(encodeURI(params));
	$.ajax({
		url:'<%=basePath%>goodsSales/games/gameInfoInit.do?'+params,
		dataType:'json',
		type:'post',
		async: false,
		success:function(datas){ 
			if(datas.retcode==1){
				alert(datas.message);
			}else if(datas.retcode==0){
				attributes = datas.data;
				loadProps(attributes);
				$("#token").val(attributes.token);
			}else if(datas.retcode==2){
			 		window.location ="<%=basePath%>jsp/error/noGoods.jsp";
			}
		},
		error:function(e){
			alert("游戏商品加载出错"+e.status)
		}
	});
}


function getMap() {//初始化map_,给map_对象增加方法，使map_像Map    
    var map_ = new Object();    
    map_.put = function(key, value) {    
        map_[key+'_'] = value;    
    };    
    map_.get = function(key) {    
        return map_[key+'_'];    
    };    
    map_.remove = function(key) {    
        delete map_[key+'_'];    
    };    
    map_.keyset = function() {    
        var ret = "";    
        for(var p in map_) {    
            if(typeof p == 'string' && p.substring(p.length-1) == "_") {    
                ret += ",";    
                ret += p.substring(0,p.length-1);    
            }    
        }    
        if(ret == "") {    
            return ret.split(",");    
        } else {    
            return ret.substring(1).split(",");    
        }    
    };    
    return map_;    
}  

function test(attributes){
	var obj = eval( attributes );
	attributes = obj; 
	var map =  getMap();
		var sb = "";
		$('#game_name').val(attributes.goodsName);
		$('#parValue').val(attributes.parValue);
		$('#parValueTip').val(attributes.parValue);
		$('#sellPrice').val(attributes.suggestRetailPrice);
		$('#goodsCode').val(attributes.goodsCode);
		$('#batchPrice').val(attributes.batchPrice);
		$('#price').text(attributes.batchPrice+"元");
		$('#priceTip').text("("+attributes.batchPrice+"元*1)");
		var good_attributes = attributes.attribute;
		if(!good_attributes){
			return;
		}
	$.each(good_attributes,function(i,attr){
		var labelType = attr.labelType;//'标签类型（0是Input:text、1是select）',
		var display = attr.display;//'是否显示（0不显示，1显示）',
		var mapField = attr.mapField;
		var valueType = attr.valueType;// （0:默认值，1通过url，2:不给值）',
		var nameCn = attr.nameCn;
		var nameEn = attr.nameEn;
		var orderNo = attr.orderNo;
		var id = attr.id;
		var value = attr.value;
		var params = attr.params;
		var isMapping = attr.isMapping;
		map.put(orderNo,nameEn);
		var display_ = "";
		if(display==0){
			 display_ = "display:none;";
		}
			if(labelType==0){
				//0是Input:text
				if(valueType==0){ //（0:默认值
					sb +="<tr style="+display_+"><td class='wz'>"+nameCn+"：</td><td><input type='text' value='"+value+"' name='"+nameEn+"' class='input4' id='textfield4' /></td><td>&nbsp;</td></tr>";
				}else if(valueType==2){
					//，2:不给值）',
					if(nameEn=="gameAccount"){
						sb +="<tr><td class='wz'>"+nameCn+"：</td><td><input   type='text' value='"+value+"'  class='input1' id='gameAccount' name='gameAccount' /></td><td><span id='gameAccountTip'></span></td></tr>";
						sb +="<tr class='confirm_gameAccount'><td class='wz'>确认"+nameCn+"：</td><td><input   type='text' value='"+value+"'   class='input1'  id='confirm_gameAccount' name='confirm_gameAccount' /></td><td><span id='confirm_gameAccountTip'></span></td></tr>";
					}else{
						sb +="<tr><td class='wz'>"+nameCn+"：</td><td><input  type='text' value='"+value+"'  name='"+nameEn+"'  class='input1'  /></td><td>&nbsp;</td></tr>";
					}
				}else if(valueType==1){//，1通过url
					var res = getGoodsParams(params);
					if(res.indexOf("!=")>-1){
						sb +="<tr style="+display_+"><td class='wz'>"+nameCn+"：</td><td><input  name='"+nameEn+"' type='text'  onclick=listen(this,'"+value+"','"+res+"') readonly='readonly'    class='input4'  /></td><td>&nbsp;</td></tr>";
					}else{
						var r_value=ajax_text(value,res);
						sb +="<tr style="+display_+"><td class='wz'>"+nameCn+"：</td><td><input  name='"+nameEn+"' type='text'  value='"+r_value+"'  readonly='readonly'   onclick=listen(this,'"+value+"','"+res+"')  class='input4'  /></td><td>&nbsp;</td></tr>";
					}
				}
			}else if(labelType==1){//1是select
					if(valueType==0){ //（0:默认值
						sb +="<tr style="+display_+"> <td class='wz'>"+nameCn+"：</td>";
						sb +="<td>  ";
						sb +="<select name='"+nameEn+"'  title="+nameCn+"'不能为空' class='select' id='"+nameEn+"'> ";
						var r_value=value;
						var strs= new Array(); //定义一数组
						strs=r_value.split(","); //字符分割      
						for (i=0;i<strs.length ;i++ )    
						    {    
						sb +="<option value='"+strs[i]+"'>"+strs[i]+"</option>";// 
						    } 
						sb +="</select> </td><td>&nbsp;</td></tr>";
					}else if(valueType==1){//，1通过ur
						sb +="<tr style="+display_+"> <td class='wz'>"+nameCn+"：</td>";
						sb +="<td>";
						var res = getGoodsParams(params);
						if(res.indexOf("!=")>-1){
							selectData += nameEn +",";
							sb +="<select '  class='select'  id='"+nameEn+"' title='"+nameCn+"不能为空'   onclick=listen(this,'"+value+"','"+res+"')   >"; 
							 sb +="<option selected='selected'  value=''>"+"请选择"+nameCn+"</option>";
						}else{
							selectData += nameEn +",";
							 sb +="<select  name='"+nameEn+"'  title='"+nameCn+"不能为空'  class='select' onchange=listenBuyNum(this,'"+value+"','"+res+"')    id='"+nameEn+"' >";  
							 var r_value=ajax(value,res);
							 sb +=r_value;// 
						}
						sb +="</select> </td><td><span id='"+nameEn+"Tip'></span></td></tr>";
						
					}else if(valueType==0){ }
		 }
				function getGoodsParams(params){//参数处理
					var result='';
					if(params=="")return result;
					var arr = new Array();
					arr = params.split(",");
					for(var i=0;i<arr.length;i++){
						var arr_param = new Array();
						arr_param = arr[i].split("=")
						if(arr_param[0]!="goodsContentId"&&arr_param[0]!="goodsCode"){
							var temp = arr_param[0]+"="+arr_param[1];
							var orderNo = arr_param[1];
							var id = map.get(orderNo);
							var value = arr_param[0]+"!="+id;
							params = params.replace(temp,value);
						}
					}
					result +=params.replace(/,/g,"&");
					return result;
				}
		});
		$("#add").append(sb); 
	}
	

function ajax_text(url,params){
	var re="";
	$.ajax({
		url:"<%=basePath%>"+url,
		dataType:'text',
		type:'post',
		async:false,
		data:params,
		success:function(datas){
			re = datas;
		},error:function(e){
			alert(e.status);
		}
	});
	return re;
}
function ajax(url,params){
	var re="";
	$.ajax({
		url:"<%=basePath%>"+url,
		dataType:'json',
		type:'post',
		async:false,
		data:params,
		success:function(datas){
			var data =datas;// eval(datas);
			for(var i=0;i<data.total;i++){
					re += "<option  value='"+data.data[i].id+"'>"+data.data[i].name+"</option>"
			}// value='"+data.data[i].id+"'
		},error:function(e){
			alert(e.status);
		}
	});
	return re;
}

function listenBuyNum(o,url,params){ 	 
	if(o.id=='buyNum'){
		select();
	}else{
		
	} 
}
function select(){ 
	var num = $("#buyNum").val();
	var parValue = $("#parValue").val();
	var price = ((parValue*1000)*num)/1000;
	$("#price").text(price);
	$("#priceTip").text("元("+parValue+"元*"+num+")");
}
 
function listen(o,url,params){
	var arr_params = new Array();
	var arr_param = new Array();
	arr_params = params.split("&");
	for(var i=0;i<arr_params.length;i++){
		if(arr_params[i].indexOf("!=")>-1){
			arr_param = arr_params[i].split("!=");
		}
	}
	var value = $('#'+arr_param[1]).val();
	if(value=="")return;//父节点为空时返回
	if(value==cache){//父节点没有改变子节点不在重新加载
		if(o.id=='buyNum')select();
		return;
	}
	cache = value;
	var new_params= params.replace(arr_param[1],value);
	new_params= new_params.replace("!=","=");
	var option = ajax(url,new_params);
	$("#"+o.id).empty();
	$("#"+o.id).append(option);
	if(o.id=='buyNum')select();
	var pid='id='+arr_param[1];
	if($("#add").html().split("onchange=pListen")==-1)//判断是否已经添加了监听
	{
		var html = $("#add").html().replace(pid,pid+"  onchange=pListen(this,"+o.id+",'"+url+"','"+params+"')");//给父元素添加监听
		$("#add").html(html);
	}
} 
function pListen(obj,childId,url,params){
	params = params.replace("!="+obj.id,"="+obj.value);
	var option = ajax(url,params);
	$("#"+childId.id).empty();
	if(option!="")
	$("#"+childId.id).append(option);
}


function creatOrder(){
	var data = $("form").serialize();
		var i = data.lastIndexOf("&")
		var sub = data.substr(i,data.length);
		var supperPassword = $("#supperPassword").val();
		data = data.replace(sub,"&supperPassword="+$.md5(supperPassword))
	$.ajax({
		url:'<%=basePath%>goodsSales/games/creatGameGoodsOrder.do',
		dataType:'json',
		async:false,
		type:'post',
		data:data,
		success:function(datas){ 
			 if(datas.retcode=="1"){
				 alert(datas.message);
			 }else{
				 var data =datas.data;
				$("#orderCode").val(data.orderCode);
				$(".form_ input[type='text']").addClass("hidetxt").attr("UNSELECTABLE","on");
				displayToggle($("#form_orderCode"));
				displayToggle($(".hide_"));
				$(".btn-t1").hide();
				$(".btn-t2").show();
				$("#sellPrice").attr("disabled",true).unFormValidator(true); //解除校验
				$("#gameAccount").attr("disabled",true).unFormValidator(true); //解除校验
				$("#buyNum").attr("disabled",true).unFormValidator(true); //解除校验
				$(".confirm_gameAccount").hide();
				$(".select").attr("disabled", "disabled");
				$(".select").css("border", "0px");
				
				var strs= new Array(); //定义一数组
				if(selectData!=""){
					strs=selectData.split(","); //字符分割      
					for (i=0;i<strs.length ;i++ )    {
						$("#"+strs[i]).attr("disabled",true);
					}
				}
				step(2);
			 }
		},
		error:function(e){alert(e.status)}
	});
	
}

function saveOrder(){
	//showMask();
	var orderCode = $("#orderCode").val();
	var token = $("#token").val();
	$.ajax({
		url:'<%=basePath%>goodsSales/games/saveGameGoodsOrder.do',
		dataType:'json',
		type:'post',
	//	async:false,
		timeout:"120000",
		data:{'orderCode':orderCode,'token':token},
		success:function(data){
			 if(data.retcode=="1"){
				 alert(data.message);
				  location.href="<%=basePath%>goodsSales/games/gameInfo.do?goodsCode="+$("#goodsCode").val();
			 }else{
				step(3);
				$(".czxx").hide();
				ajaxAccount();	
				$(".success").show();
			    $("#successMessage").html(data.message);
			    queryPage();
			 }
			  
		},
		error:function(e){
			if(e.timeout==0){
				step(3);
					displayToggle($(".form"));
					displayToggle($("#success"));
					ajaxAccount();	
					queryPage();
			}else{
				alert(e.status);
				queryPage();
			}
		}
	});
	
}
function step(num){
	document.getElementById("czbzTit").className = "czbzTit0"+num;
}
function clean(){
	 var goodsCode = $("#goodsCode").val();
	  location.href="<%=basePath%>jsp/gameCzForm.jsp?goodsCode="+goodsCode;
}  
</script>
</head>
<body>
	<div class="main">
		<%@include file="./top.jsp"%>
		<div class="content">
			<div class="content_nr">
				<%@include file="./left.jsp"%>
				<div class="content_nrright">
					<%@include file="./menu.jsp"%>
					<div class="nyRight">
						<%--<div class="nyTit">Q币充值</div>
          --%>
						<jsp:include page="czTitle.jsp">
							<jsp:param name="num" value="3" />
						</jsp:include>
						<div class="sjczBox">
							<div class="czbzTit01" id="czbzTit">
								<h2>一：提交订单</h2>
								<h3>二：支付订单</h3>
								<h4>三：充值成功</h4>
							</div>
							<div class="czxx">
								<table width="806" border="0" cellspacing="0" cellpadding="0">
									<form action="" id="form_" class="form_" style="">
										<input type="hidden" name="token" id="token" value="${token}" /> 
										<input type="hidden" name="goodsCode" id="goodsCode">
										<input type="hidden" name="goodsContentId" id="goodsContentId" >
										
										<input type="hidden" name="parValue" id="parValue" value="" autocomplete="off" />
												<tr  style="display: none;"  id="form_orderCode">
													<td width="232" class="wz">订单号：</td>
													<td width="332"><input name="orderCode" id="orderCode" readonly="readonly" 
														type="text" class="input1" />
													</td>
													<td width="242">&nbsp;</td>
												</tr>
												<tr>
													<td width="232" class="wz">游戏名称：</td>
													<td width="332"><input name="game_name" id="game_name"  readonly="readonly"  
														type="text" class="input1" />
													</td>
													<td width="242">&nbsp;</td>
												</tr>
												<tr>
													<td width="232" class="wz">面值（元）：</td>
													<td width="332"><input id="parValueShow" type="text"  class="input4" readonly="readonly" />
													</td>
													<td width="242"><span id="parValueTip"></span></td>
												</tr>
												<tr style="display: none;">
													<td class="wz">实际销售价格（元）：</td>
													<td><input type="text" class="input1" name="sellPrice" id="sellPrice" />
													</td>
													<td><span id="sellPriceTip"></span></td>
												</tr>
												<tr style="display: none;">
													<td class="wz">批价（元）：</td>
													<td><input type="text" class="input4" id="batchPrice"  readonly="readonly"/>
													</td>
													<td>&nbsp;</td>
												</tr>
												<tbody class="add" id="add">
												</tbody>
									<tr class="hide_">
										<td class="wz">交易密码：</td>
										<td><input name="supperPassword" type="password" class="input5" id="supperPassword" />
										</td>
										<td><span id="supperPasswordTip"></span></td>
									</tr>
									<tr>
										<td class="wz">价格：</td>
										<td class="t1"><em id="price"></em></span><span id="priceTip"></span>
										</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="btn-t1">
										<td>&nbsp;</td>
										<td>
										<input name="button" type="submit" class="an_input1" id="button" value="提交" /> 
										<input name="button" type="reset" class="an_input1" id="button" value="重置"  style="margin-left:15px;">
										</td> 
										<td>&nbsp;</td>
									</tr>
									<tr class="btn-t2" style="display: none;">
										<td>&nbsp;</td>
										<td>
										<input name="button" type="button" class="an_input1"  onclick="saveOrder()"   id="button" value="确认充值" /> 
										<input name="button" type="button" class="an_input1" id="button" value="取消充值"  onclick="clean();" style="margin-left:15px;">
										</td> 
										<td>&nbsp;</td>
									</tr>
									</form>
								</table>
							</div>
					<div class="success" style="border:0px solid green;text-align: center;height:60px;display: none;padding-top: 30px;">
					       		 <strong style="color: red;font-size: 25px;" id="successMessage">订单成功,是否充值成功请查看交易记录</strong> 
									<a   style="color: black;font-size: 12px;" onclick="clean();" href="javascript:void(0);" >返回</a>
       				</div>
							
						</div>
					</div>
					<div class="zjcz" >
					    <div  width="100%"  align="center">
              				 <span class="red" style="color: #f00;">最近5次交易记录 <a href="javascript:void(0)" onclick="queryPage()" >
              				 <img src="<%=basePath%>images/images/sx.gif" width="80" height="30" /></a></span> 
       					 </div>
						<table width="970" border="0" cellspacing="0" cellpadding="0" id="tablelist" class="tablelist"> 
				          <thead>
				             <tr>
				              <td bgcolor="#eaf2f7">订单号</td>
				              <td bgcolor="#eaf2f7">商品名</td>
				              <td bgcolor="#eaf2f7">充值号码</td>
				              <td bgcolor="#eaf2f7">数量</td>
				              <td bgcolor="#eaf2f7">面值(元)</td>
				              <td bgcolor="#eaf2f7">批价(元)</td>
				              <td bgcolor="#eaf2f7">售价(元)</td>
				              <td bgcolor="#eaf2f7">订单时间</td>
				              <td bgcolor="#eaf2f7">订单状态</td>
				            </tr></thead>
				           <tbody id="supplierdataTable" style="text-align: center;" >
															
															
							</tbody>
				          </table>
					</div>




				</div>
			</div>
			<%@include file="./bottom.jsp"%>
		</div>
	</div>
</body>
   <script type="text/javascript">
  function queryPage(){ 
		$("#tablelist tbody").empty();
		var tbody = "";
		$.ajax({
			url:'<%=basePath%>tradingRecord/getTradeRecord.do',
			dataType:'json',
			type:'post',
			data:{'pageno':1,'pagesize':5,'type':2,'categoryLargeId':'1'},
			success:function(datas){//'type':${isFull},
			$("#tablelist tbody").empty();
			if(datas.retcode==0){
				var page = datas.data;
				var total= page.totalCount;
				var pageno=  page.currentPageNo;
				var pagesize = page.pageSize;
				var data = page.result;
					$.each(data, function(index,dlist) {
						var goodsName = dlist.goodsName; 
						if(goodsName.length>20){
							goodsName = goodsName.substring(0,20)+"...";
						}
								 tbody += "<tr>";
								 tbody+="<td   align='center' >"+dlist.orderCode+" </td>";
							     tbody+="<td align='center'> "+goodsName+" </td>";
							     tbody+="<td align='center'>"+dlist.rechargeAccount+"</td>";
							     tbody+="<td> "+dlist.rechargeNumber+" </td> "; 
							     tbody+='<td align="center">'+dlist.inPrice/100.0+'</td> ';
							     tbody+='<td   >'+dlist.batchPrice/100.0+'</td> '; 
							     tbody+='<td >'+dlist.sellPrice/100.0+'</td> ';
							     tbody+='<td align="center">'+dlist.createTime+'</td> ';
							     tbody+='<td    align="center">'+dlist.orderStatusString+'</td> ';
							tbody += "</tr>";
					});
				}else if(datas.retcode==1){
					alert(datas.message);
				}
				if (tbody != '') {
						   	$("#tablelist tbody").html(tbody);
				} else {
					$("#tablelist tbody").html('<tr><td colspan="10" align="center">没有符合条件的记录！</td></tr>');
				}

				$(".tablelist tr").hover(function() {
					$(this).addClass("tbover");
				}, function() {
					$(this).removeClass("tbover");
				});
			},
			error:function(error){alert(error.status);}
		});
		
	}

  
	var goodsCode = "<%=goodsCode%>"; 
	if(goodsCode){
		gameCzAjax("goodsCode="+goodsCode);
	}
	init();
	queryPage();
  </script>
</html>
