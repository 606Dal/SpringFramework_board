package com.spring.dao;

import java.util.List;

import com.spring.vo.BbsVO;
import com.spring.vo.FindCriteria;
import com.spring.vo.PageCriteria;

public interface BbsDAO {
	public void insert(BbsVO bvo) throws Exception; //새로운 글이 들어오면 추가
	
	public BbsVO read(Integer bid) throws Exception; //글을 읽어 옴
	
	public void update(BbsVO bvo) throws Exception; // 글 수정
	
	public void delete(Integer bid) throws Exception; // 글 삭제
	
	public List<BbsVO> list() throws Exception; //글 목록
	
	public List<BbsVO> listPage(int page) throws Exception; // 페이지 처리를 위한 목록(임시 확인용)
	
	
	public List<BbsVO> listCriteria(PageCriteria pageCria) throws Exception; // 페이지 당 가져올 글 개수
	
	public int countData(PageCriteria pageCria) throws Exception; //DB에 있는 글의 총 개수
	//FindCriteria가 PageCriteria를 상속받아서 위의 2개 메서드는 아래 2개 메서드가 한 번에 해결
	public List<BbsVO> listFind(FindCriteria findCri) throws Exception; //검색을 위한
	
	public int findCountData(FindCriteria findCri) throws Exception; //검색된 글의 총 개수
	
}
