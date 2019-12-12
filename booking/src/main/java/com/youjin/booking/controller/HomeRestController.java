package com.youjin.booking.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.youjin.booking.dto.ProductDisplayFile;
import com.youjin.booking.service.ProductService;

// @RestController = @Controller + @ResponseBody
// @ResponseBody : 뷰 페이지를 응답하지 않고 return 값을 그대로 반환하겠다.
// jackson 라이브러리를 추가할 경우 객체를 JSON으로 변환하는 메시지 컨버터가 사용되도록 @EnableWebMvc에서 기본으로 설정되어 있습니다.
@RestController
@RequestMapping(path = "/json")
public class HomeRestController {

	@Autowired
	ProductService productService;

	@GetMapping(path = "/home")
	public Map<String, Object> home(
			@RequestParam(name = "start", required = false, defaultValue = "0") int start) {
		List<ProductDisplayFile> list = productService.getProducts(start);
		
		Map<String, Object> map = new HashMap<>();
		System.out.println(list.get(0).getDescription());
		System.out.println(list.get(1).getDescription());
		System.out.println(list.get(2).getDescription());
		System.out.println(list.get(3).getDescription());
		map.put("listProduct", list);
		return map;
		// 반환된 map 은 JSON으로 변환하는 메시지 컨버터에 의해 json 포맷 문자열로 변환
	}

}
