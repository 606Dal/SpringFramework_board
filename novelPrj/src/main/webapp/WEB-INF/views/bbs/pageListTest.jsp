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
                    <!-- 컨트롤러에서 지정한 것과 같이 list-->
                    <c:forEach items="${list}" var="bvo">
	                    <div class="post-preview">
	                        <a href="/bbs/read?bid=${bvo.bid}">
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
                    <!-- 이전 포스트로 이동하는 버튼-->
                    <div class="d-flex justify-content-end mb-4"><a class="btn btn-primary text-uppercase" href="#!">Older Posts →</a></div>
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

<%@ include file="../include/footer.jsp" %>