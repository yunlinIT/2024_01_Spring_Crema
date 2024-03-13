package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.crawling.WebCrawler13;
import com.example.demo.service.CafeService;
import com.example.demo.vo.Cafe;



@Controller
public class UsrFindCafeController {
	
	@Autowired
	private CafeService cafeService;

	@RequestMapping("/usr/findcafe/searchList")
	public String searchList() {

		return "/usr/findcafe/searchList";
	}
	
	@RequestMapping("/usr/findcafe/likeList")
	public String likeList() {

		return "/usr/findcafe/likeList";
	}
	
	@RequestMapping("/usr/findcafe/cafeDetail")
	public String cafeDetail() {

		return "/usr/findcafe/cafeDetail";
	}
	
	
	@GetMapping("/crawl")
	public void crawlAndSaveData() {
		List<Cafe> cafes = WebCrawler13.crawlCafes();
		
		//System.out.println(cafes);
		
	    cafeService.saveCafeDataFromWebCrawler(cafes);
	}



}