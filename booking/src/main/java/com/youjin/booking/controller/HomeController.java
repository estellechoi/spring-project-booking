package com.youjin.booking.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.youjin.booking.dto.Category;
import com.youjin.booking.dto.ProductDisplayFile;
import com.youjin.booking.dto.Promotion;
import com.youjin.booking.service.CategoryService;
import com.youjin.booking.service.ProductService;
import com.youjin.booking.service.PromotionService;

@Controller
public class HomeController {

	@Autowired
	PromotionService promotionService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;

	@GetMapping(path = "/home")
	public String home(ModelMap model, @RequestParam(name = "start", required = false, defaultValue = "0") int start) {

		// 프로모션 목록
		List<Promotion> listPromotion = promotionService.getPromotions();
 		// 카테고리 목록
		List<Category> listCategory = categoryService.getCategories();
		// 전체 상품의 수
		int count = productService.getCount();
		// 전체 상품 목록
		List<ProductDisplayFile> listProduct = productService.getProducts(start);
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

		model.addAttribute("listPromotion", listPromotion);
		model.addAttribute("listCategory", listCategory);
		model.addAttribute("count", count);
		model.addAttribute("listProduct", listProduct);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("listPageStartIndex", listPageStartIndex);

		return "home";
	}
	
	@GetMapping(path = "/product")
	public String product() {
		return "product";
	}
	
	@GetMapping(path = "/comment")
	public String comment() {
		return "comment";
	}
}
