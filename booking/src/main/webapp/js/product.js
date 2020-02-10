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
		// getParams.js 에 의존
		window.addEventListener("DOMContentLoaded", sendAjaxDefault(id, displayInfoId));
		
		// 슬라이드 버튼이 있을 때만
		var btnSlideImgs = document.querySelector("#btn-slideImgs");
		if (btnSlideImgs.style.display !== "none") {
			btnSlideImgs.addEventListener("click", function(evt) {
				slideImgs(evt.target.getAttribute("id"));
			});
		}
		
		function slideImgs(clickedDirection) {
			// 페이지수 제어
			var currentCount = document.querySelector("#current-count");
			var current = parseInt(currentCount.innerText);
			// 슬라이드 이미지 제어
			var background = document.querySelector("#background");
			var pre = parseInt(background.style.left);
			if (clickedDirection === "btn-left") {
				background.style.left = (pre + 600) + "px";
				currentCount.innerText = (current - 1) + "";
			}
			else {
				background.style.left = (pre - 600) + "px";
				currentCount.innerText = (current + 1) + "";
			}			
		}
				
		// 상세정보/오시는길 tab ui
		const displayinfoNav = document.querySelector("#displayinfo-nav");
		displayinfoNav.addEventListener("click", function(evt) {
			sendAjaxDisplayInfo(id, displayInfoId, evt.target.innerText);
			makeTabColored(evt.target.innerText);
		});
		
		function sendAjaxDisplayInfo(id, displayInfoId, clickedTab) {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				sendJsonDisplayInfo(jsonObj, clickedTab);
			});
			// RestController 메소드를 별도로 만들어줘야 하나 ? 쓸데없이 전송되는 데이터들이 있는데 ..
			oReq.open("GET", "./json/product?id=" + id + "&displayInfoId=" + displayInfoId);
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
		
		// 초기화 ajax
		function sendAjaxDefault(id, displayInfoId) {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				sendJsonDefault(jsonObj);
			});
			oReq.open("GET", "./json/product?id=" + id + "&displayInfoId=" + displayInfoId);
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
			setPageSlideImgs(listImage.length);			
			setBackgroundWidth(listImage.length);
			// 이미지 넣기
			var bindTemplate = Handlebars.compile(templateImgs);
			var background = document.querySelector("#background");
						
			var resultHTML = "";
			listImage.forEach(function(obj) {
				var resultTpl = bindTemplate(obj);
				resultHTML += resultTpl;
			});
			background.innerHTML = resultHTML;			
		}
		
		function setPageSlideImgs(length) {
			const btnSlideImgs = document.querySelector("#btn-slideImgs");
			if (length < 2) {
				btnSlideImgs.style.display = "none";
			}
			const totalCount = document.querySelector("#total-count");
			totalCount.innerText = length + "";
		}
		
		function setBackgroundWidth(length) {
			var background = document.querySelector("#background");
			background.style.minWidth = (length * 600) + "px";
			// 이미지 너비에 딱 맞게 설정하는 깔끔한 방법 ?
			// css 로 할 수 있는 방법 ... ?
		}
		
		function getTitleTempl(product) {
			// btn-slideImgs
			var bindTemplate = Handlebars.compile(templateTitle);
			var resultHTML = bindTemplate(product);
			var title = document.querySelector("#title");
			title.insertAdjacentHTML("beforeend", resultHTML);		
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
			if (value === "펼쳐보기 ∨") {
				// overflow hidden 내용이 있을 때에만
				contentContainer.style.height = "auto";
				if (contentContainer.offsetHeight < 80) {
					contentContainer.style.height = "80px";
				}
				btnUnfold.value = "접기 ∧";
			}
			else {
				contentContainer.style.height = "80px";
				btnUnfold.value = "펼쳐보기 ∨";
			}
		}

// 		const btnComment = document.querySelector("#btn-comment");
// 		btnComment.addEventListener("click", function() {			
// 		});
