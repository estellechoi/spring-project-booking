package com.youjin.booking.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.youjin.booking.dto.Category;
import com.youjin.booking.dto.ProductDisplayFile;
import com.youjin.booking.service.CategoryService;
import com.youjin.booking.service.ProductService;

// @RestController = @Controller + @ResponseBody
// @ResponseBody : 뷰 페이지를 응답하지 않고 return 값을 그대로 반환하겠다.
// jackson 라이브러리를 추가할 경우 객체를 JSON으로 변환하는 메시지 컨버터가 사용되도록 @EnableWebMvc에서 기본으로 설정되어 있습니다.
@RestController
@RequestMapping(path = "/json")
public class HomeRestController {

	@Autowired
	ProductService productService;
	@Autowired
	CategoryService categoryService;

	// ajax (탭 메뉴, 더보기 버튼)
	@GetMapping(path = "/home/{category}")
	public Map<String, Object> home(
			@RequestParam(name = "start", required = false, defaultValue = "0") int start,
			@PathVariable(name = "category") String categoryName) {
		
		List<ProductDisplayFile> listProduct = null;
		int count = 0;
		List<Category> listCategory = categoryService.getCategories();
		
		if (categoryName.equals("전체리스트")) {
			listProduct = productService.getProducts(start);		
			// 전체 상품의 수
			count = productService.getCount();
		}
		else {
			listProduct = productService.getProductsByCategory(categoryName, start);
			count = productService.getCountByCategory(categoryName);
		}
		
		// 페이지 수
		int pageCount = count / productService.LIMIT;
		if (count % productService.LIMIT > 0) {
			pageCount++;
		}

		// 페이지 수만큼 start index 를 리스트로 저장
		List<Integer> listPageStartIndex = new ArrayList<>();
		for (int i = 0; i < pageCount; i++) {
			listPageStartIndex.add(i * productService.LIMIT);
		}

		
		Map<String, Object> map = new HashMap<>();
		for (int i = 0; i<listProduct.size(); i++) {
			System.out.println(listProduct.get(i).getDescription());			
		}
		System.out.println(listPageStartIndex.size());
		System.out.println(count);
		map.put("listCategory", listCategory);
		map.put("count", count);
		map.put("listProduct", listProduct);
		map.put("listPageStartIndex", listPageStartIndex);
		return map;
		// 반환된 map 은 JSON으로 변환하는 메시지 컨버터에 의해 json 포맷 문자열로 변환
	}

}
