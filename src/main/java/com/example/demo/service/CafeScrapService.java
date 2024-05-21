package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CafeRepository;
import com.example.demo.repository.CafeScrapRepository;
import com.example.demo.repository.ReactionPointRepository;
import com.example.demo.vo.Cafe;
import com.example.demo.vo.ResultData;

@Service
public class CafeScrapService {
	
	@Autowired
	private CafeService cafeService;

	@Autowired
	private CafeScrapRepository cafeScrapRepository;
	
	@Autowired
	private CafeRepository cafeRepository;
	
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

		int affectedRow = cafeScrapRepository.addCafeScrapCount(loginedMemberId, cafeId);	// 내 찜 목록에서 A카페 추가
		
		
		System.err.println(affectedRow);
		
		if (affectedRow != 1) {
			return ResultData.from("F-1", "찜 실패ㅠㅠ");
		}

		cafeRepository.increaseCafeScrapCount(cafeId);	// A카페 전체 찜 목록 COUNT +1
		
		return ResultData.from("S-1", "찜!");
	}


	public ResultData deleteCafeScrapCount(int loginedMemberId, int cafeId) {
		cafeScrapRepository.deleteCafeScrapCount(loginedMemberId, cafeId);	// 내 찜 목록에서 A카페 삭제
		cafeRepository.decreaseCafeScrapCount(cafeId);						// A카페 전체 찜 목록 COUNT -1

		return ResultData.from("S-2", "찜 취소!");

	}

	public boolean isAlreadyAddCafeScrap(int memberId, int cafeId) { //isAlreadyAddGoodRp
		int getScrapStatusByMemberId = cafeScrapRepository.getSumCafeScrapCount(memberId, cafeId);

		if (getScrapStatusByMemberId > 0) {
			return true;
		}

		return false;
	}

	public List<Cafe> getForPrintScrapCafes(Integer memberId) {
		
		return cafeScrapRepository.getForPrintScrapCafes(memberId);
	}

	public boolean getBooleanCafeScrap(int loginedMemberId, int cafeId) {
		boolean isAlreadyCafeScrap = true;
		
		int myScrapCount = cafeScrapRepository.getSumCafeScrapCount(loginedMemberId, cafeId);
		
		if(myScrapCount == 0) {
			isAlreadyCafeScrap = false;
		}
			
		return isAlreadyCafeScrap;
	}
	

	
	
	
	
	
	
	
	
	
	

}
