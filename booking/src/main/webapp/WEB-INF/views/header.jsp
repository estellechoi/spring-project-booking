<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

	<head>
	<link rel="stylesheet" href="css/frame.css?ver=3" />
	</head>
		<header id="gnb">
			<div id="logo">예약</div>
			<div id="my-reservation">
			<c:choose>
				<c:when test="${sessionScope.reservationEmail != null}">
					${sessionScope.reservationEmail}
				</c:when>
				<c:otherwise>
					예약확인				
				</c:otherwise>
			</c:choose>
			</div>
		</header>
		
		<script>
			const logoBtn = document.querySelector("#logo");
			logoBtn.addEventListener("click", goHome);
			
			const myReservationBtn = document.querySelector("#my-reservation");
			myReservationBtn.addEventListener("click", function(evt) {
				goMyReservation(evt.target.innerText);
			});
			
			function goMyReservation(clickedLink) {
				if (clickedLink === "예약확인") {
					location = "signin";					
				} else {
					// post 로 보내야되는데 ..
					var form = document.createElement('form');
					form.setAttribute('method', 'post');
					form.setAttribute('action', 'my_reservation');
					var inputHidden = document.createElement('input');
					inputHidden.setAttribute('type', 'hidden');
					inputHidden.setAttribute('name', 'reservationEmail');
					inputHidden.setAttribute('value', clickedLink);
					form.appendChild(inputHidden);
					document.body.appendChild(form);
					form.submit();
				}
			}		
			
			function goHome() {
				location = "home";
			}
		</script>
