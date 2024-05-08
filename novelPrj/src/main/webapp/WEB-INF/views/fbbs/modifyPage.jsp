<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>글 수정(검색 추가)</title>
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
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="/fbbs/write">글쓰기</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="#">Contact</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Page Header-->
        <header class="masthead" style="background-image: url('${pageContext.request.contextPath}/resources/assets/img/home-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="page-heading">
                            <h1>${bbsVO.subject}</h1>
                            <span class="meta">
                            	<%-- 글 번호, 작성자 --%>
	                            ${bbsVO.bid} | Posted by
	                            ${bbsVO.writer}&nbsp;&nbsp;
	                            <%-- 작성일/조회수 --%>
	                            <fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${bbsVO.regdate}"/>
	                        </span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Main Content-->
        <main class="mb-4">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <p>읽은 책에 대하여 자유롭게 작성해 주세요.</p>
                        <div class="my-5">
                     <!-- 글 수정 부분 -->
                            <form role="form" method="post">
                            	<input type="hidden" name="page" value="${fCri.page}">
                            	<input type="hidden" name="numPerPage" value="${fCri.numPerPage}">
                            	<%-- <input type="hidden" name="findType" value="${fCri.findType}">
        						<input type="hidden" name="keyword" value="${fCri.keyword}"> --%>
                            	
                                <div class="form-floating">
                                    <input class="form-control" name="subject" type="text" value="${bbsVO.subject}" 
                                    	placeholder="Enter subject..."/>
                                    <label for="subject">제목</label>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control" name="writer" type="text" value="${bbsVO.writer}" 
                                    	placeholder="Enter your name..." readonly/>
                                    <label for="writer">작성자</label>
                                </div>
                                <div class="form-floating">
                                    <textarea class="form-control" name="content" placeholder="Enter your message here..."
                                    	style="height: 12rem" >${bbsVO.content}</textarea>
                                    <label for="content">내용</label>
                                </div>
                                <br>
                            </form>
                            <!-- Submit Button-->
                            <button class="btn btn-primary me-3" id="btn_save" type="submit" style="font-size: medium;">저장하기</button>
                            <button class="btn btn-warning" id="btn_cancle" type="submit" style="font-size: medium;">취소하기</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
         <script>
        	//jQuery
        	$(document).ready(function() {
        		var frmObj = $("form[role='form']");
        		
        		console.log("수정 폼태그입니다..");
        		//저장 버튼
        		$("#btn_save").on("click", function(){
        			frmObj.submit(); //컨트롤러에서 modifyPOST 부분으로 감
        		});
        		//취소 버튼
        		$("#btn_cancle").on("click", function(){
        			self.location="/fbbs/readPage?page=${fCri.page}&numPerPage=${fCri.numPerPage}"
        				+ "&findType=${fCri.findType}&keyword=${fCri.keyword}&bid=${bbsVO.bid}";
        		});
        	});
        	
        </script>


<%@ include file="../include/footer.jsp" %>
