package com.erp.core.util;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

public class commonUtils {
	/**
	 * 获取ip
	 * @param request
	 * @return
	 */
	public static String  getRemortIP(HttpServletRequest request) {      
		  if (request.getHeader("x-forwarded-for") == null) {      
		   return request.getRemoteAddr();      
		  }      
		  return request.getHeader("x-forwarded-for");      
	 }
	
	// 通过IP获取网卡地址
	public static String getMacAddressIP(String remotePcIP) {
		String str = "";
		String macAddress = "";
		try {
			Process pp = Runtime.getRuntime().exec("ipconfig -all " + remotePcIP);
			System.out.println("pp = " + pp);
			InputStreamReader ir = new InputStreamReader(pp.getInputStream());
			LineNumberReader input = new LineNumberReader(ir);
			for (int i = 1; i < 100; i++) {
				str = input.readLine();
				 System.out.println("str = " + str);
				if (str != null) {
					if (str.indexOf("MAC Address") > 1) {
						macAddress = str.substring(
								str.indexOf("MAC Address") + 14, str.length());
						break;
					}
				}
			}
		} catch (IOException ex) {

		}
		return macAddress;
	}
	
	/**
	 * 封装返回客户端的信息
	 * @param retcode  					编码，0：成功，1：失败 
	 * @param message   				消息描述
	 * @param useableBalance :			 可以用余额
	 * @param data  Map<String,Object>  数据
	 * @return  JSONObject 
	 */
	public static JSONObject responseClict(String retcode,String message,String useableBalance,Object obj){
		Map<String,Object> map = new HashMap<String, Object>();
			map.put("retcode", retcode);
			map.put("message", message);
			map.put("useableBalance", useableBalance);
			map.put("data", obj);
			JSONObject jsonO = new JSONObject().fromObject(map);
			return jsonO;
		}
	
}
