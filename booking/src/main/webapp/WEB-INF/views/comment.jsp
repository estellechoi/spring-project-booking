<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/frame.css?re" />
<style>

	a {
		text-decoration: none;
	}
	nav {
		height: 50px;
		background: white;
		display: flex;
	}
	
	nav > div {
		line-height: 50px;
		text-align: center;
	}
	
	nav > div:nth-child(1) {
		flex-grow: 1;
	}
	nav > div:nth-child(2) {
		flex-grow: 8;
	}
		
	.comments {
		border-top: 1px solid #eeeeee;
	}
	
</style>
</head>
<body>
	<div id="viewport" data-value="${param.id}">
		<!-- 뒤로가기 -->
		<nav>
			<div><a href="#">뒤로</a></div>
			<div>회사이름</div>
		</nav>
		
		<!-- 본문 -->
		<section id="comment-container">
			<h3>예매자 한줄평</h3>
			<div>총평점 ... 총 건수</div>
			<script type="text/template" id="template-comment">
				<article class="comments">
					<div>
						<p>한줄평 텍스트</p>
						<img src="" alt="no image" width="80px" />
					</div>
					<div>
						{점수} | {아이디} | {날짜..} 방문
					</div>
				</article>
			</script>
		</section>
		
	</div>
	
	
	<script>
		const templateComment = document.querySelector("#template-comment").innerHTML;
		
		const id = document.querySelector("#viewport").getAttribute("data-value");
		window.addEventListener("DOMContentLoaded", sendAjax(id));
		
		function sendAjax(id) {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				sendJson(jsonObj);
			});
			oReq.open("GET", "./json/comment?id=" + id);
			oReq.send();
		}
		
		function sendJson(jsonObj) {
			
		}
	</script>
</body>
</html>