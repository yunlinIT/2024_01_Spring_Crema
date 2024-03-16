package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CafeReviewRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.CafeReview;
import com.example.demo.vo.ResultData;

@Service
public class CafeReviewService {

	@Autowired
	private CafeReviewRepository cafeReviewRepository;

	public CafeReviewService(CafeReviewRepository cafeReviewRepository) {
		this.cafeReviewRepository = cafeReviewRepository;
	}

	public List<CafeReview> getForPrintCafeReviews(int loginedMemberId, int cafeId) {
		List<CafeReview> cafeReviews = cafeReviewRepository.getForPrintCafeReviews(loginedMemberId, cafeId);

		for (CafeReview cafeReview : cafeReviews) {
			controlForPrintData(loginedMemberId, cafeReview);
		}

		return cafeReviews;
	}
	
	
	public ResultData<Integer> writeCafeReview(int loginedMemberId, int cafeId, String body) {
		
		cafeReviewRepository.writeCafeReview(loginedMemberId, cafeId, body);

		int id = cafeReviewRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 리뷰가 등록되었습니다", id), "id", id);
	}


	private void controlForPrintData(int loginedMemberId, CafeReview cafeReview) {
		if (cafeReview == null) {
			return;
		}
		ResultData userCanModifyRd = userCanModify(loginedMemberId, cafeReview);
		cafeReview.setUserCanModify(userCanModifyRd.isSuccess());

		ResultData userCanDeleteRd = userCanDelete(loginedMemberId, cafeReview);
		cafeReview.setUserCanDelete(userCanDeleteRd.isSuccess());
	}

	public ResultData userCanDelete(int loginedMemberId, CafeReview cafeReview) {

		if (cafeReview.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 리뷰에 대한 삭제 권한이 없습니다", cafeReview.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 리뷰가 삭제 되었습니다", cafeReview.getId()));
	}

	public ResultData userCanModify(int loginedMemberId, CafeReview cafeReview) {

		if (cafeReview.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 리뷰에 대한 수정 권한이 없습니다", cafeReview.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 리뷰를 수정했습니다", cafeReview.getId()));
	}

	public CafeReview getCafeReview(int id) {
		return cafeReviewRepository.getCafeReview(id);
	}

	public ResultData deleteCafeReview(int id) {
		cafeReviewRepository.deleteCafeReview(id);
		return ResultData.from("S-1", Ut.f("%d번 리뷰를 삭제했습니다", id));
	}

	public void modifyCafeReview(int id, String body) {
		cafeReviewRepository.modifyCafeReview(id, body);
	}


}