<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/home.css?re" />
</head>
<body>
	<div id="viewport">
		<!-- gnb : global navigation bar -->
		<%@ include file="header.jsp" %>
		
		<section id="promotion-container">
			<div id="promotion" style="left:0px">
				<script type="text/template" id="template-promotion">
					<img class="promotion-img" src="{{saveFileName}}" alt="no image" />
				</script>
			</div>
		</section>
		
		<!-- lnb : local nav bar -->
		<nav id="tab-menu">
			<div class="categories" data-value="0">전체리스트</div>
			<script type="text/template" id="template-categories">
				<div class="categories" data-value="{{id}}">{{name}}</div>
			</script>
		</nav>
		
		<section id="tab-count">
			바로 예매 가능한 행사가 &nbsp;<span id="count-result" style="color: red"></span>&nbsp; 있습니다.
		</section>
		
		<section id="tab-content-container">
			<article id="content-left"></article>
			<article id="content-right"></article>
			<script type="text/template" id="template-tabcontent">
					<div class="tab-content" id="{{id}}" data-value="{{displayInfoId}}">
						<img src="{{saveFileName}}" alt="no image" />
						<br />
						<h3>{{description}}</h3>
						<h4>{{placeName}}</h4>
						<p class="product-content">{{content}}</p>
					</div>
			</script>
		</section>
		
		<div id="btn-container">
			<script type="text/template" id="template-btn">
				<input class="btn-showmore" type="button" value="더보기" onclick="sendAjax({pageStartIndex}, '{categoryId}')"/>		
			</script>
		</div>
		<%@ include file="footer.jsp" %>
	</div>
	
	<!-- javascript -->
	<!-- handlebar library 다운로드 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.5.3/handlebars.min.js" integrity="sha256-GwjGuGudzIwyNtTEBZuBYYPDvNlSMSKEDwECr6x6H9c=" crossorigin="anonymous"></script>
	<script src="js/home.js"></script>
</body>
</html>