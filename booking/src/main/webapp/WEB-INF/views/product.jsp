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

#gnb {
/*  	position: absolute; */
/*  	width: 100%; */
}

#btn-comment {
	height: 50px;
	display: flex;
	justify-content: center;
	align-items: center;
}

a {
	text-decoration: none;
}

#title-container {
  	height: 600px;
  	overflow: hidden;
  	position: relative;
}

#background {
	border: 1px solid red;
}

#title {
	position: absolute;
	top: 50%;
	width: 100%;
	text-align: center;
	font-size: 30px;
	font-weight: bold;
	color: white;
}

#content-container {
	height: 80px;
	overflow: hidden;
	background: white;
}

#content {
	padding: 20px;
	font-size: 20px;
	line-height: 30px;
}

#btn-unfold {
	height: 50px;
	width: 600px;
	font-size: 15px;
	background: #f6f6f6;
	border: none;
	vertical-align: middle;
	cursor: pointer;
}

#event-container {
	padding: 0px 20px;
	background: white;
}

#event-container > div {
	padding: 10px;
	height: 30px;
	line-height: 30px;
}

#event {
	border-top: 1px solid lightgrey;
}

#btn-reservation {
	height: 50px;
	width: 600px;
	font-size: 15px;
	background: #5ECB6B;
	border: none;
	color: white;
	vertical-align: middle;
	cursor: pointer;
}

#comment-container {
	height: 400px;
	overflow: hidden;
	padding: 10px 20px;
	background: white;
}

#displayinfo-container {
	margin-top: 5px;
	background: white;
}

#displayinfo-container > nav {
	display: flex;
	height: 50px;
	margin-bottom: 3px;
	
}

#displayinfo-container > nav > div {
	flex-grow: 1;
	line-height: 50px;
	text-align: center;
}

#displayinfo-container > nav > div:nth-child(1) {
	color: #5ECB6B;
	border-bottom: 3px solid #5ECB6B;
}
</style>
</head>
<body>
	<div id="viewport" data-value="${param.id}">
		<!-- gnb : global navigation bar -->
		<header id="gnb">
			<div id="logo">예약</div>
			<div id="user-email">eeee@naver.com</div>
		</header>
		
		<div id="title-container">
			<div id="background">
				<script type="text/template" id="template-imgs">
					<img class="backgroundImgs" src="{{saveFileName}}" alt="no image" width="100%"/>
				</script>
			</div>
			<script type="text/template" id="template-title">
				<div id="title">{{description}}</div>
			</script>
		</div>
		
		<section id="content-container">
			<script type="text/template" id="template-content">
				<div id="content">{{content}}</div>
			</script>
		</section>
		
		<input id="btn-unfold" type="button" value="펼쳐보기" />
		
		<section id="event-container">
			<div>이벤트 정보</div>
			<script type="text/template" id="template-event">
				<div id="event">
					{{#events event}}
						{{event}}
					{{/events}}
				</div>
			</script>
		</section>
		
		<input id="btn-reservation" type="button" value="예매하기" />	
		
		<!-- jsp import 로 수정 ? -->
		<section id="comment-container">
		</section>
		
		<!-- 한줄평 전체보기 페이지 이동 -->
		<nav id="btn-comment">
			<a href="comment?id=${param.id}">예매자 한줄평 더보기</a>
		</nav>
		
		<section id="displayinfo-container">
			<nav>
				<div>상세정보</div>
				<div>오시는길</div>
			</nav>
			<section>
				tab ui 구현 영역			
			</section>
		</section>
		
	</div>
	<!-- handlebar library 다운로드 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.5.3/handlebars.min.js" integrity="sha256-GwjGuGudzIwyNtTEBZuBYYPDvNlSMSKEDwECr6x6H9c=" crossorigin="anonymous"></script>
	<script>
		// Handlebars helper 등록
		Handlebars.registerHelper("events", function(event) {
			if (event === "") {
				return "현재 진행중인 이벤트가 없습니다.";
			}
			else {
				return event;
			}
		});
		
		const templateImgs = document.querySelector("#template-imgs").innerHTML;
		const templateTitle = document.querySelector("#template-title").innerHTML;
		const templateContent = document.querySelector("#template-content").innerHTML;
		const templateEvent = document.querySelector("#template-event").innerHTML;
		
		// DOM Loaded
		const id = document.querySelector("#viewport").getAttribute("data-value");
		window.addEventListener("DOMContentLoaded", sendAjax(id));
		
		function sendAjax(id) {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				sendJson(jsonObj);
			});
			oReq.open("GET", "./json/product?id=" + id);
			oReq.send();
		}
		
		function sendJson(jsonObj) {
			var product = jsonObj["product"];
			var listImage = jsonObj["listImage"];
			getImgsTempl(listImage);
			getTitleTempl(product);
			getContentTempl(product);
			getEventTempl(product);		
		}

		function getImgsTempl(listImage) {
			var bindTemplate = Handlebars.compile(templateImgs);
			var background = document.querySelector("#background");
						
			var resultHTML = "";
			listImage.forEach(function(obj) {
				var resultTpl = bindTemplate(obj);
				resultHTML += resultTpl;
			});
			background.innerHTML = resultHTML;
		}
		
		function getTitleTempl(product) {
			var bindTemplate = Handlebars.compile(templateTitle);
			var resultHTML = bindTemplate(product);
			var titleContainer = document.querySelector("#title-container");
			titleContainer.insertAdjacentHTML("beforeend", resultHTML);		
		}

		function getContentTempl(product) {
			var bindTemplate = Handlebars.compile(templateContent);			
			var resultHTML = bindTemplate(product);			
			var contentContainer = document.querySelector("#content-container");
			contentContainer.innerHTML = resultHTML;
		}

		function getEventTempl(product) {
			var bindTemplate = Handlebars.compile(templateEvent);			
			var resultHTML = bindTemplate(product);
			var eventContainer = document.querySelector("#event-container");
			eventContainer.insertAdjacentHTML("beforeend", resultHTML);	
		}
		
		// 펼쳐보기/접기
		var btnUnfold = document.querySelector("#btn-unfold");
		btnUnfold.addEventListener("click", function(evt) {
			unfoldContent(evt.target.value);
		});
		
		function unfoldContent(value) {
			var contentContainer = document.querySelector("#content-container");
			if (value === "펼쳐보기") {
				// overflow hidden 내용이 있을 때에만
				contentContainer.style.height = "auto";
				if (contentContainer.offsetHeight < 80) {
					contentContainer.style.height = "80px";
				}
				btnUnfold.value = "접기";
			}
			else {
				contentContainer.style.height = "80px";
				btnUnfold.value = "펼쳐보기";
			}
		}

// 		const btnComment = document.querySelector("#btn-comment");
// 		btnComment.addEventListener("click", function() {			
// 		});
	</script>
</body>
</html>