package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.CafeScrapService;
import com.example.demo.service.CafeService;
import com.example.demo.vo.Cafe;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrCafeScrapController {

	@Autowired
	private Rq rq;

	@Autowired
	private CafeService cafeService;

	@Autowired
	private CafeScrapService cafeScrapService;
	

	@RequestMapping("/usr/findcafe/scrapList")
	public String cafeScrapList(HttpServletRequest req, Model model) {
		
		Rq rq = (Rq) req.getAttribute("rq");
		
		Integer memberId = rq.getLoginedMemberId();
		
		
		List<Cafe> cafes = cafeScrapService.getForPrintScrapCafes(memberId);
		
		model.addAttribute("cafes", cafes);

		return "/usr/findcafe/scrapList";
	}
	

	@RequestMapping("/usr/cafeScrap/doCafeScrap")
	@ResponseBody
	public ResultData doCafeScrap(int cafeId, String replaceUri) {

		ResultData usersScrapRd = cafeScrapService.usersCafeScrap(rq.getLoginedMemberId(), cafeId);

		int usersScrap = (int) usersScrapRd.getData1();

		if (usersScrap == 1) {
			ResultData rd = cafeScrapService.deleteCafeScrapCount(rq.getLoginedMemberId(), cafeId); //***
			int doScrap = cafeService.getDoScrap(cafeId);
			
			return ResultData.from("S-2", "찜 취소", "doScrap", doScrap);
		} 

		ResultData scrapRd = cafeScrapService.addCafeScrapCount(rq.getLoginedMemberId(), cafeId); //**

		if (scrapRd.isFail()) {
			return ResultData.from(scrapRd.getResultCode(), scrapRd.getMsg());
		}

		int doScrap = cafeService.getDoScrap(cafeId);
		

		return ResultData.from(scrapRd.getResultCode(), scrapRd.getMsg(), "doScrap", doScrap);
		
		
	}

	
	@RequestMapping("/usr/cafeScrap/isAlreadyCafeScrapForList")
	@ResponseBody
	public boolean isAlreadyCafeScrapForList(int cafeId) {

		boolean isAlreadyCafeScrap = cafeScrapService.getBooleanCafeScrap(rq.getLoginedMemberId(), cafeId);

		return isAlreadyCafeScrap;
	}
	

}