package com.youjin.booking.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.youjin.booking.dto.Category;
import com.youjin.booking.dto.FileInfo;
import com.youjin.booking.dto.ProductDisplayFile;
import com.youjin.booking.dto.Promotion;
import com.youjin.booking.dto.ReservationInfoPrice;
import com.youjin.booking.dto.ReservationUserComment;
import com.youjin.booking.service.CategoryService;
import com.youjin.booking.service.ProductService;
import com.youjin.booking.service.PromotionService;
import com.youjin.booking.service.ReservationUserCommentService;

@Controller
public class HomeController {

	@Autowired
	PromotionService promotionService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;
	@Autowired
	ReservationUserCommentService reservationUserCommentService;

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
	
	@GetMapping(path = "/book")
	public String book() {
		return "book";
	}
	
	@PostMapping(path = "/book_ok")
	public String bookOk(ReservationUserComment reservationUserComment, HttpServletRequest request) {
		// 예약 정보
		int id = reservationUserCommentService.setReservationInfo(reservationUserComment);
		System.out.println("데이터 추가 성공, id : " + id);
		
		// 1 건의 reservation_info 데이터에 대해 다수의 reservation_info_price 데이터 존재 가능
		// 타입별 예약 가격, 수량 정보
		// request 말고 다른 방법을 생각해보자.
		int reservationInfoId = id;
		String productPriceIdStr[] = request.getParameterValues("productPriceId"); // ?????
		String countStr[] = request.getParameterValues("count");
		for (int i = 0; i < productPriceIdStr.length; i++) {
			int count = Integer.parseInt(countStr[i]);
			if (count != 0) {
				int productPriceId = Integer.parseInt(productPriceIdStr[i]);
				System.out.println(reservationInfoId + " / " + productPriceId + " / " + count);
				// 여기부터는 임시코드 
				ReservationInfoPrice reservationInfoPrice = new ReservationInfoPrice();
				reservationInfoPrice.setReservationInfoId(reservationInfoId);
				reservationInfoPrice.setProductPriceId(productPriceId);
				reservationInfoPrice.setCount(count);
				int result = reservationUserCommentService.setReservationPrice(reservationInfoPrice);
			}
		}
		// redirect 로 보내는 것과 뭐가 다르지 여기서 ??
		return "home";
	}
	
	@GetMapping(path = "/signin")
	public String signin() {
		return "signin";
	}
	
	@RequestMapping(path = "/my_reservation", method = {RequestMethod.POST, RequestMethod.GET})
	public String myReservation(@RequestParam(name = "reservationEmail", required = false) String reservationEmail,
							HttpSession session) {	
		// 세션 생성
		if (session.getAttribute("reservationEmail") == null) {
			session.setAttribute("reservationEmail", reservationEmail);
			System.out.println("세션 생성 : " + session.getAttribute("reservationEmail"));			
		}

		return "myReservation";
	}
	
	@GetMapping(path = "/cancel_reservation")
	public String cancelReservation(@RequestParam(name = "reservationInfoId") Integer reservationInfoId) {		
		System.out.println("cancel_reservation 호출");
		int cancel = reservationUserCommentService.updateCancelFlag(reservationInfoId);
		return "redirect:my_reservation";
	}
	
	@GetMapping(path = "/write_comment")
	public String writeComment(@RequestParam(name = "reservationInfoId") Integer reservationInfoId,
							@RequestParam(name = "productId") Integer productId,
							ModelMap map) {
		System.out.println(productId);
		map.put("productId", productId);
		map.put("reservationInfoId", reservationInfoId);
		
		return "writeComment";
	}
	
	@PostMapping(path = "/write_comment_ok")
	public String writeCommentOk(ReservationUserComment reservationUserComment,
								@RequestParam(name = "reviewImg") MultipartFile file) {
		// MultipartFile 여러개이면 인자는 배열 변수 : MultipartFile[]
		System.out.println(reservationUserComment.getComment());
		
		// 파일을 서버에 저장하기
		String saveFileName = "/Users/youjin/tmp/" + file.getOriginalFilename();
		try (FileOutputStream fos = new FileOutputStream(saveFileName);
			 InputStream is = file.getInputStream();) {
			
			int countByte = 0;
			byte[] buffer = new byte[1024];
			// InputStream 저장된 내용을 한 바이트씩 읽어서 buffer 변수에 저장
			while((countByte = is.read(buffer)) != -1) {
				// FileOutputStream.write(array, startIndex, endIndex);
				// buffer 배열 변수의 값을 index 0 ~ countByte 전까지 fos 저장경로의 파일에 출력
				fos.write(buffer, 0, countByte);
			}	
			System.out.println("파일 서버 저장 성공");
			
			
			// * 같은 파일명의 파일이 존재할 경우, 덮어쓰지 않고 이름 바꾸어 저장하는 작업 필요 !
			
			
		} catch (Exception e) {
			throw new RuntimeException("file Save Error");
		}
		
		
		// 파일 정보를 FileInfo 객체에 담기
		FileInfo fileInfo = new FileInfo();
		fileInfo.setFileName(file.getOriginalFilename());
		fileInfo.setSaveFileName(saveFileName);
		fileInfo.setContentType(file.getContentType());
		
		// 리뷰/파일 데이터 추가
		int id = reservationUserCommentService.setComment(reservationUserComment, fileInfo);
		
		return "redirect:my_reservation";
	}
}
