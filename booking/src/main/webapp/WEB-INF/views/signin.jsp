<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#reservation-label {
		text-align: center;
		margin: 80px auto;
		font-size: 20px;
		font-weight: bold;
	}
	
	#signin-container {
		padding: 20px;
		margin-bottom: 100px;
	}
	
	#signin-container > #signin-label {
		border-bottom: 1px solid lightgrey;
		padding: 10px 0;
		font-weight: bold;
	}
	
	#signin-container > .signin-form {
		padding: 10px 0;
		display: flex;
		flex-direction: column;
		align-self: stretch;
/* 		height: 50px; */
	}
	
	#signin-container > .signin-form > input[type=text] {
		height: 50px;
		font-size: 15px;
		padding: 0 10px;
		border: 1px solid lightgrey;
	}
	
	#signin-container > .signin-form > #btn-submit-signin {
		height: 50px;
		background: white;
		border: 1px solid #5ECB6B;
		font-size: 18px;
		color: #5ECB6B;
		cursor: pointer;
	}
</style>
</head>
<body>
	<div id="viewport">
		<!-- gnb : global navigation bar -->
		<%@ include file="header.jsp" %>
		
		<div id="reservation-label">예약</div>
		
		<form action="my_reservation" method="post" name="signinForm">
			<section id="signin-container">
				<div id="signin-label">비회원 예약확인</div>
				<div class="signin-form">
					<input type="text" name="reservationEmail" placeholder="예약자 이메일 입력">
				</div>
				<div class="signin-form">
					<input type="button" id="btn-submit-signin" value="내 예약 확인">
				</div>
			</section>
		</form>
		
		<%@ include file="footer.jsp" %>
	</div>
	<script>
		const btnSubmitSignin = document.querySelector("#btn-submit-signin");
		btnSubmitSignin.addEventListener("click", function(evt) {
			var emailValue = document.querySelector("input[name='reservationEmail']").value;
			checkEmailValue(emailValue);
		});
		
		function checkEmailValue(emailValue) {			
			var isValid = (/\w+\.?\w+@\w+\.\w+/).test(emailValue);
			if (isValid === false) {
				alert("이메일을 입력하지 않았거나 형식이 틀려요.");
			} else {
				// 수동 submit
				var signinForm = document.signinForm;
				signinForm.submit();
			}
		}
		
	</script>
</body>
</html>