<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>esales</title>
<%@include file="./include/common.jsp" %>
</head>

<body>
<div class="main">


<%@include file="./top.jsp" %>
      <div class="content">
    <div class="content_nr">
<%@include file="./left.jsp" %>
      <div class="content_nrright">
         <%@include file="./menu.jsp" %>
        
        <div class="nyRight">
          <div class="nyTit">下级</div>
          <div class="gamenamebox">
            <ul class="tit">
              <li class="hover" id="spcx1" onmouseover="setTab('spcx',1,5)">查询下级基本信息</li>
              <li id="spcx2" onmouseover="setTab('spcx',2,5)">查询下级账务</li>
              <li id="spcx3" onmouseover="setTab('spcx',3,5)">查询下级商品</li>
              <li id="spcx4" onmouseover="setTab('spcx',4,5)">查询下级订单</li>
              <li id="spcx5" onmouseover="setTab('spcx',5,5)">下级代理商注册</li>
            </ul>
            <div class="gamename">
	              <div class="spcxtj" id="con_spcx_1">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
						  <tr>
						    <td class="wz">省份：</td>
						    <td><select name="select3" class="input6" id="select3">
						      <option>——全部——</option>
						    </select></td>
						    <td class="wz">城市：</td>
						    <td><select name="select4" class="input6" id="select4">
						      <option>——全部——</option>
						    </select></td>
						    <td class="wz">&nbsp;</td>
						    <td>&nbsp;</td>
						    <td class="wz">&nbsp;</td>
						    <td>&nbsp;</td>
						  </tr>
						  <tr>
						    <td class="wz">产品大类：</td>
						    <td><select name="select" class="input6" id="select">
						      <option>——全部——</option>
						    </select></td>
						    <td class="wz">产品小类：</td>
						    <td><select name="select2" class="input6" id="select2">
						      <option>——全部——</option>
						    </select></td>
						    <td class="wz">产品编码：</td>
						    <td><input name="textfield" type="text" class="input6" id="textfield" /></td>
						    <td class="wz">商品名称：</td>
						    <td><input name="textfield2" type="text" class="input6" id="textfield2" /></td>
						  </tr>
						  <tr>
						    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" value="查询" /></td>
						    </tr>
						</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="348" class="wz">商品</td>
	                    <td width="231" class="wz">建议零售价（元）</td>
	                    <td width="233" class="wz">批价（元）</td>
	                    <td width="116" class="wz">数量</td>
	                  </tr>
	                  <tr>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                  </tr>
	                </table>
	              </div>
	              <div class="spcxtj" id="con_spcx_2" style="display:none">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
					  <tr>
					    <td class="wz">产品大类：</td>
					    <td><select name="select" class="input6" id="select">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">产品小类：</td>
					    <td><select name="select2" class="input6" id="select2">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">产品编码：</td>
					    <td><input name="textfield" type="text" class="input6" id="textfield" /></td>
					    <td class="wz">商品名称：</td>
					    <td><input name="textfield2" type="text" class="input6" id="textfield2" /></td>
					  </tr>
					  <tr>
					    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" value="查询" /></td>
					    </tr>
					</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="348" class="wz">商品</td>
	                    <td width="231" class="wz">建议零售价（元）</td>
	                    <td width="233" class="wz">批价（元）</td>
	                    <td width="116" class="wz">数量</td>
	                  </tr>
	                  <tr>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                  </tr>
	                </table>
	              </div>
	              <div class="spcxtj" id="con_spcx_3" style="display:none">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
					  <tr>
					    <td class="wz">产品大类3：</td>
					    <td><select name="select" class="input6" id="select">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">产品小类：</td>
					    <td><select name="select2" class="input6" id="select2">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">产品编码：</td>
					    <td><input name="textfield" type="text" class="input6" id="textfield" /></td>
					    <td class="wz">商品名称：</td>
					    <td><input name="textfield2" type="text" class="input6" id="textfield2" /></td>
					  </tr>
					  <tr>
					    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" value="查询" /></td>
					    </tr>
					</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="348" class="wz">商品</td>
	                    <td width="231" class="wz">建议零售价（元）</td>
	                    <td width="233" class="wz">批价（元）</td>
	                    <td width="116" class="wz">数量</td>
	                  </tr>
	                  <tr>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                  </tr>
	                </table>
	              </div>
	              <div class="spcxtj" id="con_spcx_4" style="display:none">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
					  <tr>
					    <td class="wz">产品大类4：</td>
					    <td><select name="select" class="input6" id="select">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">产品小类：</td>
					    <td><select name="select2" class="input6" id="select2">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">产品编码：</td>
					    <td><input name="textfield" type="text" class="input6" id="textfield" /></td>
					    <td class="wz">商品名称：</td>
					    <td><input name="textfield2" type="text" class="input6" id="textfield2" /></td>
					  </tr>
					  <tr>
					    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" value="查询" /></td>
					    </tr>
					</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="348" class="wz">商品</td>
	                    <td width="231" class="wz">建议零售价（元）</td>
	                    <td width="233" class="wz">批价（元）</td>
	                    <td width="116" class="wz">数量</td>
	                  </tr>
	                  <tr>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                  </tr>
	                </table>
	              </div>
	              <div class="spcxtj" id="con_spcx_5" style="display:none">
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cx">
					  <tr>
					    <td class="wz">产品大类5：</td>
					    <td><select name="select" class="input6" id="select">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">产品小类：</td>
					    <td><select name="select2" class="input6" id="select2">
					      <option>——全部——</option>
					    </select></td>
					    <td class="wz">产品编码：</td>
					    <td><input name="textfield" type="text" class="input6" id="textfield" /></td>
					    <td class="wz">商品名称：</td>
					    <td><input name="textfield2" type="text" class="input6" id="textfield2" /></td>
					  </tr>
					  <tr>
					    <td colspan="8" align="center"><input name="button" type="submit" class="an_input2" id="button" value="查询" /></td>
					    </tr>
					</table>
	                <table width="928" border="0" cellspacing="0" cellpadding="0" class="cxjg">
	                  <tr>
	                    <td width="348" class="wz">商品</td>
	                    <td width="231" class="wz">建议零售价（元）</td>
	                    <td width="233" class="wz">批价（元）</td>
	                    <td width="116" class="wz">数量</td>
	                  </tr>
	                  <tr>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                    <td>&nbsp;</td>
	                  </tr>
	                </table>
	              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@include file="./bottom.jsp" %>
  </div>
</div>
</body>
</html>
