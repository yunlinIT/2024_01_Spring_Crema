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
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
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

//	@RequestMapping("/usr/findcafe/cafeDetail")
//	public String cafeDetail() {
//
//		return "/usr/findcafe/cafeDetail";
//	}

	@GetMapping("/crawl")
	public String crawlAndSaveData() {
		List<Cafe> cafes = WebCrawler13.crawlCafes();

		// System.out.println(cafes);

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

	@RequestMapping("/usr/findcafe/cafeDetail")
	public String showcafeDetail(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Cafe cafe = cafeService.getForPrintCafe(id);

//		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), "article", id);
//
//		if (usersReactionRd.isSuccess()) {
//			model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
//		}

//		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "article", id);
//
//		int repliesCount = replies.size();

		model.addAttribute("cafe", cafe);
//		model.addAttribute("replies", replies);
//		model.addAttribute("repliesCount", repliesCount);
//		model.addAttribute("isAlreadyAddGoodRp",
//				reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id, "article"));
//		model.addAttribute("isAlreadyAddBadRp",
//				reactionPointService.isAlreadyAddBadRp(rq.getLoginedMemberId(), id, "article"));

		return "usr/findcafe/cafeDetail";

	}
}