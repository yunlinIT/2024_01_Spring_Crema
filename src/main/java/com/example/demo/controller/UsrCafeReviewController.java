package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.CafeReviewService;
import com.example.demo.util.Ut;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrCafeReviewController {

	@Autowired
	private Rq rq;

	@Autowired
	private CafeReviewService cafeReviewService;

	
	@RequestMapping("/usr/cafeReview/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, int cafeId, String body) {

		Rq rq = (Rq) req.getAttribute("rq");

		
		if (Ut.isEmpty(cafeId)) {
			return Ut.jsHistoryBack("F-2", "cafeId를 입력해주세요");
		}
		if (Ut.isNullOrEmpty(body)) {
			return Ut.jsHistoryBack("F-3", "내용을 입력해주세요");
		}

		ResultData<Integer> writeCafeReviewRd = cafeReviewService.writeCafeReview(rq.getLoginedMemberId(), cafeId, body);

		int id = (int) writeCafeReviewRd.getData1();

		return Ut.jsReplace(writeCafeReviewRd.getResultCode(), writeCafeReviewRd.getMsg(), "../findcafe/cafeDetail?id=" + cafeId);

	}

//	@RequestMapping("/usr/reply/doDelete")
//	@ResponseBody
//	public String doDelete(HttpServletRequest req, int id, String replaceUri) {
//		Rq rq = (Rq) req.getAttribute("rq");
//
//		CafeReview cafeReview = cafeReviewService.getCafeReview(id);
//
//		if (cafeReview == null) {
//			return Ut.jsHistoryBack("F-1", Ut.f("%d번 리뷰는 존재하지 않습니다", id));
//		}
//
//		ResultData loginedMemberCanDeleteRd = cafeReviewService.userCanDelete(rq.getLoginedMemberId(), cafeReview);
//
//		if (loginedMemberCanDeleteRd.isSuccess()) {
//			cafeReviewService.deleteCafeReview(id);
//		}
//
////		if (Ut.isNullOrEmpty(replaceUri)) {
////			switch (reply.getRelTypeCode()) {
////			case "article":
////				replaceUri = Ut.f("../article/detail?id=%d", reply.getRelId());
////				break;
////			}
////		}
//
//		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(), replaceUri);
//	}
//
//	@RequestMapping("/usr/reply/doModify")
//	@ResponseBody
//	public String doModify(HttpServletRequest req, int id, String body) {
//		System.err.println(id);
//		System.err.println(body);
//		Rq rq = (Rq) req.getAttribute("rq");
//
//		Reply reply = replyService.getReply(id);
//
//		if (reply == null) {
//			return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
//		}
//
//		ResultData loginedMemberCanModifyRd = replyService.userCanModify(rq.getLoginedMemberId(), reply);
//
//		if (loginedMemberCanModifyRd.isSuccess()) {
//			replyService.modifyReply(id, body);
//		}
//
//		reply = replyService.getReply(id);
//
//		return reply.getBody();
//	}

}