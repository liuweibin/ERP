// JavaScript Document
 ra = document.getElementsByName('bank');
 len = ra.length;
 for(i=0;i<len;i++){
 ra[i].onclick = function(){
  la = document.getElementsByTagName('label');
  len2 = la.length;
  for(j=0;j<len2;j++){
   la[j].className = la[j].className.replace('checked',''); 
  }
  var label_id = this.getAttribute('id')+'_label';
  var label_obj = document.getElementById(label_id);
  label_obj.className+=" checked";
  }
}
