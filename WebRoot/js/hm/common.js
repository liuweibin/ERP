
function getbrowse(){ //判断当前浏览器是何种浏览器
    var str="";
    // 包含「Opera」文字列
    Agent=navigator.userAgent;
    if(Agent.indexOf("Opera") != -1) {
        str='Opera';
    }
    // 包含「MSIE」文字列
    else if(Agent.indexOf("MSIE") != -1) {
        str='MSIE';
    }
    // 包含「Firefox」文字列
    else if(Agent.indexOf("Firefox") != -1) {
        str='Firefox';
    }
    // 包含「Netscape」文字列
    else if(Agent.indexOf("Netscape") != -1) {
        str='Netscape';
    }
    // 包含「Safari」文字列
    else if(Agent.indexOf("Safari") != -1) {
        str='Safari';
    }
    else{  
    }  
    return str;
}
function displayToggle(obj){
	$.each(obj,function(i,attr){
		if(attr.style.display=='block'||attr.style.display==''){
				attr.style.display='none';	
		}else if(attr.style.display=='none'){
			var BrowseType="";
			if(getbrowse()=="MSIE"){
			    BrowseType="block";
			}
			else{
			    BrowseType="block";
			}
		attr.style.display=BrowseType;
		}
	});
};
//回车转换成tab事件
$(document).ready(function () {
	$(':input:text:first').focus();
	$(':input:enabled').addClass('enterIndex');
	// get only input tags with class data-entry
	textboxes = $('.enterIndex');
	// now we check to see which browser is being used
	if ($.browser.mozilla) {
	$(textboxes).bind('keypress', CheckForEnter);
	} else {
	$(textboxes).bind('keydown', CheckForEnter);
	}
	});
	function CheckForEnter(event) {
	if (event.keyCode == 13 && $(this).attr('type') != 'button' && $(this).attr('type') != 'submit' && $(this).attr('type') != 'textarea' && $(this).attr('type') != 'reset') {
	var i = $('.enterIndex').index($(this));
	var n = $('.enterIndex').length;
	if (i < n - 1) {
	if ($(this).attr('type') != 'radio')
	{
	NextDOM($('.enterIndex'),i);
	}
	else {
	var last_radio = $('.enterIndex').index($('.enterIndex[type=radio][name=' + $(this).attr('name') + ']:last'));
	NextDOM($('.enterIndex'),last_radio);
	}
	}
	return false;
	}
	}
	function NextDOM(myjQueryObjects,counter) {
	if (myjQueryObjects.eq(counter+1)[0].disabled) {
	NextDOM(myjQueryObjects, counter + 1);
	}
	else {
	myjQueryObjects.eq(counter + 1).trigger('focus');
	}
	}
