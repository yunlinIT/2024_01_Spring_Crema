package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.CafeService;
import com.example.demo.vo.Cafe;





@Controller
public class UsrHomeController {
	
	
	@Autowired
	private CafeService cafeService;


//	@RequestMapping("/usr/home/main")
//	public String showMain(Model model, @RequestParam(required = false) String keyword) {
//		
//		Cafe getNewestCafe = cafeService.getNewestCafe();
//		Cafe getPopularCafe = cafeService.getPopularCafe();
//		Cafe getRecommendedCafe = cafeService.getRecommendedCafe(keyword);
//
//		model.addAttribute("getNewestCafe", getNewestCafe);
//		model.addAttribute("getPopularCafe", getPopularCafe);
//		model.addAttribute("getRecommendedCafe", getRecommendedCafe);
//		
//
//		return "/usr/home/main";
//	}
//
//	@RequestMapping("/")
//	public String showRoot(Model model,  @RequestParam(required = false) String keyword) {
//		
//		Cafe getNewestCafe = cafeService.getNewestCafe();
//		Cafe getPopularCafe = cafeService.getPopularCafe();
//		Cafe getRecommendedCafe = cafeService.getRecommendedCafe(keyword);
//
//		model.addAttribute("getNewestCafe", getNewestCafe);
//		model.addAttribute("getPopularCafe", getPopularCafe);
//		model.addAttribute("getRecommendedCafe", getRecommendedCafe);
//		
//		return "redirect:/usr/home/main";
//	}
	
	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		
		Cafe getNewestCafe = cafeService.getNewestCafe();
		Cafe getPopularCafe = cafeService.getPopularCafe();
		Cafe getRecommendedCafe = cafeService.getRecommendedCafe();

		model.addAttribute("getNewestCafe", getNewestCafe);
		model.addAttribute("getPopularCafe", getPopularCafe);
		model.addAttribute("getRecommendedCafe", getRecommendedCafe);
		

		return "/usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot(Model model) {
		
		Cafe getNewestCafe = cafeService.getNewestCafe();
		Cafe getPopularCafe = cafeService.getPopularCafe();
		Cafe getRecommendedCafe = cafeService.getRecommendedCafe();

		model.addAttribute("getNewestCafe", getNewestCafe);
		model.addAttribute("getPopularCafe", getPopularCafe);
		model.addAttribute("getRecommendedCafe", getRecommendedCafe);
		
		return "redirect:/usr/home/main";
	}
	
	// 윤린에게 이메일 쓰기 페이지 요청 처리
    @RequestMapping("/usr/home/writeEmailToYunlin")
    public String writeEmailToYunlin() {
        // 윤린에게 이메일 쓰기 페이지로 이동
        return "/usr/home/writeEmailToYunlin";
    }

}