package com.erp.core.web.readXml;

import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.jdom.Attribute;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;

/**
 * 
 * @author mwh JDOM 生成与解析XML文档
 * 
 */
public class JDomDemo implements XmlDocument {
	public static void init(){

		Map<String,String> map = new HashMap<String, String>();
		SAXBuilder builder = new SAXBuilder(false);
		try {
			Document document;
			document = builder.build("D:/vgss_config.xml");
			Element root = document.getRootElement();// 获得根节点
			List<Element> list = root.getChildren();
			for (Element e : list) {
				map.put("Join_Hotline",e.getChild("Join_Hotline").getAttributeValue("text")+":"+e.getChildText("Join_Hotline"));
				map.put("National_Hotline",e.getChild("National_Hotline").getAttributeValue("text")+":"+ e.getChildText("National_Hotline"));
				map.put("Customer_Service_Hotline",e.getChild("Customer_Service_Hotline").getAttributeValue("text")+":"+e.getChildText("Customer_Service_Hotline"));
			}
		} catch (JDOMException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
	public static void main(String args[]) {
		/*JDomDemo dd = new JDomDemo();
		String str = "D:/vgss_config.xml";
		dd.createXml(str); // 创建xml
		dd.parserXml("src/com/oms/core/web/readXml/vgss_config.xml"); // 读取xml
		*/
	}
	public void createXml(String fileName) {
		Document document;
		Element root = new Element("vgss");
		document = new Document(root);
		
		Element employee = new Element("loginPageInfo");

		Element name = new Element("Join_Hotline");
		Element sex = new Element("Customer_Service_Hotline");
		Element age = new Element("National_Hotline");

		employee.addContent(name);
		employee.addContent(sex);
		employee.addContent(age);

		root.addContent(employee);

		name.setAttribute("text", "加盟热线");
		name.setText("021-11111111");
		sex.setText("021-22222222");
		sex.setAttribute("text", "客服热线");
		age.setText("400-000-000");
		age.setAttribute("text", "全国统一电话");
		XMLOutputter XMLOut = new XMLOutputter();
		try {
			XMLOut.output(document, new FileOutputStream(fileName));
			System.out.println("生成XML文件成功!");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public void parserXml(String fileName) {
		SAXBuilder builder = new SAXBuilder(false);
		try {
			Document document;
			document = builder.build(fileName);
			Element root = document.getRootElement();// 获得根节点
			List<Element> list = root.getChildren();
			for (Element e : list) {
				System.out.println(e.getChild("Join_Hotline").getAttributeValue("text")+":"+ e.getChildText("Join_Hotline"));
				System.out.println("age=" + e.getChildText("Customer_Service_Hotline"));
				System.out.println("sex=" + e.getChildText("National_Hotline"));
			}
		} catch (JDOMException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
	//获取xml中指定参数值
	public static String parserXml001(String msg,String attName,String coding) {
		SAXBuilder builder = new SAXBuilder(false);
		String re ="++";
		try {
			//String msg = "<?xml version=\"1.0\" encoding=\"GBK\"?><AIPG>  <INFO>    <TRX_CODE>210003</TRX_CODE>    <VERSION>03</VERSION>    <DATA_TYPE>2</DATA_TYPE>    <LEVEL>5</LEVEL>    <MERCHANT_ID>200604000000445</MERCHANT_ID>    <USER_NAME>20060400000044502</USER_NAME>    <USER_PASS>111111</USER_PASS>    <REQ_SN>200604000000445021393991647437</REQ_SN>    <SIGNED_MSG>9758603f6dd03e3f694682cb16db29c0f67edd486d0100b6a3d70cf04e633604e2cbca2aca1521bd801a7160118e418439223bb35f48539e432522d807e724eb12f9dfc55baec8a4643b38ea54a98a073a97738a87fd6b0cef51e35281e6a2c00f53183b45c7a7f63cd439ddc00b56ed3015a244ba03faf384743e0e04832b9f</SIGNED_MSG>  </INFO>  <NSIGNREQ>    <QSDETAIL>      <AGREEMENTNO>0002000012</AGREEMENTNO>      <ACCT>4563516216043711109</ACCT>      <ACCTNAME>许燕</ACCTNAME>      <STATUS>2</STATUS>      <SIGNTYPE>2</SIGNTYPE>    </QSDETAIL>  </NSIGNREQ></AIPG>";
			InputStream   in   =   new   ByteArrayInputStream(msg.getBytes(coding));  
			Document document;
			document =builder.build(in);
			Element root = document.getRootElement();// 获得根节点
		 re =	process(root,attName);
		} catch (JDOMException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return re;
	}
	public static List<Map<String,String>> parserXmlBankCode(String configName) {
		SAXBuilder builder = new SAXBuilder(false);
	
		 List<Map<String,String>> listOut = new ArrayList<Map<String,String>>();
		try {
			Document document;
			document = builder.build(configName);
			Element root = document.getRootElement();// 获得根节点
			//log.info(root.getValue()+"---value");
			List<Element> le = root.getChildren();//根节点 vgss
			Element e = le.get(0);//banks
			List<Element> banks= e.getChildren();//bank
			Iterator it=banks.iterator();  
			 while(it.hasNext()){  
				 Map<String,String> map = new HashMap<String, String>();
				  Element child=(Element)it.next();  
				  map.put("bankCode", child.getAttribute("code").getValue());
				  map.put("name", child.getValue()+"");
				  listOut.add(map);
			 }
		} catch (JDOMException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return listOut;
	}
	
	public static String process(Element element,String attName) {
		String re="++";
        List content = element.getContent();
        Iterator iterator = content.iterator();
        String qualifiedName = element.getQualifiedName();
        if(qualifiedName.equals(attName)){
        	//System.out.println(qualifiedName + "::" + element.getTextNormalize());
        	return element.getTextNormalize();
        }
        while (iterator.hasNext()) {
            Object o = iterator.next();
            if (o instanceof Element) {
                Element child = (Element)o;
                re =    process(child,attName);
                if(!re.equals("++")){
                	return re;
                }
            }
        }
        
        return re;
    }
	public static void process(Element element) {
		List content = element.getContent();
		Iterator iterator = content.iterator();
		String qualifiedName = element.getQualifiedName();
			System.out.println(qualifiedName + "::" + element.getTextNormalize());
		List attributes = element.getAttributes();
		if (!attributes.isEmpty()) {
			Iterator iterator1 = attributes.iterator();
			while (iterator1.hasNext()) {
				Attribute attribute = (Attribute) iterator1.next();
				String name = attribute.getName();
				String value = attribute.getValue();
				System.out.println(name + ':' + value);
			}
		}
		while (iterator.hasNext()) {
			Object o = iterator.next();
			if (o instanceof Element) {
				Element child = (Element)o;
				process(child);
			}
		}
	}
}