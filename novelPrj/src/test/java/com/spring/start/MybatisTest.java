package com.spring.start;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MybatisTest {
	
	@Inject
	private SqlSessionFactory sqlFactory;
	
	//스프링에 의해 제대로 생성되고 주입이 됐는지 테스트
	@Test
	public void testSqlFactory() {
		System.out.println(sqlFactory);
	}
	
	//SqlSessionTemplate 확인
	@Test
	public void sessionTest() throws Exception{
		try(SqlSession sqlSessionTemplate = sqlFactory.openSession()) {
			System.out.println(sqlSessionTemplate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
