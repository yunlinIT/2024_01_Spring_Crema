package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CafeRepository;
import com.example.demo.repository.CafeScrapRepository;
import com.example.demo.vo.Cafe;
import com.example.demo.vo.ResultData;

@Service
public class CafeService {

	@Autowired
	private CafeRepository cafeRepository;
	private CafeScrapRepository cafeScrapRepository;

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
	
	public List<Cafe> getForPrintCafesKeyword(int itemsInAPage, int page, List<String> selectedKeywords) {

		int limitFrom = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return cafeRepository.getForPrintCafesKeyword(limitFrom, limitTake, selectedKeywords);
	}

	public Cafe getForPrintCafe(int id) {
		Cafe cafe = cafeRepository.getForPrintCafe(id);
		return cafe;
	}

	public int getCafesCount() {
		return cafeRepository.getCafesCount();
	}
	
	public int getCafesCountKeyword(List<String> selectedKeywords) {
		return cafeRepository.getCafesCountKeyword(selectedKeywords);
	}

	public void updateReviewCount() {
		cafeRepository.updateReviewCount();
	}


	public List<Cafe> searchCafes(String keyword) {
		return cafeRepository.searchCafes(keyword);
	}

	public ResultData decreaseCafeScrapCount(int cafeId) { //TODO
		//int affectedRow = cafeRepository.decreaseCafeScrapCount(cafeId);
		int affectedRow = 0;
		
		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 카페");
		}

		return ResultData.from("S-1", "찜 감소", "affectedRow", affectedRow);
	}
	
	public ResultData increaseCafeScrapCount(int cafeId) { //TODO
//		int affectedRow = cafeRepository.increaseCafeScrapCount(cafeId);
		int affectedRow = 0;
		
		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 카페");
		}

		return ResultData.from("S-1", "찜 증가", "affectedRow", affectedRow);
	}
	
	public int getDoScrap(int relId) {
		return cafeRepository.getDoScrap(relId);
	}
	
	
	public Cafe getNewestCafe() {
		
		return cafeRepository.getNewestCafe();
	}

	public Cafe getPopularCafe() {
		
		return cafeRepository.getPopularCafe();
	}

	public Cafe getRecommendedCafe() {
		
		return cafeRepository.getRecommendedCafe();
	}




}
