package com.youjin.booking.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.youjin.booking.dto.Category;
import com.youjin.booking.dto.Price;
import com.youjin.booking.dto.ProductDisplayFile;
import com.youjin.booking.dto.Promotion;
import com.youjin.booking.dto.ReservationInfoPrice;
import com.youjin.booking.dto.ReservationUserComment;
import com.youjin.booking.service.CategoryService;
import com.youjin.booking.service.ProductService;
import com.youjin.booking.service.PromotionService;
import com.youjin.booking.service.ReservationUserCommentService;

// @RestController = @Controller + @ResponseBody
// @ResponseBody : 뷰 페이지를 응답하지 않고 return 값을 그대로 반환하겠다.
// jackson 라이브러리를 추가할 경우 객체를 JSON으로 변환하는 메시지 컨버터가 사용되도록 @EnableWebMvc에서 기본으로 설정되어 있습니다.
@RestController
@RequestMapping(path = "/json")
public class HomeRestController {

	@Autowired
	PromotionService promotionService;
	@Autowired
	ProductService productService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	ReservationUserCommentService reservationUserCommentService;

	// ajax (탭 메뉴, 더보기 버튼)
	@GetMapping(path = "/home/{categoryId}")
	public Map<String, Object> home(
			@RequestParam(name = "start", required = false, defaultValue = "0") int start,
			@PathVariable(name = "categoryId") int categoryId) {
		
		Map<String, Object> map = new HashMap<>();

		List<ProductDisplayFile> listProduct = null;
		int count = 0;
		
		List<Promotion> listPromotion = promotionService.getPromotions();
		List<Category> listCategory = categoryService.getCategories();
		
		if (categoryId == 0) {
			listProduct = productService.getProducts(start);		
			// 전체 상품의 수
			count = productService.getCount();
		}
		else {
			listProduct = productService.getProductsByCategory(categoryId, start);
			count = productService.getCountByCategory(categoryId);
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
		
		map.put("listPromotion", listPromotion);
		map.put("listCategory", listCategory);
		map.put("count", count);
		map.put("listProduct", listProduct);
		map.put("listPageStartIndex", listPageStartIndex);
		return map;
		// 반환된 map 은 JSON으로 변환하는 메시지 컨버터에 의해 json 포맷 문자열로 변환
	}
	
	@GetMapping(path = "/product")
	public Map<String, Object> product(@RequestParam(name ="id") int id,
										@RequestParam(name ="displayInfoId") int displayInfoId) {
		Map<String, Object> map = new HashMap<>();
		
		// 상품 객체 1개 
		ProductDisplayFile product = productService.getProductById(id);
		// 상품 객체 1개 이상 (이미지의 수에 따라)
		List<ProductDisplayFile> listImage = productService.getProductImageById(id);
		
		ProductDisplayFile displayInfo = productService.getDisplayInfoById(id, displayInfoId);
		
		map.put("product", product);
		map.put("listImage", listImage);
		map.put("displayInfo", displayInfo);
						
		return map;
	}
	
	@GetMapping(path = "/comment")
	public Map<String, Object> comment(@RequestParam(name = "id") int id,
									@RequestParam(name = "displayInfoId") int displayInfoId) {
		System.out.println(id + " " + displayInfoId);
		Map<String, Object> map = new HashMap<>();
		int count =reservationUserCommentService.getCount(id, displayInfoId);
		BigDecimal avg = reservationUserCommentService.getAvg(id, displayInfoId);
		List<ReservationUserComment> listComment = reservationUserCommentService.getComment(id, displayInfoId);
		System.out.println(listComment);
		map.put("count", count);
		map.put("avg", avg);
		map.put("listComment", listComment);
		
		return map;	
	}
	
	@GetMapping(path = "/book")
	public Map<String, Object> book(@RequestParam(name = "id") int id,
									@RequestParam(name = "displayInfoId") int displayInfoId) {
		Map<String, Object> map = new HashMap<>();
		List<Price> listPrice = productService.getPriceById(id);
		List<ProductDisplayFile> listImage = productService.getProductImageById(id);
		ProductDisplayFile displayInfo = productService.getDisplayInfoById(id, displayInfoId);
		
		// 예매일 랜덤 생성 (오늘포함해서 1-5일 랜덤값)
		int days = (int) (Math.random() * 5) + 1; // 1 ~ 5 랜덤값

		Calendar cal = Calendar.getInstance();		
		cal.add(Calendar.DAY_OF_MONTH, days); // 날짜 이동
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String reservationDate = sdf.format(cal.getTime());
		
		System.out.println(sdf.format(cal.getTime())); // 예약 날짜 
		
		map.put("listPrice", listPrice);
		map.put("listImage", listImage);
		map.put("displayInfo", displayInfo);
		map.put("reservationDate", reservationDate);
		return map;
	}
	
	@GetMapping(path = "/my_reservation")
	public Map<String, Object> myReservation(HttpSession session) {
		
		System.out.println("REST Controller 메소드 호출");
		Map<String, Object> map = new HashMap<>();
		
		// 이메일로 예약정보 조회하기
		List<ReservationUserComment> listReservation = reservationUserCommentService.getReservationInfo(session.getAttribute("reservationEmail").toString());
		
		// listReservation의 각 객체마다 타입별 수량,가격 정보 (리스트)를 주입하기 (reservationInfoId 별 조회)
		for (ReservationUserComment reservation: listReservation) {
			int reservationInfoId = reservation.getReservationInfoId();
			List<ReservationInfoPrice> listPrice = reservationUserCommentService.getReservationPrice(reservationInfoId);
			reservation.setReservationInfoPrice(listPrice);
		}
		
		map.put("listReservation", listReservation);
		
		return map;
	}
}
