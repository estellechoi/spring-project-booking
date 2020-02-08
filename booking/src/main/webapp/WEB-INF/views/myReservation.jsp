<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.reservation-summary-tab {
		display: flex;
		justify-content: center;
		background: #5ECB6B;
		color: white;
		font-size: 13px;
	}
	
	.reservation-summary-tab > div {
		width: 140px;
		border-left: 1px solid lightgrey;
		text-align: center;
		display: flex;
		flex-direction: column;
		justify-content: center;
		padding: 20px 0 10px 0;
		cursor: pointer;
	}
	
	.reservation-summary-tab > div:nth-child(1) {
		border-left: none;
		color: #BCF48C;
	}
	
	.reservation-count {
		font-size: 20px;
		font-weight: bold;
		height: 30px;
		line-height: 30px;
	}
	
	#reservation-detail-container {
		padding: 10px 20px;
	}
	
	#reservation-detail-container > .reservation-tab {
		border: 1px solid #5ECB6B;
		border-bottom: none;
		background: #5ECB6B;
		color: white;
		padding: 10px 0 0 35px;
	}
	
	#reservation-detail-container > .reservation-tab-tail {
		height: 1px;
		border-bottom: none;
		border-top: 10px solid #5ECB6B;
		border-left: 10px solid transparent;
		border-right: 10px solid transparent;		
		width: 540px;
	}
	
	/* 이용완료 라벨 */
	#reservation-detail-container > #past-tab {
		background: grey;
		border: 1px solid grey;
		border-bottom: none;
	}
	
	#reservation-detail-container > #past-tab-tail {
		border-top: 10px solid grey;
	}
	
	#reservation-detail-container > .reservation-templ-head {
		width: 540px;
		height: 1px;
		border-top: none;
		border-bottom: 10px solid white;
		border-left: 10px solid transparent;
		border-right: 10px solid transparent;		
	}
	
	/**/
	.reservation-tab, .reservation-tab-tail, .reservation-templ-head {
		display: none;
	}
	
	.reservation-detail {
		margin-bottom: 20px;
	}
	
	.reservation-templ {
		background: white;
		padding: 10px;
		margin-bottom: 2px;
	}
	
	.reservation-number, .reservation-title {
		width: 90%;
		margin: 10px auto 0 auto;
	}
	.reservation-table {
		width: 90%;
		margin: 20px auto;
		padding: 10px;
		border-top: 1px solid lightgrey;
		border-bottom: 1px solid lightgrey;
	}
	
	.reservation-table th {
		color: grey;
		width: 50px;
		text-align: left;
		padding: 5px 0;
	}
	
	.reservation-amount {
		width: 90%;
		margin: auto;
		display: flex;
		justify-content: space-between;
		height: 40px;
	}
	
	.reservation-amount-number {
		color: red;
		font-weight: bold;
		letter-spacing: 1px;
	}
	
	.btn-cancel {
		border: 1px solid lightgrey;
		background: #eeeeee;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 40px;
		width: 90%;
		margin: 10px auto;
		cursor: pointer;
	}
	
	/* 예매취소 확인 레이어 */
	#layer-cancel {
		position: fixed;
		top: 300px;
		left: 350px;
		width: 300px;
		height: 100px;
		background: white;
		border: 5px solid darkgrey;
		text-align: center;
		font-size: 15px;
		display: none;
	}
	
	#layer-cancel > a {
		color: black;
		font-weight: bold;
		text-decoration: underline;
		padding: 5px 10px;
	}
	
	#layer-cancel > div {
		text-align: right;
		padding: 10px 10px 0 0;
	}
	#layer-cancel > div > a {
		font-weight: bold;
		color: black;
	}
</style>
</head>
<body>
	<div id="viewport">
		<!-- gnb : global navigation bar -->
		<%@ include file="header.jsp" %>
		
		<!-- tab-ui -->
		<nav class="reservation-summary-tab">
			<div class='summary-tabs' id='all-tab'>
				전체
				<div class="reservation-count count-all">0</div>
			</div>
			<div class='summary-tabs' id='coming-tab'>
				이용예정
				<div class="reservation-count count-coming">0</div>
			</div>
			<div class='summary-tabs' id='past-tab'>
				이용완료
				<div class="reservation-count count-past">0</div>
			</div>
			<div class='summary-tabs' id='cancel-tab'>
				취소﹒환불
				<div class="reservation-count count-cancel">0</div>
			</div>
		</nav>
		
		<!-- 예약 내역 상세 -->
		<section id='reservation-detail-container'>
			<div class='reservation-tab coming'>예약 확정</div>
			<div class='reservation-tab-tail coming'></div>
			<!-- 내역 -->
			<div class='reservation-templ-head coming'></div>
			<section class='reservation-detail reservation-confirmed coming'>
			<script type='text/template' id='template-reservation'>
				<article class='reservation-templ'>
					<h5 class='reservation-number'>No. 0000000</h5>
					<h3 class='reservation-title'>{{description}}</h2>
					<table class='reservation-table'>
						<tr>
							<th>일정</th>
							<td>
								{{#day reservationDate}}
									{{reservationDate}}
								{{/day}}
							</td>
						</tr>
						<tr>
							<th>내역</th>
							<td>
								{{#each reservationInfoPrice}}
									{{priceTypeName}}&nbsp;{{count}}개&nbsp;/
								{{/each}}
							</td>
						</tr>
						<tr>
							<th>장소</th>
							<td>{{placeName}}</td>
						</tr>
					</table>
					<div class='reservation-amount'>
						<div>결제 예정 금액</div>
						<div class='reservation-amount-number'>{{#prices reservationInfoPrice}}{{reservationInfoPrice}}{{/prices}} 원</div>
					</div>
					{{#ifCancel cancelFlag}}
					{{else}}
						<div class='btn-cancel' data-value='{{reservationInfoId}}' id='{{productId}}'>
							{{#cancel reservationDate}}
								{{reservationDate}}
							{{/cancel}}
						</div>
					{{/ifCancel}}
				</article>
			</script>
			</section>
			
			
			<!-- 이용완료 내역 -->
			<div class='reservation-tab past' id='past-tab'>이용 완료</div>
			<div class='reservation-tab-tail past' id= 'past-tab-tail'></div>
			<!--  내역 -->
			<div class='reservation-templ-head past'></div>
			<section class='reservation-detail reservation-past past'>
				<!-- template 삽입 -->		
			</section>
			
			
			<!-- 취소한 예약 내역 -->
			<div class='reservation-tab	cancel' id='past-tab'>취소된 예약</div>
			<div class='reservation-tab-tail cancel' id= 'past-tab-tail'></div>
			<!--  내역 -->
			<div class='reservation-templ-head cancel'></div>
			<section class='reservation-detail reservation-cancel cancel'>
				<!-- template 삽입 -->
			</section>
			
		</section>
		
		<!-- 취소여부 확인 알림창 레이어 -->
		<div id='layer-cancel'>
			<div>
				<a id='close-layer' href="javascript:closeLayerCacel()">X</a>
			</div>
			정말 취소할까요 ? <br><br>
			<a href="javascript:cancelReservation()">네, 취소합니다.</a>
		</div>
	</div>
	
	<!-- javascript -->
	<!-- handlebar library 다운로드 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.5.3/handlebars.min.js" integrity="sha256-GwjGuGudzIwyNtTEBZuBYYPDvNlSMSKEDwECr6x6H9c=" crossorigin="anonymous"></script>
	<script>
		// HTML Template 에서 Helper 등록하여 사용하기 
		Handlebars.registerHelper('cancel', function(reservationDate) {
			var result = getIfPast(reservationDate);
			if (result === true) {
				return '취소';
			} else {
				return '예매자 리뷰 남기기';
			}
		});
		
		Handlebars.registerHelper('ifCancel', function(cancelFlag, options) {
			if (cancelFlag !== 0) {
				return options.fn(this);
			} else {
				return options.inverse(this);
			}
		});
		
		Handlebars.registerHelper('day', function(reservationDate) {
			var week = ['일', '월', '화', '수', '목', '금', '토'];
			var time = reservationDate.split(' ');
			var dayIndex = new Date(time[0]).getDay(); // 0 ~ 6
			return time[0] + ' (' + week[dayIndex] + ') ' + time[1];
		});
		
		Handlebars.registerHelper('prices', function(reservationInfoPrice) {
			var amount = 0;

			reservationInfoPrice.forEach(function(reservationPrice) {
				var price =  parseInt(reservationPrice['price']);
				var count = parseInt(reservationPrice['count']);
				amount += price * count;
			});
						
			amount = getFixedLength(amount, 9);
			return getComma(amount);
		});
		
		// 금액을 일정한 자릿수의 문자열로 변환하기
		function getFixedLength(amount, n) {
			var result = '';
			amount = amount + '';
			var lengthDiff = n - amount.length;
			for (var i = 0; i < lengthDiff; i++) {
				result += '0';
			}			
			result = result + amount;
			return result;
		}
		
		// session 이메일 값이 없다면 이 페이지에 접근이 불가하도록 설계하였음
		const reservationEmail = document.querySelector("#my-reservation").innerText;
		const templateReservation = document.querySelector('#template-reservation').innerHTML;
		window.addEventListener("DOMContentLoaded", sendAjax);

		const summaryTab = document.querySelector('.reservation-summary-tab');
		summaryTab.addEventListener('click', function(evt) {
			var clickedTab = null;
			// summary-tabs
			if (evt.target.className === 'summary-tabs') {
				clickedTab = evt.target.id;
			} else {
				clickedTab = evt.target.closest('.summary-tabs').id;
			}
			getClickedTab(clickedTab);
			colorClickedTab(clickedTab);
			
		});
		
		function colorClickedTab(clickedTabId) {
			var summaryTabs = document.querySelectorAll('.summary-tabs');
			summaryTabs.forEach(function(tab) {
				tab.style.color = 'white';
			});
			var clickedTab = document.querySelector('#' + clickedTabId);
			clickedTab.style.color = '#BCF48C';
		}
		
		function getClickedTab(clickedTab) {
			switch (clickedTab) {
			case 'all-tab': sendAjax(); break;
			case 'coming-tab': getTabsHidden(clickedTab); break;
			case 'past-tab': getTabsHidden(clickedTab); break;
			case 'cancel-tab': getTabsHidden(clickedTab); break;
			default: break;
			}
		}
		
		function getTabsHidden(clickedTab) {
			var comings = document.querySelectorAll('.coming');
			var pasts = document.querySelectorAll('.past');
			var cancels = document.querySelectorAll('.cancel');
			comings.forEach(function(el) {
				el.style.display = 'none';
			});
			pasts.forEach(function(el) {
				el.style.display = 'none';
			});
			cancels.forEach(function(el) {
				el.style.display = 'none';
			});

			var cliked = null;
			switch (clickedTab) {
// 			case 'all-tab': cliked = 'all'; break;
			case 'coming-tab': cliked = '.coming'; break;
			case 'past-tab': cliked = '.past'; break;
			case 'cancel-tab': cliked = '.cancel'; break;
			default: break;
			}
			cliked = document.querySelectorAll(cliked);			
			cliked.forEach(function(el) {
				el.style.display = 'block';
			});
		}
		
		
		
		// AJAX
		function sendAjax() {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				sendJson(jsonObj);
			});
			oReq.open("GET", "./json/my_reservation");
			oReq.send();
		}
		
		function sendJson(jsonObj) {
			var listReservation = jsonObj['listReservation'];
			getReservationTempl(listReservation);
			getReservationPastTempl(listReservation);
			addEventToBtns();
			getCancelTempl(listReservation);
		}
		
		function getCancelTempl(listReservation) {
			var bindTemplate = Handlebars.compile(templateReservation);
			var cancel = 0;
			var resultHTML = '';
			listReservation.some(function(obj) {
				// 취소여부 판단
				var cancelFlag = obj['cancelFlag'];
				if (cancelFlag === 0) {
					return false; // 반복문 continue
				}
				cancel++;
				var resultTpl = bindTemplate(obj); // template 하나씩 완성
				resultHTML += resultTpl;				
			});
			
			if (cancel > 0) {
				document.querySelector('.reservation-cancel').innerHTML = resultHTML;				
			}			
		}
				
		// 예약 상세내용 (필요정보 : 제목, 날짜, 장소, 금액)
		function getReservationTempl(listReservation) {
			var bindTemplate = Handlebars.compile(templateReservation);
			var coming = 0;
			var cancel = 0;
			var resultHTML = '';
			listReservation.some(function(obj) {
				// 취소여부 판단
				var cancelFlag = obj['cancelFlag'];
				if (cancelFlag !== 0) {
					cancel++;
					return false; // 반복문 continue
				}
				// 전시 시간 (이용예정/이용완료 판단)
				var reservationDate = obj['reservationDate'];
				if(getIfPast(reservationDate)) {
					coming++;
					var resultTpl = bindTemplate(obj); // template 하나씩 완성
					resultHTML += resultTpl;					
				}
			});
			
			// 데이터가 0이면 탭 표시하지 않기
			if (coming > 0) {
				document.querySelector('.reservation-detail').innerHTML = resultHTML;
			}
			// 예약 갯수 표시 
			getReservationCount(listReservation.length, coming, cancel);
		}
		
		// 예약 개수
		function getReservationCount(all, coming, cancel) {
			var past = all - coming - cancel;
			document.querySelector('.count-all').innerText = all;
			document.querySelector('.count-coming').innerText = coming;
			document.querySelector('.count-past').innerText = past;
			document.querySelector('.count-cancel').innerText = cancel;
			removeTab(coming, past, cancel);
		}
		
		// 데이터가 0이면 탭 표시하지 않기
		function removeTab(coming, past, cancel) {
			var comings = document.querySelectorAll('.coming');
			var pasts = document.querySelectorAll('.past');
			var cancels = document.querySelectorAll('.cancel');

			if (cancel > 0) {
				cancels.forEach(function(el) {
					el.style.display = 'block';
				});
			} else {
				cancels.forEach(function(el) {
					el.style.display = 'none';
				});
			}
			
			
			if (coming > 0) {
				comings.forEach(function(el) {
					el.style.display = 'block';
				});
			} else {
				comings.forEach(function(el) {
					el.style.display = 'none';
				});				
			}
			
			if (past > 0) {
				pasts.forEach(function(el) {
					el.style.display = 'block';
				});
			} else {
				pasts.forEach(function(el) {
					el.style.display = 'none';
				});
			}

		}
				
		function getReservationPastTempl(listReservation) {
			var bindTemplate = Handlebars.compile(templateReservation);
			var resultHTML = '';
			listReservation.some(function(obj) {
				// 취소여부 판단
				var cancelFlag = obj['cancelFlag'];
				if (cancelFlag !== 0) {
					return false; // 반복문 continue
				}
				// 전시 시간 (이용예정/이용완료 판단)
				var reservationDate = obj['reservationDate'];
				if(!getIfPast(reservationDate)) {
					var resultTpl = bindTemplate(obj); // template 하나씩 완성
					resultHTML += resultTpl;					
				}
			});
			if (resultHTML !== '') {
				document.querySelector('.reservation-past').innerHTML = resultHTML;				
			}				
		}
		
		// 템플릿 완성후 각 템플릿의 버튼에 이벤트 추가
		function addEventToBtns() {
			var btns = document.querySelectorAll('.btn-cancel');
			btns.forEach(function(btn) {
				btn.addEventListener('click', function(evt) {
					// data-value 속성에 저장된 값 가져오기
					var reservationInfoId = btn.getAttribute('data-value');
					var clickedNav = evt.target.innerText;
					// alert(clickedNav);
					if (clickedNav === '취소') {
						openLayerCacel(reservationInfoId);
					} else if (clickedNav === '예매자 리뷰 남기기') {
						// location 으로 페이지 이동
						var productId = btn.id;
						goWriteComment(reservationInfoId, productId);
					}
				});
			});
		}
		
		// 예매자 리뷰 남기기 페이지로 이동
		function goWriteComment(reservationInfoId, productId) {
			location = 'write_comment?reservationInfoId=' + reservationInfoId + '&productId=' + productId;
		}
		
		// 취소 확인 레이어 열기, 닫기
		const layerCancel = document.querySelector('#layer-cancel');
		function openLayerCacel(reservationInfoId) {
			layerCancel.style.display = 'block';
			layerCancel.setAttribute('data-value', reservationInfoId);
		}
		
		function closeLayerCacel() {
			layerCancel.style.display = 'none';
			layerCancel.removeAttribute('data-value');
		}
		
		// 예매 취소 
		function cancelReservation() {
			var reservationInfoId = layerCancel.getAttribute('data-value');
			alert(reservationInfoId);
			location = 'cancel_reservation?reservationInfoId=' + reservationInfoId;
		}
		
		// 현재날짜보다 이전 날짜이면 true 를 반환하는 함수
		function getIfPast(date) {
			var result = false;
			// 전시 시간
			date = date.replace(' ', 'T');
			var inTime = new Date(date).getTime();
			// 현재 시간
			var nowTime = new Date().getTime();
			// 하루는 86400000 밀리초
			if (inTime > nowTime) {
				result =  true;
			}			
			return result;
		}
		
		function getComma(price) {
			// * 금액 표시 정규표현식
			// \B : 문자 경계
			// \B(?=(\d{3})) : 세자리 \d 가 뒤따르는 문자 경계
			// \B(?=(\d{3})+) : 세자리 \d 가 (1회 이상 반복) 뒤따르는 문자 경계
			// \B(?=(\d{3})+(?!\d)) : \d 가 뒤따르지 않는 세자리 \d (1회 이상 반복)				
			var regEx = /\B(?=(\d{3})+(?!\d))/g;
			var priceComma = '';
			if (typeof price === 'number') {
				priceComma = price.toString().replace(regEx, ",");
			} else {
				priceComma = price.replace(regEx, ",");				
			}
			return priceComma;
		}


		
		
		/* 삽질 ..
		function getTimeStamp() {
			var today = new Date();
			var yy = leadingZeros(today.getFullYear(), 4);
			var MM = leadingZeros(today.getMonth() + 1, 2);
			var dd = leadingZeros(today.getDate(), 2);
			var HH = leadingZeros(today.getHours(), 2);
			var mm = leadingZeros(today.getMinutes(), 2);
			var ss = leadingZeros(today.getSeconds(), 2);
			
			var s = yy + '-' + MM + '-' + dd + ' ' + HH + ':' + mm + ':' + ss;
			return s;
		}
		
		function leadingZeros(number, digits) {
			var zeros = '';
			number = number.toString();
			if (number.length < digits) {
				for (var i = 0; i < digits - number.length; i++) {
					zeros += '0';
				}
			}		
			return zeros + number;
		}
		*/

	</script>	
</body>
</html>

