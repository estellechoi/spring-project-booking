<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@font-face {
	    font-family: NanumGothicWebR;
	    font-style: normal;
	    font-weight: 400;
	    src: url('/booking/font/NanumGothicRegular.woff') format('woff')
	}
	
	body, header, section, div {
		font-family: NanumGothicWebR;
	}
	
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
		background: #5ECB6B;
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
 		transition: all 2s ease-out;
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
		height: 50px;
	}
	#tab-menu > .categories {
		height: 50px;
		display: inline-block;
		line-height: 50px;
		text-align: center;
		/* margin: auto 왜 안되지 */
		width: 70px;
		margin-right: 10px;
		margin-left: 10px;
		cursor: pointer;
		font-size: 15px;
		font-weight: 600;
		color: #4c4c4c;
	}
	
	#tab-menu > .categories:nth-child(1) {
 		color: #5ECB6B;
 		border-bottom: 3px solid #5ECB6B;		
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
				<div class="categories">전체리스트</div>
				<c:forEach items="${listCategory}" var="category">
					<div class="categories">${category.name}</div>
				</c:forEach>
			</div>
			<div id="tab-count">
				바로 예매 가능한 행사가 &nbsp;<span id="count-result" style="color: red">${count}개</span>&nbsp; 있습니다.
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
			<div id="btn-container">
				<c:forEach items="${listPageStartIndex}" begin="1" var="pageStartIndex">
					<input class="btn-showmore" type="button" value="더보기" onclick="showAjax(${pageStartIndex}, '전체리스트')"/>			
				</c:forEach>
			</div>
			<input id="btn-top" type="button" value="TOP" />
		</div>
	</div>
	<!-- html template -->
	<script type="text/template" id="template-categories">
		<div class="categories">{categoryName}</div>
	</script>
	<script type="text/template" id="template-tabcontent">
		<div class="tab-content">
			<img src="{saveFileName}" alt="no image" /><br />
			<h3>{description}</h3>
			<h4>{placeName}</h4>
			<p class="product-content">{content}</p>
		</div>
	</script>
	<script type="text/template" id="template-btn">
		<input class="btn-showmore" type="button" value="더보기" onclick="showAjax({pageStartIndex}, '{clickedMenu}')"/>		
	</script>
	<!-- javascript -->
	<script>
	
		// 프로모션 멤버
		const promotion = document.querySelector("#promotion");
		const promotionImgs = document.querySelectorAll(".promotion-img");
		var countPromotion = 0;
		// 탭 멤버
		const tabMenu = document.querySelector("#tab-menu");
		const categories = document.querySelectorAll(".categories");
		var countPage = 1;
		// html template
		var templateTabContent = document.querySelector("#template-tabcontent").innerHTML;
		var templateBtn = document.querySelector("#template-btn").innerHTML;
		// TOP 버튼
		const btnTop = document.querySelector("#btn-top");
		
		// 함수 호출
		window.addEventListener("DOMContentLoaded", slidePromotion);
		window.addEventListener("DOMContentLoaded", controlBtnShowmore(countPage));
		window.addEventListener("DOMContentLoaded", showAjax(0, '전체리스트'));
		btnTop.addEventListener("click", goTop);
		tabMenu.addEventListener("click", function(evt) {
			showAjax(0, evt.target.innerText);
			makeTabColored(evt.target.innerText);
		});
				
		// setTimeout을 하는 순간 호출 스택에 함수가 쌓이는 게 아니라 백그라운드를 거쳐 태스크 큐로 넘어가기 때문에 호출 스택이 터지는 일이 발생하지 않습니다.
		function slidePromotion() {
				setTimeout(function(){
					var preX = parseInt(promotion.style.left);
					promotion.style.left = (preX - 600) + "px";
					countPromotion++;										
					// 마지막 이미지일 때
					if (countPromotion >= promotionImgs.length - 1) {
						promotion.style.left = 0;
						countPromotion = 0;
					}
					// 재귀 호출
					slidePromotion();					
				}, 2000);
 		}
		
		// 클릭한 탭 색상 표시하기
		function makeTabColored(clickedMenu) {
			categories.forEach(function(category) {
				if (category.innerText === clickedMenu) {
					category.style.color = "#5ECB6B";
					category.style.borderBottom = "3px solid #5ECB6B";
				}
				else {
					category.style.color = "#4c4c4c";
					category.style.borderBottom = "none";					
				}
			});
		}
		
		// 더보기 버튼 숨기기
		function controlBtnShowmore(countPage) {
			var btnShowmore = document.querySelectorAll(".btn-showmore");
			// countPage : 첫번째 페이지 포함 3
			// btnShowmore.length : 첫번째 페이지 불포 2
			if (countPage <= btnShowmore.length) {
				btnShowmore[countPage - 1].style.display = "flex";
			}
			if (countPage >= 2) {
				btnShowmore[countPage - 2].style.display = "none";				
			}
		}
		
		// scrollTop = 0 으로 위로 돌아가기
		function goTop() {
			document.documentElement.scrollTop = 0;
		}
		
		// AJAX
		function showAjax(start, clickedMenu) {			
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				// json 포맷 문자열 응답결과를 json 객체로 변환 (서버 Map -> json 객체)
				var jsonObj = JSON.parse(this.responseText);
				template(jsonObj, start, clickedMenu);
			});
			oReq.open("GET", "./json/home/" + clickedMenu + "?start=" + start);				
			oReq.send();
		}

		function template(jsonObj, start, clickedMenu) {
// 			var listCategory = jsonObj["listCategory"];
			var count = jsonObj["count"];
			var listProduct = jsonObj["listProduct"];
			var listPageStartIndex = jsonObj["listPageStartIndex"];
			var tabContentContainer = document.querySelector("#tab-content-container");
			if (start === 0) {
				tabContentContainer.innerHTML = "";
				getCount(count);
				btnTemplate(listPageStartIndex, clickedMenu);
				// 페이지, 버튼 보이기 숨기기 초기화
				countPage = 1;
				controlBtnShowmore(countPage);
			}
			else {
				// 페이지 수 카운트, 버튼 보이기 숨기기 컨트롤
				countPage++;
				controlBtnShowmore(countPage);				
			}						
			// listProduct : ProductDisplayFile 객체를 요소로 하는 배열
			var resultHTML = "";
			listProduct.forEach(function(objValue) {
				var resultTemplate = templateTabContent.replace("{saveFileName}", objValue["saveFileName"])
									 				   .replace("{description}", objValue["description"])
									 				   .replace("{placeName}", objValue["placeName"])
									 				   .replace("{content}", objValue["content"]);
				resultHTML += resultTemplate;
			});
			tabContentContainer.insertAdjacentHTML("beforeend", resultHTML);		
		}

		// 탭마다 더보기 버튼 얻어오기
		function btnTemplate(listPageStartIndex, clickedMenu) {
			// 초기화
			var btnContainer = document.querySelector("#btn-container");
			btnContainer.innerHTML = "";
			// 카테고리별 페이지수에 맞추어 더보기 버튼 생성
			var resultHTML = "";
			listPageStartIndex.forEach(function(index) {
				if (index !== 0) {
					var resultTemplate = templateBtn.replace("{pageStartIndex}", index)
													.replace("{clickedMenu}", clickedMenu);
					resultHTML += resultTemplate;						
				}
			});				
			btnContainer.insertAdjacentHTML("beforeend", resultHTML);				
		}		
		
		function getCount(count) {
			var countResult = document.querySelector("#count-result");
			countResult.innerText = count + "개";
		}

		// 카테고리 ajax 보류 .. (카테고리를 꼭 비동기 처리해야 할까 ..?)
		function getCategories(listCategory) {
			// 카테고리 초기화
			document.querySelector("#tab-menu").innerHTML = "<div class='categories'>전체리스트</div>";
			
			// 카테고리 template
			const templateCategories = document.querySelector("#template-categories").innerHTML;
			var resultHTML = "";
			listCategory.forEach(function(ObjValue, index) {
				var resultTemplate = templateCategories.replace("{categoryName}", ObjValue["name"]);
				resultHTML += resultTemplate;
			});
			document.querySelector("#tab-menu").insertAdjacentHTML("beforeend", resultHTML);		
		}
		
	</script>
</body>
</html>