package com.spring.vo;

public class PageCriteria {

	private int page;
	private int numPerPage; //페이지당 몇 개씩
	
	public PageCriteria() {
		this.page = 1;
		this.numPerPage = 10;
	}
	
	public void setPage(int page) {
		if(page<=0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setNumPerPage(int numPerPage) {
		if (numPerPage <=0 || numPerPage > 100) {
			this.numPerPage = 10;
			return;
		}
		this.numPerPage = numPerPage;
	}
	
	public int getPage() {
		return page;
	}
	//시작 페이지 위치
	public int getStartPage() {
		return (this.page-1)*numPerPage;
	}
	
	public int getNumPerPage() {
		return this.numPerPage;
	}

	@Override
	public String toString() {
		return "PageCriteria [page=" + page + ", numPerPage=" + numPerPage + "]";
	}
	
	
}
