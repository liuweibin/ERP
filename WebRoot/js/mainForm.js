	
 function SwitchPanel(obj) {
	document.getElementById('nav5').className = 'boxcontent';
	document.getElementById('nav6').className = 'boxcontent';
	switch (obj.id) {
	case "nav5":
	document.getElementById('lxkf').style.display = "block";
	document.getElementById('myaccountinfo').style.display = "none";
	if (obj) obj.className = 'on';
	break;
	case "nav6":
	//freshaccountinfo();
	document.getElementById('lxkf').style.display = "none";
	document.getElementById('myaccountinfo').style.display = "block";
	if (obj) obj.className = 'on';
	break;
	}
} 
 function SwitchNav(obj) {
	$("#nav1").removeClass('nav_on');
	$("#nav2").removeClass('nav_on');
	$("#nav3").removeClass('nav_on');
	$("#nav4").removeClass('nav_on');
	if (obj) obj.className = 'nav_on';
} 
	/*页面倒计时*/
	var second =14400; // 剩余秒数
	var toDays = function(){
		 var s = second % 60; // 秒
		 var mi = (second - s) / 60 % 60; // 分钟
		 var h =  ((second - s) / 60 - mi ) / 60 % 24; // 小时
		return  ((h < 10) ? "0"+h : h) + ":" + ((mi < 10) ? "0"+mi : mi) + ":" +  ((s < 10) ? "0"+s : s);
	}
	var a =	window.setInterval("interval()", 1000);
	function resetTime(){ 
		second =14400;
		// 写一个方法，将秒数专为天数
		clearInterval(a);
		//然后写一个定时器
		a =	window.setInterval("interval()", 1000);
	}	
	function interval(){
		second --;
		var day = toDays();
		$("#showTimes").html(day);
		if (day == "00:00:00") {
			   	alert('尊敬的代理商：你的离线时间已到，请重新登录系统!!!');
			  	window.location.assign(path+'/user/logout.do');
		}
	};
	/*页面倒计时  end*/
 /*根据iframe子页面自动设置iframe高度  1*/
	function turnHeight(iframe)   
	{   
	    var frm = document.getElementById(iframe);   
	    var subWeb = document.frames ? document.frames[iframe].document : frm.contentDocument; 
		    	if(frm != null && subWeb != null)   
		    	{ 
		    		if(subWeb.body.scrollHeight<500){
		    			frm.height = subWeb.body.scrollHeight + 20;
		    		}else{
		    			frm.height = subWeb.body.scrollHeight + 20;
		    		}
		    	}   
	}
/*页面弹出框 依赖主页面*/	
	function LightBox(url, title1, width1, height1,modal,msg){
		if(url.indexOf('?')!=-1){
			url=url+"&width="+width1;
			url=url+"&height="+height1;
		}else{
			url=url+"?width="+width1;
			url=url+"&height="+height1;
		}
		if(modal){
			url=url+"&modal=true";
		} 
		tb_show(title1,url,true);
		changeMsg(msg);
	}
	
	function changeMsg(msg){
		$("#hid_message").html(msg);alert('111'+msg);
		$("#TB_ajaxContent").html( '<p id="hid_message">'+msg+'</p>');
	}
	/*页面弹出框 依赖主页面 end*/	
	
/*退出*/
	 function IsExit(path) {
		 var bo = confirm('尊敬的代理商：你确认退出系统吗？');
	 if(bo){ 
		window.location.assign(path+'/user/logout.do');
	 }
	}
/*页面跳转*/
 function addTap(url){
		$("#main").attr("src", url);
}
 