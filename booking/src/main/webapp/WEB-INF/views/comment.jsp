<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/frame.css?ver=1" />
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
	
	#comment-container {
		background: white;
		margin-top: 10px;
		padding: 0px 20px;
	}
	
	h3 {
		margin: 0;
		height: 50px;
		line-height: 50px;
	}

	#comment-summary {
		display: flex;
		height: 50px;
		color: grey;
	}
	
	#comment-summary > div {
		line-height: 50px;
		letter-spacing: 1px;
	}
	
	#comment-summary > div:nth-child(1) {
		flex-grow: 8;
	}

	#comment-summary > div:nth-child(2) {
		flex-grow: 1;
		text-align: right;
	}
	
	.star {
		font-size: 20px;
	}
	
	.comment-container {
		border-top: 1px solid #eeeeee;
		padding: 15px 0px;
	}
	
	.comment-container h4 {
		margin: 0;
	}
	
	.comment-container p {
		font-size: 15px;
	}
	
	.comment-container .comment {
		display: flex;
	}
	
	.comment-container .comment > div:nth-child(1) {
		flex-grow: 6;
	}
	.comment-container .comment > div:nth-child(1) {
		flex-grow: 1;
	}
	
	.comment-container .reservation-info {
		color: grey;
		font-size: 13px;
	}
	
	#no-comment-container {
		display: none;
		text-align: center;
		padding-top: 100px;
	}
	
	#no-comment-container > div {
		color: #4c4c4c;
	}
</style>
</head>
<body>
	<div id="viewport" data-value="${param.id}">
		<!-- 뒤로가기 -->
		<header id="lnb">
			<nav><a href="javascript:history.back();">«</a></nav>
			<div>회사이름</div>
		</header>
		
		<!-- 본문 -->
		<section id="comment-container">
		
			<h3>예매자 한줄평</h3>
			
			<article id="comment-summary">
				<div>
					<span class="star">★</span>
					<span class="star">★</span>
					<span class="star">★</span>
					<span class="star">★</span>
					<span class="star">★</span>
					<span id="score-avg" style="color:black"></span>&nbsp;/&nbsp;5.0
				</div>
				<div>
					<span id="comment-count" style="color:#5ECB6B"></span>&nbsp;등록
				</div>
			</article>
			<article id="no-comment-container">
				<div>아직 등록된 한줄평이 없습니다.</div>
			</article>
			<script type="text/template" id="template-comment">
				<article class="comment-container">
					<div class="comment">
						<div>
							<h4>{{description}}</h4>
							<p>{{comment}}</p>
						</div>
						<div>
							{{#file saveFileName}}
								{{saveFileName}}
							{{/file}}
						</div>
					</div>
					<div class="reservation-info">
						<span style='color:black; font-weight: bold;'>{{#scores score}}{{score}}{{/scores}}</span>&nbsp;&nbsp;|&nbsp;&nbsp;{{#email reservationEmail}}{{reservationEmail}}{{/email}}&nbsp;&nbsp;|&nbsp;&nbsp;{{#date reservationDate}}{{reservationDate}}{{/date}} 방문
					</div>
				</article>
			</script>
		</section>
		
	</div>
	
	<!-- handlebar library 다운로드 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.5.3/handlebars.min.js" integrity="sha256-GwjGuGudzIwyNtTEBZuBYYPDvNlSMSKEDwECr6x6H9c=" crossorigin="anonymous"></script>
	<script src="js/getParams.js"></script>
	<script>
		// Handlebars.registerHelper
		Handlebars.registerHelper("file", function(saveFileName) {
			if (saveFileName === "" || saveFileName === null || saveFileName === undefined) {
				return;
			}
			else {
				return "<img class='img' src='" + saveFileName + "' alt='no image' width='120px' />";
			}
		});
		Handlebars.registerHelper("scores", function(score) {
			return score.toFixed(1);
		});
		Handlebars.registerHelper("email", function(reservationEmail) {
				return reservationEmail.substring(0, 4) + "****";
		});
		Handlebars.registerHelper("date", function(reservationDate) {
			// timestamp -> Date
			var date = new Date(reservationDate);
			var yy = date.getFullYear();
			var mm = date.getMonth();
			var dd = date.getDate();
			return yy + "." + mm + "." + dd;
		});
		// registerHelper 끝
		
		const templateComment = document.querySelector("#template-comment").innerHTML;
		
		// getParams.js 에 의존		
// 		const id = document.querySelector("#viewport").getAttribute("data-value");
		window.addEventListener("DOMContentLoaded", sendAjax(id, displayInfoId));
		
		function sendAjax(id, displayInfoId) {
			var oReq = new XMLHttpRequest();
			oReq.addEventListener("load", function() {
				var jsonObj = JSON.parse(this.responseText);
				sendJson(jsonObj);
			});
			oReq.open("GET", "./json/comment?id=" + id + "&displayInfoId=" + displayInfoId);
			oReq.send();
		}
		
		function sendJson(jsonObj) {
			var count = jsonObj["count"];
			var avg = jsonObj["avg"];
			var listComment = jsonObj["listComment"];
			getCount(count);
			getAvg(avg);
			getComments(listComment);
		}
		
		function getCount(count) {
			var commentCount = document.querySelector("#comment-count");
			commentCount.innerHTML = count + "건";
		}
		
		function getAvg(avg) {
			if (avg === null) {
				avg = 0;
			}
			// 별점 구현 일단 대충 ..
			var star = document.querySelectorAll(".star");
			for (var j = 0; j < star.length; j++) {
				if (avg <= (j + 1) && avg > j) {
					for (var i = 0; i < j; i++) {
						star[i].style.color = "orange";									
					}
				}				
			}
			var scoreAvg = document.querySelector("#score-avg");
			scoreAvg.innerHTML = avg.toFixed(1) + "";				
		}
		// ??
		function getComments(listComment) {
			if (listComment.length === 0) {
				var noCommentContainer = document.querySelector("#no-comment-container");
				noCommentContainer.style.display = "block";
				noCommentContainer.style.height = window.innerHeight + "px";				
			}
			else {
				var bindTemplate = Handlebars.compile(templateComment);
				var resultHTML = "";
				listComment.forEach(function(comment) {
					var resultTpl = bindTemplate(comment);
					resultHTML += resultTpl;
				});				
				document.querySelector("#comment-container").insertAdjacentHTML("beforeend", resultHTML);				
			}
		}
		
	</script>
</body>
</html>