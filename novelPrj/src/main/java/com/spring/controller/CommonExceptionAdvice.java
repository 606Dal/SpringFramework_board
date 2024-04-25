package com.spring.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice //현재 이 클래스가 컨트롤러에서 발생하는 Exception을 전문적으로 처리하는 클래스임을 알려줌.
public class CommonExceptionAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);
	
//	@ExceptionHandler(Exception.class)
//	public String common(Exception e) {
//		logger.info(e.toString());
//		
//		return "err_exception"; //컨트롤러에서 Exception이 발생하면 보여줄 뷰
//	}
	
	//더 구체적으로
	@ExceptionHandler(Exception.class)
	private ModelAndView errMAV(Exception e) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("err_exception");
		mav.addObject("exception", e); //컨트롤러에서 발생할 수 있는 모든 예외를 한 번에 담음
		
		return mav;
	}
	
}
