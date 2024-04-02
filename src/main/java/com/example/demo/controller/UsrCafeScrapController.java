package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.CafeScrapService;
import com.example.demo.service.CafeService;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Controller
public class UsrCafeScrapController {

	@Autowired
	private Rq rq;

	@Autowired
	private CafeService cafeService;

	@Autowired
	private CafeScrapService cafeScrapService;

	@RequestMapping("/usr/cafeScrap/doCafeScrap")
	@ResponseBody
	public ResultData doCafeScrap(int cafeId, String replaceUri) {

		ResultData usersScrapRd = cafeScrapService.usersCafeScrap(rq.getLoginedMemberId(), cafeId);

		int usersScrap = (int) usersScrapRd.getData1();

		if (usersScrap == 1) {
			ResultData rd = cafeScrapService.deleteCafeScrapCount(rq.getLoginedMemberId(), cafeId);
			int doScrap = cafeService.getDoScrap(cafeId);
			
			return ResultData.from("S-1", "찜 취소", "doScrap", doScrap);
		} 

		ResultData scrapRd = cafeScrapService.addCafeScrapCount(rq.getLoginedMemberId(), cafeId);

		if (scrapRd.isFail()) {
			return ResultData.from(scrapRd.getResultCode(), scrapRd.getMsg());
		}

		int doScrap = cafeService.getDoScrap(cafeId);
		

		return ResultData.from(scrapRd.getResultCode(), scrapRd.getMsg(), "doScrap", doScrap);
		
		
	}

	
	
	
//	@RequestMapping("/usr/reactionPoint/doBadReaction")
//	@ResponseBody
//	public ResultData doBadReaction(String relTypeCode, int relId, String replaceUri) {
//
//		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), relTypeCode, relId);
//
//		int usersReaction = (int) usersReactionRd.getData1();
//
//		if (usersReaction == -1) {
//			ResultData rd = reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
//			int goodRP = articleService.getGoodRP(relId);
//			int badRP = articleService.getBadRP(relId);
//
//			return ResultData.from("S-1", "싫어요 취소", "goodRP", goodRP, "badRP", badRP);
//		} else if (usersReaction == 1) {
//			ResultData rd = reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
//			rd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
//			int goodRP = articleService.getGoodRP(relId);
//			int badRP = articleService.getBadRP(relId);
//
//			return ResultData.from("S-2", "좋아요 눌렀잖어", "goodRP", goodRP, "badRP", badRP);
//		}
//
//		ResultData reactionRd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
//
//		if (reactionRd.isFail()) {
//			return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
//		}
//
//		int goodRP = articleService.getGoodRP(relId);
//		int badRP = articleService.getBadRP(relId);
//
//		return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg(), "goodRP", goodRP, "badRP", badRP);
//	}
	
	
	

	
	
	
	
	
	
	

}