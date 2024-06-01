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

	// ** crawling 전용 method
	@RequestMapping("/crawl")
	// /crawl 경로로 들어오는 요청을 처리하는 메서드
	public String crawlAndSaveData() {
		List<Cafe> cafes = WebCrawler13.crawlCafes(); // WebCrawler13를 사용하여 카페 데이터를 크롤링

		// System.out.println(cafes); // 크롤링한 카페 데이터를 출력하는 코드

		cafeService.saveCafeDataFromWebCrawler(cafes); // 크롤링한 카페 데이터를 데이터베이스에 저장

		return "/usr/home/main"; // 작업 완료 후 /usr/home/main 페이지로 이동
	}

	// ** View 이동 method -> '카페찾기'버튼 클릭 시 실행되는 함수
	@RequestMapping("/usr/findcafe/searchList")
	public String showSearchList(HttpServletRequest req) {

		return "/usr/findcafe/searchList"; // "usr/findcafe/searchList" 뷰를 반환
	}
	
	// ** 메인페이지 검색 키워드 method -> 메인검색창에서 []이던 [키워드]이던 돋보기클릭(검색)시 실행되는 함수
	@RequestMapping("/usr/findcafe/searchCafes") // 메인페이지에서 키워드로 검색하는 검색창 관련 메서드
	// @RequestParam으로 'keyword'를 선택적으로 받고, Model 객체를 받음
	public String searchCafes(@RequestParam(required = false) String keyword, Model model) {

		// 모델에 'keyword'를 속성으로 추가
		model.addAttribute("keyword", keyword);

		// 렌더링할 뷰 템플릿의 이름을 반환, 이 경우 "/usr/findcafe/searchList"
		return "/usr/findcafe/searchList";
	}
	
	// ** 카페리스트 통합검색 method
	@ResponseBody
	@RequestMapping("/usr/findcafe/filterCafes") // 카페찾기 페이지에서 필터 and 검색창 기능 관련
	// 이 메서드의 반환값은 JSON 형식으로 변환되어 HTTP 응답의 본문에 작성
	public Map<String, Object> filterCafes(@RequestBody Map<String, Object> filterData) {
		// HTTP 요청 본문에서 필터 데이터를 받아옴

		Map<String, Object> returnDataMap = new HashMap<>(); // 반환할 데이터를 저장할 맵을 생성
		List<String> selectedKeywords = new ArrayList<String>(); // 선택된 키워드를 저장할 리스트를 생성

		// HTTP 요청에서 선택된 키워드를 가져옴
		Object selectedKeywordsObject = filterData.get("selectedKeywords"); 
																			
		// 키워드 선택이 단일일 경우와 다중일 경우를 구분하여 처리
		// 아래에서 타입체크
		// 키워드 선택 안했을 시 빈값이 String으로 들어와서 String(빈값) 여부 판단 후
		if (selectedKeywordsObject instanceof String == true) {
			
			// (2024-05-06) 아래 기능 주석 사유 : 검색창에서 아늑한 + 카페 라고 검색 시, '아늑한'을 파싱하여 검색하기로 했으나 보류
			// *** 검색창 전용
			// String -> array(배열) -> List
			// 검색창을 통한 키워드 검색 또는 빈값(카페찾기 page 바로 접근 시) 용도
			// 빈값인 경우 전체카페 리스트 보여줌
//			String keyword = selectedKeywordsObject.toString(); // 대관 바보

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
			// *** 필터를 통해 선택된 키워드들인 경우
			// array(배열) -> List
			selectedKeywords = (List<String>) selectedKeywordsObject; // {아늑한, 대관, 중구} -> [아늑한, 대관, 중구]
		}

		int page = Integer.parseInt(filterData.get("page").toString()); // 페이지 번호를 가져옴
		List<Cafe> cafesList; // 반환할 카페 목록을 담을 리스트

		cafeRepository.updateReviewCount(); // 카페 리뷰 수를 업데이트

		int cafesCount = 0; // 전체 카페 수를 초기화
		int itemsInAPage = 5; // 페이지 당 표시할 카페 수를 설정

		// 선택된 키워드가 없는 경우와 있는 경우를 구분하여 처리
		if (selectedKeywords.isEmpty()) {
			// 선택된 키워드가 없는 경우 전체 카페 목록을 가져옴
			cafesCount = cafeService.getCafesCount(); // 전체 카페 수를 가져옴
			cafesList = cafeService.getForPrintCafes(itemsInAPage, page); // 키워드가 선택 되지 않았을 경우에 대한 전체카페 리스팅
		} else {
			// 선택된 키워드가 있는 경우 해당 키워드로 검색창 keyword검색 및 필터링된 카페 목록을 가져옴
			cafesCount = cafeService.getCafesCountKeyword(selectedKeywords);
			cafesList = cafeService.getForPrintCafesKeyword(itemsInAPage, page, selectedKeywords); // 키워드가 선택 되었을 경우에 대한
																									// 키워드별 카페 리스팅
		}

		// 반환할 데이터 맵에 전체 카페 수와 현재 페이지의 카페 목록을 추가
		returnDataMap.put("cafesTotalCount", cafesCount);
		returnDataMap.put("cafesCurrentList", cafesList);

		// 처리된 결과를 반환
		return returnDataMap;
	}

	// ** 상세페이지 method
	@RequestMapping("/usr/findcafe/cafeDetail")
	// HttpServletRequest, Model, 그리고 int 타입의 'id' 매개변수를 받음
	public String showcafeDetail(HttpServletRequest req, Model model, int id) {

		// 요청 속성에서 "rq"라는 이름으로 Rq 객체를 가져옴
		Rq rq = (Rq) req.getAttribute("rq");

		// cafeService를 사용하여 ID로 카페 객체를 가져옴
		Cafe cafe = cafeService.getForPrintCafe(id);

		// cafeScrapService를 사용하여 사용자가 해당 카페를 스크랩했는지 여부를 ResultData 객체로 가져옴
		ResultData usersScrapRd = cafeScrapService.usersCafeScrap(rq.getLoginedMemberId(), id);

		// 사용자가 해당 카페를 스크랩했다면, 모델에 사용자가 스크랩할 수 있다는 속성을 추가
		if (usersScrapRd.isSuccess()) {
			model.addAttribute("userCanScrap", usersScrapRd.isSuccess());
		}

		// 카페의 스크랩 수를 업데이트
		cafeRepository.updateCafeScrapCount();

		// 해당 카페에 대한 리뷰 목록을 가져옴
		List<CafeReview> cafeReviews = cafeReviewService.getForPrintCafeReviews(rq.getLoginedMemberId(), id);

		// 리뷰의 개수를 계산
		int cafeReviewsCount = cafeReviews.size();

		// 모델에 카페, 카페 리뷰, 리뷰 개수를 속성으로 추가
		model.addAttribute("cafe", cafe);
		model.addAttribute("cafeReviews", cafeReviews);
		model.addAttribute("cafeReviewsCount", cafeReviewsCount);

		// 사용자가 이미 카페를 스크랩했는지 여부를 모델에 속성으로 추가
		model.addAttribute("isAlreadyAddCafeScrap",
				cafeScrapService.isAlreadyAddCafeScrap(rq.getLoginedMemberId(), id));

		// 렌더링할 뷰 템플릿의 이름을 반환, 이 경우 "usr/findcafe/cafeDetail"
		return "usr/findcafe/cafeDetail";
	}



	// 두 좌표 사이의 거리를 구하는 함수
	// distance(첫번쨰 좌표의 위도, 첫번째 좌표의 경도, 두번째 좌표의 위도, 두번째 좌표의 경도)
	// 이 어노테이션은 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정
	@ResponseBody
	// 이 어노테이션은 URL "/usr/findcafe/distance"를 이 메서드에 매핑
	@RequestMapping("/usr/findcafe/distance")
	// 이 메서드는 요청 본문을 Map으로 받아 처리
	public String distance(@RequestBody Map<String, Double> requestMap) {

		// 학원 위도와 경도를 Map에서 가져옴
		Double myLat = requestMap.get("myLat");
		Double myLon = requestMap.get("myLon");
		// 카페 위도와 경도를 Map에서 가져옴
		Double cafeLat = requestMap.get("cafeLat");
		Double cafeLon = requestMap.get("cafeLon");

		// 경도 차이 계산
		double theta = myLon - cafeLon;
		// 두 지점 간의 거리 계산
		double dist = Math.sin(deg2rad(myLat)) * Math.sin(deg2rad(cafeLat))
				+ Math.cos(deg2rad(myLat)) * Math.cos(deg2rad(cafeLat)) * Math.cos(deg2rad(theta));
		dist = Math.acos(dist);
		dist = rad2deg(dist);
		// 거리 계산 결과를 마일 단위에서 미터 단위로 변환
		dist = dist * 60 * 1.1515 * 1609.344;

		// 거리 계산 결과를 킬로미터 단위로 포맷팅
		String distanceInKm = String.format("%.1f", dist / 1000);

		// 거리 정보를 콘솔에 출력
		System.out.println(distanceInKm + "km");

		// 킬로미터 단위의 거리 정보를 반환
		return distanceInKm;
	}

	// 도(degree)를 라디안(radian)으로 변환하는 메서드
	private double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	// 라디안(radian)을 도(degree)로 변환하는 메서드
	private double rad2deg(double rad) {
		return (rad * 180.0 / Math.PI);
	}

}
