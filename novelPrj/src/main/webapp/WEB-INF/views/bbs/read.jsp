<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>글 조회</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="index.html">Start Read</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="#">Home</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="#">About</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="#">Sample Post</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="#">Contact</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <%--role 속성 : HTML5에서 새롭게 추가.
        ARIA(Aceessible Rich Internet Application)라는 HTML5의 상세 규격 중 하나
        시각 장애인이 컴퓨터의 리더기를 사용해서 웹 페이지를 읽을 때 해당 부분이 form이라고 정의해 줌
        role은 필수적인 요소는 아니지만 화면용 리더기를 이용해야 하는 사람들에게도 불편함이 없는 사이트를 제공하고자 하는 경우에 이용--%>
        
        <%-- 제이쿼리 이용해서 처리 --%>
        <form role="form" method="post">
        	<input type="hidden" name="bid" value="${bbsVO.bid}">
        </form>
        
        <!-- Page Header-->
        <header class="masthead" style="background-image: url('${pageContext.request.contextPath}/resources/assets/img/post-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="post-heading">
                        <%-- 컨트롤러의 read()에서 bbsVO로 데이터가 넘어옴. --%>
                            <h1>${bbsVO.subject}</h1>
                            <span class="meta">
	                            &nbsp;&nbsp;Posted by ${bbsVO.writer}&nbsp;&nbsp;
	                            <%-- 작성일/조회수 --%>
	                            <fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${bbsVO.regdate}"/>
	                        </span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
         <article class="mb-4">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <p>${bbsVO.content}</p>
                        <br>
				        <!--Button-->
				        <div class="d-grid gap-2 d-md-block">
					        <button class="btn btn-success me-3" id="btn_modify" type="submit" style="font-size: medium;">수정하기</button>
					        <button class="btn btn-danger me-3" id="submitButton" type="submit" style="font-size: medium;">삭제하기</button>
					        <button class="btn btn-primary" id="submitButton" type="submit" style="font-size: medium;">목록 →</button>
				        </div>
                    </div>
                </div>
            </div>
        </article>
        <script>
        	//$=jQuery
        	$(document).ready(function(){ //현재 문서(document)가 준비가 되면 다음 function을 시행
        		var frmObj = $("form[role='form']"); // role이 form으로 설정된 form을 선택
        		
        		console.log("폼 태그입니다..") //F12 눌렀을 때 나오는 콘솔 창에 출력
        		// * id를 이용한 방법
        		$("#btn_modify").on("click", function(){ //수정 버튼 클릭하면
        			frmObj.attr("action", "/bbs/modify"); //attr=Attribute, 여기로 이동
        			frmObj.attr("method", "get");	//설정 안 하면 기본 get 방식(여기 선택한 폼은 기본 post로 설정 해 놔서 사용)
        			frmObj.submit();
        		});
        		// * class="" 부분을 이용한 방법
        		$(".btn-danger").on("click", function(){ //삭제 버튼 클릭하면
        			frmObj.attr("action", "/bbs/delete"); //여기로 이동
        			frmObj.submit();
        		});
        		
        		$(".btn-primary").on("click", function(){ //목록 버튼 클릭하면
        			self.location = "/bbs/list";	//현재 위치 변경
        		});
        		
        	});
        </script>


<%@ include file="../include/footer.jsp" %>
