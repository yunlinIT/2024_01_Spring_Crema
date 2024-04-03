package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.CafeService;
import com.example.demo.vo.Cafe;





@Controller
public class UsrHomeController {
	
	
	@Autowired
	private CafeService cafeService;


	@RequestMapping("/usr/home/main")
	public String showMain(Model model, String keyword) {
		
		Cafe getNewestCafe = cafeService.getNewestCafe();
		Cafe getPopularCafe = cafeService.getPopularCafe();
		Cafe getRecommendedCafe = cafeService.getRecommendedCafe(keyword);

		model.addAttribute("getNewestCafe", getNewestCafe);
		model.addAttribute("getPopularCafe", getPopularCafe);
		model.addAttribute("getRecommendedCafe", getRecommendedCafe);
		
		
		

		return "/usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot(Model model,  String keyword) {
		
		Cafe getNewestCafe = cafeService.getNewestCafe();
		Cafe getPopularCafe = cafeService.getPopularCafe();
		Cafe getRecommendedCafe = cafeService.getRecommendedCafe(keyword);

		model.addAttribute("getNewestCafe", getNewestCafe);
		model.addAttribute("getPopularCafe", getPopularCafe);
		model.addAttribute("getRecommendedCafe", getRecommendedCafe);
		

		return "redirect:/usr/home/main";
	}

}