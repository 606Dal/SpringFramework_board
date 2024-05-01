package com.spring.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PagingMaker {
	private int totalData; //전체 데이터 개수
	private int startPage; //페이지 목록 버튼의 시작 번호
	private int endPage; //페이지 목록 버튼의 끝 번호
	private boolean prev; //이전 버튼을 나타내는 부울 값
	private boolean next; //다음 버튼을 나타내는 부울 값
	
	private int displyPageNum = 10;  // 페이지 버튼에 나타낼 페이지 번호의 개수
	
	private PageCriteria cri;
	
	public void setCri(PageCriteria cri) {
		this.cri = cri;
	}
	//중요한 부분.
	public void setTotalData(int totalData) {
		this.totalData = totalData;
		
		getPagingData();
	}
	
	private void getPagingData() {
		//endPage 구하기 Math.올림(현재 페이지 번호/페이지 버튼에 나타낼 페이지 번호의 개수) * 페이지 버튼에 나타낼 페이지 번호의 개수
		endPage = (int)(Math.ceil(cri.getPage()/(double)displyPageNum) * displyPageNum);
	
		startPage = (endPage - displyPageNum) + 1;
		//버튼의 끝 페이지 = 전체 글의 수 / 한 페이지 당 보여줄 글의 수
		int finalEndPage = (int)(Math.ceil(totalData/(double)cri.getNumPerPage()));
		
		if(endPage > finalEndPage) {
			endPage = finalEndPage;
		}
		
		prev = startPage == 1 ? false : true;
		
		next = endPage*cri.getNumPerPage() >= totalData ? false : true;
		
	}//getPagingData()

	//uri자동 생성
	public String makeURI(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("numPerPage", cri.getNumPerPage())
				.build();
		
		return uriComponents.toUriString();
	}
	//검색용 uri 생성
	public String makeFind(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("numPerPage", cri.getNumPerPage())
				.queryParam("findType", ((FindCriteria)cri).getFindType())
				.queryParam("keyword", ((FindCriteria)cri).getKeyword())
				.build();
		
		return uriComponents.toUriString();
	}
	

	//setter, getter
	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplyPageNum() {
		return displyPageNum;
	}

	public void setDisplyPageNum(int displyPageNum) {
		this.displyPageNum = displyPageNum;
	}

	public int getTotalData() {
		return totalData;
	}

	public PageCriteria getCri() {
		return cri;
	}

	
}
