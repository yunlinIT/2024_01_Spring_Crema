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

@Controller // Spring의 Controller임을 명시
public class UsrCafeScrapController {

	@Autowired // 의존성 주입
	private Rq rq;

	@Autowired 
	private CafeService cafeService;

	@Autowired 
	private CafeScrapService cafeScrapService;
	

	@RequestMapping("/usr/findcafe/scrapList") // /usr/findcafe/scrapList URL로 요청이 오면 이 메서드가 처리
	public String cafeScrapList(HttpServletRequest req, Model model) {
		
		Rq rq = (Rq) req.getAttribute("rq"); // 요청에서 rq 객체를 가져옴
		
		Integer memberId = rq.getLoginedMemberId(); // 로그인된 멤버의 ID를 가져옴
		
		// 로그인된 멤버의 스크랩된 카페 목록을 가져옴
		List<Cafe> cafes = cafeScrapService.getForPrintScrapCafes(memberId);
		
		model.addAttribute("cafes", cafes); // 모델에 카페 목록 추가

		return "/usr/findcafe/scrapList"; // 뷰 페이지 반환
	}
	

	@RequestMapping("/usr/cafeScrap/doCafeScrap") // /usr/cafeScrap/doCafeScrap URL로 요청이 오면 이 메서드가 처리
	@ResponseBody // 응답을 JSON 형태로 반환
	public ResultData doCafeScrap(int cafeId, String replaceUri) {

		// 사용자가 해당 카페를 스크랩했는지 여부를 가져옴
		ResultData usersScrapRd = cafeScrapService.usersCafeScrap(rq.getLoginedMemberId(), cafeId);

		int usersScrap = (int) usersScrapRd.getData1(); // 스크랩 여부를 정수로 반환

		if (usersScrap == 1) { // 이미 스크랩된 상태라면
			// 스크랩 취소
			ResultData rd = cafeScrapService.deleteCafeScrapCount(rq.getLoginedMemberId(), cafeId); //***
			int doScrap = cafeService.getDoScrap(cafeId); // 스크랩 수를 가져옴
			
			// 스크랩 취소 메시지 반환
			return ResultData.from("S-2", "찜 취소", "doScrap", doScrap);
		} 

		// 스크랩 추가
		ResultData scrapRd = cafeScrapService.addCafeScrapCount(rq.getLoginedMemberId(), cafeId); //**

		if (scrapRd.isFail()) { // 실패 시 메시지 반환
			return ResultData.from(scrapRd.getResultCode(), scrapRd.getMsg());
		}

		int doScrap = cafeService.getDoScrap(cafeId); // 스크랩 수를 가져옴
		
		// 성공 메시지 반환
		return ResultData.from(scrapRd.getResultCode(), scrapRd.getMsg(), "doScrap", doScrap);
		
		
	}

	
	@RequestMapping("/usr/cafeScrap/isAlreadyCafeScrapForList") // /usr/cafeScrap/isAlreadyCafeScrapForList URL로 요청이 오면 이 메서드가 처리
	@ResponseBody // 응답을 JSON 형태로 반환
	public boolean isAlreadyCafeScrapForList(int cafeId) {

		// 사용자가 해당 카페를 이미 스크랩했는지 여부를 확인
		boolean isAlreadyCafeScrap = cafeScrapService.getBooleanCafeScrap(rq.getLoginedMemberId(), cafeId);

		return isAlreadyCafeScrap; // 결과 반환
	}
	

}
