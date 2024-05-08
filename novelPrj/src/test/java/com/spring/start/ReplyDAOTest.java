package com.spring.start;

import javax.inject.Inject;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.dao.ReplyDAO;
import com.spring.vo.ReplyVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class ReplyDAOTest {
	
	@Inject
	private ReplyDAO reDao;
	
	private static Logger logger = LogManager.getLogger(ReplyDAOTest.class);
	/*
	@Test
	public void listTest() throws Exception {
		logger.info(reDao.relist(1).toString());
	} //마이바티스에서 이름이 모호하다는 오류 나옴 -> Bbs에서도 list를(같은 단어) 사용해서 생긴 오류였음.
	
	@Test
	public void writeTest() throws Exception {
		ReplyVO revo = new ReplyVO();
		revo.setBid(2);
		revo.setReplyContent("작성 테스트 중");
		revo.setReplyer("테스터1");
		
		reDao.write(revo);
	}

	@Test
	public void modifyTest() throws Exception{
		ReplyVO revo = new ReplyVO();
		revo.setRebid(2);
		revo.setReplyContent("작성/수정 테스트 중");
		
		reDao.modify(revo);
	}
	*/
	
	@Test
	public void deleteTest() throws Exception{
		reDao.reDelete(3); //3번 글 지움
	}
	//list랑 같은 오류
}
