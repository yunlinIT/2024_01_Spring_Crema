package com.example.demo.interceptor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.crawling.WebCrawler13;
import com.example.demo.vo.Cafe;
import com.example.demo.vo.Rq;
import com.example.demo.service.CafeService;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class BeforeActionInterceptor implements HandlerInterceptor {
	@Autowired
	private Rq rq;
	@Autowired
	private CafeService cafeService;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

		rq.initBeforeActionInterceptor();

		return HandlerInterceptor.super.preHandle(req, resp, handler);
		
	}
	
	
	

	
}