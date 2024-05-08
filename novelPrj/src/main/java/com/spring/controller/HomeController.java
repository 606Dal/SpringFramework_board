package com.spring.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	private static final Logger logger = LogManager.getLogger(HomeController.class);
    
    @RequestMapping("/")
//    public String welcome(Local local, Model model) {
    	public String home(Model model) { //Local을 없애니까 잘 이동함;
    	return "home";
    }
    
    //ajxa테스트
    @RequestMapping(value = "/ajaxTest", method = RequestMethod.GET)
    public void ajaxTest() {
    	
    }
}
