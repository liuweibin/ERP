package com.erp.core.web;


import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/user")
public class UserController{
	private Logger log = Logger.getLogger(UserController.class);
 
	 @RequestMapping(value="/login")
	 public String Login(){
		 log.info("-----"); 
		 return "index";
	 }
	 @RequestMapping(value="/loginError")
	 public String loginError(){
		 log.info("-----");
		 return "login";
	 }
 
}
