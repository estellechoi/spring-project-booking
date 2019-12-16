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

#background-container {
  	height: 600px;
  	overflow: hidden;
  	position: relative;
}

#frontground {
	position: absolute;
	left: 50%;
	transform:translateX(-50%);
	top: 50%;
	font-size: 30px;
	color: white;
}

#content-container {
	height: 100px;
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
	background: #eeeeee;
	border: 1px solid lightgrey;
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
	color: white;
	vertical-align: middle;
	cursor: pointer;
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
		<div id="background-container">
			<div id="background">
			</div>
		</div>
		<section id="content-container"></section>
		<input id="btn-unfold" type="button" value="펼쳐보기" />
		<section id="event-container">
			<div>이벤트 정보</div>
		</section>
		<input id="btn-reservation" type="button" value="예매하기" />	
	</div>
	
	<!-- html template -->
	<script type="text/template" id="template-background">
		<img class="backgroundImgs" src="{{saveFileName}}" alt="no image" width="100%"/>
	</script>
	<script type="text/template" id="template-frontground">
		<!-- position absolute -->
		<div id="frontground">{{description}}</div>
	</script>
	<script type="text/template" id="template-content">
		<div id="content">{{content}}</div>
	</script>
	<script type="text/template" id="template-event">
		<div id="event">
			{{#events event}}
				{{event}}
			{{/events}}
		</div>
	</script>
	
	<!-- handlebar library 다운로드 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.5.3/handlebars.min.js" integrity="sha256-GwjGuGudzIwyNtTEBZuBYYPDvNlSMSKEDwECr6x6H9c=" crossorigin="anonymous"></script>
	<script>
		Handlebars.registerHelper("events", function(event) {
			if (event === "") {
				return "현재 진행중인 이벤트가 없습니다.";
			}
			else {
				return event;
			}
		});
		// DOM Loaded
		const id = document.querySelector("#viewport").getAttribute("data-value");
		window.addEventListener("DOMContentLoaded", sendAjax(id));
		
		function sendAjax(id) {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				getTemplateBackground(jsonObj);
// 				getBackgroundImg(jsonObj);
				getTemplateContent(jsonObj);
				getTemplateEvent(jsonObj);
			});
			oReq.open("GET", "./json/product?id=" + id);
			oReq.send();
		}
		
		function getTemplateEvent(jsonObj) {
			const template = document.querySelector("#template-event").innerHTML;
			var bindTemplate = Handlebars.compile(template);
			
			var listProduct = jsonObj["listProduct"];
			var resultHTML = bindTemplate(listProduct[0]);
			var eventContainer = document.querySelector("#event-container");
			eventContainer.insertAdjacentHTML("beforeend", resultHTML);	
		}
		
		function getTemplateContent(jsonObj) {
			const template = document.querySelector("#template-content").innerHTML;
			var bindTemplate = Handlebars.compile(template);
			
			var listProduct = jsonObj["listProduct"];
			var resultHTML = bindTemplate(listProduct[0]);
// 			alert(listProduct[0].id);
			
			var contentContainer = document.querySelector("#content-container");
			contentContainer.innerHTML = resultHTML;
		}
		
		function getTemplateBackground(jsonObj) {
			const templateBack = document.querySelector("#template-background").innerHTML;
			const templateFront = document.querySelector("#template-frontground").innerHTML;
			var bindTemplateBack = Handlebars.compile(templateBack);
			var bindTemplateFront = Handlebars.compile(templateFront);
			var backgroundContainer = document.querySelector("#background-container");
			var background = document.querySelector("#background");
			
			var listProduct = jsonObj["listProduct"];
			var resultFront = bindTemplateFront(listProduct[0]);
			backgroundContainer.insertAdjacentHTML("beforeend", resultFront);
			
			var resultBack = "";
			listProduct.forEach(function(obj) {
				resultBack += bindTemplateBack(obj);
			});
			background.innerHTML = resultBack;
		}
		
		function getBackgroundImg(jsonObj) {
			
			var imgUrl = "";
			listProduct.forEach(function(obj) {
				imgUrl += "url('" + obj.saveFileName + "'),";		
			});
			var e = imgUrl.lastIndexOf(",");
			imgUrl = imgUrl.substring(0, e);
			backgroundContainer.style.backgroundImage = imgUrl;			
		}
		
		// 펼쳐보기/접기
		var btnUnfold = document.querySelector("#btn-unfold");
		btnUnfold.addEventListener("click", function(evt) {
			unfoldContent(evt.target.value);
		});
		
		function unfoldContent(value) {
			if (value === "펼쳐보기") {
				document.querySelector("#content-container").style.height = "auto";
				btnUnfold.value = "접기";
			}
			else {
				document.querySelector("#content-container").style.height = "100px";
				btnUnfold.value = "펼쳐보기";
			}
		}

	</script>
</body>
</html>