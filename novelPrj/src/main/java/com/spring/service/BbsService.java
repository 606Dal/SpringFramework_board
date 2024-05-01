package com.spring.service;

import java.util.List;

import com.spring.vo.BbsVO;
import com.spring.vo.FindCriteria;
import com.spring.vo.PageCriteria;

public interface BbsService {
	public void write(BbsVO bvo) throws Exception; //글 등록을 위한
	
	public BbsVO read(Integer bid) throws Exception; // 글 읽기

	public void modify(BbsVO bvo) throws Exception; // 글 수정
	
	public void remove(Integer bid) throws Exception; // 글 삭제
	
	public List<BbsVO> list() throws Exception; // 글 목록
	
	public List<BbsVO> listCriteria(PageCriteria pCria) throws Exception; //페이지당 글 개수(선택 가능)
	
	public int listCountData(PageCriteria pCria) throws Exception; //DB에 있는 글의 총 개수
	
	public List<BbsVO> listFind(FindCriteria findCri) throws Exception; //검색 목록
	
	public int findCountData(FindCriteria findCri) throws Exception; //검색된 글의 총 개수
	
}
