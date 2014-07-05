 //网关设置  显示银行说明
 function setPaygate(payid,paygatecode,bankid){
  
}

function openDefDialog(id,paygatecode){
       var title = "管理绑定淘宝账号";
       var url = "/jsp/credit/bandtaobaoaccount.jsp?id="+id+"&paygatecode="+paygatecode;
       var width = 550;                                                
       var height = 450;
       parent.LightBox(url, title, width, height);
	   return ;
}

//显示选项卡
function changebankshow(key){ 
      var y = 0;
	  var element = document.getElementById("tab").getElementsByTagName("li");
	  for(var i=1;i<=element.length;i++){
		 y=i-1;
		if(i==key){
			element[y].className = "current";
			$("#pay" + key).attr({style:"display:block"});
		}else{
			element[y].className = "";
			$("#pay" + i).attr({style:"display:none"});
		}
	}
	 
	changebankshowInfo(key);
}
 
function changebankshowInfo(key){ 
	//支付宝
	if(key==1){
		changeBuyType(2);//2是网银支付
		$("#selectPayType").val(1);//支付宝
		$("#rmPay").attr({style:"display:none"});
		$("#tlPay").attr({style:"display:none"});
		$("#alipy_bankPay").attr({style:"display:block"});
        $("#tenpay").attr({style:"display:none"});
	}
	else if(key==2){
		changeBuyType(2);
		$("#selectPayType").val(2);//财付通
	    $("#tenpay").attr({style:"display:block"});
		$("#rmPay").attr({style:"display:none"});
		$("#tlPay").attr({style:"display:none"});
		$("#alipy_bankPay").attr({style:"display:block"});
	    $("#tenpay div table tbody tr td div div ul li label").attr({style:"cursor:pointer"});
	    $("#tenpay div table tbody tr td div div ul li input").attr({style:"cursor:pointer"});
	}
	// 汇款时
	else if(key==3){
		 changeBuyType(1);//1是银行转账
		 $("#selectPayType").val(3);//汇款
	     $("#rmPay").attr({style:"display:block"});
	 	$("#tlPay").attr({style:"display:none"});
	     $("#alipy_bankPay").attr({style:"display:none"});
	    $("#tenpay").attr({style:"display:none"});
	}
	// 通联
	else if(key==4){
		changeBuyType(1);//1是通联代付
		$("#selectPayType").val(4);//代付
		 $("#rmPay").attr({style:"display:none"});
		$("#tlPay").attr({style:"display:none"});
		$("#alipy_bankPay").attr({style:"display:block"});
		$("#tenpay").attr({style:"display:none"});
		queryPage();
	}
	// 银联
	else if(key==5){
		changeBuyType(1);//1是银联代付
		$("#selectPayType").val(5);//代付
		$("#rmPay").attr({style:"display:none"});
		$("#tlPay").attr({style:"display:none"});
		$("#alipy_bankPay").attr({style:"display:block"});
		$("#tenpay").attr({style:"display:none"});
		queryPageUn();
	}
	
}

function changeBuyType(buytype){
	 $("#buyType").val(buytype);
}

function Beauty(obj){
	var element = document.getElementsByName("select_paygate");
	for(var i=0;i<element.length;i++){
		if(obj==element[i]){
			element[i].className = "current";
		}else{
			element[i].className = "";
		}
	}
}
 // 提交
function chkCreditSub(){
	try{
		 	//添加支付宝逻辑
		    var selectPayType=	$("#selectPayType").val();;
		    //支付宝/网银支付
		    if(selectPayType == 1){
		    	var url_ = $('#alipay_buy_action').val();
		    	$('#buycreditform').attr('action', url_);
		    }
		    
			// 财付通
			else if(selectPayType == 2){
				var url_ = $('#tenpay_buy_action').val();
		    	$('#buycreditform').attr('action', url_);
			} 
			// 汇款
			else if(selectPayType == 3){
		    	if(!validateAmount()){
				return false;
				} 
				var remark = $("#remark").val(); 
				if(remark==""){
				alert("预留信息是您与客服验证的标记，请谨慎填写");
				$("#remark").focus();
				return false;
				}
		 	}
		    //通联
			else if(selectPayType == 4){
		    /*	if(!validateTlAmount()){
				return false;
				}*/
		    	var id = $('input[name="tl_radio"]:checked').val()
		    	if(!id){
		    		alert("请选择银行账户");
		    		return false;
		    	} 
		    	//var tlAmount = $('#selCash').val();
		    	//var url_ = $('#tlpay_buy_action').val()+"?id="+id+"&tlAmount="+tlAmount;
		    	var url_ = $('#tlpay_buy_action').val();
		    	$('#buycreditform').attr('action', url_);
		    	
		    	//tlAjax(url_);
		 	}
		    //银联
			else if(selectPayType == 5){
				/*	if(!validateTlAmount()){
				return false;
				}*/
				var id = $('input[name="un_radio"]:checked').val()
				if(!id){
					alert("请选择银行账户");
					return false;
				} 
				//var tlAmount = $('#selCash').val();
				//var url_ = $('#tlpay_buy_action').val()+"?id="+id+"&tlAmount="+tlAmount;
				var url_ = $('#unpay_buy_action').val();
				$('#buycreditform').attr('action', url_);
				
				//tlAjax(url_);
			}
			return true;			
		
	}catch(e){
	 return false;
	}
}/*
function tlAjax(url){
	$.ajax({ 
	    cache: true, 
	    type: "POST",
	    url:url, 
	    dataType : 'json',
	    error: function(request) { 
	        alert("Connection error"); 
	    }, 
	    success: function(data) {
	    	if(data.retcode=="0"){
	    		alert("代收成功");
	    	}else{
	    		alert("代收失败");
	    	}
	    } 
	});
}*/
//amber
function createAmount(){
		validateAmount();
		createOddAmount();
	}
function validateAmount(){
	var amount = $("#rmAmount").val(); 
	if(amount!=""){
		if(isNaN(amount) || parseFloat(amount)<=0){
			alert("汇款金额不正确，请重新输入！");
			$("#rmAmount").val(""); 
			$("#oddAmount").val(""); 
			$("#rmAmount").focus();
			return false;
		}	
		
		//信用卡还款金额不能到分
		if(amount.indexOf(".")>0){
			alert("汇款金额只能是整数，请重新输入")
			$("#rmAmount").val(""); 
			$("#oddAmount").val(""); 
			$("#rmAmount").focus();
			return false;
		}
	}else{
		alert("请输入正确汇款金额");
		$("#rmAmount").val(""); 
		$("#oddAmount").val(""); 
		$("#rmAmount").focus();
		return false;
	}
	return true;
}
/**
 * 通联
 * @returns {Boolean}
 
	function validateTlAmount(){
		var amount = $("#tlAmount").val(); 
		if(amount!=""){
			if(isNaN(amount) || parseFloat(amount)<=0){
				alert("汇款金额不正确，请重新输入！");
				$("#tlAmount").val(""); 
				$("#tlAmount").focus();
				return false;
			}	
			
			//信用卡还款金额不能到分
			if(amount.indexOf(".")>0){
				alert("汇款金额只能是整数，请重新输入")
				$("#tlAmount").val(""); 
				$("#tlAmount").focus();
				return false;
			}
		}else{
			alert("请输入正确汇款金额");
				$("#tlAmount").val(""); 
				$("#tlAmount").focus();
			return false;
		}
		return true;
	}
	*/
	function createOddAmount() {
        var oddAmount = parseInt(Math.random() * (9) + 1);
        if (oddAmount == 10) {
            createOddAmount();
        } else {
            oddAmount = "0." + oddAmount;
          $("#oddAmount").val(oddAmount);   
        }
    }
	
	
  function submitbuy(){	
					if(!validateAmount()){
						return false;
					}
					var remark =$("#remark").val(); 
					if(remark==""){
						alert("预留信息是您与客服验证的标记，请谨慎填写");
						$("#remark").focus();
						return false;
					}
		
	    return true;
	}
  
  
  	//我的汇款单增加
  	function hidebox() {
        $("#ajaxmsg").hide();
    }

    function showbox() {
        $("#ajaxmsg").hide().fadeIn("slow");
        setTimeout("hidebox()", 3000)
    }

  