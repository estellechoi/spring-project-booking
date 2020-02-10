<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/frame.css">
<style>
	/* clip: rect(0,0,0,0); 요소의 특정 부분만 보이기 */
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
	
	#write-comment-container > div {
		text-align: center;
	}
	
	#score-label {
		height: 60px;
		line-height: 60px;
	}
	
	#score-stars {
		height: 70px;
		line-height: 70px;
		font-size: 50px;
	}
	
	.scoreStar {
		color: lightgrey;
		font-weight: bold;
		cursor: pointer;
	}
	
	/* input 영역 */
	#comment-input-box {
		text-align: center;
		padding: 20px 0 0 0;
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
		opacity: 0;
		/*
		opacity is used to hide the file input instead of visibility: hidden or display: none, 
		because assistive technology interprets the latter two styles to mean the file input isn't interactive.
		*/
	}
	
	.file-box div {
		display: inline-block;
		color: grey;
	}
	
	.thumb-box {
		display: flex;
		align-items: center;
		justify-content: flex-start;
/* 		flex-wrap: wrap; */
		margin: 0 auto;
		padding: 20px 0;
		height: 150px;
		width: 93%;
	}
	
	.thumb-box > p {
		border: 1px solid #eeeeee;
		color: grey;
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.thumb-box > div {
		position: relative;
		width: 170px;
		height: 100%;
		border: 2px solid #5ECB6B;
		overflow: hidden;
		background-size: 110%;
		margin: 0 20px 0 0;
	}
	
	/* 파일 첨부 취소버튼 */	
	.thumb-box > div > .cancelFileBtn {
		position: absolute;
		top: -2px;
		left: -2px;
		display: flex;
		align-items: center;
		justify-content: center;
		width: 25px;
		height: 25px;
		border: 2px solid #5ECB6B;
		color: #5ECB6B;
		font-weight: bold;
		background: white;
		cursor: pointer;
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
			${productId}
		</div>
		<form action="write_comment_ok" method='post' name="reviewForm" enctype="multipart/form-data">	
			<section id='write-comment-container'>
				<div id='score-label'>별점과 이용경험을 남겨주세요.</div>
				<div id='score-stars'>
					<span class="scoreStar">★</span>
					<span class="scoreStar">★</span>
					<span class="scoreStar">★</span>
					<span class="scoreStar">★</span>
					<span class="scoreStar">★</span>
					<span id="score">0</span>
				</div>
				<section id="comment-input-box">
					<textarea name="comment" id="comment-box" placeholder="정말 재밌는 연극이였어요~!"></textarea>
					<div class="file-box">
						<!-- label 의 for 와 input 의 id 를 일치시킨다. -->
						<label id="label-reviewImg" for="reviewImg">
							사진 추가
							<input type="file" name="reviewImg" id="reviewImg">	
							<!-- 
							accept=".jpg, .jpeg, .png"
							accept 속성으로 지정 확장자 외 파일의 선택을 막는다 (브라우저 지원범위 좁음) 
							-->
						</label>
						<div>
							<span id="text-count-box">0</span>
							/400 (최소 5자 이상)
						</div>
					</div>
					<div class="thumb-box">
						<p>선택한 사진이 없습니다.</p>
					</div>
				</section>
			</section>

			<input type="hidden" name="productId" value="${productId}">
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
		const scoreStars = document.querySelector("#score-stars");
		scoreStars.addEventListener("click", function(evt) {
			if (evt.target.className !== "scoreStar") {
				return;
			} else {
				getScoreStars(evt.target);
			}
		});
		
		function getScoreStars(clickedStar) {
			var score = document.querySelector("#score");
			var scoreStarList = document.querySelectorAll(".scoreStar");
			scoreStarList.forEach(function(star, index) {
				if (star === clickedStar) {
					for (var i = 0; i <= index; i++) {
						scoreStarList[i].style.color = "orange";
					}
					for (var i = scoreStarList.length - 1; i > index; i--) {
						scoreStarList[i].style.color = "lightgrey";
					}
					score.innerText = (index + 1) + "";
					document.querySelector("input[name='score']").value = (index + 1) + "";
					return;
				}
			});
		}
	
		const commentBox = document.querySelector("#comment-box");
		const textCountBox = document.querySelector("#text-count-box");
		commentBox.addEventListener("keyup", function(evt) {
			checkByte(evt.target.value);
		});
		
		const reviewImg = document.querySelector("#reviewImg");
		reviewImg.addEventListener("change", function(evt) {
			updateImageDisplay(evt.target);
		});
		
		// 첨부파일 썸네일 X 클릭으로 취소하기
		const thumbBox = document.querySelector(".thumb-box");
		thumbBox.addEventListener("click", function(evt) {
			removeFile(evt.target);
		});
		
		function removeFile(target) {
			if (target.className === "cancelFileBtn") {
				target.closest(".thumbImg").remove();
				if (!document.querySelector(".thumbImg")) {
					// 이 방법은 text value 만 초기화하는듯 ? 그리고 IE 브라우저 지원이 안된다고 함
					reviewImg.value = null;
					setThumbBoxDefault();
				}
			}
		}
		
		function setThumbBoxDefault() {
			var para = document.createElement("p");
			para.textContent = "선택한 사진이 없습니다.";
			thumbBox.appendChild(para);
		}		
		
		// 이미지 타입 유효성 검사 (true/false 반환)
		const validImageTypes = ['image/jpeg', 'image/png', 'image/jpg'];
		function checkImageType(imageType) {
			// forEach의 callback 함수 ? return false 가 먼저 실행된다 ....;;;
			for (var i = 0; i < validImageTypes.length; i++) {
				if (validImageTypes[i] === imageType) {
					return true;
				}
			}
			return false;
		}
		
		// 업로드 이미지 썸네일 노출하기
		function updateImageDisplay(target) {
			// files : 선택한 모든 파일을 나열하는 FileList 객체
			var imageList = target.files;
			// 상자 비우기 (child node가 없어질 때까지 모두 제거하는 작업)
			while (thumbBox.firstChild) {
				thumbBox.removeChild(thumbBox.firstChild);
			}
			
			if (imageList.length === 0) {
				setThumbBoxDefault();
			} else {
				for (var i = 0; i < imageList.length; i++) {
					if(!checkImageType(imageList[i].type)) {
						alert("jpeg, jpg, png 파일만 업로드할 수 있어요.");
						thumbBox.innerHTML = "";
						setThumbBoxDefault();
						// input file 초기화
						// HTMLInputElement.select() method selects all the text in a <textarea> element or in an <input> element that includes a text field.
						// document.querySelector("#reviewImg").select();
						// document.selection.clear();
						
						// 파일 업로드 전의 input file 노드를 복제	(이 방법 실패)			
						// document.querySelector("#label-reviewImg").replaceChild(target, reviewImg.cloneNode(true));
						// 이 방법은 text value 만 초기화하는듯 ? 그리고 IE 브라우저 지원이 안된다고 함
						reviewImg.value = null;
						break;
					}
					var imageBox = document.createElement("div");
					imageBox.className = "thumbImg";
		 			// URL 객체의 createObjectURL 메소드를 이용하여 객체의 url을 생성
		 			// <img> 태그의 src 속성에 File 객체의 url 값을 할당한다.
					imageBox.style.backgroundImage = "url(" + window.URL.createObjectURL(imageList[i]) + ")";
		 			var cancelFileBtn = document.createElement("div");
		 			cancelFileBtn.className = "cancelFileBtn";
		 			cancelFileBtn.innerText = "𝗫";
		 			imageBox.appendChild(cancelFileBtn);
					thumbBox.appendChild(imageBox);
				}
			}			
 		}
				
		// 5자 미만 입력시 제출 제한
		const reviewForm = document.reviewForm;
		reviewForm.addEventListener("submit", function(evt) {
			var textLength = document.querySelector("#text-count-box").innerText;
			if (textLength < 5) {
				evt.preventDefault();
				alert("리뷰를 5자 이상 입력하세요.");
			} else if (!document.querySelector("input[name='score']")) {
				evt.preventDefault();
				alert("점수를 선택하세요.");		
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