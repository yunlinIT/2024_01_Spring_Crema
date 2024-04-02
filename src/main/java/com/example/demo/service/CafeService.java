package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.repository.CafeRepository;
import com.example.demo.vo.Cafe;
import com.example.demo.vo.ResultData;

@Service
public class CafeService {

	@Autowired
	private CafeRepository cafeRepository;

	// 웹 크롤러를 통해 카페 데이터를 가져와서 저장하는 메서드
	public void saveCafeDataFromWebCrawler(List<Cafe> cafes) {

		for (Cafe cafe : cafes) {

			int count = cafeRepository.countDuplicateCafeName(cafe.getName());

			if (count == 0) {
				cafeRepository.insertCafe(cafe);
			}
		}
	}

	public List<Cafe> getForPrintCafes(int itemsInAPage, int page) {

		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return cafeRepository.getForPrintCafes(limitFrom, limitTake);
	}
	
	public List<Cafe> getForPrintCafesKeyword(int itemsInAPage, int page, String keyword) {

		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return cafeRepository.getForPrintCafesKeyword(limitFrom, limitTake, keyword);
	}

	public Cafe getForPrintCafe(int id) {
		Cafe cafe = cafeRepository.getForPrintCafe(id);
		return cafe;
	}

	public int getCafesCount() {
		return cafeRepository.getCafesCount();
	}
	
	public int getCafesCountKeyword(String keyword) {
		return cafeRepository.getCafesCountKeyword(keyword);
	}

	public void updateReviewCount() {
		cafeRepository.updateReviewCount();
	}


	public List<Cafe> searchCafes(String keyword) {
		return cafeRepository.searchCafes(keyword);
	}

//    @Transactional(readOnly = true)
//    public List<Cafe> getAllCafes() {
//        return cafeRepository.getForPrintCafes(0, Integer.MAX_VALUE);
//    }

//    @Transactional(readOnly = true)
//    public List<Cafe> filterCafesByKeyword(String keyword) {
//        return cafeRepository.searchCafes(keyword);
//    }
	
	public ResultData decreaseGoodReactionPoint(int relId) { //TODO
		int affectedRow = cafeRepository.decreaseGoodReactionPoint(relId);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "좋아요 감소", "affectedRow", affectedRow);
	}
	
	public ResultData increaseGoodReactionPoint(int relId) { //TODO
		int affectedRow = cafeRepository.increaseGoodReactionPoint(relId);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "좋아요 증가", "affectedRow", affectedRow);
	}



}
