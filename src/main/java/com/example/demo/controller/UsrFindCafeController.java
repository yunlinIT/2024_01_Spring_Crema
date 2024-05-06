package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.crawling.WebCrawler13;
import com.example.demo.repository.CafeRepository;
import com.example.demo.service.CafeReviewService;
import com.example.demo.service.CafeScrapService;
import com.example.demo.service.CafeService;
import com.example.demo.vo.Cafe;
import com.example.demo.vo.CafeReview;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrFindCafeController {

	@Autowired
	private CafeService cafeService;

	@Autowired
	private CafeRepository cafeRepository;

	@Autowired
	private CafeReviewService cafeReviewService;

	@Autowired
	private CafeScrapService cafeScrapService;

	@RequestMapping("/crawl")
	public String crawlAndSaveData() {
		List<Cafe> cafes = WebCrawler13.crawlCafes();

		// System.out.println(cafes);

		cafeService.saveCafeDataFromWebCrawler(cafes);

		return "/usr/home/main";
	}

	@RequestMapping("/usr/findcafe/filterCafes")
	@ResponseBody
	public Map<String, Object> filterCafes(@RequestBody Map<String, Object> filterData) {

		Map<String, Object> returnDataMap = new HashMap<>();
		List<String> selectedKeywords = new ArrayList<String>();

		// String keyword = filterData.get("keyword"); // 키워드 다중선택 아닌 단일선택 시
		// List<String> selectedKeywords = (List<String>)
		// filterData.get("selectedKeywords"); // 키워드 선택하지 않았을 경우 리스트 보이지 않음 (키워드가 빈값 일
		// 때 String)
		Object selectedKeywordsObject = filterData.get("selectedKeywords"); // 키워드 선택 안했을 때 String으로 넘어오고, 키워드 선택 했을 땐
																			// List로 넘어와서 변수타입을 Object로 선언.

		// 아래에서 타입체크
		// 키워드 선택 안했을 시 빈값이 String으로 들어와서 String(빈값) 여부 판단 후
		if (selectedKeywordsObject instanceof String == true) {
			// *** 검색창 전용
			// String -> array(배열) -> List
			// 검색창을 통한 키워드 검색 또는 빈값(카페찾기 page 바로 접근 시) 용도
			// 빈값인 경우 전체카페 리스트 보여줌
			String keyword = selectedKeywordsObject.toString(); // 대관 바보
			
//			if (!"".equals(keyword)) {
//																	// keyword = "아늑한 분위기의 카페"
//				keyword = keyword.replace("카페", "");				// keyword = "아늑한 분위기의 "
//				keyword.trim();										// keyword = "아늑한 분위기의"
//				
//				String[] splitKeywords = keyword.split(" ");		// {아늑한, 분위기의}
//				selectedKeywords = Arrays.asList(splitKeywords);	// [아늑한, 분위기의]
//				//selectedKeywords.add(keyword);
//			}

		} else {
			// *** 필터 전용
			// array(배열) -> List 
			selectedKeywords = (List<String>) selectedKeywordsObject; // {아늑한, 대관, 중구} -> [아늑한, 대관, 중구]
		}

		int page = Integer.parseInt(filterData.get("page").toString());
		List<Cafe> cafesList;

		cafeRepository.updateReviewCount();

		int cafesCount = 0;
		int itemsInAPage = 5;
		if (selectedKeywords.isEmpty()) {
			cafesCount = cafeService.getCafesCount();
			cafesList  = cafeService.getForPrintCafes(itemsInAPage, page); // 키워드가 선택 되지 않았을 경우에 대한 전체카페 리스팅
		} else {
			cafesCount = cafeService.getCafesCountKeyword(selectedKeywords);
			cafesList  = cafeService.getForPrintCafesKeyword(itemsInAPage, page, selectedKeywords); // 키워드가 선택 되었을 경우에 대한 키워드별 카페 리스팅
		}

		returnDataMap.put("cafesTotalCount", cafesCount);
		returnDataMap.put("cafesCurrentList", cafesList);

		return returnDataMap;
	}

//	@RequestMapping("/usr/findcafe/filterCafes")
//	@ResponseBody
//	public Map<String, Object> filterCafes(@RequestBody Map<String, Object> filterData) {
//	    Map<String, Object> returnMap = new HashMap<>();
//	    
//	    List<String> keywords = (List<String>) filterData.get("keywords");
//	    int page = 0;
//	    if (filterData.get("page") instanceof Integer) {
//	        page = (Integer) filterData.get("page");
//	    } else if (filterData.get("page") instanceof String) {
//	        page = Integer.parseInt((String) filterData.get("page"));
//	    }
//	    
//	    List<Cafe> cafesList;
//
//	    int cafesCount = 0;
//	    if (keywords == null || keywords.isEmpty()) {
//	        cafesCount = cafeService.getCafesCount();
//	    } else {
//	        cafesCount = cafeService.getCafesCountKeyword(keywords);
//	    }
//	    
//	    int itemsInAPage = 5;
//
//	    if (keywords == null || keywords.isEmpty()) {
//	        cafesList = cafeService.getForPrintCafes(itemsInAPage, page);
//	    } else {
//	        cafesList = cafeService.getForPrintCafesKeyword(itemsInAPage, page, keywords);
//	    }
//	    
//	    returnMap.put("cafesTotalCount", cafesCount);
//	    returnMap.put("cafesCurrentList", cafesList);
//	    
//	    return returnMap;
//	}

	@RequestMapping("/usr/findcafe/searchList")
	public String showSearchList(HttpServletRequest req) {

//		Rq rq = (Rq) req.getAttribute("rq");
//
//		int cafesCount = cafeService.getCafesCount();
//
//		cafeRepository.updateReviewCount();
//		
//		//@RequestParam(defaultValue = "1")
//
//		// 한페이지에 글 10개씩이야
//		// 글 20개 -> 2 page
//		// 글 24개 -> 3 page
//		int itemsInAPage = 5;
//
//		int pagesCount = (int) Math.ceil(cafesCount / (double) itemsInAPage);
//
//		List<Cafe> cafes = cafeService.getForPrintCafes(itemsInAPage, page);
//
//		model.addAttribute("page", page);
//		model.addAttribute("pagesCount", pagesCount);
//		model.addAttribute("cafesCount", cafesCount);
//		model.addAttribute("cafes", cafes);

		return "/usr/findcafe/searchList";
	}

	@RequestMapping("/usr/findcafe/cafeDetail")
	// @RequestMapping(value = "/usr/findcafe/cafeDetail", method =
	// {RequestMethod.GET, RequestMethod.POST})
	public String showcafeDetail(HttpServletRequest req, Model model, int id) {

		// @RequestParam Map<String, Object> MapForLocation //매개변수안에 작성

		Rq rq = (Rq) req.getAttribute("rq");

		Cafe cafe = cafeService.getForPrintCafe(id);

		ResultData usersScrapRd = cafeScrapService.usersCafeScrap(rq.getLoginedMemberId(), id);

		if (usersScrapRd.isSuccess()) {
			model.addAttribute("userCanScrap", usersScrapRd.isSuccess());
		}

		cafeRepository.updateCafeScrapCount();

		List<CafeReview> cafeReviews = cafeReviewService.getForPrintCafeReviews(rq.getLoginedMemberId(), id);

		int cafeReviewsCount = cafeReviews.size();

		model.addAttribute("cafe", cafe);
		model.addAttribute("cafeReviews", cafeReviews);
		model.addAttribute("cafeReviewsCount", cafeReviewsCount);

		model.addAttribute("isAlreadyAddCafeScrap",
				cafeScrapService.isAlreadyAddCafeScrap(rq.getLoginedMemberId(), id));

		return "usr/findcafe/cafeDetail";

	}

	@RequestMapping("/usr/findcafe/searchCafes")
	public String searchCafes(@RequestParam(required = false) String keyword, Model model) {
//		if (keyword != null) {
//			List<Cafe> cafes = cafeService.searchCafes(keyword);
//			if (cafes.isEmpty()) {
//	            //model.addAttribute("message", "검색 결과가 없습니다.");
//				//return "usr/findcafe/searchList2";
//			} else {
//				model.addAttribute("cafes", cafes);
//			}
//		}

		model.addAttribute("keyword", keyword);

		return "/usr/findcafe/searchList";
	}

	// 두 좌표 사이의 거리를 구하는 함수
	// distance(첫번쨰 좌표의 위도, 첫번째 좌표의 경도, 두번째 좌표의 위도, 두번째 좌표의 경도)
	@ResponseBody
	@RequestMapping("/usr/findcafe/distance")
	public String distance(@RequestBody Map<String, Double> requestMap) {

		// 학원 위도경도
		Double myLat = requestMap.get("myLat");
		Double myLon = requestMap.get("myLon");
		Double cafeLat = requestMap.get("cafeLat");
		Double cafeLon = requestMap.get("cafeLon");

		double theta = myLon - cafeLon;
		double dist = Math.sin(deg2rad(myLat)) * Math.sin(deg2rad(cafeLat))
				+ Math.cos(deg2rad(myLat)) * Math.cos(deg2rad(cafeLat)) * Math.cos(deg2rad(theta));
		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515 * 1609.344;

		String distanceInKm = String.format("%.1f", dist / 1000);

		System.out.println(distanceInKm + "km");

		return distanceInKm; // 단위 kilometer
	}

	// 10진수를 radian(라디안)으로 변환
	private static double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	// radian(라디안)을 10진수로 변환
	private static double rad2deg(double rad) {

		return (rad * 180 / Math.PI);
	}

}
