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

a {
	text-decoration: none;
}

#title-container {
  	height: 600px;
  	overflow: hidden;
  	position: relative;
}

#background {
/* 	border: 1px solid red; */
	opacity: 0.7;
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

#btn-slideImgs {
	display: flex;
}

#btn-slideImgs span {
	padding: 0 10px;
	cursor: pointer;
}

#btn-slideImgs span:nth-child(1) {
	flex-grow: 1;
	text-align: left;
}

#btn-slideImgs span:nth-child(2) {
	flex-grow: 1;
	text-align: right;
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


#comment-container {
	height: 200px;
	overflow: hidden;
	padding: 10px 20px;
	background: white;
}

#btn-reservation {
	background: #5ECB6B;
	display: flex;
}

#btn-reservation a {
	color: white;
	flex-grow: 1;
	height: 50px;
	line-height: 50px;
	text-align: center;
}

#btn-comment {
	display: flex;
/* 	justify-content: center; */
/* 	align-items: center; */
}

#btn-comment a {
	color: #4c4c4c;
	flex-grow: 1;
	height: 50px;
	line-height: 50px;
	text-align: center;
}

#displayinfo-container {
	margin-top: 5px;
}

#displayinfo-container > nav {
	display: flex;
	height: 50px;
	margin-bottom: 3px;
	background: white;	
}

#displayinfo-container > nav > div {
	flex-grow: 1;
	line-height: 50px;
	text-align: center;
	cursor: pointer;
}

#nav-info {
	color: #5ECB6B;
	border-bottom: 3px solid #5ECB6B;
}

#displayinfo {
	padding: 20px;
	background: white;		
}

#displayinfo h4 {
	margin: 0;
}
/* 상세보기 */
#info p {
	line-height: 25px;
}
/* 오시는길 */
#map-img {
	margin-bottom: 20px;
	height: 200px;
	overflow: scroll;
}

#displayinfo table {
	width: 400px;
	margin: 20px 0;
}

#displayinfo table td {
	padding: 5px 10px;
}

#placeLot-alert {
	font-size: 13px;
	color: grey;
}

#placeLot {
	font-size: 14px;	
}

#placeName {
	color: #4c4c4c;
	font-size: 14px;
}

#navigation-nav {
	height: 50px;
	background: #eeeeee;
	border: 1px solid #dcdcdc;
	display: flex;
	align-items: center;
}

#navigation-nav a {
	flex-grow: 1;
	text-align: center;
	color: #4c4c4c;
}

#navigation-nav a:nth-child(1) {
	border-right: 2px solid #dcdcdc;
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
				<div id="title">
					<!-- 화살표는 template 밖으로 빼야겠다 .. -->
					<div id="btn-slideImgs">
						<span>«</span>
						<span>»</span>
					</div>
					<div>{{description}}</div>
				</div>
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
		
		<nav id="btn-reservation">
			<a href="#">예매하기</a>
		</nav>
		
		<!-- jsp import 로 수정 ? -->
		<section id="comment-container">
		</section>
		
		<!-- 한줄평 전체보기 페이지 이동 -->
		<nav id="btn-comment">
			<a href="comment?id=${param.id}">예매자 한줄평 더보기</a>
		</nav>
		
		<section id="displayinfo-container">
			<nav id="displayinfo-nav">
				<div id="nav-info">상세정보</div>
				<div id="nav-map">오시는길</div>
			</nav>
			<section id="displayinfo">
				<script type="text/template" id="template-info">
					<article id="info">
						<h4>[소개]</h4>
						<p>{{content}}</p>
						<h4>[공지사항]</h4>
						<p>없음</p>
					</article>
				</script>
				<script type="text/template" id="template-map">
					<article id="map">
						<div id="map-img" style="text-align: center">
							<img src="{{saveFileName}}" alt="no image" />					
						</div>
						<h4>{{description}}</h4>
						<table>
							<tr>
								<td><span style="color:#dcdcdc">ღ</span></td>
								<td>{{placeStreet}}</td>
							</tr>
							<tr>
								<td></td>
								<td><span id="placeLot-alert">지번</span>&nbsp;<span id="placeLot">{{placeLot}}</span></td>
							</tr>
							<tr>
								<td></td>
								<td><span id="placeName">{{placeName}}</span></td>
							</tr>
							<tr>
								<td><span style="color:#dcdcdc">ღ</span></td>
								<td>{{tel}}</td>
							</tr>
						</table>
						<nav id="navigation-nav">
							<a href="#">길찾기</a>
							<a href="#">네비게이션</a>
						</nav>
					</article>
				</script>		
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
		const templateInfo = document.querySelector("#template-info").innerHTML;
		const templateMap = document.querySelector("#template-map").innerHTML;
		
		// DOM Loaded
		const id = document.querySelector("#viewport").getAttribute("data-value");
		window.addEventListener("DOMContentLoaded", sendAjaxDefault(id));
		
		const displayinfoNav = document.querySelector("#displayinfo-nav");
		displayinfoNav.addEventListener("click", function(evt) {
			sendAjaxDisplayInfo(id, evt.target.innerText);
			makeTabColored(evt.target.innerText);
		});
		
		function sendAjaxDisplayInfo(id, clickedTab) {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				sendJsonDisplayInfo(jsonObj, clickedTab);
			});
			// RestController 메소드를 별도로 만들어줘야 하나 ? 쓸데없이 전송되는 데이터들이 있는데 ..
			oReq.open("GET", "./json/product?id=" + id);
			oReq.send();
		}
		
		function sendJsonDisplayInfo(jsonObj, clickedTab) {
			var displayInfo = jsonObj["displayInfo"];
			var product = jsonObj["product"];
			if (clickedTab === "오시는길") {
				getMapTempl(displayInfo);				
			}
			else if (clickedTab === "상세정보") {
				getInfoTempl(product);				
			}
		}
		
		function sendAjaxDefault(id) {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				sendJsonDefault(jsonObj);
			});
			oReq.open("GET", "./json/product?id=" + id);
			oReq.send();
		}
		
		function sendJsonDefault(jsonObj) {
			var product = jsonObj["product"];
			var listImage = jsonObj["listImage"];
			getImgsTempl(listImage);
			getTitleTempl(product);
			getContentTempl(product);
			getEventTempl(product);
			getInfoTempl(product);
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
			// btn-slideImgs
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
		
		function getInfoTempl(product) {
			var bindTemplate = Handlebars.compile(templateInfo);
			var resultHTML = bindTemplate(product);
			var displayinfo = document.querySelector("#displayinfo");
			displayinfo.innerHTML = resultHTML;
		}
		
		function getMapTempl(displayInfo) {
			var bindTemplate = Handlebars.compile(templateMap);
			var resultHTML = bindTemplate(displayInfo);
			var displayinfo = document.querySelector("#displayinfo");
			displayinfo.innerHTML = resultHTML;			
		}
		
		function makeTabColored(clickedTab) {
			var navInfo = document.querySelector("#nav-info");
			var navMap = document.querySelector("#nav-map");
			if (clickedTab === "오시는길") {
				navInfo.style.color = "#4c4c4c";
				navInfo.style.borderBottom = "none";
				navMap.style.color = "#5ECB6B";
				navMap.style.borderBottom = "3px solid #5ECB6B";
			}
			else {
				navInfo.style.color = "#5ECB6B";
				navInfo.style.borderBottom = "3px solid #5ECB6B";
				navMap.style.color = "#4c4c4c";
				navMap.style.borderBottom = "none";				
			}
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