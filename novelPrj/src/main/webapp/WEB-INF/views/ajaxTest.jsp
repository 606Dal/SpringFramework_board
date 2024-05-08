<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax테스트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style type="text/css">
	#modifyDiv{
		width: 500px;
		height: 100px;
		background-color: rgba(255, 255, 128, .5);
		position: absolute;
		top:20%;
		left: 30%;
		padding: 20px;
		z-index: 100;
		display: none;
	}

</style>
</head>
<body>
	<h3>Reply REST + Ajax Test</h3>
	
	<%-- 댓글 입력 부분 --%>
	<div class="container" align="left" >
		<div>
			작성자 : <input type="text" name="replyer" id="writer">
		</div>
		<br>
		<div>
			댓 글 : <input type="text" size="50" name="replyContent" id="addReContent">
		</div>
		<br>
		<button id="submitBtn">댓글 작성</button>
	</div>
	
	<%-- 띄워줄 수정 창 --%>
	<div id="modifyDiv" class="container">
		<span class="title-dialog"></span>번 댓글
		<div>
			수정 내용 : <br>
			<input type="text" id="reContent" size="60">
		</div>
		<br>
		<div align="center">
			<button type="button" id="reModifyBtn">수정</button>
			<button type="button" id="reDelBtn">삭제</button>
			<button type="button" id="closeBtn">닫기</button>
		</div>
	</div>
	
	<h4>댓글 리스트</h4>
	<ul id="reply">
	
	</ul>
	
	<%-- 페이지 버튼 --%>
	<ul class="pgeNumList">
	</ul>

<%-- * bid 는 임시로 지정 
	* 선택자가 없으면 ($).으로 들어감	JSONData로 받을 거라서 getJSON 사용.
		이때 들어오는 데이터는 보통 data 라는 매개변수로 받음 -> function(data) 
		reListAll()에서는 댓글리스트를 data로 받는 것
	* each = for 문 
	* reListAll() 이라고 함수를 만들어서 계속 사용 가능--%>
<script type="text/javascript">

	var bid = 2;
	
	getPgeNum(1);//임시 호출
	
	function reListAll(){
		//""안에는 댓글 List 가져오는 url(ReplyController에서 지정했던 경로)
		$.getJSON("/replies/selectAll/"+bid,function(data){
			//console.log(data.length); //리스트의 개수
			var str = "";
			
			$(data).each(function(){
				str += "<li data-rebid='" + this.rebid + "' class='reList'>"
					+ this.rebid + " | " + this.replyContent
					+"<button>수정</button>"
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
				str += "<li data-rebid='" + this.rebid + "' class='reList'>"
					+ this.rebid + " | " + this.replyContent
					+"<button>수정</button>"
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
			str +="<li><a href='"+(pagingMaker.startPage-1)+"'>◀</a></li>";
		}
		for(var i=pagingMaker.startPage, end=pagingMaker.endPage; i <= end; i++){
			str += "<a href='"+i+"'><button type='button'>"+i+"</button></a>";
		}
		//다음 버튼
		if(pagingMaker.next){
			str +="<li><a href='"+(pagingMaker.endPage+1)+"'>▶</a></li>";
		}
		
		$(".pgeNumList").html(str);
		
	}//showPageNum()
	
//페이지 버튼 번호 클릭 시 이동
	var rePage = 1;
	
	$(".pgeNumList").on("click", "a button", function(e) {
		e.preventDefault(); // <a> 태그의 화면 전환이 일어나지 않게 하는 메서드
		
		rePage = $(this).parent().attr("href"); //this = button
		
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
				}
			}
		});
	});
	
//댓글 수정 버튼 - <ul id="reply"> / <li class="reList"> 안의 버튼 지정
	//댓글 작성 후에 list가 나와야 수정 버튼이 생김. 그래서 이미 있는 ul에서 시작해서 이벤트 위임
	$("#reply").on("click", ".reList button", function(){
		var li = $(this).parent(); //리스트 부분
		
		var rebid = li.attr("data-rebid");
		var reContent = li.text();
		
		//alert("댓글번호 : "+rebid+" 수정할 내용 :"+reContent);
		//수정 창
		$(".title-dialog").html(rebid);
		$("#reContent").val(reContent);
		$("#modifyDiv").show("slow");
	});
	
//수정 창 - 삭제버튼 클릭 시 처리
	$("#reDelBtn").on("click", function(){
		
		var rebid = $(".title-dialog").html();
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
		
		var rebid = $(".title-dialog").html();
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
					alert("댓글 수정 성공!");
					$("#modifyDiv").hide("slow");//수정 창 다시 닫음
					reListAll();
				}
			}
		});
	});
	

</script>
</body>
</html>