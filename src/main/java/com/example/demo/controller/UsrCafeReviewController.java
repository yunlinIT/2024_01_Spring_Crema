package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.CafeReviewService;
import com.example.demo.util.Ut;
import com.example.demo.vo.CafeReview;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller 
public class UsrCafeReviewController {

	@Autowired 
	private Rq rq;

	@Autowired 
	private CafeReviewService cafeReviewService;

	@RequestMapping("/usr/cafeReview/doWrite") // /usr/cafeReview/doWrite URL로 요청이 오면 이 메서드가 처리
	@ResponseBody // 응답을 JSON 형태로 반환
	public String doWrite(HttpServletRequest req, int cafeId, String body) {

		Rq rq = (Rq) req.getAttribute("rq"); // 요청에서 rq 객체를 가져옴

		if (Ut.isEmpty(cafeId)) { // cafeId가 비어있다면
			return Ut.jsHistoryBack("F-2", "cafeId를 입력해주세요"); // 오류 메시지 반환
		}
		if (Ut.isNullOrEmpty(body)) { // body가 비어있다면
			return Ut.jsHistoryBack("F-3", "내용을 입력해주세요"); // 오류 메시지 반환
		}

		// 카페 리뷰 작성 서비스 호출, 결과 데이터를 받아옴
		ResultData<Integer> writeCafeReviewRd = cafeReviewService.writeCafeReview(rq.getLoginedMemberId(), cafeId,
				body);

		int id = (int) writeCafeReviewRd.getData1(); // 작성된 리뷰의 ID를 가져옴

		// 작성 성공 메시지와 함께 카페 상세 페이지로 리다이렉트
		return Ut.jsReplace(writeCafeReviewRd.getResultCode(), writeCafeReviewRd.getMsg(),
				"../findcafe/cafeDetail?id=" + cafeId);
	}

	@RequestMapping("/usr/cafeReview/doDelete") // /usr/cafeReview/doDelete URL로 요청이 오면 이 메서드가 처리
	@ResponseBody // 응답을 JSON 형태로 반환
	public String doDelete(HttpServletRequest req, int id, String replaceUri) {
		Rq rq = (Rq) req.getAttribute("rq"); // 요청에서 rq 객체를 가져옴

		CafeReview cafeReview = cafeReviewService.getCafeReview(id); // 리뷰를 ID로 가져옴

		if (cafeReview == null) { // 리뷰가 존재하지 않는다면
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 리뷰는 존재하지 않습니다", id)); // 오류 메시지 반환
		}

		// 로그인된 사용자가 해당 리뷰를 삭제할 수 있는지 확인
		ResultData loginedMemberCanDeleteRd = cafeReviewService.userCanDelete(rq.getLoginedMemberId(), cafeReview);

		if (loginedMemberCanDeleteRd.isSuccess()) { // 삭제 권한이 있다면
			cafeReviewService.deleteCafeReview(id); // 리뷰 삭제
		}

		if (Ut.isNullOrEmpty(replaceUri)) { // replaceUri가 비어있다면
			replaceUri = Ut.f("../findcafe/cafeDetail?id=%d", cafeReview.getCafeId()); // 기본 URL 설정
		}

		// 삭제 성공 메시지와 함께 페이지 리다이렉트
		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(), replaceUri);
	}

	@RequestMapping("/usr/cafeReview/doModify") // /usr/cafeReview/doModify URL로 요청이 오면 이 메서드가 처리
	@ResponseBody // 응답을 JSON 형태로 반환
	public String doModify(HttpServletRequest req, int id, String body) {
		System.err.println(id); // 디버그 용도 출력
		System.err.println(body); // 디버그 용도 출력
		Rq rq = (Rq) req.getAttribute("rq"); // 요청에서 rq 객체를 가져옴

		CafeReview cafeReview = cafeReviewService.getCafeReview(id); // 리뷰를 ID로 가져옴

		if (cafeReview == null) { // 리뷰가 존재하지 않는다면
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id)); // 오류 메시지 반환
		}

		// 로그인된 사용자가 해당 리뷰를 수정할 수 있는지 확인
		ResultData loginedMemberCanModifyRd = cafeReviewService.userCanModify(rq.getLoginedMemberId(), cafeReview);

		if (loginedMemberCanModifyRd.isSuccess()) { // 수정 권한이 있다면
			cafeReviewService.modifyCafeReview(id, body); // 리뷰 수정
		}

		cafeReview = cafeReviewService.getCafeReview(id); // 수정된 리뷰를 다시 가져옴

		return cafeReview.getBody(); // 수정된 리뷰 내용 반환
	}
}
