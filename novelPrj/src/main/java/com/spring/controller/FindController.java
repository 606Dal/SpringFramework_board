package com.spring.controller;

import javax.inject.Inject;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.service.BbsService;
import com.spring.vo.BbsVO;
import com.spring.vo.FindCriteria;
import com.spring.vo.PagingMaker;

@Controller
@RequestMapping("/fbbs/*")
public class FindController {
	private static final Logger logger = LogManager.getLogger(FindController.class);
	
	@Inject
	private BbsService bsvc;
	
	//검색 기능 포함 글 보기
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void list(@ModelAttribute("fCri") FindCriteria fCri, Model model) throws Exception {
		logger.info(fCri.toString());
		
		//BbsService에서는 PageCriteria를 인자로 사용하고 있는데, FindCriteria가 상속받아서 이렇게 사용 가능
//		model.addAttribute("list", bsvc.listCriteria(fCri));
		model.addAttribute("list", bsvc.listFind(fCri));
		
		PagingMaker pagingMaker = new PagingMaker();
		pagingMaker.setCri(fCri);
		
//		pagingMaker.setTotalData(bsvc.listCountData(fCri)); //전체 데이터 알아내기
		pagingMaker.setTotalData(bsvc.findCountData(fCri));
		
		model.addAttribute("pagingMaker", pagingMaker);
	}
	//상세 글 페이지
	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void readPage(@RequestParam("bid") int bid, 
			@ModelAttribute("fCri") FindCriteria fCri, Model model) throws Exception {
		model.addAttribute(bsvc.read(bid));
	}
	//글 삭제
	@RequestMapping(value = "/delPage", method = RequestMethod.POST)
	public String delPage(@RequestParam("bid") int bid, FindCriteria fCri,
			RedirectAttributes reAttr) throws Exception {
		
		bsvc.remove(bid);
		//원래 목록 페이지로 돌아오기 위해 모두 유지
		reAttr.addAttribute("page", fCri.getPage());
		reAttr.addAttribute("numPerPage", fCri.getNumPerPage());
		reAttr.addAttribute("findType", fCri.getFindType());
		reAttr.addAttribute("keyword", fCri.getKeyword());
		
		reAttr.addFlashAttribute("result", "DelSuccess");
		
		return "redirect:/fbbs/list";
	}
	
	//글 수정 페이지
	@RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
	public void modifyGET(int bid, @ModelAttribute("fCri") FindCriteria fCri, Model model) throws Exception {
		//addAttribute에 key를 사용하지 않았을 경우 key는 클래스의 이름을 자동으로 소문자로 시작해서 저장됨.
		model.addAttribute(bsvc.read(bid)); //jsp파일에서 bbsVO 사용
	}
		//DB 수정 처리
	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
	public String modifyPOSt(BbsVO bvo, FindCriteria fCri, RedirectAttributes reAttr) throws Exception {
		logger.info("fCri : " + fCri.toString());
		
		bsvc.modify(bvo);//수정한 내용을 DB에 전달
		
		reAttr.addAttribute("page", fCri.getPage());
		reAttr.addAttribute("numPerPage", fCri.getNumPerPage());
		reAttr.addAttribute("findType", fCri.getFindType());
		reAttr.addAttribute("keyword", fCri.getKeyword());
		
		//addFlashAttribute : 주소창에 값이 나오지 않게 하기 위해 사용
		reAttr.addFlashAttribute("result", "ModifySuccess");
		
		logger.info(reAttr.toString());
		
		return "redirect:/fbbs/list";
	}
	
	//글 쓰기 페이지 요청
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void writeGET() throws Exception {
		logger.info("***writeGET() 호출***");
	}
		//DB에 쓴 글 저장
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String writePOST(BbsVO bvo, RedirectAttributes reAttr) throws Exception {
		logger.info("***writePOST() 호출***");
		
		bsvc.write(bvo);
		
		reAttr.addFlashAttribute("result", "WriteSuccess");
		
		return "redirect:/fbbs/list";
	}
	
	
}
