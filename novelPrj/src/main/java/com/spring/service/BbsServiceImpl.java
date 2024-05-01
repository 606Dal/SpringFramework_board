package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.dao.BbsDAO;
import com.spring.vo.BbsVO;
import com.spring.vo.FindCriteria;
import com.spring.vo.PageCriteria;

//어노테이션 안 잊게 주의
@Service
public class BbsServiceImpl implements BbsService {
	
	@Inject
	private BbsDAO bdao;
	
	//글 쓰기
	@Override
	public void write(BbsVO bvo) throws Exception {
		bdao.insert(bvo); //BbsDAO에 작성한 메서드 사용
	}
	//글 읽기
	@Override
	public BbsVO read(Integer bid) throws Exception {
		return bdao.read(bid);
	}
	//글 수정
	@Override
	public void modify(BbsVO bvo) throws Exception {
		bdao.update(bvo);
	}
	//글 삭제
	@Override
	public void remove(Integer bid) throws Exception {
		bdao.delete(bid);
	}
	//글 목록
	@Override
	public List<BbsVO> list() throws Exception {
		return bdao.list();
	}
	//페이지당 글 개수(선택 가능)
	@Override
	public List<BbsVO> listCriteria(PageCriteria pCria) throws Exception {
		return bdao.listCriteria(pCria);
	}
	//DB에 있는 글의 총 개수
	@Override
	public int listCountData(PageCriteria pCria) throws Exception {
		return bdao.countData(pCria);
	}

	//검색된 목록
	@Override
	public List<BbsVO> listFind(FindCriteria findCri) throws Exception {
		return bdao.listFind(findCri);
	}
	//검색된 글의 총 개수
	@Override
	public int findCountData(FindCriteria findCri) throws Exception {
		return bdao.findCountData(findCri);
	}
}
