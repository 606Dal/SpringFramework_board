package com.spring.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.service.BbsService;
import com.spring.vo.BbsVO;
import com.spring.vo.PageCriteria;
import com.spring.vo.PagingMaker;

@Controller
@RequestMapping("/bbs/*")//게시판 관련 공통 경로
public class BbsController {

	private static final Logger logger = LoggerFactory.getLogger(BbsController.class);
	
	//root.context에 스캔 등록 해놔서 주입 가능
	@Inject
	private BbsService bsvc;
	
	//글 쓰기
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void writeGet(BbsVO bvo, Model model) throws Exception {
		logger.info("write Get.....");
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
//	public String writePost(BbsVO bvo, Model model) throws Exception {
	//RedirectAttributes 객체 : 리다이렉트 시점에 한 번만 사용되는 데이터를 전송할 수 있는 addFlashAttribute()메소드를 지원함.
	public String writePost(BbsVO bvo, RedirectAttributes reAttr) throws Exception {
		logger.info("write Post.....");
		logger.info(bvo.toString()); //전달되는 정보 확인 용
		
		bsvc.write(bvo);
//		model.addAttribute("result", "게시글 등록 완료");
		reAttr.addFlashAttribute("result", "등록 완료");
		
//		return "/bbs/resultOk"; //결과 페이지 (나중에는 list로)
		return "redirect:/bbs/list";
	}
	
	//글 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void list(Model model) throws Exception{
		logger.info("글 목록 가져오기......");
		
		model.addAttribute("list", bsvc.list()); //BbsServiceImpl의 메소드 호출
	}
	
	//글 상세보기
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	  //@RequestParam : 글 번호(=bid)를 전달(jsp 에서 a 태그로)받기 위한 어노테이션
	public void read(@RequestParam("bid") int bid, Model model) throws Exception {
		model.addAttribute(bsvc.read(bid)); //bid를 받아와서 넘겨 줌
		//addAttribute에 key를 사용하지 않았을 경우 key는 클래스의 이름을 자동으로 소문자로 시작해서 저장됨.
		//원래 bsvc.read의 리턴 값은 BbsVO -> bbsVO(=key)
	}
	
	//글 삭제(read.jsp-form에 post 설정함)
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@RequestParam("bid") int bid, RedirectAttributes reAttr) throws Exception {
		
		bsvc.remove(bid);
		
		reAttr.addFlashAttribute("result", "삭제 성공"); //list.jsp에서 result로 받음
		return "redirect:/bbs/list";
	}
	
	//글 수정(조회 페이지)
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void modifyGET(int bid, Model model) throws Exception{
		model.addAttribute(bsvc.read(bid)); //bbsVO로 넘어옴
	}
		//수정 처리
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(BbsVO bvo, RedirectAttributes reAttr) throws Exception{
		logger.info("modifyPOST().......");
		
		bsvc.modyfi(bvo);
		reAttr.addFlashAttribute("result", "수정 완료");
		
		return "redirect:/bbs/list";
	}
	
	//페이지 당 글 개수 조정(테스트)
	@RequestMapping(value = "/pageListTest", method = RequestMethod.GET)
	public void pageListTest(PageCriteria pCria, Model model) throws Exception{
		logger.info("pageListTest().......");
		
		model.addAttribute("list", bsvc.listCriteria(pCria));
		// '/pageListTest'로 들어가면 PageCriteria 클래스를 읽어서 기본적으로 설정된 1페이지, 10개만 보이게 됨
	}
	
	//페이지 버튼을 위한 페이징 처리
	@RequestMapping(value = "/pageList", method = RequestMethod.GET)
	public void pageList(PageCriteria pCria, Model model) throws Exception {
		logger.info(pCria.toString());
		
		model.addAttribute("list", bsvc.listCriteria(pCria));
		//PagingMaker를 생성해서 Criteria를 세팅하고 값 설정(현재 페이지와 보여줄 글 개수)
		PagingMaker pagingMaker = new PagingMaker();
		pagingMaker.setCri(pCria);
//		pagingMaker.setTotalData(155); //임의로 값 설정 -> 총 16페이지
		pagingMaker.setTotalData(bsvc.listCountData(pCria)); //DB에 저장된 글의 총 개수
		
		// model > pagingMaker > Criteria(페이징메이커 안에 포함)
		model.addAttribute("pagingMaker", pagingMaker);
	}
}
