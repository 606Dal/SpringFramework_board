<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>


<%@ include file="../include/header.jsp" %>

	<!-- main -->
	<section class="content">
	
		<div class="container col-md-10 py-1">
            <!-- 검색 창 -->
            <span class="col-md-7">
            	<select id="findType" name="findType" class="form-select form-select-sm float-start" style="width: 180px;" aria-label=".form-select-sm">
				  <option value="N"
				  	<c:out value="${fCri.findType == null ? 'selected' : ''} "/> >------</option>
				  <option value="S"
				  	<c:out value="${fCri.findType == 'S' ? 'selected' : ''} "/> >제목</option>
				  <option value="C"
				  	<c:out value="${fCri.findType == 'C' ? 'selected' : ''} "/> >내용</option>
				  <option value="W"
				  	<c:out value="${fCri.findType == 'W' ? 'selected' : ''} "/> >작성자</option>
				  <option value="SC"
				  	<c:out value="${fCri.findType == 'SC' ? 'selected' : ''} "/> >제목+내용</option>
				  <option value="CW"
				  	<c:out value="${fCri.findType == 'CW' ? 'selected' : ''} "/> >내용+작성자</option>
				  <option value="SCW"
				  	<c:out value="${fCri.findType == 'SCW' ? 'selected' : ''} "/> >제목+내용+작성자</option>
				</select>
				<input class="ms-2" type="text" name="Keyword" id="findword" value="${fCri.keyword}">
				<button class="btn btn-primary btn-sm ms-2 mb-1" id="findBtn"  type="submit" style="font-size: medium;">검색</button>
           	</span>
            	<!-- 목록에 보이는 글 개수 선택 창 -->
             <span class="col-md-3">
             	<select id="selectList" class="form-select form-select-sm float-end" style="width: 130px;" aria-label=".form-select-sm">
				  <option value="10">10개씩 보기</option>
				  <option value="15">15개씩 보기</option>
				  <option value="20">20개씩 보기</option>
				</select>
             </span>
		</div>
		
		<!-- Main Content-->
        <div class="container px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5 justify-content-center">
                <div class="col-md-10 col-lg-8 col-xl-7">
                	
                    <!-- 컨트롤러에서 지정한 것과 같이 list-->
                    <c:forEach items="${list}" var="bvo">
	                    <div class="post-preview">
	                        <a href="/fbbs/readPage${pagingMaker.makeFind(pagingMaker.cri.page)}&bid=${bvo.bid}">
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
							      <a class="page-link" href="list${pagingMaker.makeFind(pagingMaker.startPage-1)}" aria-label="Previous">
							        <span aria-hidden="true">&laquo;</span>
							      </a>
							    </li>
						    </c:if>
						    <%-- 버튼 총 10개(번호 부분만) 표시됨 --%>
						    <c:forEach begin="${pagingMaker.startPage}" end="${pagingMaker.endPage}" var="pNum">
						    	<%-- PageCriteria의 페이지 값이 pNum과 같으면 page-item active(=해당 버튼 색 표시)를 class=""부분에 출력 --%>
							    <li class= "<c:out value="${pagingMaker.cri.page == pNum ? 'page-item active' : 'page-item'}"/> ">
							    	<a class="page-link" href="list${pagingMaker.makeFind(pNum)}">
							    		${pNum}
							    	</a>
							    </li>
						    </c:forEach>
						    
						    <c:if test="${pagingMaker.next && pagingMaker.endPage > 0}">
							    <li class="page-item">
							      <a class="page-link" href="list${pagingMaker.makeFind(pagingMaker.endPage+1)}" aria-label="Next">
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
		
		if(result == 'WriteSuccess'){
			alert("게시 글이 등록 완료되었습니다!");
		} else if (result == 'DelSuccess'){
			alert("삭제 완료되었습니다!");
		} else if (result == 'ModifySuccess'){
			alert("수정 완료되었습니다!");
		}
	</script>
	<script type="text/javascript">
       	//$=jQuery
       	$(document).ready(function(){ //현재 문서(document)가 준비가 되면 다음 function을 시행
       		
       		// * id를 이용한 방법
       		$("#selectList").on("change", function(){ //옵션을 고르면 그 값을 넣어서 위치 이동
       			self.location="/fbbs/list?page=${fCri.page}&numPerPage="+ $(this).val() +"&findType="+$("select option:selected").val()
					+"&keyword=${fCri.keyword}";
       		});
       		//이동 후 numPerPage 값이 옵션의 값과 같으면 선택한 옵션 요소를 가져옴. 해야 버튼 부분에도 내용이 적용됨.
   			if ($('#selectList').val(${fCri.numPerPage}) == 'optionValue') {
   				$("option:selected", this);
   			};
   			
   			//검색 버튼
   			$("#findBtn").on("click", function(e){
   				self.location = "list"+"${pagingMaker.makeURI(1)}"
   					+"&findType="
   					+$("select option:selected").val()
   					+"&keyword="+$("#findword").val();
   			});
   		});
       	
    </script>

<%@ include file="../include/footer.jsp" %>