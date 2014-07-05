package com.erp.core.web.util;

/*
 *
 * TODO 要更改此生成的文件的模板，请转至
 * 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */

import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Entity;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 * @author Administrator
 * 计算分页信息
 */
@Entity
public class DbPages {
	  /**
	   * 计算分页信息
	   * @param pageSize 页长度
	   * @param currentPage 当前页
	   * @param sql sql语句
	   * @param scriptUrl 翻页信息链接地址
	   * @return
	   */
	  public String[] GetPageInfo(int pageSize,String currentPage,String sql,String scriptUrl,Map map) {
	  	String totalNum="0";
	  	Session session;
	  	try {
			session = SessionFactory.currentSession();
		     Query query = session.createQuery("select count(*) "+sql);  
			  System.out.println("count ---"+"select count(*) "+sql);
		        Iterator it = map.keySet().iterator();  
		        while (it.hasNext())  
		        {  
		            Object key = it.next();  
		            query.setParameter(key.toString(), map.get(key));  
		        }  
		        totalNum=""+((Long)query.uniqueResult()).intValue();
		        System.out.println(totalNum+"=======");
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			try {
				SessionFactory.closeSession();
			} catch (HibernateException e1) {
				e1.printStackTrace();
			}
		}
		return (new DbPages()).GetPageInfo(totalNum,pageSize,currentPage,scriptUrl);
	  }
	 
	 
	  /**
	   * 计算分页信息///////////////////////////////////
	   * @param pageSize 页长度
	   * @param /////////////!=currentPage 当前页
	   * @param sql sql语句
	   * @param scriptUrl 翻页信息链接地址
	   * @return
	   */
	  public String[] GetPageInfo2(int pageSize,String currentPage,String sql,String scriptUrl,Map map) {
		  	String totalNum="0";
		  	Session session;
		  	try {
				session = SessionFactory.currentSession();
				 Query query = session.createQuery("select count(*) "+sql);  
				  
			        Iterator it = map.keySet().iterator();  
			        while (it.hasNext())  
			        {  
			            Object key = it.next();  
			            query.setParameter(key.toString(), map.get(key));  
			        }  
			        totalNum=""+((Long)query.uniqueResult()).intValue();
			} catch (HibernateException e) {
				e.printStackTrace();
			} finally {
				try {
					SessionFactory.closeSession();
				} catch (HibernateException e1) {
					e1.printStackTrace();
				}
			}
			return (new DbPages()).GetPageInfo2(totalNum,pageSize,currentPage,scriptUrl);
		  }
	  /**
	   * 计算分页信息
	   * @param pageSize 页长度
	   * @param currentPage 当前页
	   * @param sql sql语句
	   * @param scriptUrl 翻页信息链接地址
	   * @return
	   */
	  public String[] GetPageInfo3(int pageSize,String currentPage,String sql,String scriptUrl,Map map) {
	  	String totalNum="0";
	  	Session session;
	  	try {
			session = SessionFactory.currentSession();
			 Query query = session.createQuery(sql);  
			  
		        Iterator it = map.keySet().iterator();  
		        while (it.hasNext())  
		        {  
		            Object key = it.next();  
		            System.out.println(key.toString()+ map.get(key));
		            query.setParameter(key.toString(), map.get(key));  
		        }  
		        List list = query.list();
		        totalNum=""+ list.size();
		        System.out.println( list.size());
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			try {
				SessionFactory.closeSession();
			} catch (HibernateException e1) {
				e1.printStackTrace();
			}
		}
		return (new DbPages()).GetPageInfo(totalNum,pageSize,currentPage,scriptUrl);
	  }
	  /**
	   * 计算分页信息
	   * @param totalNum String 记录总数
	   * @param pageSize String 页长度
	   * @param currentPage String 当前页
	   * @param scriptUrl String 翻页信息链接地址
	   * @return String[]
	   * 返回数组：GetPageInfo[0]为记录开始编号，GetPageInfo[1]为记录结束编号，GetPageInfo[2]为翻页信息串
	   */
	  public String[] GetPageInfo(String totalNum,int pageSize,String currentPage,String scriptUrl) {
	    int totalNumInt=0;
	    int currentPageInt=0;
	    int totalPage=0;
	    if(currentPage==null){
	      currentPage="1";
	      currentPageInt=1;
	    }else{
	      currentPageInt=Integer.parseInt(currentPage);
	    }
	    totalNumInt = Integer.parseInt(totalNum);
	    totalPage = ceil(Double.parseDouble(totalNum) / pageSize);
	    if(currentPageInt>totalPage){
	      currentPageInt=totalPage;
	    }
	    if(scriptUrl==null){
	      scriptUrl="?";
	    }
	    int pageParagraph = ceil(Double.parseDouble(""+currentPageInt)/10);
	    int maxpageParagraph = ceil(Double.parseDouble(""+totalPage)/10);
	    StringBuffer pagestr=new StringBuffer();
	    pagestr.append("<script language='JavaScript'>\n");
	    pagestr.append("function pageGo(){\n");
	    pagestr.append("var pageid=window.document.all(\"pagenum\").value;\n");
	    pagestr.append("var checknum=/^\\d+$/g;\n");
	    pagestr.append("if(!checknum.test(pageid)){\n");
	    pagestr.append("alert('输入页码只能为正整数!')\n");
	    pagestr.append("pageid='1';\n");
	    pagestr.append("}else if(pageid<1 || pageid>").append(totalPage).append("){\n");
	    pagestr.append("alert('输入页码超出页码范围!')\n");
	    pagestr.append("}else if(pageid==").append(currentPage).append("){\n");
	    pagestr.append("alert('输入页码就是当前显示页码!')\n");
	    pagestr.append("}else{\n");
	    pagestr.append("window.location=\"").append("page.do?").append("page=\"+pageid;\n");
	    pagestr.append("}\n}\n</script>\n");
	    pagestr.append("…页次：").append(currentPageInt).append("/").append(totalPage).append("页 ").append(pageSize).append("条/页&nbsp;&nbsp;").append("总 ").append(totalNumInt).append("条 ");
	    pagestr.append("<a href='").append(scriptUrl).append("page=1' title='第一页'><font face=webdings>9</font></a> ");
	    if(pageParagraph>1)
	      pagestr.append("<a href='").append(scriptUrl).append("page=").append(((pageParagraph - 1) * 10)).append("' title='上十页'><font face=webdings>7</font></a> ");
	    pagestr.append("<b>");
	    int startpage=(pageParagraph - 1) * 10 + 1;
	    int endpage=pageParagraph * 10 + 1;
	    for(int i=startpage;i<endpage;i++){
	      if(i==currentPageInt){
	        pagestr.append("<font color=red>").append(i).append("</font> ");
	      }else{
	        if(i<=totalPage){
	          pagestr.append("<a href='").append(scriptUrl).append("page=").append(i).append("'>").append(i).append("</a> ");
	        }
	      }
	    }
	    pagestr.append("</b>");
	    if(pageParagraph<maxpageParagraph)
	      pagestr.append("<a href='").append(scriptUrl).append("page=").append(((pageParagraph * 10) + 1)).append("' title='下十页'><font face=webdings>8</font></a> ");
	    pagestr.append("<a href='").append(scriptUrl).append("page=").append(totalPage).append("' title='末一页'><font face=webdings>:</font></a>");
	    pagestr.append("&nbsp;&nbsp;<input name='pagenum' id='pagenum' type='text' value='").append(currentPage).append("' size='3'>");
	    pagestr.append("<input type='button' name='cmdpage' value='GO' onClick=\"javascript:pageGo();\">");
	    if(currentPageInt==0){
	    	currentPageInt=1;
	    }
	    int start = (currentPageInt-1) * pageSize;
	    int endtmp = start + pageSize;
	    if(endtmp>totalNumInt){
	      endtmp=totalNumInt;
	    }
	    int end = endtmp;
	    String retArr[]=new String[3];
	    retArr[0]=""+start;
	    retArr[1]=""+end;
	    retArr[2]=pagestr.toString();
	    return retArr;
	  }
	  /**
	   * 计算分页信息///////////////////////
	   * @param totalNum String 记录总数
	   * @param pageSize String 页长度
	   * @param scriptUrl String 翻页信息链接地址
	   * @return String[]
	   * 返回数组：GetPageInfo[0]为记录开始编号，GetPageInfo[1]为记录结束编号，GetPageInfo[2]为翻页信息串
	   */
	  public String[] GetPageInfo2(String totalNum,int pageSize,String currentPage,String scriptUrl) {
		    int totalNumInt=0;
		    int currentPageInt=0;
		    int totalPage=0;
		    if(currentPage==null){
		      currentPage="1";
		      currentPageInt=1;
		    }else{
		      currentPageInt=Integer.parseInt(currentPage);
		    }
		    totalNumInt = Integer.parseInt(totalNum);
		    totalPage = ceil(Double.parseDouble(totalNum) / pageSize);
		    if(currentPageInt>totalPage){
		      currentPageInt=totalPage;
		    }
		    if(scriptUrl==null){
		      scriptUrl="?";
		    }
		    int pageParagraph = ceil(Double.parseDouble(""+currentPageInt)/10);
		    int maxpageParagraph = ceil(Double.parseDouble(""+totalPage)/10);
		    StringBuffer pagestr=new StringBuffer();
		    pagestr.append("<script language='JavaScript'>\n");
		    pagestr.append("function pageGo(){\n");
		    pagestr.append("var pageid=window.document.all(\"pagenum\").value;\n");
		    pagestr.append("var checknum=/^\\d+$/g;\n");
		    pagestr.append("if(!checknum.test(pageid)){\n");
		    pagestr.append("alert('输入页码只能为正整数!')\n");
		    pagestr.append("pageid='1';\n");
		    pagestr.append("}else if(pageid<1 || pageid>").append(totalPage).append("){\n");
		    pagestr.append("alert('输入页码超出页码范围!')\n");
		    pagestr.append("}else if(pageid==").append(currentPage).append("){\n");
		    pagestr.append("alert('输入页码就是当前显示页码!')\n");
		    pagestr.append("}else{\n");
		    pagestr.append("window.location=\"").append(scriptUrl).append("page=\"+pageid;\n");
		    pagestr.append("}\n}\n</script>\n");
		    pagestr.append("…页次：").append(currentPageInt).append("/").append(totalPage).append("页 ").append(pageSize).append("条/页&nbsp;&nbsp;").append("总 ").append(totalNumInt).append("条 ");
		    pagestr.append("<a href='").append(scriptUrl).append("page=1' title='第一页'></a> ");
		    if(pageParagraph>1)
		      pagestr.append("<a href='").append(scriptUrl).append("page=").append(((pageParagraph - 1) * 10)).append("' title='上十页'></a> ");
		    pagestr.append("<b>");
		    int startpage=(pageParagraph - 1) * 10 + 1;
		    int endpage=pageParagraph * 10 + 1;
//		    for(int i=startpage;i<endpage;i++){
//		      if(i==currentPageInt){
//		        pagestr.append("");
//		      }else{
//		        if(i<=totalPage){
//		          pagestr.append("<a href='").append(scriptUrl).append("page=").append(i).append("'>").append(i).append("</a> ");
//		        }
//		      }
//		    }
		    pagestr.append("</b>");
		    if(pageParagraph<maxpageParagraph)
		      pagestr.append("<a href='").append(scriptUrl).append("page=").append(((pageParagraph * 10) + 1)).append("' title='下十页'></a> ");
		    pagestr.append("<a href='").append(scriptUrl).append("page=").append(totalPage).append("' title='末一页'></a>");
		    pagestr.append("&nbsp;&nbsp;<input name='pagenum' id='pagenum' type='hidden' value='").append(currentPage).append("' size='3'>");
		    pagestr.append("<input type='hidden' name='cmdpage' value='G--O' onClick=\"javascript:pageGo();\">");
		    int start = (currentPageInt-1) * pageSize;
		    int endtmp = start + pageSize;
		    if(endtmp>totalNumInt){
		      endtmp=totalNumInt;
		    }
		    int end = endtmp;
		    String retArr[]=new String[3];
		    retArr[0]=""+start;
		    retArr[1]=""+end;
		    retArr[2]=pagestr.toString();
		    return retArr;
		  }
	  /**
	   * 计算分页信息
	   * @param totalNum String 记录总数
	   * @param pageSize String 页长度
	   * @param currentPage String 当前页
	   * @param scriptUrl String 翻页信息链接地址
	   * @return String[]
	   * 返回数组：GetPageInfo[0]为记录开始编号，GetPageInfo[1]为记录结束编号，GetPageInfo[2]为翻页信息串
	   */
	  public String[] GetPageInfo3(String totalNum,int pageSize,String currentPage,String scriptUrl) {
	    int totalNumInt=0;
	    int currentPageInt=0;
	    int totalPage=0;
	    if(currentPage==null){
	      currentPage="1";
	      currentPageInt=1;
	    }else{
	      currentPageInt=Integer.parseInt(currentPage);
	    }
	    totalNumInt = Integer.parseInt(totalNum);
	    totalPage = ceil(Double.parseDouble(totalNum) / pageSize);
	    if(currentPageInt>totalPage){
	      currentPageInt=totalPage;
	    }
	    if(scriptUrl==null){
	      scriptUrl="?";
	    }
	    String[] jj=scriptUrl.split("@#");
	    String[] aa=jj[0].split("=");
	    String bb=aa[1];
	    String[] cc=bb.split("&");
	    String dd=cc[0];
	    String tel=jj[1];
	    if(!tel.equals("null")){
	    	tel=jj[1];
	    }else{
	    	tel="";
	    }
	    int pageParagraph = ceil(Double.parseDouble(""+currentPageInt)/10);
	    int maxpageParagraph = ceil(Double.parseDouble(""+totalPage)/10);
	    StringBuffer pagestr=new StringBuffer();
	    pagestr.append("<script language='JavaScript'>\n");
	    pagestr.append("function pageGo(){\n");
	    pagestr.append("var pageid=window.document.all(\"pagenum\").value;\n");
	    pagestr.append("var checknum=/^\\d+$/g;\n");
	    pagestr.append("if(!checknum.test(pageid)){\n");
	    pagestr.append("alert('输入页码只能为正整数!')\n");
	    pagestr.append("pageid='1';\n");
	    pagestr.append("}else if(pageid<1 || pageid>").append(totalPage).append("){\n");
	    pagestr.append("alert('输入页码超出页码范围!')\n");
	    pagestr.append("}else if(pageid==").append(currentPage).append("){\n");
	    pagestr.append("");
	    pagestr.append("}else{\n");
	    pagestr.append("window.location=\"").append(scriptUrl).append("page=\"+pageid;\n");
	    pagestr.append("}\n}\n</script>\n");
	    pagestr.append("<input type='button' name='cmdpage' value='给");
	    pagestr.append(totalPage);//onClick=\location.href='ms.do?key=&tel=';\">
	    pagestr.append("页号码发短信 ' onClick=\"location.href='ms.do");
	    pagestr.append("?key=").append(dd);
	    pagestr.append("&tel=").append(tel).append("';\">");
	    pagestr.append("…页次：").append(currentPageInt).append("/").append(totalPage).append("页 ").append(pageSize).append("条/页&nbsp;&nbsp;").append("总 ").append(totalNumInt).append("条 ");
	    pagestr.append("<a href='").append(scriptUrl).append("page=1' title='第一页'><font face=webdings>9</font></a> ");
	    if(pageParagraph>1)
	      pagestr.append("<a href='").append(scriptUrl).append("page=").append(((pageParagraph - 1) * 10)).append("' title='上十页'><font face=webdings>7</font></a> ");
	    pagestr.append("<b>");
	    int startpage=(pageParagraph - 1) * 10 + 1;
	    int endpage=pageParagraph * 10 + 1;
	    for(int i=startpage;i<endpage;i++){
	      if(i==currentPageInt){
	        pagestr.append("<font color=red>").append(i).append("</font> ");
	      }else{
	        if(i<=totalPage){
	          pagestr.append("<a href='").append(scriptUrl).append("page=").append(i).append("'>").append(i).append("</a> ");
	        }
	      }
	    }
	    pagestr.append("</b>");
	    if(pageParagraph<maxpageParagraph)
	      pagestr.append("<a href='").append(scriptUrl).append("page=").append(((pageParagraph * 10) + 1)).append("' title='下十页'><font face=webdings>8</font></a> ");
	    pagestr.append("<a href='").append(scriptUrl).append("page=").append(totalPage).append("' title='末一页'><font face=webdings>:</font></a>");
	    pagestr.append("&nbsp;&nbsp;<input name='pagenum' id='pagenum' type='text' value='").append(currentPage).append("' size='3'>");
	    pagestr.append("<input type='button' name='cmdpage' value='GO' onClick=\"javascript:pageGo();\">");
	    if(currentPageInt==0){
	    	currentPageInt=1;
	    }
	    int start = (currentPageInt-1) * pageSize;
	    int endtmp = start + pageSize;
	    if(endtmp>totalNumInt){
	      endtmp=totalNumInt;
	    }
	    int end = endtmp;
	    String retArr[]=new String[3];
	    retArr[0]=""+start;
	    retArr[1]=""+end;
	    retArr[2]=pagestr.toString();
	    return retArr;
	  }
	  /**
	   * 计算分页信息
	   * @param totalNum String 记录总数
	   * @param pageSize String 页长度
	   * @param currentPage String 当前页
	   * @return String[]
	   * 返回数组：GetPageInfo[0]为记录开始编号，GetPageInfo[1]为记录结束编号，GetPageInfo[2]为翻页信息串
	   */
	  public String[] GetPageInfo(String totalNum,int pageSize,String currentPage) {
	    int totalNumInt=0;
	    int currentPageInt=0;
	    int totalPage=0;
	    if(currentPage==null){
	      currentPage="1";
	      currentPageInt=1;
	    }else{
	      currentPageInt=Integer.parseInt(currentPage);
	    }
	    totalNumInt = Integer.parseInt(totalNum);
	    totalPage = ceil(Double.parseDouble(totalNum) / pageSize);
	    if(currentPageInt>totalPage){
	      currentPageInt=totalPage;
	    }
	    String scriptUrl="?";
	    int pageParagraph = ceil(Double.parseDouble(""+currentPageInt)/10);
	    int maxpageParagraph = ceil(Double.parseDouble(""+totalPage)/10);
	    StringBuffer pagestr=new StringBuffer();
	    pagestr.append("<script language='JavaScript'>\n");
	    pagestr.append("function pageGo(){\n");
	    pagestr.append("var pageid=window.document.all(\"pagenum\").value;\n");
	    pagestr.append("var checknum=/^\\d+$/g;\n");
	    pagestr.append("if(!checknum.test(pageid)){\n");
	    pagestr.append("alert('输入页码只能为正整数!')\n");
	    pagestr.append("pageid='1';\n");
	    pagestr.append("}else if(pageid<1 || pageid>").append(totalPage).append("){\n");
	    pagestr.append("alert('输入页码超出页码范围!')\n");
	    pagestr.append("}else if(pageid==").append(currentPage).append("){\n");
	    pagestr.append("alert('输入页码就是当前显示页码!')\n");
	    pagestr.append("}else{\n");
	    pagestr.append("window.location=\"").append(scriptUrl).append("page=\"+pageid;\n");
	    pagestr.append("}\n}\n</script>\n");
	    pagestr.append("页次：").append(currentPageInt).append("/").append(totalPage).append("页 ").append(pageSize).append("条/页&nbsp;&nbsp;");
	    pagestr.append("<a href='").append(scriptUrl).append("page=1' title='第一页'><font face=webdings>9</font></a> ");
	    if(pageParagraph>1)
	      pagestr.append("<a href='").append(scriptUrl).append("page=").append(((pageParagraph - 1) * 10)).append("' title='上十页'><font face=webdings>7</font></a> ");
	    pagestr.append("<b>");
	    int startpage=(pageParagraph - 1) * 10 + 1;
	    int endpage=pageParagraph * 10 + 1;
	    for(int i=startpage;i<endpage;i++){
	      if(i==currentPageInt){
	        pagestr.append("<font color=red>").append(i).append("</font> ");
	      }else{
	        if(i<=totalPage){
	          pagestr.append("<a href='").append(scriptUrl).append("page=").append(i).append("'>").append(i).append("</a> ");
	        }
	      }
	    }
	    pagestr.append("</b>");
	    if(pageParagraph<maxpageParagraph)
	      pagestr.append("<a href='").append(scriptUrl).append("page=").append(((pageParagraph * 10) + 1)).append("' title='下十页'><font face=webdings>8</font></a> ");
	    pagestr.append("<a href='").append(scriptUrl).append("page=").append(totalPage).append("' title='末一页'><font face=webdings>:</font></a>");
	    pagestr.append("&nbsp;&nbsp;<input name='pagenum' id='pagenum' type='text' value='").append(currentPage).append("' size='3'>");
	    pagestr.append("<input type='button' name='cmdpage' value='GO' onClick=\"javascript:pageGo();\">");
	    int start = (currentPageInt-1) * pageSize;
	    int endtmp = start + pageSize;
	    if(endtmp>totalNumInt){
	      endtmp=totalNumInt;
	    }
	    int end = endtmp;
	    String retArr[]=new String[3];
	    retArr[0]=""+start;
	    retArr[1]=""+end;
	    retArr[2]=pagestr.toString();
	    return retArr;
	  }

	  private int ceil(double in){
	    String dbStr=new DecimalFormat("#0").format(in);
	    int newdb=Integer.parseInt(dbStr);
	    if(in>newdb){
	      newdb++;
	    }
	    return newdb;
	  }
	  private static void test(){
		  String hql = "from SystemLogTbl";
			Session session;
		  	try {
				session = SessionFactory.currentSession();
			Query query =	session.createQuery(hql);
			System.out.println("---"+query.list().size());
			} catch (HibernateException e) {
				e.printStackTrace();
			}
	  }

	  public static void main(String[] args){
//			String dbPagesArr[]=(new DbPages()).GetPageInfo(15,""+1,"select count(*) from BatchPriceTbl","",null);
//			String PagesStr=dbPagesArr[2];
//			System.out.println(PagesStr);
//			
			System.out.println((short)2+"---");
			
//			Integer.parseInt(dbPagesArr[0]);
//			PagesInfo pagesinfo=new PagesInfo();
//			pagesinfo.setPageinfo(PagesStr);
//			System.out.println(pagesinfo);
//		  test();
	 /*   String dataArr[]=(new DbPages()).GetPageInfo("239",10,"1","?");
	    for(int i=0;i<dataArr.length;i++){
	      System.out.println(dataArr[i]);
	    }*/
	  }
}
