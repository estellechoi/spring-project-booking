<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/frame.css?re" />
<link rel="stylesheet" href="css/home.css" />
</head>
<body>
	<div id="viewport">
		<!-- gnb : global navigation bar -->
		<header id="gnb">
			<div id="logo">예약</div>
			<div id="user-email">eeee@naver.com</div>
		</header>
		<section id="promotion-container">
			<div id="promotion" style="left:0px">
				<c:forEach items="${listPromotion}" var="promotion">
					<img class="promotion-img" src="${promotion.saveFileName}" alt="no image" />
				</c:forEach>
			</div>
		</section>
		<!-- tab ui -->
		<section id="tab-container">
			<!-- lnb : local nav bar -->
			<div id="tab-menu">
				<div class="categories">전체리스트</div>
				<c:forEach items="${listCategory}" var="category">
					<div class="categories">${category.name}</div>
				</c:forEach>
					<script type="text/template" id="template-categories">
						<div class="categories">{categoryName}</div>
					</script>
			</div>
			<div id="tab-count">
				바로 예매 가능한 행사가 &nbsp;<span id="count-result" style="color: red">${count}개</span>&nbsp; 있습니다.
			</div>
			<section id="tab-content-container">
				<script type="text/template" id="template-tabcontent">
					<div class="tab-content" data-value="{id}">
						<img src="{saveFileName}" alt="no image" />
						<br />
						<h3>{description}</h3>
						<h4>{placeName}</h4>
						<p class="product-content">{content}</p>
					</div>
				</script>
			</section>
		</section>
		
		<div id="btn-container">
			<script type="text/template" id="template-btn">
				<input class="btn-showmore" type="button" value="더보기" onclick="sendAjax({pageStartIndex}, '{clickedMenu}')"/>		
			</script>
		</div>
		
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
	
	<!-- javascript -->
	<script src="js/home.js"></script>
</body>
</html>