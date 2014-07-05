<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
<script type="text/javascript">
function getGoodsContentTbl(){
	$.ajax({
		url:'<%=basePath%>goodsSales/games/getGoodsContentTbl.do',
		dataType:'json',
		type:'post',
		success:function(datas){	
		if(datas.retcode==1){
			//alert(datas.message);
			window.location ="<%=basePath%>jsp/error/noGoods.jsp";
		}else{
			var arr = datas.data;
	
			var common = $("#con_yxname_1");
			common.html('');
		
			var games ="";
		
			var contentOften=arr.contentOften;
			var game1=arr.a;
			var game2=arr.b;
			var game3=arr.c;
			var game4=arr.d;
			var game5=arr.e;
			var game6=arr.f;
			var game7=arr.j;
			var game8=arr.h;
			for ( var i = 0; i < contentOften.length; i++) {
				games += "<li><a href=javascript:void(0) onclick=setChargeGame('"+contentOften[i].id+"')>"+contentOften[i].name+"</a></li>";
			}
			common.html(games);
		
			
			for(var i=1 ;i<=9;i++){
				var n = i+1;
				var game = $("#con_yxname_"+n);
				game.html('');
				var gameName ="";
				if(i==1){
					gameName = game1;
				}else if(i==2){
					gameName = game2;
				}else if(i==3){
					gameName = game3;
				}else if(i==4){
					gameName = game4;
				}else if(i==5){
					gameName = game5;
				}else if(i==6){
					gameName = game6;
				}else if(i==7){
					gameName = game7;
				}else if(i==8){
					gameName = game8;
				}
				var game_list ="";
				for ( var j = 0; j < gameName.length; j++) {
					var name = gameName[j].name;
						game_list += "<li><a href=javascript:void(0) onclick=setChargeGame('"+gameName[j].id+"')>"+ $.trim(name)+"</a></li>";
				}
				game.html(game_list);
			}
			
			
		}
		},
		error:function(e){
			alert("游戏列表加载出错："+e.status);
		}
	});
}

 
function setChargeGame (id){ 
	$.ajax({
		url:'<%=basePath%>goodsSales/games/getGameGoods.do',
		dataType:'json',
		type:'post',
		data:{goodsContentId:id},
		success:function(datas){
			if(datas.retcode==2){
				var gmlist = $('.gamelbnr');
				gmlist.html('');
				gmlist.append("<li><label  class='jj'>"+datas.message+"</label></li>");
			}else{
				var arr =  datas.data;
				var gmlist = $('.gamelbnr');
				gmlist.html('');
				var temp ='';
				$.each(arr,function(i,attr){
					var params = "goodsCode="+attr.goodsCode;
					temp +="<li><dl>"; 
					temp +="<dt><img src= '<%=basePath%>images/images/img2.jpg' width='125' height='94' /></dt>";
					temp +="<dd class='dd1'><img  src=<%=basePath%>images/images/zhang.gif width='16' height='16' /> <a href='<%=basePath%>jsp/gameCzForm.jsp?"+params+"'>"+  attr.goodsName+ "</a></dd>";
					temp +="<dd>物品类型： 虚拟 物品</dd>";
								//tbody += "<dd>游戏区服： 倩女幽魂2 /笑苍穹 /水龙吟</dd></dl>");
					temp +="<dd>建议零售价： "+attr.suggestRetailPrice/100.0+"元</dd></dl>";
					temp +="<div class='xs'><a href='<%=basePath%>jsp/gameCzForm.jsp?"+params+"'><img src=<%=basePath%>images/images/xs.gif width='64' height='23' /></a></div>";
					temp +="<div class='sl'>--</div>";
					temp +="<div class='jj'>"+attr.parValue/100.0+"元</div>";
					temp +="</li>";
				})
				$(".gamelbnr").html(temp);
			}
		},
		error:function(e){
			alert("游戏商品加载出错"+e.status)
		}
	});
}
 getGoodsContentTbl();
 $(function(){
	 
 queryPage();
	 
 })
</script>
</head>

<body>
<div class="main">

  <%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
        <div class="nyRight"><%--
          <div class="nyTit">游戏充值</div>
          --%>
            <jsp:include page="czTitle.jsp" >
			  <jsp:param name="num" value="4" /> 
			</jsp:include>
          <div class="gamenamebox">
            <ul class="tit">
              <li class="hover" id="yxname1" onmouseover="setTab('yxname',1,9)">常用</li>
              <li id="yxname2" onmouseover="setTab('yxname',2,9)">ABC</li>
              <li id="yxname3" onmouseover="setTab('yxname',3,9)">DEFG</li>
              <li id="yxname4" onmouseover="setTab('yxname',4,9)">HIJK</li>
              <li id="yxname5" onmouseover="setTab('yxname',5,9)">LMNO</li>
              <li id="yxname6" onmouseover="setTab('yxname',6,9)">PQR</li>
              <li id="yxname7" onmouseover="setTab('yxname',7,9)">STU</li>
              <li id="yxname8" onmouseover="setTab('yxname',8,9)">VWX</li>
              <li id="yxname9" onmouseover="setTab('yxname',9,9)">YZ</li>
            </ul>
            <div class="gamename">
              <ul class="yxname" id="con_yxname_1" style="display:block">
              <%-- <li><a href="#">龙剑</a></li>
                <li><a href="#">梦幻魔兽</a></li>  --%>
              </ul>
              <ul class="yxname" id="con_yxname_2"> </ul>
              <ul class="yxname" id="con_yxname_3"> </ul>
              <ul class="yxname" id="con_yxname_4">  </ul>
              <ul class="yxname" id="con_yxname_5"> </ul>
              <ul class="yxname" id="con_yxname_6">  </ul>
              <ul class="yxname" id="con_yxname_7"> </ul>
              <ul class="yxname" id="con_yxname_8"> </ul>
              <ul class="yxname" id="con_yxname_9">  </ul>
            </div>
          </div>
          <div class="gamelb">
            <div class="gamelbTit">
              <h1>充值类型</h1>
              <h4>销售</h4>
              <h2>数量</h2>
              <h3>进价</h3>
            </div>
            <ul class="gamelbnr"><%--
              <li>
                <dl>
                  <dt><img src="../images/images/img2.jpg" width="125" height="94" /></dt>
                  <dd class="dd1"><img src="../images/images/zhang.gif" width="16" height="16" /> <a href="#">倩女幽魂[账号]A530-83级女射手有白虎坐骑</a></dd>
                  <dd>物品类型： 游戏账号</dd>
                  <dd>游戏区服： 倩女幽魂2 /笑苍穹 /水龙吟</dd>
                </dl>
                <div class="xs"><a href="#"><img src="../images/images/xs.gif" width="64" height="23" /></a></div>
                <div class="sl">10</div>
                <div class="jj">20.0元</div>
              </li>
            --%></ul>
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
   <%@include file="./bottom.jsp" %>
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
  </script>
</html>
