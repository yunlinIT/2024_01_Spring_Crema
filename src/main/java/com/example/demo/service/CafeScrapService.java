package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CafeScrapRepository;
import com.example.demo.repository.ReactionPointRepository;

@Service
public class CafeScrapService {
	
	@Autowired
	private ArticleService cafeService;

	@Autowired
	private CafeScrapRepository cafeScrapRepository;


	
//	public boolean isAlreadyAddGoodRp(int memberId, int relId, String relTypeCode) {
//		int getPointTypeCodeByMemberId = reactionPointRepository.getSumReactionPoint(memberId, relTypeCode, relId);
//
//		if (getPointTypeCodeByMemberId > 0) {
//			return true;
//		}
//
//		return false;
//	}



	public int getSumScrapCount(int cafeId) {
		int getScrapCountByMemberId = cafeScrapRepository.getSumScrapCount(cafeId);

		if (getScrapCountByMemberId > 0) {
			return getScrapCountByMemberId;
		}

		return 0;
	}

}
