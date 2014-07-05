var a_propNames = new Array();

function loadProps(attributes) {
	var sb = "";

	$('#game_name').val(attributes.goodsName);
	$('#parValueShow').val(attributes.parValueShow);
	$('#parValue').val(attributes.parValue);
	$('#sellPrice').val(attributes.suggestRetailPrice);
	$('#goodsCode').val(attributes.goodsCode);
	$('#batchPrice').val(attributes.batchPrice);
	$('#goodsContentId').val(attributes.goodsContentTblId);
	$('#price').text(attributes.batchPrice + "元");
	$('#priceTip').text("(" + attributes.batchPrice + "元*1)");
	var good_attributes = attributes.attribute;

	if (!good_attributes) {
		return;
	}

	$
			.each(good_attributes, function(i, attr) {

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

					var display_ = "";

					a_propNames[i] = nameEn;

					if (display == 0) {
						display_ = "display:none;";
					}

					if (labelType == 0) {//0是Input:text
						sb += "<tr style=" + display_ + "><td class='wz'>"
								+ nameCn
								+ "：</td><td><input type='text' value='"
								+ value + "' name='" + nameEn + "' id='id_"
								+ nameEn
								+ "' class='input1' /></td><td><span id='id_"
								+ nameEn + "Tip'></span></td></tr>";

						if (nameEn == "gameAccount") {
							sb += "<tr class='confirm_gameAccount'><td class='wz'>确认"
									+ nameCn
									+ "：</td><td><input   type='text' value='"
									+ value
									+ "'   class='input1'  id='confirm_gameAccount' name='confirm_gameAccount' /></td><td><span id='confirm_gameAccountTip'></span></td></tr>";
						}
					}

					if (labelType == 1) {//1是select
						sb += "<tr style=" + display_ + "> <td class='wz'>"
								+ nameCn + "：</td>";
						sb += "<td>  ";
						sb += "<select onchange='" + getOnchangeMethod(nameEn)
								+ "' name='" + nameEn + "'  title=" + nameCn
								+ "'不能为空' class='select' id='id_" + nameEn
								+ "'> ";
						sb += createOptionsWithValues(value);
						sb += "</select> </td><td>&nbsp;</td></tr>";
					}
				});

	$("#add").append(sb);

	queryPropsNotify();
}

function createOptionsWithValues(values) {
	var sb = "";
	var arr = new Array(); //定义一数组
	arr = values.split(","); //字符分割      
	for (i = 0; i < arr.length; i++) {
		sb += "<option  value='" + arr[i] + "'>" + arr[i] + "</option>";
	}

	return sb;
}

function createOptionsWithJsonValues(values) {
	var sb = "";

	var jsonObj = eval('(' + values + ')');

	for (i = 0; i < jsonObj.data.length; i++) {
		sb += "<option  value='" + jsonObj.data[i].id + "'>"
				+ jsonObj.data[i].name + "</option>";
	}

	return sb;
}

function common_ajax(url) {
	var rs = "";
	$.ajax( {
		url : url,
		dataType : 'text',
		type : 'post',
		async : false,
		success : function(data) {
			rs = data;
		},
		error : function(e) {
			//alert(e.status);
	}
	});
	return rs;
}

/////////////////////////////////////////
function getOnchangeMethod(nameEn) {
	if ('accountType' == nameEn) {
		return 'accountTypeChangeNotify();';
	}

	if ('chargeType' == nameEn) {
		return 'chargeTypeNotify();';
	}

	if ('gameArea' == nameEn) {
		return 'gameAreaChangeNotify();';
	}

	if ('gameServer' == nameEn) {
		return 'gameServerChangeNotify();';
	}

	if ('buyNum' == nameEn) {
		return 'buyNumNotify();';
	}
}

//充值账号
function accountTypeChangeNotify(){
	queryChargeNumber();
}

//充值类型
function chargeTypeChangeNotify(){
	//queryChargeNumber();
}

//游戏区域
function gameAreaChangeNotify(){
	queryGameServer();
}

//游戏服务器
function gameServerChangeNotify(){
	//queryGameServer();
}

//充值数量
function buyNumNotify(){
	changePriceAndBuyNum();
}


//账号类型
function queryAccountType(){
	try{
		var url = "xz/queryAccountType.do";
	    url += getRequestParams();
	    var rs = common_ajax(url);
	
	    var options = createOptionsWithJsonValues(rs);
	
	    $("#id_accountType").empty();
	    $("#id_accountType").append(options);
	}catch (e){ }
}

//充值数量
function queryChargeNumber(){
	try{
	    var url = "xz/queryBuyNum.do";
	    url += getRequestParams();
	    var rs = common_ajax(url);
	
	    var options = createOptionsWithJsonValues(rs);
	
	    $("#id_buyNum").empty();
	    $("#id_buyNum").append(options);
	}catch (e){ }
}



//游戏区域
function queryGameArea(){
	try{
		var url = "xz/queryArea.do";
	    url += getRequestParams();
	    
	    var rs = common_ajax(url);
	
	    var options = createOptionsWithJsonValues(rs);
	
	    $("#id_gameArea").empty();
	    $("#id_gameArea").append(options);
	}catch (e){ }
}

//游戏区域
function queryGameServer(){
	try{
		var url = "xz/queryServer.do";
	    url += getRequestParams();
	    
	    var rs = common_ajax(url);
	
	    var options = createOptionsWithJsonValues(rs);
	
	    $("#id_gameServer").empty();
	    $("#id_gameServer").append(options);
	}catch (e){ }
}

function getRequestParams(){
	 var url ="?goodsCode="+$("#goodsCode").val();
	 url +="&goodsContentId="+$('#goodsContentId').val();
	 
	 for(var i=0; i< a_propNames.length; i++){
		var pName = a_propNames[i];
		if(pName == null || pName == ""){
			continue;
		}
		url +="&"+pName+"="+$("#id_"+pName).val();
	}
	 
	return url;
}


function changePriceAndBuyNum(){ 
	var num = $("#id_buyNum").val();
	var parValue = $("#parValue").val();
	var price = ((parValue*1000)*num)/1000;;
	$("#price").text(price);
	$("#priceTip").text("元("+parValue+"元*"+num+")");
}

function queryPropsNotify(){
	queryAccountType();
	accountTypeChangeNotify();
	queryGameArea();
	gameAreaChangeNotify();
	buyNumNotify();
}