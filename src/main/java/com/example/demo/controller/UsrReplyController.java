package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReactionPointService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrReplyController {

	@Autowired
	private Rq rq; // 요청 클래스 객체 주입

	@Autowired
	private ReplyService replyService; // 댓글 서비스 객체 주입

	@Autowired
	private ReactionPointService reactionPointService; // 반응 포인트 서비스 객체 주입

	@RequestMapping("/usr/reply/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, String relTypeCode, int relId, String body) {

		Rq rq = (Rq) req.getAttribute("rq"); // 요청 클래스 객체 가져오기

		// 필수 입력 항목 검사
		if (Ut.isNullOrEmpty(relTypeCode)) {
			return Ut.jsHistoryBack("F-1", "relTypeCode을 입력해주세요");
		}
		if (Ut.isEmpty(relId)) {
			return Ut.jsHistoryBack("F-2", "relId을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(body)) {
			return Ut.jsHistoryBack("F-3", "내용을 입력해주세요");
		}

		// 댓글 작성 처리 결과 반환
		ResultData<Integer> writeReplyRd = replyService.writeReply(rq.getLoginedMemberId(), relTypeCode, relId, body);
		int id = (int) writeReplyRd.getData1(); // 작성된 댓글의 ID 가져오기

		// 작성 결과에 따라 적절한 메시지 반환
		return Ut.jsReplace(writeReplyRd.getResultCode(), writeReplyRd.getMsg(), "../article/detail?id=" + relId);
	}

	// 댓글 삭제 처리를 담당하는 메서드
	@RequestMapping("/usr/reply/doDelete") // 요청 매핑 어노테이션
	@ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정하는 어노테이션
	public String doDelete(HttpServletRequest req, int id, String replaceUri) {
		Rq rq = (Rq) req.getAttribute("rq"); // 요청 클래스 객체 가져오기

		// 댓글 정보 가져오기
		Reply reply = replyService.getReply(id);

		// 댓글이 존재하지 않을 경우 메시지 반환
		if (reply == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
		}

		// 현재 로그인한 사용자가 삭제할 권한이 있는지 확인
		ResultData loginedMemberCanDeleteRd = replyService.userCanDelete(rq.getLoginedMemberId(), reply);

		// 삭제 권한이 있을 경우 댓글 삭제
		if (loginedMemberCanDeleteRd.isSuccess()) {
			replyService.deleteReply(id);
		}

		// 대체 URI가 없는 경우 처리
		if (Ut.isNullOrEmpty(replaceUri)) {
			switch (reply.getRelTypeCode()) {
			case "article":
				replaceUri = Ut.f("../article/detail?id=%d", reply.getRelId());
				break;
			}
		}

		// 삭제 결과에 따라 적절한 메시지 반환
		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(), replaceUri);
	}

	// 댓글 수정 처리를 담당하는 메서드
	@RequestMapping("/usr/reply/doModify") // 요청 매핑 어노테이션
	@ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정하는 어노테이션
	public String doModify(HttpServletRequest req, int id, String body) {
		System.err.println(id); // 댓글 ID 로그 출력
		System.err.println(body); // 댓글 내용 로그 출력
		Rq rq = (Rq) req.getAttribute("rq"); // 요청 클래스 객체 가져오기

		// 수정할 댓글 정보 가져오기
		Reply reply = replyService.getReply(id);

		// 댓글이 존재하지 않을 경우 메시지 반환
		if (reply == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
		}

		// 현재 로그인한 사용자가 수정할 권한이 있는지 확인
		ResultData loginedMemberCanModifyRd = replyService.userCanModify(rq.getLoginedMemberId(), reply);

		// 수정 권한이 있을 경우 댓글 수정
		if (loginedMemberCanModifyRd.isSuccess()) {
			replyService.modifyReply(id, body);
		}

		// 수정된 댓글 정보 다시 가져오기
		reply = replyService.getReply(id);

		// 수정된 댓글 내용 반환
		return reply.getBody();
	}
}
