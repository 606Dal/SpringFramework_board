package com.spring.service;

import java.util.List;

import com.spring.vo.PageCriteria;
import com.spring.vo.ReplyVO;

public interface ReplySvc {
	public void inputReply(ReplyVO rvo) throws Exception; //댓글 추가
	
	public List<ReplyVO> replyList(Integer bid) throws Exception; //댓글들 불러오기
	
	public void modifyReply(ReplyVO rvo) throws Exception; //댓글 수정
	
	public void delReply(Integer rebid) throws Exception; //댓글 삭제
	
	public List<ReplyVO> replyListPage(Integer bid, PageCriteria pCri) throws Exception; //댓글 페이징 처리
	
	public int reCount(Integer bid) throws Exception; //댓글 총 개수

}
