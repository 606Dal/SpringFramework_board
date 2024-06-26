package com.spring.vo;

public class FindCriteria extends PageCriteria {
	private String findType;
	private String Keyword;
	
	public String getFindType() {
		return findType;
	}
	public void setFindType(String findType) {
		this.findType = findType;
	}
	public String getKeyword() {
		return Keyword;
	}
	public void setKeyword(String keyword) {
		this.Keyword = keyword;
	}
	
	@Override
	public String toString() {
		return super.toString() + "FindCriteria [findType=" + findType + ", Keyword=" + Keyword + "]";
	}
	
	
}
