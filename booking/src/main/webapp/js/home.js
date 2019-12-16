/**
 * 
 */
const templatePromotion = document.querySelector("#template-promotion").innerHTML;
const templateCategories = document.querySelector("#template-categories").innerHTML;
const templateTabContent = document.querySelector("#template-tabcontent").innerHTML;
const templateBtn = document.querySelector("#template-btn").innerHTML;
var countPromotion = 0;
var countPage = 1;
var countAjaxLoad = 0;

window.addEventListener("DOMContentLoaded", slidePromotion);
window.addEventListener("DOMContentLoaded", controlBtnShowmore(countPage));
window.addEventListener("DOMContentLoaded", sendAjax(0, '0'));

const btnTop = document.querySelector("#btn-top");
btnTop.addEventListener("click", goTop);

// 카테고리 탭 클릭
const tabMenu = document.querySelector("#tab-menu");
tabMenu.addEventListener("click", function(evt) {
	sendAjax(0, evt.target.getAttribute("data-value"));
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
function sendAjax(start, categoryId) {
	var oReq = new XMLHttpRequest();
	oReq.addEventListener("load", function() {
		// json 포맷 문자열 응답결과를 json 객체로 변환 (서버 Map -> json 객체)
		var jsonObj = JSON.parse(this.responseText);
		sendJson(jsonObj, start, categoryId);
	});
	oReq.open("GET", "./json/home/" + categoryId + "?start=" + start);
	oReq.send();
}

function sendJson(jsonObj, start, categoryId) {
	countAjaxLoad++;
	// var listCategory = jsonObj["listCategory"];
	var count = jsonObj["count"];
	var listProduct = jsonObj["listProduct"];
	var listPageStartIndex = jsonObj["listPageStartIndex"];
	var listCategory = jsonObj["listCategory"];
	var listPromotion = jsonObj["listPromotion"];
	
	if(countAjaxLoad === 1) {
		getPromotionTempl(listPromotion);
		getCategoriesTempl(listCategory);		
	}
	
	getContentTempl(listProduct, start);
	
	if (start === 0) {
		getCount(count);
		getBtnTempl(listPageStartIndex, categoryId);
		countPage = 1;
		controlBtnShowmore(countPage);
	} else {
		countPage++;
		controlBtnShowmore(countPage);
	}
}

function getPromotionTempl(listPromotion) {
	var bindTemplate = Handlebars.compile(templatePromotion);
	var resultHTML = "";
	listPromotion.forEach(function(obj) {
		var resultTpl = bindTemplate(obj);
		resultHTML += resultTpl;
	});
	document.querySelector("#promotion").innerHTML = resultHTML;
};

function getContentTempl(listProduct, start) {
	var contentLeft = document.querySelector("#content-left");
	var contentRight = document.querySelector("#content-right");
	if (start === 0) {
		contentLeft.innerHTML = "";
		contentRight.innerHTML = "";
	}
	// listProduct : ProductDisplayFile 객체를 요소로 하는 배열
	var bindTemplate = Handlebars.compile(templateTabContent);
	var resultLeft = "";
	var resultRight = "";
	listProduct.forEach(function(product, i) {
		var resultTpl = bindTemplate(product);
		if (i % 2 == 0) {
			resultLeft += resultTpl;			
		}
		else {
			resultRight += resultTpl;
		}
	});
	contentLeft.insertAdjacentHTML("beforeend", resultLeft);
	contentRight.insertAdjacentHTML("beforeend", resultRight);
}

function getCount(count) {
	var countResult = document.querySelector("#count-result");
	countResult.innerText = count + "개";
}

// 카테고리별 더보기 버튼 생성
function getBtnTempl(listPageStartIndex, categoryId) {
//	var bindTemplate = Handlebars.compile(templateBtn);
	var btnContainer = document.querySelector("#btn-container");
	btnContainer.innerHTML = "";
	// 카테고리별 페이지수에 맞추어 더보기 버튼 생성
	var resultHTML = "";
	listPageStartIndex.forEach(function(index) {
		if (index !== 0) {
			var resultTpl = templateBtn.replace("{pageStartIndex}", index)
									   .replace("{categoryId}", categoryId);
			resultHTML += resultTpl;
		}
	});
	btnContainer.insertAdjacentHTML("beforeend", resultHTML);
}

function getCategoriesTempl(listCategory) {
	var bindTemplate = Handlebars.compile(templateCategories);
	var resultHTML = "";
	listCategory.forEach(function(obj) {
		var resultTpl = bindTemplate(obj);
		resultHTML += resultTpl;
	});
	document.querySelector("#tab-menu").insertAdjacentHTML("beforeend", resultHTML);
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

