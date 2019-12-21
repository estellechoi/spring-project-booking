const btnTop = document.querySelector("#btn-top");
btnTop.addEventListener("click", goTop);

//scrollTop = 0 으로 위로 돌아가기
function goTop() {
	document.documentElement.scrollTop = 0;
}

