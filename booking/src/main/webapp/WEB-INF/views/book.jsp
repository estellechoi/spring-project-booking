<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/frame.css" />
<style>
	
	a {
		text-decoration: none;
		color: #4c4c4c;	
	}
	
	#lnb {
		height: 50px;
		background: white;
		display: flex;
		position: relative;
	}
	
	#lnb > nav, #lnb > div {
		line-height: 50px;
		text-align: center;
	}
	
	#lnb > nav {
		position: absolute;
		top: 0;
		left: 0;
		width: 50px;
	}
	
	#lnb > div {
		flex-grow: 1;
	}
	
	
	/**/
	.display-info {
		padding: 20px 10px;
		background: white;
		margin-bottom: 10px;
	}
	
	.display-info h4 {
		margin: 0;
	}
	
	.display-info p {
		margin: 0;
		padding: 10px 0 20px 0;
		letter-spacing: 1px;
		font-size: 15px;
	}

	.ticket-container {
		background: white;
	}
	
	.ticket-selector-box {
		padding: 20px 20px;
		border-bottom: 1px solid #eeeeee;
	}
	.price-controller {
		width: 60%;
		float: left;
	}
	
	.price-controller div:nth-child(2) {
		margin-top: 5px;
	}
	
	.price {
		font-weight: bold;
	}
	
	.ticket-controller {
		border-collapse: collapse;
		float: right;
		display: flex;
		justify-content: center;
	}
	
	.cal {
		clear: both;
		padding: 10px 0 0 0;
/* 		border: 1px solid red; */
		height: 20px;
	}
	
	.cal > div:nth-child(1) {
		float: left;
		color: grey;
	}
	.cal > div:nth-child(2) {
		float: right;
		font-weight: bold;
	}
	
	.ticket-controller div {
		width: 40px;
		height: 40px;
		text-align: center;
		line-height: 40px;
	}
	
	.btn-minus, .qty {
		background: white;
		color: #d9d9d9;
		border: 1px solid #d9d9d9;
		border-right: none;
	}
	
	.btn-plus {
		background: #5ECB6B;
		color: white;
		border: 1px solid #5ECB6B;
	}
	
	.btn-minus, .btn-plus {
		cursor: pointer;
		font-size: 25px;
	}
	
	.reservation-form-container {
		background: white;
	}
	
	.caption {
/* 		height: 80px; */
		display: flex;
		justify-content: center;
		align-items: center;
		padding: 30px 20px 20px 20px;
		border-bottom: 1px solid #eeeeee;
	}
	
	.caption > h3 {
		width: 50%;
		margin: 0;
	}
	
	.caption > div {
		width: 50%;
		text-align: right;
		color: grey;
	}
	
	.reservation-input table {
		width: 500px;
		margin: 10px auto;
	}
	
	.reservation-input table td {
		vertical-align: center;
		color: grey;
		height: 35px;
	}
	
	.reservation-input table input {
		height: 30px;
		width: 300px;
		padding: 0 10px;
		font-size: 15px;
	}
	
	.input-alert {
		color: red;
		font-size: 15px;
		display: none;
	}
	
	#reservation-info {
		color: black;
	}
	
	.term-title {
		padding: 20px;
		display: flex;
	}
	
	.term-title h4 {
		width: 50%;
		margin: 0;
		color: grey;
	}
	.term-title div {
		width: 50%;
		text-align: right;
		text-decoration: underline;
	}
	
	.btn-fold {
		cursor: pointer;
		color: grey;
	}
	
	.term-content {
		padding: 0 20px 10px 20px;
		display: none;
	}
	
	.term-content p {
		margin: 0;
		background: #fcfcfc;
		border: 1px solid #eeeeee;
		border-left: none;
		height: 100px;
		overflow: scroll;
		color: grey;
		padding: 20px;	
	}

	.checkbox-agree {
		font-weight: bold;
		font-size: 30px;
		color: grey;
		cursor: pointer;
	}
	
	/* 데이터 제출 버튼 */
	.submit-container {
		text-align: center;
	}
	
	#btn-submit {
		width: 90%;
		height: 50px;
		margin: 10px 0;
		background: #d1d1d1;
		border: 1px solid #d3d3d3;
		color: white;
		font-size: 20px;
	}
</style>
</head>
<body>
	<div id="viewport">
		<!-- 뒤로가기 -->
		<header id="lnb">
			<nav><a href="javascript:history.back();">«</a></nav>
			<div class="description"></div>
		</header>
		
		<section class="display-container">
			<div class="display-img"></div>
			<div class="display-info">
				<h4>장소</h4>
				<p class="placeName"></p>
				<h4>관람시간</h4>
				<p class="openingHours"></p>
				<h4>요금</h4>
				<p class="priceByType">
					<script type="text/template" id="templat-price">
						{{typeName}}{{typeDetail}} {{priceComma}} 원 <br /><br />
					</script>
					20인 이상 단체 20% 할인 <br />
				</p>
			</div>	
		</section>

		<form action="book_ok" method="post">
			<section class="ticket-container">
				<!-- 타입별 티켓 수량 선택 박스 -->
				<script type="text/template" id="template-ticket">
					<div class="ticket-selector-box">
						<div class="price-controller">
							<div>{{typeName}}</div>
							<div><span class="price" data-value="{{price}}">{{priceComma}}</span> 원</div>
						</div>
						<div class="ticket-controller">
							<div class="btn-minus">-</div>
							<div class="qty">0</div>
							<div class="btn-plus">+</div>
						</div>
						<div class="cal">
							<div class="discount-info">{{priceComma}}원 ({{discountRate}}% 할인가)</div>
							<div><span class="amount">0</span> 원</div>
						</div>
					</div>
					<input type="hidden" name="productPriceId" value="{{id}}">
					<input type="hidden" name="count" value="0">
				</script>
			</section>
		
			<section class="reservation-form-container">
				<section class="reservation-input">
					<div class="caption">
						<h3>예매자 정보</h3>
						<div><span style="color:pink">*</span> 필수입력</div>
					</div>
					<table>
						<tr>
							<td>*</td>
							<td>예매자</td>
							<td class="input-column">
								<input type="text" name="reservationName" placeholder="네이버">
								<span class="input-alert name-alert">1자 이상 20자 이하의 이름을 입력해주세요.</span>
							</td>
						</tr>
						<tr>
							<td>*</td>
							<td>연락처</td>
							<td class="input-column">
								<input type="text" name="reservationTel" placeholder="휴대폰 입력 시 예매내역 문자 발송">
								<span class="input-alert tel-alert">형식이 틀렸거나 입력하지 않았어요.</span>
							</td>
						</tr>
						<tr>
							<td>*</td>
							<td>이메일</td>
							<td class="input-column">
								<input type="text" name="reservationEmail" placeholder="crong@codesquad.kr">
								<span class="input-alert email-alert">형식이 틀렸거나 입력하지 않았어요.</span>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>예매내용</td>
							<td id="reservation-info">
								<span id="reservation-date"></span>, 총&nbsp;<span id="totalQty">0</span>매
							</td>
						</tr>
					</table>				
				</section>
				
				<section class="reservation-agree">
					<div class="caption">
						<h3><span class="checkbox-agree">*</span>이용자 약관 전체동의</h3>
						<div>필수동의</div>
					</div>
					<div>
						<div class="term-title">			
							<h4>개인정보 수집 및 이용동의</h4>
							<div class="btn-fold">보기</div>
						</div>
						<div class="term-content">
							<p>내용 ...</p>
						</div>
						<div class="term-title">	
							<h4>개인정보 제3자 제공동의</h4>
							<div class="btn-fold">보기</div>
						</div>
						<div class="term-content">
							<p>내용 ...</p>
						</div>
					</div>
				</section>
			</section>
			<div class="submit-container">
				<input type="hidden" name="productId" value="${param.id}">
				<input type="hidden" name="displayInfoId" value="${param.displayInfoId}">
				<input type="hidden" name="reservationDate">
				<input type="hidden" name="termIsAgreed" value="no">
				<input id="btn-submit" type="submit" value="예약하기" disabled>
			</div>
		</form>			
	</div>
	<!-- handlebar library 다운로드 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.5.3/handlebars.min.js" integrity="sha256-GwjGuGudzIwyNtTEBZuBYYPDvNlSMSKEDwECr6x6H9c=" crossorigin="anonymous"></script>
	<script src="js/getParams.js"></script>
	<script>
		const templatePrice = document.querySelector("#templat-price").innerHTML;
		const templateTicket = document.querySelector("#template-ticket").innerHTML;
		const name = document.querySelector("[name='reservationName']");
		const tel = document.querySelector("[name='reservationTel']");
		const email = document.querySelector("[name='reservationEmail']");
		const termIsAgreed = document.querySelector("[name='termIsAgreed']");
		var checkName = false;
		var checkTel = false;
		var checkEmail = false;
		var checkTicket = false;
		const btnFoldTerms = document.querySelectorAll(".btn-fold");
		const checkboxAgree = document.querySelector(".checkbox-agree");
		// getParams.js 에 의존
		window.addEventListener("DOMContentLoaded", sendAjaxDefault(id, displayInfoId));
		// form 입력값 확인
		name.addEventListener("change", function(evt) {
			var nameValue = evt.target.value;
			var isValid = nameValue.length <= 20 && nameValue.length > 0;
			checkInputValue(evt.target, isValid);
		});
		tel.addEventListener("change", function(evt) {
			var telValue = evt.target.value;
			var isValid = (/01[01789]-\d{3,4}-\d{4}/).test(telValue);
			checkInputValue(evt.target, isValid);
		});
		email.addEventListener("change", function(evt) {
			var emailValue = evt.target.value;
			var isValid = (/\w+\.?\w+@\w+\.\w+/).test(emailValue);
			checkInputValue(evt.target, isValid);
		});
		// 약관 접기/보기
		btnFoldTerms.forEach(function(btn, i) {
			btn.addEventListener("click", function(evt) {
				showTerms(evt.target, i);
			});
		});
		// 약관 동의
		checkboxAgree.addEventListener("click", function(evt) {
			agreeTerm(evt.target);
		});
		
		function checkInputValue(target, isValid) {
			var alert = null;
			const nameAlert = document.querySelector(".name-alert");
			const telAlert = document.querySelector(".tel-alert");
			const emailAlert = document.querySelector(".email-alert");

			switch (target.getAttribute("name")) {
			case "reservationName":	checkName = isValid; alert = nameAlert; break;
			case "reservationTel" : checkTel = isValid; alert = telAlert; break;
			case "reservationEmail" : checkEmail = isValid; alert = emailAlert; break;
			default: ;
			}

			if (isValid === false) {
				target.style.display = "none";
				alert.style.display = "inline";
				// 1s 후 복귀
				setTimeout(function() {
					target.style.display = "inline";
					alert.style.display = "none";
				}, 1000);
			}
			// 예약하기 버튼 활성화
			setReservationDisabled();
		}
				
		function agreeTerm(checkBox) {
			if (termIsAgreed.value === "no") {
				termIsAgreed.value = "yes";
				checkBox.style.color = "#5ECB6B";
			} else {
				termIsAgreed.value = "no";				
				checkBox.style.color = "grey";
			}
			setReservationDisabled();
		}
		
		function setReservationDisabled() {
			var btnSubmit = document.querySelector("#btn-submit");
			if (termIsAgreed.value === "yes" && checkTicket === true && checkName === true && checkTel === true && checkEmail === true) {
				btnSubmit.style.background = "#5ECB6B";
				btnSubmit.removeAttribute("disabled");					
			} else {
				btnSubmit.style.background = "#d1d1d1";
				btnSubmit.setAttribute("disabled", true);
			}
		}
				
		function showTerms(clickedBtn, i) {
			var termContent = document.querySelectorAll(".term-content");
			if (clickedBtn.innerText === "보기") {
				clickedBtn.innerText = "접기";
				termContent[i].style.display = "block";
			}
			else if (clickedBtn.innerText === "접기") {
				clickedBtn.innerText = "보기";
				termContent[i].style.display = "none";
			}
		}
		
		// 버튼 이벤트 설정
		function setTicketBtn() {
			var btnMinus = document.querySelectorAll(".btn-minus");
			var btnPlus = document.querySelectorAll(".btn-plus");
			// sendAjaxDefault() 에 의존
			setTicketBtnEvent(btnMinus);
			setTicketBtnEvent(btnPlus);
			// 버튼 이벤트 추가
			function setTicketBtnEvent(btnArray) {
				btnArray.forEach(function(btn, i) {
					btn.addEventListener("click", function(evt) {
						getNewQty(evt.target, i);
					});
				});			
			}
		}
		
		// 티켓 수량 변경
		function getNewQty(clickedBtn, i) {
			var qtyList = document.querySelectorAll(".qty");
			var price = parseInt(document.querySelectorAll(".price")[i].getAttribute("data-value"));
			var qty = parseInt(qtyList[i].innerText);
			// 수량 변경
			if (clickedBtn.className === "btn-minus") {
				if (qty < 1) return;
				qty--;
				if (qty === 0) controlTicketBtnColor(qty, i);
			}
			else if (clickedBtn.className === "btn-plus") {
				qty++;
				if (qty === 1) controlTicketBtnColor(qty, i);
			}
			var amount = price * qty;
			var amountComma = getComma(amount);
			qtyList[i].innerText = qty + "";
			document.querySelectorAll(".amount")[i].innerText = amountComma;
			// 서버에 전송할 예약정보를 저장
			document.querySelectorAll("[name='count']")[i].value = qty + "";
			// 전체 매수
			getTotalQty(qtyList);
		}
		
		function getTotalQty(qtyList) {
			// 전체 매수
			var total = 0;
			qtyList.forEach(function(el) {
				var qty = parseInt(el.innerText);
				total += qty;
			});
			document.querySelector("#totalQty").innerText = total + "";
			
			if (total > 0) checkTicket = true;
			else checkTicket = false;
			setReservationDisabled();
		}
		
		
		
		// 버튼 스타일 제어 (비활성화 표시)
		function controlTicketBtnColor(q, i) {
			var btnMinus = document.querySelectorAll(".btn-minus")[i];
			var qty = document.querySelectorAll(".qty")[i];
			if (q !== 0) {
				btnMinus.style.borderColor = "#5ECB6B";
				btnMinus.style.color = "#5ECB6B";
				qty.style.borderColor = "#5ECB6B";
				qty.style.color = "#5ECB6B";				
			}
			else {
				btnMinus.style.borderColor = "#d9d9d9";
				btnMinus.style.color = "#d9d9d9";
				qty.style.borderColor = "#d9d9d9";
				qty.style.color = "#d9d9d9";				
			} 
		}

		function sendAjaxDefault(id, displayInfoId) {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				sendJsonDefault(jsonObj);
			});			
			oReq.open("GET", "./json/book?id=" + id + "&displayInfoId=" + displayInfoId);
			oReq.send();
		}
		
		function sendJsonDefault(jsonObj) {
			var listImage = jsonObj["listImage"];
			var displayInfo = jsonObj["displayInfo"];
			var listPrice = jsonObj["listPrice"];
			var reservationDate = jsonObj["reservationDate"];
			// 객체 배열 반환
			var priceMap = getPriceObject(listPrice); 
			getImage(listImage);
			getDisplayInfo(displayInfo);
			getPriceByType(priceMap);
			getTicketTempl(priceMap);
			getReservationDate(reservationDate);
		}
		
		// 가격 객체 배열을 반환하는 함수 
		function getPriceObject(listPrice) {
			var priceMap = listPrice.map(function(obj) {
				
				var priceObj = {};
				var typeName = null;
				var typeDetail = null;
				
				switch(obj.priceTypeName) {
				case "A": typeName = "성인"; typeDetail = "(만 19-64세)"; break;
				case "Y": typeName = "청소년"; typeDetail = "(만 13-18세)"; break;
				case "B": typeName = "어린이"; typeDetail = "(만 4-12세)"; break;
				case "R": typeName = "일반"; typeDetail = "(만 19-64세)"; break;
				case "D": typeName = "할인"; typeDetail = "(만 18세 이하, 65세 이상)"; break;
				default: typeName = "일반"; typeDetail = "";
				}
				
				// 객체 요소 추가
				priceObj.id = obj.id;
				priceObj.typeName = typeName;
				priceObj.typeDetail = typeDetail;
				priceObj.price = obj.price;
				priceObj.priceComma = getComma(obj.price);
				priceObj.discountRate = obj.discountRate;
				return priceObj;
			});			
			return priceMap;
		}
		
		function getComma(price) {
			// * 금액 표시 정규표현식
			// \B : 문자 경계
			// \B(?=(\d{3})) : 세자리 \d 가 뒤따르는 문자 경계
			// \B(?=(\d{3})+) : 세자리 \d 가 (1회 이상 반복) 뒤따르는 문자 경계
			// \B(?=(\d{3})+(?!\d)) : \d 가 뒤따르지 않는 세자리 \d (1회 이상 반복)				
			var regEx = /\B(?=(\d{3})+(?!\d))/g;
			var priceComma = price.toString().replace(regEx, ",");
			return priceComma;
		}
		
		function getImage(listImage) {
			var imgHTML = "<img src='" + listImage[0].saveFileName + "' alt='no image' width='100%'>";
			document.querySelector(".display-img").innerHTML = imgHTML;
		}
		
		function getDisplayInfo(displayInfo) {
			document.querySelector(".description").innerText = displayInfo.description;
			document.querySelector(".placeName").innerText = displayInfo.placeName;
			document.querySelector(".openingHours").innerText = displayInfo.openingHours;		
		}
				
		function getPriceByType(priceMap) {
			var bindTemplate = Handlebars.compile(templatePrice);
			var resultHTML = "";
			priceMap.forEach(function(obj) {
				var resultTpl = bindTemplate(obj);
				resultHTML += resultTpl;
			});
			document.querySelector(".priceByType").insertAdjacentHTML("afterbegin", resultHTML);
		}
		
		function getTicketTempl(priceMap) {
			var bindTemplate = Handlebars.compile(templateTicket);
			var resultHTML = "";
			priceMap.forEach(function(obj) {
				var resultTpl = bindTemplate(obj);
				resultHTML += resultTpl;
			});			
			var ticketContainer = document.querySelector(".ticket-container");
			ticketContainer.insertAdjacentHTML("afterbegin", resultHTML);
			// 템플릿 완성 후 버튼 이벤트 추가하기
			setTicketBtn();
		}
		
		// 서버에서 생성된 랜덤 날짜
		function getReservationDate(reservationDate) {
			document.querySelector("#reservation-date").innerText = reservationDate;
			// g : global 발생하는 모든 패턴 전역 검색
			// i : ignore case (대소문자 무관)
			var result = reservationDate.replace(/\./gi, "-");
			document.querySelector("[name='reservationDate']").value = result;
		}
	</script>
</body>
</html>