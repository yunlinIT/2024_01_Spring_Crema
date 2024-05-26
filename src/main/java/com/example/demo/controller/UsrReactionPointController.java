package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody; 

import com.example.demo.service.ArticleService;
import com.example.demo.service.ReactionPointService; 
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq; 

@Controller 
public class UsrReactionPointController {

	@Autowired 
	private Rq rq; // 요청 클래스 객체 주입

	@Autowired 
	private ArticleService articleService; // 게시물 서비스 객체 주입

	@Autowired 
	private ReactionPointService reactionPointService; // 반응 포인트 서비스 객체 주입

	// 좋아요 반응 처리를 담당하는 메서드
	@RequestMapping("/usr/reactionPoint/doGoodReaction") // 요청 매핑 어노테이션
	@ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정하는 어노테이션
	public ResultData doGoodReaction(String relTypeCode, int relId, String replaceUri) {

		// 사용자의 반응 상태를 가져옴
		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), relTypeCode, relId);
		int usersReaction = (int) usersReactionRd.getData1();

		if (usersReaction == 1) { // 이미 좋아요를 눌렀을 경우
			// 좋아요 반응을 취소하고 결과를 반환
			ResultData rd = reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			int goodRP = articleService.getGoodRP(relId);
			int badRP = articleService.getBadRP(relId);
			return ResultData.from("S-1", "좋아요 취소", "goodRP", goodRP, "badRP", badRP);
		} else if (usersReaction == -1) { // 싫어요를 눌렀을 경우
			// 싫어요를 취소하고 좋아요를 누름
			ResultData rd = reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			rd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			int goodRP = articleService.getGoodRP(relId);
			int badRP = articleService.getBadRP(relId);
			return ResultData.from("S-2", "싫어요 눌렀잖어", "goodRP", goodRP, "badRP", badRP);
		}

		// 좋아요 반응을 추가하고 결과를 반환
		ResultData reactionRd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
		if (reactionRd.isFail()) {
			return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
		}

		int goodRP = articleService.getGoodRP(relId);
		int badRP = articleService.getBadRP(relId);
		return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg(), "goodRP", goodRP, "badRP", badRP);
	}

	// 싫어요 반응 처리를 담당하는 메서드
	@RequestMapping("/usr/reactionPoint/doBadReaction") // 요청 매핑 어노테이션
	@ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정하는 어노테이션
	public ResultData doBadReaction(String relTypeCode, int relId, String replaceUri) {

		// 사용자의 반응 상태를 가져옴
		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), relTypeCode, relId);
		int usersReaction = (int) usersReactionRd.getData1();

		if (usersReaction == -1) { // 이미 싫어요를 눌렀을 경우
			// 싫어요 반응을 취소하고 결과를 반환
			ResultData rd = reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			int goodRP = articleService.getGoodRP(relId);
			int badRP = articleService.getBadRP(relId);
			return ResultData.from("S-1", "싫어요 취소", "goodRP", goodRP, "badRP", badRP);
		} else if (usersReaction == 1) { // 좋아요를 눌렀을 경우
			// 좋아요를 취소하고 싫어요를 누름
			ResultData rd = reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			rd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			int goodRP = articleService.getGoodRP(relId);
			int badRP = articleService.getBadRP(relId);
			return ResultData.from("S-2", "좋아요 눌렀잖어", "goodRP", goodRP, "badRP", badRP);
		}

		// 싫어요 반응을 추가하고 결과를 반환
		ResultData reactionRd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
		if (reactionRd.isFail()) {
			return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
		}

		int goodRP = articleService.getGoodRP(relId);
		int badRP = articleService.getBadRP(relId);
		return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg(), "goodRP", goodRP, "badRP", badRP);
	}
}
