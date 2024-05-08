package com.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.service.ReplySvc;
import com.spring.vo.PageCriteria;
import com.spring.vo.PagingMaker;
import com.spring.vo.ReplyVO;

@RestController
//보통 경로 설정 때 (replies)복수 명으로 많이 사용
@RequestMapping("/replies") //주로 데이터를 입력하는 경우 replies 단어를 많이 사용?(URI 정책)
public class ReplyController {

	@Inject
	private ReplySvc rsvc;
	
	//댓글 추가
		//REST방식에서는 POST가 등록, ResponseEntity : 상태코드를 리턴하겠다는 의미
		//@RequestBody는 @ModelAttribute와 비슷. ReplyVO를 객체로 만듦(JSON 형태로)
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> input(@RequestBody ReplyVO rvo){
		
		ResponseEntity<String> resEntity = null;
		//예외처리가 필요
		try {
			rsvc.inputReply(rvo);
			//뷰가 없어서 대신 볼 수 있는 상태코드가 필요.
			resEntity = new ResponseEntity<String>("Success", HttpStatus.OK); //성공 시 보여줌
		} catch (Exception e) {
			e.printStackTrace();
			resEntity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return resEntity;
	}
	
	//댓글 리스트 가져오기 (@PathVariable : url경로 상에서 값을 지정 /{bid})
	@RequestMapping(value = "/selectAll/{bid}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bid") Integer bid){
		
		ResponseEntity<List<ReplyVO>> resEntity = null;
		
		try {
			resEntity = new ResponseEntity<>(rsvc.replyList(bid), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			resEntity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return resEntity;
	}
	
	//댓글 수정 (PUT과 PATCH 둘 다 쓰려면 배열 방식으로 입력)
		//수정을 위해 보낼 때 JSON 형태로 보내질 거라서, 그 처리를 위해 @RequestBody를 사용해 ReplyVO 형태로 객체를 변환시켜줘야 함
	@RequestMapping(value = "/{rebid}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> modify(@PathVariable("rebid") Integer rebid, 
			@RequestBody ReplyVO rvo){
		
		ResponseEntity<String> resEntity = null;
		
		try {
			rvo.setRebid(rebid);
			rsvc.modifyReply(rvo);
			
			resEntity = new ResponseEntity<String>("Success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			resEntity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return resEntity;
	}
	
	//댓글 삭제
	@RequestMapping(value = "/{rebid}", method = RequestMethod.DELETE)
	public ResponseEntity<String> reDel(@PathVariable("rebid") Integer rebid) {
		
		ResponseEntity<String> resEntity = null;
		
		try {
			rsvc.delReply(rebid);
			resEntity = new ResponseEntity<String>("Success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			resEntity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return resEntity;
	}
	
	//댓글 페이징 처리
	@RequestMapping(value =  "/{bid}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> reListPage(
			@PathVariable("bid") Integer bid,
			@PathVariable("page") Integer page){
		ResponseEntity<Map<String, Object>> resEntity = null;
		
		try {
			
			PageCriteria pCri = new PageCriteria();
			pCri.setPage(page); //현재 페이지
			
			PagingMaker pagingMaker = new PagingMaker();
			pagingMaker.setCri(pCri);
			
			Map<String, Object> reMap = new HashMap<>();
			List<ReplyVO> reList = rsvc.replyListPage(bid, pCri);
			
			reMap.put("reList", reList);
			//댓글 총 개수 구하기
			int reCount = rsvc.reCount(bid);
			pagingMaker.setTotalData(reCount);
			
			reMap.put("pagingMaker", pagingMaker);
			
			resEntity = new ResponseEntity<Map<String,Object>>(reMap, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			resEntity =  new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return resEntity;
	}
	
	
}
