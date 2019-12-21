/**
 * 
 */


const url = window.location.search; // url 에서 ? 부분부터 문자열 반환
const paramsObj = getParamsFromUrl(url);
const id = paramsObj["id"];
const displayInfoId = paramsObj["displayInfoId"];

// url 에서 parameter name, value 로 구성된 객체 반환하기
function getParamsFromUrl(url) {
	var paramsObj = {};
	var paramsUrl = url.substring(1); // index 1 부터 문자열 반환
	var paramsArray = paramsUrl.split("&"); // ["id=49", "displayInfoId=1"]
	paramsArray.forEach(function(value) {
		var param = value.split("=");
		paramsObj[param[0]] = param[1];
	});
	return paramsObj;
}
