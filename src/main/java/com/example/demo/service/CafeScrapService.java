package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CafeScrapRepository;
import com.example.demo.repository.ReactionPointRepository;
import com.example.demo.vo.ResultData;

@Service
public class CafeScrapService {
	
	@Autowired
	private CafeService cafeService;

	@Autowired
	private CafeScrapRepository cafeScrapRepository;



//	public int getSumScrapCount(int cafeId) {
//		int getScrapCountByMemberId = cafeScrapRepository.getSumScrapCount(cafeId);
//
//		if (getScrapCountByMemberId > 0) {
//			return getScrapCountByMemberId;
//		}
//
//		return 0;
//	}
	
	
	
	public ResultData usersCafeScrap(int loginedMemberId, int cafeId) {

		if (loginedMemberId == 0) {
			return ResultData.from("F-L", "로그인 하고 써야해");
		}

		int sumCafeScrapByMemberId = cafeScrapRepository.getSumCafeScrapCount(loginedMemberId, cafeId);

		if (sumCafeScrapByMemberId != 0) {
			return ResultData.from("F-1", "찜 불가능", "sumCafeScrapByMemberId", sumCafeScrapByMemberId);
		}

		return ResultData.from("S-1", "찜 가능", "sumCafeScrapByMemberId", sumCafeScrapByMemberId);
	}

	public ResultData addCafeScrapCount(int loginedMemberId, int cafeId) {

		int affectedRow = cafeScrapRepository.addCafeScrapCount(loginedMemberId, cafeId);
		
		System.err.println(affectedRow);
		
		if (affectedRow != 1) {
			return ResultData.from("F-1", "찜 실패ㅠㅠ");
		}


		return ResultData.from("S-1", "찜!");
	}

//	public ResultData addBadReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
//		int affectedRow = cafeScrapRepository.addBadReactionPoint(loginedMemberId, relTypeCode, relId);
//
//		if (affectedRow != 1) {
//			return ResultData.from("F-1", "싫어요 실패");
//		}
//
//		switch (relTypeCode) {
//		case "cafe":
//			cafeService.increaseBadReactionPoint(relId);
//			break;
//		}
//
//		return ResultData.from("S-1", "싫어요!");
//	}

	public ResultData deleteCafeScrapCount(int loginedMemberId, int cafeId) {
		cafeScrapRepository.deleteCafeScrapCount(loginedMemberId, cafeId);


		return ResultData.from("S-1", "찜 취소!");

	}

//	public ResultData deleteBadReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
//		cafeScrapRepository.deleteReactionPoint(loginedMemberId, relTypeCode, relId);
//
//		switch (relTypeCode) {
//		case "cafe":
//			cafeService.decreaseBadReactionPoint(relId);
//			break;
//		}
//		return ResultData.from("S-1", "싫어요 취소 됨");
//	}

	public boolean isAlreadyAddCafeScrap(int memberId, int cafeId) { //isAlreadyAddGoodRp
		int getScrapStatusByMemberId = cafeScrapRepository.getSumCafeScrapCount(memberId, cafeId);

		if (getScrapStatusByMemberId > 0) {
			return true;
		}

		return false;
	}

//	public boolean isAlreadyAddBadRp(int memberId, int relId, String relTypeCode) {
//		int getPointTypeCodeByMemberId = cafeScrapRepository.getSumReactionPoint(memberId, relTypeCode, relId);
//
//		if (getPointTypeCodeByMemberId < 0) {
//			return true;
//		}
//
//		return false;
//	}

	
	
	
	
	
	
	
	
	
	
	

}
