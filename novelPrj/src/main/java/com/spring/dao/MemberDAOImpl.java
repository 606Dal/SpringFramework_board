package com.spring.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	//memberMapper.xml에서 지정한 namespace와 같은 이름
//	private static final String namespace = "com.spring.MemberMapper";
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public String getTime() {
		//memberMapper.xml에서 지정한 id
		return sqlSession.selectOne("getTime");
		//위에 namespace를 저렇게 지정했을 때 이런식으로도 사용 가능.
//		return sqlSession.selectOne(namespace+".getTime");
	}

	@Override
	public void insertMember(MemberVO mvo) {
		sqlSession.insert("insertMember", mvo);
//		sqlSession.insert(namespace+".insertMember", mvo);
	}

}
