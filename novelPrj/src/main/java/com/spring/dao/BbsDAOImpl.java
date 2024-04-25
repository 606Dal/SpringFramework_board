package com.spring.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.vo.BbsVO;
import com.spring.vo.PageCriteria;

@Repository
public class BbsDAOImpl implements BbsDAO {

	@Inject
	private SqlSession sqlSession;
	//글 추가
	@Override
	public void insert(BbsVO bvo) throws Exception {
		sqlSession.insert("insert", bvo);
	}
	//하나의 글 가져오기
	@Override
	public BbsVO read(Integer bid) throws Exception {
		return sqlSession.selectOne("read", bid);
	}
	//글 수정
	@Override
	public void update(BbsVO bvo) throws Exception {
		sqlSession.update("update", bvo);
	}
	//글 삭제
	@Override
	public void delete(Integer bid) throws Exception {
		sqlSession.delete("delete", bid);
	}
	//글 목록
	@Override
	public List<BbsVO> list() throws Exception {
		return sqlSession.selectList("list");
	}
	//페이지 처리(임시 사용)
	@Override
	public List<BbsVO> listPage(int page) throws Exception {
		//첫 페이지 설정
		if(page <=0) {
			page = 1;
		}
		//페이지 당 글 10개씩 보이게 할 거라서 (20개씩 하려면 * 20 // sql도 같이 바꿔야 함)
		page = (page - 1) * 10;
		
		return sqlSession.selectList("listPage", page);
	}
	//페이지 당 표시할 글 개수 선택 가능
	@Override
	public List<BbsVO> listCriteria(PageCriteria pageCria) throws Exception {
		return sqlSession.selectList("listCriteria", pageCria);
	}
	//DB에 저장된 글의 총 개수
	@Override
	public int countData(PageCriteria pCria) throws Exception {
		return sqlSession.selectOne("countData", pCria);
	}

}
