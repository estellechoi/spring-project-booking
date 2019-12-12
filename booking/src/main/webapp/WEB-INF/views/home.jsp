<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	body {
		background: #444444;
		margin: 0;
	}

	#veiwport {
		background: #eeeeee;
		width: 600px;
		margin: 0px auto;
	}
	
	#gnb {
		height: 50px;
		background: green;
	}
	/* 고정된 컨테이너 */
	#promotion-container {
		height: 200px;
		overflow: hidden;
		/* 부모요소의 position 을 static 하지 않게 설정 */
		position: relative;
		top: 0px;
		left: 0px;
	}
	/* 실제 움직이는 녀석 */
	#promotion {
		height: 200px;
		position: absolute;
		top: 0px;
		display: flex;
 		transition: all 1s ease-out;
	}	
	/* 그 안의 이미지들 */
	#promotion > img {
 		width: 600px;
	}
	
	#tab-container {
		text-align: center;
	}
	
	#tab-menu {
		background: white;
		text-align: center;
	}
	#tab-menu > div {
		height: 50px;
		display: inline-block;
		line-height: 50px;
		text-align: center;
		/* margin: auto 왜 안되지 */
		width: 70px;
		margin-right: 10px;
		margin-left: 10px;
		cursor: pointer;
		font-size: 13px;
		font-weight: bold;
	}
	
	#tab-count {
		height: 50px;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 3px;
		background: white;
		color: grey;
	}
	
 	#tab-content-container {
 		margin: 0;
 		padding: 0;
  		display: inline-flex;
/*   		flex-direction: row; */
  		/* 줄바꿈 가능 */
  		flex-wrap: wrap;
/*   		flex-flow: row wrap; */
  		justify-content: space-around; 
   		align-items: flex-start;
	}
	
	.tab-content {
/* 		align-self: baseline; */
		margin: 5px;
		flex: none;
		text-align: center;
		background: white;
 		width: 260px;
		padding: 10px;
		border: 1px solid lightgrey;
	}

	.tab-content h3, h4 {
		text-align: left;
	}
	
	.tab-content .product-content {
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 2; /* 라인수 */
		-webkit-box-orient: vertical;
		word-wrap: break-word;
		line-height: 1.2em;
		height: 2.4em;
		text-align: left;
		color: grey;
		border-top: 1px solid #eeeeee;
		padding-top: 10px;
	}
	
	.btn-showmore {
		display: none;
		justify-content: center;
		align-items: center;
		background: white;
		font-size: 15px;
		border: 1px solid lightgrey;
		cursor: pointer;
		height: 50px;
 		width: 570px;
		margin: 5px auto;
	}
	
	#btn-top {
		display: flex;
		justify-content: center;
		align-items: center;
		background: none;
		border: none;
		font-size: 15px;
		color: darkgrey;
		cursor: pointer;
		height: 50px;
 		width: 570px;
		margin: 5px auto;		
	}
</style>
</head>
<body>
	<div id="veiwport">
		<!-- gnb : global navigation bar -->
		<header id="gnb"></header>
		<div id="promotion-container">
			<div id="promotion" style="left:0px">
				<c:forEach items="${listPromotion}" var="promotion">
					<img class="promotion-img" src="${promotion.saveFileName}" alt="no image" />
				</c:forEach>
			</div>
		</div>
		<!-- tab ui -->
		<div id="tab-container">
			<!-- lnb : local nav bar -->
			<div id="tab-menu">
				<div>전체리스트</div>
				<c:forEach items="${listCategory}" var="category">
					<div>${category.name}</div>
				</c:forEach>
			</div>
			<div id="tab-count">
				바로 예매 가능한 행사가 <span style="color: red">&nbsp;${count}개&nbsp;</span> 있습니다.
			</div>
			<section id="tab-content-container">
				<c:forEach items="${listProduct}" var="product" varStatus="status">
					<div class="tab-content">
						<img src="${product.saveFileName}" alt="no image" /><br />
						<h3>${product.description}</h3>
						<h4>${product.placeName}</h4>
						<p class="product-content">${product.content}</p>
					</div>
				</c:forEach>
			</section>
			<c:forEach items="${listPageStartIndex}" begin="1" var="pageStartIndex">
				<input class="btn-showmore" type="button" value="더보기" onclick="showMore(${pageStartIndex})"/>			
			</c:forEach>
				<input id="btn-top" type="button" value="TOP" />
		</div>
	</div>
	<!-- html template -->
	<script type="text/template" id="html-template">
		<div class="tab-content">
			<img src="{saveFileName}" alt="no image" /><br />
			<h3>{description}</h3>
			<h4>{placeName}</h4>
			<p class="product-content">{content}</p>
		</div>
	</script>
	<!-- javascript -->
	<script>
	
		// 멤버 선언
		const promotion = document.querySelector("#promotion");
		const promotionImgs = document.querySelectorAll(".promotion-img");
		var countPromotion = 0;
		const tabContainer = document.querySelector("#tab-content-container");
		const btnShowmore = document.querySelectorAll(".btn-showmore");
		var template = document.querySelector("#html-template").innerHTML;
		var countPage = 1;
		const btnTop = document.querySelector("#btn-top");
		
		// 함수 호출
		window.addEventListener("DOMContentLoaded", slidePromotion);
		window.addEventListener("DOMContentLoaded", controlBtnShowmore(countPage));
		btnTop.addEventListener("click", goTop);
				
		// setTimeout을 하는 순간 호출 스택에 함수가 쌓이는 게 아니라 백그라운드를 거쳐 태스크 큐로 넘어가기 때문에 호출 스택이 터지는 일이 발생하지 않습니다.
		function slidePromotion() {
				setTimeout(function(){
					var preX = parseInt(promotion.style.left);
					promotion.style.left = (preX - 600) + "px";
					countPromotion++;					
					// const movingChild = promotion.firstChild;
					// promotion.removeChild(movingChild);
					// promotion.appendChild(movingChild);
					
					// 마지막 이미지일 때
					if (countPromotion >= promotionImgs.length - 1) {
						promotion.style.left = 0;
						countPromotion = 0;
					}
					// 재귀 호출
					slidePromotion();					
				}, 1000);
 		}
		
		// 더보기 버튼 숨기기
		function controlBtnShowmore(countPage) {
			// countPage : 첫번째 페이지 포함
			// btnShowmore.length : 첫번째 페이지 불포
			if (countPage <= btnShowmore.length) {
				// 더보기 버튼 보이기
				btnShowmore[countPage - 1].style.display = "flex";
			}

			// 버튼 숨기기 (2 페이지부터)
			if (countPage >= 2) {
				btnShowmore[countPage - 2].style.display = "none";				
			}
		}
		
		// scrollTop = 0 으로 위로 돌아가기
		function goTop() {
			document.documentElement.scrollTop = 0;
		}
		
		// 상품 더보기 AJAX
		function showMore(start) {			
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				// json 포맷 문자열 응답결과를 json 객체로 변환 (서버 Map -> json 객체)
				var jsonObj = JSON.parse(this.responseText);
				var jsonArray = jsonObj["listProduct"];
				fillTemplate(jsonArray);
			});
			
			oReq.open("GET", "./json/home?start=" + start);
			oReq.send();
		}
		
		function fillTemplate(jsonArray) {
			var tabContentContainer = document.querySelector("#tab-content-container");
			// jsonArray : ProductDisplayFile 객체를 요소로 하는 배열
			var result = "";
			jsonArray.forEach(function(objValue) {
				var resultTemplate = template.replace("{saveFileName}", objValue["saveFileName"])
									 .replace("{description}", objValue["description"])
									 .replace("{placeName}", objValue["placeName"])
									 .replace("{content}", objValue["content"]);
				result += resultTemplate;
			});
			
			// 특정 요소 전/후로 HTML 더하기
			tabContentContainer.insertAdjacentHTML("beforeend", result);
			// 페이지 수 카운트
			countPage++;
			controlBtnShowmore(countPage);
		}
		
	</script>
</body>
</html>