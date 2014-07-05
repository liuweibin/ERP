// JavaScript Document

<!--
function setTab(name,cursel,n){
for(i=1;i<=n;i++){
var menu=document.getElementById(name+i);
var con=document.getElementById("con_"+name+"_"+i);
menu.className=i==cursel?"hover":"";
con.style.display=i==cursel?"block":"none";
}
}
 
	 function setTab3(name,cursel,n){ 
			for(i=1;i<=n;i++){
				var menu=document.getElementById(name+i);
				if(i==cursel){ 
					menu.className="hover";
				}
			}
		}
	 
function setTab1(name,cursel,n){
for(i=1;i<=n;i++){
var menu=document.getElementById(name+i);
var con=document.getElementById("con_"+name+"_"+i);
menu.className=i==cursel?"hoverer":"";
con.style.display=i==cursel?"block":"none";
}
}
function setTab2(name,cursel,n){
	for(i=0;i<n;i++){
		var menu=document.getElementById(name+i);
		var con=document.getElementById("con_"+name+"_"+i);
		menu.className=i==cursel?"over":"";
		con.style.display=i==cursel?"block":"none";
	}
}

function changeFontSize(size)
{
    document.getElementById('changeBodyFont').style.fontSize = size+'px';
}


function check(theform) {
	if(theform.username.value=="") {
		alert("请输入姓名");
		theform.username.focus();		
		return false;
	
	}else if(theform.tel.value == "") {
		alert("请输入联系方式");
		theform.tel.focus();
		return false;
	} else if(theform.jbms.value == "") {
		alert("请输入疾病描述");
		theform.jbms.focus();
		return false;
	} else {
		return true;		
		theform.submit();
	}
}


//-->

