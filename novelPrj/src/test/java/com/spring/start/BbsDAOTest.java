package com.spring.start;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.spring.dao.BbsDAO;
import com.spring.vo.BbsVO;
import com.spring.vo.PageCriteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class BbsDAOTest {
	
	@Inject
	private BbsDAO bdao; //impl에서 @Repository를 써서 DAO로 인식시킨 걸 주입받음
	
	private static Logger logger = LoggerFactory.getLogger(BbsDAOTest.class);
	
/*	@Test
	public void insertTest() throws Exception {
		BbsVO bvo = new BbsVO();
		bvo.setSubject("테스트 제목1");
		bvo.setContent("테스트 내용");
		bvo.setWriter("테스터1");
		
		bdao.insert(bvo);
	}
	
	@Test
	public void readTest() throws Exception{
		//toString은 BbsVO에서 제일 마지막에 정의해 놓은 메서드
		logger.info(bdao.read(1).toString());//글 번호 1번을 읽어옴
	}
	
	//수정 테스트
	@Test//테스트는 그냥 void로 하면 됨
	public void updateTest() throws Exception{
		BbsVO bvo = new BbsVO(); //impl에서도 bvo를 사용 중
		bvo.setBid(2);
		bvo.setSubject("수정 테스트 글");
		bvo.setContent("수정 내용");
		bdao.update(bvo);
	}
	
	@Test
	public void deleteTest() throws Exception{
		bdao.delete(3); //3번 글 지움
	}
	
	@Test
	public void listTest() throws Exception{
		//원래 리턴값은 BbsVO. 이때는 로거를 이용
		logger.info(bdao.list().toString());
	}
	
	@Test
	public void listPageTest() throws Exception{
		int page = 5;
		
		List<BbsVO> list = bdao.listPage(page);
		
		for (BbsVO bbsVO : list) {
			logger.info(bbsVO.getBid() + ":" + bbsVO.getSubject());
		}
	}
	
	@Test
	public void listCriteriaTest() throws Exception{
		PageCriteria pCria = new PageCriteria();
		pCria.setPage(3); //3페이지로 지정
		pCria.setNumPerPage(15); //페이지 당 글 개수
		
		List<BbsVO> list = bdao.listCriteria(pCria);
		
		for (BbsVO bvo : list) {
			logger.info(bvo.getBid() + ":" + bvo.getSubject());
		}
	}
	
	//UriComponentsBuilder를 이용하는 법 : org.springframework.web.util 패키지에 있음.
	@Test
	public void uriTest() throws Exception {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.path("/bbs/read")
				.queryParam("bid", 100)
				.queryParam("numPerPage", 20)
				.build();
		//위 처럼 지정해주면 아래처럼 uri를 생성해 줌
		logger.info("/bbs/read?bid=100&numPerPage=20");
		logger.info("uriComponents : " + uriComponents.toString());
	}
 */
	//더 많이 사용하는 방식
	@Test
	public void uriTest2() throws Exception {
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.path("/{module}/{page}")
				.queryParam("bid", 100)
				.queryParam("numPerPage", 20)
				.build()
				.expand("bbs","read")
				.encode();
		//위 처럼 지정해주면 아래처럼 uri를 생성해 줌
		logger.info("/bbs/read?bid=100&numPerPage=20");
		logger.info("uriComponents : " + uriComponents.toString());
	}
	
}
