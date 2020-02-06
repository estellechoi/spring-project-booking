<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/frame.css">
<style>
	#description-bar {
		height: 50px;
		background: white;
		text-align: center;
		line-height: 50px;
		font-size: 20px;
		margin-bottom: 20px;
	}
	
	#description-bar > a {
		float: left;
 		padding-left: 10px;
 		color: black;
	}
	
	#write-comment-container {
		background: white;
	}
	
	#write-comment-container div {
		text-align: center;		
	}
	
	#score-label {
		height: 60px;
		line-height: 60px;
	}
	
	#score-stars {
		height: 70px;
		line-height: 70px;
		font-size: 23px;
		font-weight: bold;
	}
	
	/* input 영역 */
	#comment-input-box {
		text-align: center;
		padding: 20px 0;
	}
	
	#comment-box {
		width: 90%;
		height: 350px;
		font-size: 18px;
		padding: 10px;
		border: 1px solid #eeeeee;
		overflow: scroll;
		margin: 0 0 -5px 0;
	}
		
	.file-box {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 15px 10px;
		border: 1px solid #eeeeee;
		width: 90%;
		margin: 0 auto;
	}
	
	.file-box label {
		cursor: pointer;
		font-size: 20px;
		display: flex;
		align-items: center;
	}
	
	/* 파일 필드 숨기기 */
	.file-box input[type=file] {
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		border: 0;
		/* 요소의 특정 부분만 보이기 */
		clip: rect(0,0,0,0);
	}
	
	.file-box div {
		display: inline-block;
		color: grey;
	}
	
	.thumb-box {
		margin: auto;
		padding: 10px 0;
		height: 150px;
		width: 93%;
		display: flex;
		flex-direction: row;
		align-items: left;
	}
	
	.thumb-box > img {
		display: none;
		width: 170px;
		height: 140px;
		border: 1px solid #eeeeee;
		overflow: hidden;
		margin-right: 15px;
	}

	.thumb-box > img:nth-child(1) {
		display: inline-block;
	}
	
	/* 파일 첨부 취소버튼 */	
	.thumb-box > div {
		position: relative;
		border: 1px solid #5ECB6B;
		color: #5ECB6B;
		background: none;
		width: 20px;
		height: 20px;
	}
	
	#submit-box {
		padding: 10px 0;
		text-align: center;
		margin: 0 0 100px 0;
	}
	
	#submit-box input[type=submit] {
		width: 95%;
		height: 50px;
		border: 1px solid #eeeeee;
		background: #5ECB6B;
		color: white;
		font-size: 17px;
		cursor: pointer;
	}
</style>
</head>
<body>
	<div id="viewport">
		<div id="description-bar">
			<a href="javascript:history.back()">⇐</a>
			${description}
		</div>
		<form action="" method='post' name="reviewForm">		
			<section id='write-comment-container'>
				<div id='score-label'>별점과 이용경험을 남겨주세요.</div>
				<div id='score-stars'>별별별별별</div>
				<section id="comment-input-box">
					<textarea name="comment" id="comment-box" placeholder="정말 재밌는 연극이였어요~!"></textarea>
					<div class="file-box">
						<!-- label 의 for 와 input 의 id 를 일치시킨다. -->
						<label for="reviewImg">
							사진 추가
							<input type="file" multiple name="reviewImg" id="reviewImg">					
						</label>
						<div>
							<span id="text-count-box">0</span>
							/400 (최소 5자 이상)
						</div>
					</div>
					<div class="thumb-box">
<!-- 						<div>X</div> -->
						<img src="img/1_ma_2.png" alt="no image" class="thumb-img">
						<img src="" alt="no image" class="thumb-img">
						<img src="" alt="no image" class="thumb-img">
					</div>
				</section>
			</section>

			<input type="hidden" name="reservationInfoId" value="${reservationInfoId}">
			<input type="hidden" name="score">
			
			<div id="submit-box">
				<input type="submit" value="리뷰 등록">
			</div>
		</form>
		<%@ include file="footer.jsp" %>
	</div>
	
	<!-- script -->
	<script>
		const commentBox = document.querySelector("#comment-box");
		const textCountBox = document.querySelector("#text-count-box");
		commentBox.addEventListener("keyup", function(evt) {
			var text = evt.target.value;
			checkByte(text);
		});
		
		const validImageTypes = ['image/jpeg', 'image/png', 'image/jpg'];
		let countImg = 0;
		const reviewImg = document.querySelector("#reviewImg");
		reviewImg.addEventListener("change", function(evt) {
			countImg++;
			// File 객체 반환
			// FileList object
			var image = evt.target.files[countImg - 1];
			checkImageType(image);
			getThumbImage(image, countImg - 1);
		});
		
		
		// 이미지 타입 유효성 검사하기
		function checkImageType(image) {
			var isValid = validImageTypes.indexOf(image.type) > -1;
			if (!isValid) {
				alert("jpeg, jpg, png 파일만 업로드할 수 있어요.");
				// 업로드(change 이벤트) 취소하기는 어떻게 구현 ?
				return;
			}
		}
		
		// 업로드 이미지 썸네일 노출하기 
		const thumbImg = document.querySelectorAll(".thumb-img");
		function getThumbImage(image, i) {
			thumbImg[i].style.display = "inline-block";
			thumbImg[i].src = window.URL.createObjectURL(image);
 			// URL 객체의 createObjectURL 메소드를 이용하여 객체의 url을 생성
 			// <img> 태그의 src 속성에 File 객체의 url 값을 할당한다.
 		}
		
		// 5자 미만 입력시 제출 제한
		const reviewForm = document.reviewForm;
		reviewForm.addEventListener("submit", function(evt) {
			var textLength = document.querySelector("#text-count-box").innerText;
			if (textLength < 5) {
				evt.preventDefault();
				alert("리뷰를 5자 이상 입력하세요.");
			}
		});
		
		// 한글여부를 판단하고 2byte로 바꿔주기
		function checkByte(text) {
			var textLength = text.length;
			/*
				* 한글은 2바이트, 영어는 1바이트
				* escape(str)
				다음 문자를 제외하고 모두 유니코드 형식으로 인코딩한다.
				ABCDEFGHIJKLMNOPQRSTUVWXYZ
				abcdefghijklmnopqrstuvwxyz
				1234567890
				@*-_+./
				
				* 유니코드 값 
				한글, 한자 등은 '%u16진수4자리'로 표시 (2바이트)
			*/
			for (var i = 0; i < text.length; i++) {
				// charAt() : 문자열에서 특정 인덱스에 위치하는 단일문자 반환
				// charCodeAt() : 문자열에서 특정 인덱스에 위치하는 유니코드 값 반환
				var charac = escape(text.charAt(i));
				if (charac.indexOf("%u") !== -1) {
					textLength++;
				}
			}

			if (textLength > 400) {
				alert("최대 400자까지 입력할 수 있어요.");
				evt.target.value = text.substring(0, 400);
				textCountBox.innerText = "400";
			} else {
				textCountBox.innerText = textLength;	
			}			
		}
	</script>
</body>
</html>