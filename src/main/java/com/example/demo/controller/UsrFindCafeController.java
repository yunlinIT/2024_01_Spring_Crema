package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.crawling.WebCrawler13;
import com.example.demo.service.CafeService;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.Cafe;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;



@Controller
public class UsrFindCafeController {
	
	@Autowired
	private CafeService cafeService;

	
	@RequestMapping("/usr/findcafe/likeList")
	public String likeList() {

		return "/usr/findcafe/likeList";
	}
	
	@RequestMapping("/usr/findcafe/cafeDetail")
	public String cafeDetail() {

		return "/usr/findcafe/cafeDetail";
	}
	
	
	@GetMapping("/crawl")
	public String crawlAndSaveData() {
		List<Cafe> cafes = WebCrawler13.crawlCafes();
		
		//System.out.println(cafes);
		
	    cafeService.saveCafeDataFromWebCrawler(cafes);
	    
	    return "/usr/home/main";
	}
	
	@RequestMapping("/usr/findcafe/searchList")
	public String showsearchList(HttpServletRequest req, Model model) {
		
		Rq rq = (Rq) req.getAttribute("rq");

		
		List<Cafe> cafes = cafeService.getForPrintCafes();


		model.addAttribute("cafes", cafes);

		return "/usr/findcafe/searchList";
	}


}