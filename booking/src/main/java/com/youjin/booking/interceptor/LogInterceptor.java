package com.youjin.booking.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LogInterceptor extends HandlerInterceptorAdapter {
	
	// slf4j 라이브러리에서 제공하는 Logger 객체 생성 (메소드로 로그 작성)
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	// Controller 실행 전 실행
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("Controller 실행 전");
		// 요청받은 시간 구하기 (현재 시간)
		long currentTime = System.currentTimeMillis();
		request.setAttribute("requestTime", currentTime);
				
		// info(); 진행상황 같은 일반 정보
		logger.info("요청 URL : {} / 시간 : {} / 클라이언트 IP : {}", request.getRequestURL(), request.getAttribute("requestTime"), request.getRemoteAddr());

		return true;
	}

	// Controller 실행 후 실행
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("Controller 실행 전");
		// 요청받은 시간 구하기 (현재 시간)
		long currentTime = System.currentTimeMillis();
		long preTime = (Long) request.getAttribute("requestTime");
		long processedTime = currentTime - preTime;
		// info(); 진행상황 같은 일반 정보
		logger.info("요청 URL : {} / 시간 : {} / 클라이언트 IP : {}", request.getRequestURL(), processedTime, request.getRemoteAddr());
		
	}
	
	
}
