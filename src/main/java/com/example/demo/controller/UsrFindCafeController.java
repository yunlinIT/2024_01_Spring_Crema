package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.crawling.WebCrawler13;
import com.example.demo.repository.CafeRepository;
import com.example.demo.service.CafeReviewService;
import com.example.demo.service.CafeService;
import com.example.demo.vo.Cafe;
import com.example.demo.vo.CafeReview;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrFindCafeController {

	@Autowired
	private CafeService cafeService;

	@Autowired
	private CafeRepository cafeRepository;

	@Autowired
	private CafeReviewService cafeReviewService;

	@RequestMapping("/usr/findcafe/likeList")
	public String likeList() {

		return "/usr/findcafe/likeList";
	}

	@GetMapping("/crawl")
	public String crawlAndSaveData() {
		List<Cafe> cafes = WebCrawler13.crawlCafes();

		// System.out.println(cafes);

		cafeService.saveCafeDataFromWebCrawler(cafes);

		return "/usr/home/main";
	}

	@RequestMapping("/usr/findcafe/searchList")
	public String showsearchList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "1") int page) {

		Rq rq = (Rq) req.getAttribute("rq");

		int cafesCount = cafeService.getCafesCount();

		cafeRepository.updateReviewCount();

		// 한페이지에 글 10개씩이야
		// 글 20개 -> 2 page
		// 글 24개 -> 3 page
		int itemsInAPage = 5;

		int pagesCount = (int) Math.ceil(cafesCount / (double) itemsInAPage);

		List<Cafe> cafes = cafeService.getForPrintCafes(itemsInAPage, page);

		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("cafes", cafesCount);
		model.addAttribute("cafes", cafes);

		return "/usr/findcafe/searchList";
	}

	@RequestMapping("/usr/findcafe/cafeDetail")
	public String showcafeDetail(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Cafe cafe = cafeService.getForPrintCafe(id);

//		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), "article", id);
//
//		if (usersReactionRd.isSuccess()) {
//			model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
//		}

		List<CafeReview> cafeReviews = cafeReviewService.getForPrintCafeReviews(rq.getLoginedMemberId(), id);

		int cafeReviewsCount = cafeReviews.size();

		model.addAttribute("cafe", cafe);
		model.addAttribute("cafeReviews", cafeReviews);
		model.addAttribute("cafeReviewsCount", cafeReviewsCount);
//		model.addAttribute("isAlreadyAddGoodRp",
//				reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id, "article"));
//		model.addAttribute("isAlreadyAddBadRp",
//				reactionPointService.isAlreadyAddBadRp(rq.getLoginedMemberId(), id, "article"));

		return "usr/findcafe/cafeDetail";

	}

	
	@GetMapping("/usr/findcafe/searchKeyword")
	public String searchCafes(@RequestParam(required = false) String keyword, Model model) {
		if (keyword != null) {
			List<Cafe> cafes = cafeService.searchCafes(keyword);
			if (cafes.isEmpty()) {
//	            model.addAttribute("message", "검색 결과가 없습니다.");
				return "usr/findcafe/searchList2";
	        } else {
	            model.addAttribute("cafes", cafes);
	        }
		}
		return "/usr/findcafe/searchList";
	}

}