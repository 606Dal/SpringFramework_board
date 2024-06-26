<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>


<%@ include file="../include/header.jsp" %>

	<!-- main -->
	<section class="content">
		<!-- Main Content-->
        <div class="container px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5 justify-content-center">
                <div class="col-md-10 col-lg-8 col-xl-7">
                	<!-- 목록에 보이는 글 개수 선택 창 -->
               		<select id="select" class="form-select form-select-sm float-end" style="width: 200px;" aria-label=".form-select-sm">
					  <option value="10">10개씩 보기</option>
					  <option value="15">15개씩 보기</option>
					  <option value="20">20개씩 보기</option>
					</select>
                	
                    <!-- 컨트롤러에서 지정한 것과 같이 list-->
                    <c:forEach items="${list}" var="bvo">
	                    <div class="post-preview">
	                        <%-- <a href="/bbs/read?bid=${bvo.bid}"> 수정--%>
	                        <a href="/bbs/readPage${pagingMaker.makeURI(pagingMaker.cri.page)}&bid=${bvo.bid}">
	                            <h2 class="post-title">${bvo.subject}</h2>
	                        </a>
	                        <p class="post-meta">
	                            ${bvo.bid} | Posted by
	                            <a href="#!">${bvo.writer}</a>&nbsp;&nbsp;
	                            <%-- 작성일/조회수 --%>
	                            <fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${bvo.regdate}"/> &nbsp;&nbsp;hit : ${bvo.hit}
	                        </p>
	                    </div>
	                    <!-- Divider-->
	                    <hr class="my-4" />
                    </c:forEach>
                    
                    <!-- 페이지 이동 버튼-->
                    <div class="d-flex justify-content-center mb-4">
                    	<nav aria-label="Page navigation">
						  <ul class="pagination">
						  	<%-- 시작페이지가 1이면 이전 버튼이 안 보이게 --%>
						    <c:if test="${pagingMaker.prev}">
							    <li class="page-item">
							      <a class="page-link" href="pageList${pagingMaker.makeURI(pagingMaker.startPage-1)}" aria-label="Previous">
							        <span aria-hidden="true">&laquo;</span>
							      </a>
							    </li>
						    </c:if>
						    <%-- 버튼 총 10개(번호 부분만) 표시됨 --%>
						    <c:forEach begin="${pagingMaker.startPage}" end="${pagingMaker.endPage}" var="pNum">
						    	<%-- PageCriteria의 페이지 값이 pNum과 같으면 page-item active(=해당 버튼 색 표시)를 class=""부분에 출력 --%>
							    <li class= "<c:out value="${pagingMaker.cri.page == pNum ? 'page-item active' : 'page-item'}"/> ">
							    	<a class="page-link" href="pageList${pagingMaker.makeURI(pNum)}">
							    		${pNum}
							    	</a>
							    </li>
						    </c:forEach>
						    
						    <c:if test="${pagingMaker.next && pagingMaker.endPage > 0}">
							    <li class="page-item">
							      <a class="page-link" href="pageList${pagingMaker.makeURI(pagingMaker.endPage+1)}" aria-label="Next">
							        <span aria-hidden="true">&raquo;</span>
							      </a>
							    </li>
						    </c:if>
						  </ul>
						</nav>
                    </div>
                </div>
            </div>
        </div>
	</section>
	
	<script>
		var result = '${result}';
		
		if(result == '등록 완료'){
			alert("게시 글이 등록 완료되었습니다!");
		} else if (result == '삭제 성공'){
			alert("삭제 완료되었습니다!");
		} else if (result == '수정 완료'){
			alert("수정 완료되었습니다!");
		}
	</script>
	<script>
       	//$=jQuery
       	$(document).ready(function(){ //현재 문서(document)가 준비가 되면 다음 function을 시행
       		
       		// * id를 이용한 방법
       		$("#select").on("change", function(){ //옵션을 고르면 그 값을 넣어서 위치 이동
       			/* var numPer = $(this).val(); */
       			self.location="/bbs/pageList?page=${pageCriteria.page}&numPerPage="+ $(this).val();
       		});
       			//이동 후 numPerPage 값이 옵션의 값과 같으면 selected. 해야 버튼 부분에도 내용이 적용됨.
   			if ($('#select').val(${pageCriteria.numPerPage}) == 'optionValue') {
   				$("option:selected", this);
   			};
   			
       	});
    </script>

<%@ include file="../include/footer.jsp" %>