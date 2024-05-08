package com.spring.dao;

import java.util.List;

import com.spring.vo.PageCriteria;
import com.spring.vo.ReplyVO;

public interface ReplyDAO {
	public List<ReplyVO> relist(Integer bid) throws Exception; //해당 게시글에 대한 댓글(을 위해서 bid를 사용)

	public void write(ReplyVO rvo) throws Exception; //댓글 쓰기
	
	public void modify(ReplyVO rvo) throws Exception; //댓글 수정
	
	public void reDelete(Integer rebid) throws Exception; //댓글 삭제
	
	public List<ReplyVO> reListPage(Integer bid, PageCriteria pCri) throws Exception; //댓글 페이징 처리
	
	public int reCount(Integer bid) throws Exception; //총 댓글 수
}
