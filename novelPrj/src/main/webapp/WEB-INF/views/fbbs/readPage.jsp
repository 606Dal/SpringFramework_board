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
        <title>글 조회(검색 추가)</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style type="text/css">
		/* #modifyDiv{
			width: 500px;
			height: 100px;
			background-color: rgba(255, 255, 128, .5);
			position: absolute;
			top:20%;
			left: 30%;
			 padding: 20px;
			 z-index: 100;
			display: none;
		} */
		#reList {
		font-size: 15px;
		}
	</style>
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
        <%--role 속성 : HTML5에서 새롭게 추가.
        ARIA(Aceessible Rich Internet Application)라는 HTML5의 상세 규격 중 하나
        시각 장애인이 컴퓨터의 리더기를 사용해서 웹 페이지를 읽을 때 해당 부분이 form이라고 정의해 줌
        role은 필수적인 요소는 아니지만 화면용 리더기를 이용해야 하는 사람들에게도 불편함이 없는 사이트를 제공하고자 하는 경우에 이용--%>
        
        <%-- 제이쿼리 이용해서 처리 --%>
        <form role="form" method="post">
        	<input type="hidden" name="bid" value="${bbsVO.bid}">
        	<input type="hidden" name="page" value="${fCri.page}">
        	<input type="hidden" name="numPerPage" value="${fCri.numPerPage}">
        	<input type="hidden" name="findType" value="${fCri.findType}">
        	<input type="hidden" name="keyword" value="${fCri.keyword}">
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
				        
				        <!-- 댓글 -->
				        <div class="post-preview mt-5">
	                    	<h5 class="post-title">댓글</h5>
	                    	<!-- 댓글 목록 -->
                           	<ul id="reply" class="list-group">
							</ul>
							<!-- 페이징 목록 -->
							<div class="d-flex justify-content-center my-2">
	                    		<nav aria-label="Page navigation">
									<ul id="pgeNumList" class="pagination">
									</ul>
								</nav>
							</div>
	                    </div>
	                    <!-- Divider-->
	                    <hr class="my-4" />
	                    
	                    <div class="form-floating">
                            <input class="form-control" name="replyer" id="writer" type="text" placeholder="Enter your name..." />
                            <label for="writer">작성자</label>
                        </div>
                        <div class="form-floating">
                            <textarea class="form-control" name="replyContent" id="addReContent" placeholder="Enter your message here..." style="height: 6rem" ></textarea>
                            <label for="addReContent">댓글을 입력해 주세요</label>
                        </div>
                        <br>
                        <!-- Submit Button-->
                        <button class="btn btn-outline-dark btn-sm" id="submitBtn" type="submit" style="font-size: medium;">댓글 등록</button>
                        
                        <%-- 띄워줄 수정 창 --%>
                        <div class="modal" tabindex="-1" id="modifyDiv">
						  <div class="modal-dialog" >
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title">번 댓글</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <div class="modal-body">
						        <label for="reContent">수정 내용:</label>
						        <textarea class="form-control" name="reContent" id="reContent" placeholder="Enter your message here..." style="height: 6rem" ></textarea>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-outline-success" id="reModifyBtn">수정</button>
						        <button type="button" class="btn btn-outline-danger" id="reDelBtn">삭제</button>
						        <button type="button" class="btn btn-outline-dark"  data-bs-dismiss="modal" id="closeBtn">닫기</button>
						      </div>
						    </div>
						  </div>
						</div>
                    </div>
                </div>
            </div>
        </article>
        <script type="text/javascript">
        	//$=jQuery
        	$(document).ready(function(){ //현재 문서(document)가 준비가 되면 다음 function을 시행
        		var frmObj = $("form[role='form']"); // role이 form으로 설정된 form을 선택
        		
        		console.log("폼 태그입니다..") //F12 눌렀을 때 나오는 콘솔 창에 출력
        		// * id를 이용한 방법
        		$("#btn_modify").on("click", function(){ //수정 버튼 클릭하면
        			frmObj.attr("action", "/fbbs/modifyPage"); //attr=Attribute, 여기로 이동
        			frmObj.attr("method", "get");	//설정 안 하면 기본 get 방식(여기 선택한 폼은 기본 post로 설정 해 놔서 사용)
        			frmObj.submit();
        		});
        		// * class="" 부분을 이용한 방법
        		$(".btn-danger").on("click", function(){ //삭제 버튼 클릭하면
        			frmObj.attr("action", "/fbbs/delPage"); //여기로 이동
        			frmObj.submit();
        		});
        		
        		$(".btn-primary").on("click", function(){ //목록 버튼 클릭하면
        			/* self.location = "/fbbs/list";	//현재 위치 변경 */
        			frmObj.attr("method", "get");
        			frmObj.attr("action", "/fbbs/list");
        			frmObj.submit();
        		});
        		
        	});
        	
        //댓글
        	var bid = ${bbsVO.bid};
        	
        	getPgeNum(1);//임시 호출
        	
        	function reListAll(){
        		//""안에는 댓글 List 가져오는 url(ReplyController에서 지정했던 경로)
        		$.getJSON("/replies/selectAll/"+bid,function(data){
        			//console.log(data.length); //리스트의 개수
        			var str = "";
        			
        			$(data).each(function(){
        				str += "<li data-rebid='" + this.rebid + "' id='reList' class='list-group-item'>"
        					+ this.rebid + " | Posted by <a href='#!'>" + this.replyer
        					+ "</a><br> <span id='spanReCon'>" + this.replyContent + "</span>"
        					+"<button type='button' class='btn btn-outline-success btn-sm ms-2 float-end'>수정</button>"
        					+ "</li>";
        			});
        			
        			$("#reply").html(str);
        		});
        	}//reListAll()
        	
        //페이지 버튼(목록 번호 얻어오기)
        	function getPgeNum(page){
        		$.getJSON("/replies/"+bid+"/"+page, function(data){
        			
        			console.log(data.reList.length);
        			
        			var str="";
        			
        			$(data.reList).each(function(){
        				str += "<li data-rebid='" + this.rebid + "' id='reList' class='list-group-item'>"
        					+ this.rebid + " | Posted by <a href='#!'>" + this.replyer
        					+ "</a><br> <span id='spanReCon'>" + this.replyContent + "</span>"
        					+"<button type='button' class='btn btn-outline-success btn-sm ms-2 float-end'>수정</button>"
        					+ "</li>";
        			});
        			
        			$("#reply").html(str);
        			
        			showPageNum(data.pagingMaker)
        		});
        	}//getPgeNum()
        	
        //페이지 버튼 보기
        	function showPageNum(pagingMaker){
        		var str = "";
        		//이전 버튼
        		if(pagingMaker.prev){
        			str +="<li class='page-item'><a class='page-link' href='"+(pagingMaker.startPage-1)+"'>◀</a></li>";
        		}
        		for(var i=pagingMaker.startPage, end=pagingMaker.endPage; i <= end; i++){
        			str += "<li class='page-item'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
        		}
        		//다음 버튼
        		if(pagingMaker.next){
        			str +="<class='page-item'li><a class='page-link' href='"+(pagingMaker.endPage+1)+"'>▶</a></li>";
        		}
        		
        		$("#pgeNumList").html(str);
        		
        	}//showPageNum()
        	
        //페이지 버튼 번호 클릭 시 이동
        	var rePage = 1;
        	
        	$("#pgeNumList").on("click", "a", function(e) {
        		e.preventDefault(); // <a> 태그의 화면 전환이 일어나지 않게 하는 메서드
        		
        		//rePage = $(this).parent().attr("href"); //this = button
        		rePage = $(this).attr("href");
        		
        		getPgeNum(rePage);
        	});
        	
        //댓글 작성 버튼 클릭 시 처리
        	$("#submitBtn").on("click", function(){
        		
        		var reWriter = $("#writer").val();
        		var reContent = $("#addReContent").val();
        		
        		$.ajax({
        			type : 'post',
        			url : '/replies',
        			headers:{
        				"Content-Type" : "application/json",
        				//X-HTTP-Method-Override : 필터 등록 후 사용 가능. REST가 적용 안 되는 브라우저를 위해 사용
        				"X-HTTP-Method-Override" : "POST"
        			},
        			
        			dataType : 'text',
        				//stringify : JSON 형태로 데이터를 만들어서 전송
        			data : JSON.stringify({
        				bid : bid,
        				replyer : reWriter,
        				replyContent : reContent
        			}),
        			
        			success : function(result){
        				if(result == 'Success'){
        					//alert("댓글 등록 성공!")
        					reListAll();
        					//댓글 등록 성공 시 내용 초기화
        					$("#writer").val("");
        					$("#addReContent").val("");
        				}
        			}
        		});
        	});
        	
        //댓글 수정 버튼 - <ul id="reply"> / <li id="reList"> 안의 버튼 지정
        	//댓글 작성 후에 list가 나와야 수정 버튼이 생김. 그래서 이미 있는 ul에서 시작해서 이벤트 위임
        	$("#reply").on("click", "#reList button", function(){
        		var li = $(this).parent(); //리스트 부분
        		
        		var rebid = li.attr("data-rebid");
        		var reContent = $("#spanReCon").text();
        		
        		//alert("댓글번호 : "+rebid+" 수정할 내용 :"+reContent);
        		//수정 창
        		$(".modal-title").html(rebid);
        		$("#reContent").val(reContent);
        		$("#modifyDiv").show("slow");
        	});
        	
        //수정 창 - 삭제버튼 클릭 시 처리
        	$("#reDelBtn").on("click", function(){
        		
        		var rebid = $(".modal-title").html();
        		var reContent = $("#reContent").val();
        		
        		$.ajax({
        			type:'delete',
        			url : '/replies/'+rebid,
        			headers:{
        				"Content-Type" : "application/json",
        				"X-HTTP-Method-Override" : "DELETE"
        			},
        			dataType : 'text',
        			success : function(result){
        				console.log("result: " + result);
        				if(result == 'Success'){
        					alert("댓글 삭제 성공!");
        					$("#modifyDiv").hide("slow");//수정 창 다시 닫음
        					reListAll();
        				}
        			}
        		});
        	});
        	
        //수정 창 - 수정버튼 클릭 시 처리
        	$("#reModifyBtn").on("click", function(){
        		
        		var rebid = $(".modal-title").html();
        		var reContent = $("#reContent").val();
        		
        		$.ajax({
        			type:'put',
        			url : '/replies/'+rebid,
        			headers:{
        				"Content-Type" : "application/json",
        				"X-HTTP-Method-Override" : "PUT"
        			},
        			dataType : 'text',
        			data : JSON.stringify({replyContent : reContent}),
        			success : function(result){
        				console.log("result: " + result);
        				if(result == 'Success'){
        					//alert("댓글 수정 성공!");
        					$("#modifyDiv").hide("slow");//수정 창 다시 닫음
        					reListAll();
        				}
        			}
        		});
        	});
        
        	//수정 창 - 닫기 버튼 클릭 시 처리
        	$("#closeBtn").on("click", function(){
        		$("#modifyDiv").hide("slow");
        	});
        	$(".btn-close").on("click", function(){
        		$("#modifyDiv").hide("slow");
        	});
        	
        	
        </script>


<%@ include file="../include/footer.jsp" %>
