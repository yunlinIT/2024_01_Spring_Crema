package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.example.demo.service.CafeService;
import com.example.demo.vo.Cafe;

@Controller 
public class UsrHomeController {
    
    @Autowired // CafeService 객체 주입
    private CafeService cafeService;

    @RequestMapping("/usr/home/main") // URL "/usr/home/main" 요청을 이 메서드에 매핑
    public String showMain(Model model) {
        
        // 최신 카페, 인기 카페, 추천 카페 정보를 가져옴
        Cafe getNewestCafe = cafeService.getNewestCafe();
        Cafe getPopularCafe = cafeService.getPopularCafe();
        Cafe getRecommendedCafe = cafeService.getRecommendedCafe();

        // 모델에 카페 정보를 속성으로 추가
        model.addAttribute("getNewestCafe", getNewestCafe);
        model.addAttribute("getPopularCafe", getPopularCafe);
        model.addAttribute("getRecommendedCafe", getRecommendedCafe);
        
        // "usr/home/main" 뷰를 반환
        return "/usr/home/main";
    }

    @RequestMapping("/") // 루트 URL 요청을 이 메서드에 매핑
    public String showRoot(Model model) {
        
        // 최신 카페, 인기 카페, 추천 카페 정보를 가져옴
        Cafe getNewestCafe = cafeService.getNewestCafe();
        Cafe getPopularCafe = cafeService.getPopularCafe();
        Cafe getRecommendedCafe = cafeService.getRecommendedCafe();

        // 모델에 카페 정보를 속성으로 추가
        model.addAttribute("getNewestCafe", getNewestCafe);
        model.addAttribute("getPopularCafe", getPopularCafe);
        model.addAttribute("getRecommendedCafe", getRecommendedCafe);
        
        // "/usr/home/main" URL로 리다이렉트
        return "redirect:/usr/home/main";
    }
    
    // 윤린에게 이메일 쓰기 페이지 요청 처리
    @RequestMapping("/usr/home/writeEmailToYunlin")
    public String writeEmailToYunlin() {
        // "usr/home/writeEmailToYunlin" 뷰로 이동
        return "/usr/home/writeEmailToYunlin";
    }
}
