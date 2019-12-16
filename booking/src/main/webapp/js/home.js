/**
 * 
 */
const templateTabContent = document.getElementById("template-tabcontent").innerHTML;
const templateBtn = document.querySelector("#template-btn").innerHTML;
var countPromotion = 0;
var countPage = 1;

window.addEventListener("DOMContentLoaded", slidePromotion);
window.addEventListener("DOMContentLoaded", controlBtnShowmore(countPage));
window.addEventListener("DOMContentLoaded", sendAjax(0, '전체리스트'));

const btnTop = document.querySelector("#btn-top");
btnTop.addEventListener("click", goTop);

// 카테고리 탭 클릭
const tabMenu = document.querySelector("#tab-menu");
tabMenu.addEventListener("click", function(evt) {
	sendAjax(0, evt.target.innerText);
	makeTabColored(evt.target.innerText);
});

// 상품 상세 페이지로 이동
var tabContentContainer = document.querySelector("#tab-content-container");
tabContentContainer.addEventListener("click", function(evt) {
	locateProductPage(evt.target.closest(".tab-content").getAttribute("data-value"));
});

function locateProductPage(id) {
	location = "product?id=" + id;
}

//AJAX
function sendAjax(start, clickedMenu) {
	var oReq = new XMLHttpRequest();
	oReq.addEventListener("load", function() {
		// json 포맷 문자열 응답결과를 json 객체로 변환 (서버 Map -> json 객체)
		var jsonObj = JSON.parse(this.responseText);
		sendJson(jsonObj, start, clickedMenu);
	});
	oReq.open("GET", "./json/home/" + clickedMenu + "?start=" + start);
	oReq.send();
}

function sendJson(jsonObj, start, clickedMenu) {
	// var listCategory = jsonObj["listCategory"];
	var count = jsonObj["count"];
	var listProduct = jsonObj["listProduct"];
	var listPageStartIndex = jsonObj["listPageStartIndex"];
	
	getContentTemplate(listProduct, start);
	
	if (start === 0) {
		getCount(count);
		btnTemplate(listPageStartIndex, clickedMenu);
		// 페이지, 버튼 보이기 숨기기 초기화
		countPage = 1;
		controlBtnShowmore(countPage);
	} else {
		// 페이지 수 카운트, 버튼 보이기 숨기기 컨트롤
		countPage++;
		controlBtnShowmore(countPage);
	}
}

function getContentTemplate(listProduct, start) {
	// 왜 null ????
	var tabContentContainer = document.querySelector("#tab-content-container");
	if (start === 0) {
		tabContentContainer.innerHTML = "";
	}
	// listProduct : ProductDisplayFile 객체를 요소로 하는 배열
	var resultHTML = "";
	listProduct.forEach(function(product) {
		var resultTpl = templateTabContent.replace("{saveFileName}", product["saveFileName"])
										  .replace("{description}", product["description"])
										  .replace("{placeName}", product["placeName"])
										  .replace("{content}", product["content"])
										  .replace("{id}",product["id"]);
		resultHTML += resultTpl;
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
		var resultTemplate = templateCategories.replace("{categoryName}",
				ObjValue["name"]);
		resultHTML += resultTemplate;
	});
	document.querySelector("#tab-menu").insertAdjacentHTML("beforeend",
			resultHTML);
}



// setTimeout을 하는 순간 호출 스택에 함수가 쌓이는 게 아니라 백그라운드를 거쳐 태스크 큐로 넘어가기 때문에 호출 스택이 터지는
// 일이 발생하지 않습니다.
function slidePromotion() {
	const promotion = document.querySelector("#promotion");
	const promotionImgs = document.querySelectorAll(".promotion-img");
	setTimeout(function() {
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
	const categories = document.querySelectorAll(".categories");
	categories.forEach(function(category) {
		if (category.innerText === clickedMenu) {
			category.style.color = "#5ECB6B";
			category.style.borderBottom = "3px solid #5ECB6B";
		} else {
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

