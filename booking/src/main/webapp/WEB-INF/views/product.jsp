<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/frame.css?ver=3" />
<link rel="stylesheet" href="css/product.css" />
</head>
<body>
	<div id="viewport">
		<!-- gnb : global navigation bar -->
		<header id="gnb">
			<div id="logo">예약</div>
			<div id="user-email">eeee@naver.com</div>
		</header>
		
		<div id="title-container">
			<div id="background" style="left: 0">
				<script type="text/template" id="template-imgs">
					<img class="backgroundImgs" src="{{saveFileName}}" alt="no image" />
				</script>
			</div>
			<div id="title">
				<div id="btn-slideImgs">
					<span id="btn-left">«</span>
					<span id="btn-right">»</span>
				</div>
				<script type="text/template" id="template-title">
					<div id="description">{{description}}</div>
				</script>
			</div>
		</div>
		
		<section id="content-container">
			<script type="text/template" id="template-content">
				<div id="content">{{content}}</div>
			</script>
		</section>
		
		<input id="btn-unfold" type="button" value="펼쳐보기 ∨" />
		
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
			<a href="comment?id=${param.id}&displayInfoId=${param.displayInfoId}">예매자 한줄평 더보기 ≫</a>
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
		
		<input id="btn-top" type="button" value="↑ TOP" />
		
		<footer>
	    	<p>네이버(주)는 통신판매의 당사자가 아니며, 상품의정보, 거래조건, 이용 및 환불 등과 관련한 의무와 책임은 각 회원에게 있습니다.</p>
	      	<p class="copyright">(주)네이버 사업자정보 </p>
	      	<span>이용약관 | </span>
	      	<span class="infoPolicy">개인정보처리방침 |</span>
	      	<span> 네이버 예약 고객센터</span>
	      	<p>ⓒ NAVER Corp.</p>
	    </footer>
		
	</div>
	<!-- handlebar library 다운로드 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.5.3/handlebars.min.js" integrity="sha256-GwjGuGudzIwyNtTEBZuBYYPDvNlSMSKEDwECr6x6H9c=" crossorigin="anonymous"></script>
	<script src="js/getParams.js"></script>
	<script src="js/frame.js"></script>
	<script src="js/product.js"></script>
</body>
</html>