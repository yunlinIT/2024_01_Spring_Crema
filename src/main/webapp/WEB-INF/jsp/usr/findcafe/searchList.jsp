<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Crema | 카페 찾기"></c:set>

<%@ include file="../common/head.jspf"%>


<!-- Start | java script -->
<script>

<!-- 전역변수 -->
var currentPage = 1; // 현재 페이지 초기화
var totalPages = 1; // 전체 페이지 수 초기화
var keyword = ""; // 검색 키워드 초기화
var selectedKeywords = []; // 선택된 키워드를 저장할 배열


<!-- 페이지 접속 시 최초 실행(onload) 함수 -->
window.onload = function() {
    // 페이지가 완전히 로드되면 이 함수가 실행
    
   // alert('페이지가 로드되었습니다!'); 
    
    keyword = '${keyword}';
    
    if (keyword != ""){

        selectedKeywords.push(keyword);
    }
    
    
    loadFilteredCafes(selectedKeywords, currentPage);	// 카페검색 최초 리스팅
};


<!-- document ready Area -->

$(document).ready(function() {


    // 필터 버튼 클릭 이벤트 핸들러 등록
    $(".filterButton").on("click", function(event) {
        var keyword = $(this).find(".text-wrapper").text(); // 클릭한 버튼의 텍스트에서 키워드 추출

        // '전체선택' 또는 '전체해제'인 경우
        if (keyword === '전체' || keyword === '전체해제') {
            // 키워드를 빈 문자열로 설정
            keyword = "";
            // 기존에 선택되었던 다른 키워드들 제거
            selectedKeywords = [];
            $(".filterButton").removeClass('active');
        } else {
            // 해당 키워드가 이미 선택되어 있는지 확인
            var index = selectedKeywords.indexOf(keyword); // 선택된 키워드 배열에서 해당 키워드의 인덱스 확인(indexOf)
            if (index !== -1) {
                // 이미 선택되어 있다면 해당 키워드를 제거
                selectedKeywords.splice(index, 1); //splice(index, 1)
                $(this).removeClass('active');
            } else {
                // 선택되어 있지 않다면 해당 키워드를 배열에 추가
                selectedKeywords.push(keyword);
                $(this).addClass('active');
            }
        }

        currentPage = 1; // 페이지를 1로 설정하여 필터가 변경되었음을 나타냄
        loadFilteredCafes(selectedKeywords, currentPage); // 필터된 카페들을 불러오는 함수 호출
    });

    // 검색 버튼 클릭 이벤트 핸들러 등록
    $("#searchForm").submit(function(event) {
        event.preventDefault(); // 기본 동작 방지 (페이지 이동 막기)
        keyword = $("#keyword").val(); // 검색어 입력값 가져오기
        currentPage = 1; // 페이지를 1로 설정하여 검색이 변경되었음을 나타냄
        
        selectedKeywords = [];			// 검색 키워드 초기화
        selectedKeywords.push(keyword);	// 검색 키워드 배열에 담기
        loadFilteredCafes(selectedKeywords, currentPage); // 검색어로 필터된 카페들을 불러오는 함수 호출
    });

    $('.pagination').on('click', 'a', function(event) {
        event.preventDefault(); // 기본 동작 방지 (페이지 이동 막기)
        currentPage = parseInt($(this).attr('href').split('=')[1]); // 클릭한 페이지 번호 추출

        // 필터링된 카페 목록을 요청하는 함수 호출
        loadFilteredCafes(selectedKeywords, currentPage);

        // 페이지 맨 위로 스크롤
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
    });
});



<!-- function Area -->
// 필터된 카페들을 불러오는 함수
function loadFilteredCafes(selectedKeywords, currentPage){	
	// FILTER {아늑한, 대관, 중구}
 	// 검색창 
 	
    $.ajax({
        url: "/usr/findcafe/filterCafes", // 요청할 URL
        type: "POST", // POST 방식으로 요청
        contentType: "application/json", // 요청 데이터의 타입
        data: JSON.stringify({ 	// JSON 형태로 데이터 전송
        	selectedKeywords: selectedKeywords, 	// 키워드 전송
            page: currentPage 						// 페이지 번호 전송
        }),
        success: function(dataMap) { // 요청이 성공했을 때의 콜백 함수
            totalPages = Math.ceil(dataMap.cafesTotalCount / 5); // 전체 페이지 수 계산
            updatePagination(currentPage, totalPages); // 페이지네이션 업데이트
            updateCafeList(dataMap.cafesCurrentList, selectedKeywords); // 카페 리스트 업데이트
        },
        error: function(xhr, status, error) { // 요청이 실패했을 때의 콜백 함수
            console.error("Ajax request failed:", status, error); // 에러 로그 출력
        }
    });
}


function updatePagination(currentPage, totalPages) {
	
	///// 페이지네이션을 표시할 HTML 요소를 가져온다
    var paginationElement = $(".pagination");

	///// 이전에 표시된 페이지네이션을 초기화
    paginationElement.empty();
	
    var paginationHTML = '';
    // 페이지 번호 생성
    for (var i = 1; i <= totalPages; i++) {
        var activeClass = (i === currentPage) ? 'btn-active' : '';
        paginationHTML += '<a class="btn btn-circle btn-ghost btn-xs ' + activeClass + '" href="?page=' + i + '">' + i + '</a>';
    }
    $('.pagination').html(paginationHTML); // 페이지네이션 업데이트
}

function isAlreadyAddCafeScrap(cafeId){
	var isAlreadyScrap = true;
	
	$.ajax({
		url: '/usr/cafeScrap/isAlreadyCafeScrapForList', 
		type: 'POST',
		data: {cafeId: cafeId},
		dataType: 'json',
		success: function(booleanData){
			console.log("cafeId : "+cafeId+"\n"+"booleanData : "+booleanData);
			
			isAlreadyScrap = booleanData;
			if(isAlreadyScrap === true){
				$(".material-symbols-outlined[data-cafeid="+cafeId+"]").css('font-variation-settings', "'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24");
			} else {
				$(".material-symbols-outlined[data-cafeid="+cafeId+"]").css('font-variation-settings', "'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24");
			}
		},
		error: function(jqXHR,textStatus,errorThrown) {
			alert('찜 확인 오류 : ' + textStatus);
		}
		
	});
	
}

// 카페 리스트 업데이트 함수
function updateCafeList(cafeList, selectedKeywords) {
    var cafeListElement = $(".linkbox１"); // 카페 리스트 요소 선택
    var searchResult = $("#search-result"); // 검색 결과 영역 요소 선택

    cafeListElement.empty(); // 카페 리스트 요소 일단 무조건 비우기 -> 왜? -> 필터 및 검색결과 다시 보여줄꺼니까

    var cafeItem;
    if( cafeList.length == 0 ) {
//     	alert("카페 검색 결과가 없습니다.");
    	cafeItem = $(`
    			<div class="cafe-item">
	                <div class="linkbox１">
	                    <div class="content-info-box" style="margin-bottom: 50px">
	                    	<p>"`+selectedKeywords+`"에 대한 검색 결과가 없습니다.</p>
	                    </div>
	                </div>
                </div>
        		`);	// end var cafeItem
        searchResult.append(cafeItem); // 카페 리스트에 카페 아이템 추가
    } else {
	    cafeList.forEach(function(cafe) { // 각 카페에 대해 반복
	    	// 나의 찜 카페들은 isAlreadyAddCafeScrap = true
	    	isAlreadyAddCafeScrap(cafe.id);
	    	
	        cafeItem = $(`
	        		
	            <div class="cafe-item">
	                <a href="cafeDetail?id=`+cafe.id+`" class="linkbox１">
	                    <div class="content-info-box" style="margin-bottom: 50px">
	                        <div class="cafe-img-box">
	                            <img src="`+cafe.cafeImgUrl1+`" alt="카페 이미지" />
	                        </div>
	                        <div class="name-address">
	                            <div class="cafe-name equal-filter">`+cafe.name+`</div>
	                            <p class="cafe-address equal-filter">`+cafe.address+`</p>
	                        </div>
	                        <div class="like-count">
	                            <span class="material-symbols-outlined" data-cafeid="`+cafe.id+`"> favorite </span>
	                            <div class="like-count-num">`+cafe.cafeScrapCount+`</div>
	                        </div>
	                        <div class="review-count">
	                            <div class="title-review">리뷰</div>
	                            <div class="review-count-num">`+cafe.reviewCount+`</div>
	                        </div>
	                        <div class="hashtag equal-filter">`+cafe.hashtag+`</div>
	                    </div>
	                </a>
	            </div>
	        `);	// end var cafeItem
	        searchResult.append(cafeItem); // 카페 리스트에 카페 아이템 추가
	    });	// end cafeList.forEach    	
    }
    
    applyStyleToMatchingText(selectedKeywords); // 선택된 키워드와 일치하는 텍스트에 스타일 적용
    
}	
// end function updateCafeList



//선택된 키워드와 일치하는 텍스트에 스타일 적용하는 함수
function applyStyleToMatchingText(selectedKeywords) {
	
 	if (typeof selectedKeywords === 'string') {
        // selectedKeywords가 문자열인 경우에 대한 처리
        // 예를 들어, 문자열을 배열로 변환하거나 다른 작업을 수행할 수 있습니다.
        if ( selectedKeywords.trim() != "" ) {
        	selectedKeywords = selectedKeywords.split(" ");
        }
 	}
	
    // 선택된 키워드가 배열인지 확인
    if (Array.isArray(selectedKeywords)) {
       	// console.error("selectedKeywords must be an array");
	    // 각 카페 아이템에 대해 반복
	    $(".equal-filter").each(function() {
	        var cafeItem = $(this);		// cafe Name, address, hashTag
	        var text = cafeItem.text(); // 카페 아이템의 텍스트 가져오기
	
	        // 선택된 키워드와 일치하는 부분에 스타일 적용
	        selectedKeywords.forEach(function(keyword) {
	            var regex = new RegExp(keyword, "gi"); // 대소문자 구분 없이 일치하는 모든 부분 찾기 위한 정규표현식(Regular Expression) 생성
	            text = text.replace(regex, '<span style="color: #b02717; font-weight: 700;">$&</span>'); // 일치하는 부분에 스타일 적용
	        });
	
	        cafeItem.html(text); // 스타일이 적용된 텍스트로 카페 아이템 업데이트
	    });
	    
    } else { // String 일 때
    	$(".equal-filter").each(function() {
	        var cafeItem = $(this); 	// cafe Name, address, hashTag
	        var text = cafeItem.text(); // 카페 아이템의 텍스트 가져오기
	
	        // 선택된 키워드와 일치하는 부분에 스타일 적용
	        var regex = new RegExp(selectedKeywords, "gi"); // 대소문자 구분 없이 일치하는 모든 부분 찾기 위한 정규표현식(Regular Expression) 생성
	        text = text.replace(regex, '<span style="color: #b02717; font-weight: 700;">$&</span>'); // 일치하는 부분에 스타일 적용
	
	        cafeItem.html(text); // 스타일이 적용된 텍스트로 카페 아이템 업데이트
	    });
    }

}
<!-- end function Area -->
</script>
<!-- End | java script -->

<!-- 페이지제목 css -->
<style>
.search-box {
	position: absolute; /* 절대적 위치 설정 */
	top: 200px; /* 상단에 위치 */
	left: 390px; /* 좌측에 위치 */
	background-color: #ffffff;
	z-index: 1; /* 다른 요소 위에 표시 */
}
</style>

<style>
.page-title {
	position: relative;
	top: 100px;
	text-align: center;
	font-family: "Pretendard";
	font-weight: 600;
	font-family: "Pretendard";
	font-weight: 600;
	font-size: 30px;
	font-weight: 600;
	font-family: "Pretendard";
	font-weight: 600;
	font-family: "Pretendard";
	font-weight: 600;
}

/* 카페검색결과 */
.find-cafe {
	display: flex;
	justify-content: center; /* 좌우 중앙 정렬 */
	margin-top: 150px
}
}
</style>

<!-- 필터 css -->
<style>
.active {
	background-color: #dfdfdf !important; /* 클릭된 버튼의 배경색을 변경. */
}

.search-filter {
	Position: sticky;
	top: -10px;
	width: 309px;
	height: 908px;
	background-color: #ffffff;
}

.search-filter .filter-facility {
	position: absolute;
	width: 293px;
	height: 196px;
	top: 654px;
	left: 16px;
	overflow: hidden;
}

.search-filter .filter-btn {
	position: absolute;
	width: 92px;
	height: 31px;
	top: 145px;
	left: 100px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .text-wrapper {
	position: absolute;
	width: 91px;
	height: 30px;
	top: 6px;
	left: 0;
	font-family: "Inter-SemiBold", Helvetica;
	font-weight: 600;
	color: #333333;
	font-size: 14px;
	text-align: center;
	letter-spacing: 0;
	line-height: normal;
}

.search-filter .filter-btn-14 {
	top: 145px;
	left: 0;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .div {
	top: 105px;
	left: 200px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-1 {
	top: 105px;
	left: 200px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-2 {
	top: 105px;
	left: 100px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-3 {
	top: 105px;
	left: 0;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-4 {
	top: 65px;
	left: 200px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-5 {
	top: 65px;
	left: 100px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-6 {
	top: 65px;
	left: 0;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .text-wrapper-2 {
	top: 19px;
	left: 1px;
	font-size: 16px;
	position: absolute;
	width: 133px;
	height: 30px;
	font-family: "Inter-SemiBold", Helvetica;
	font-weight: 600;
	color: #333333;
	letter-spacing: 0;
	line-height: normal;
}

.search-filter .line {
	position: absolute;
	width: 301px;
	top: 5px;
	left: 0;
	border: 1px rgba(0, 0, 0, 0.06) solid;
}

.search-filter .filter-theme {
	position: absolute;
	width: 293px;
	height: 276px;
	top: 332px;
	left: 16px;
	overflow: hidden;
}

.search-filter .filter-btn-7 {
	top: 225px;
	left: 200px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-8 {
	top: 225px;
	left: 100px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-9 {
	top: 225px;
	left: 0;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-10 {
	top: 185px;
	left: 200px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-11 {
	top: 185px;
	left: 100px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-12 {
	top: 185px;
	left: 0;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-btn-13 {
	top: 145px;
	left: 200px;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .filter-area {
	position: absolute;
	width: 293px;
	height: 156px;
	top: 130px;
	left: 16px;
	overflow: hidden;
}

.search-filter .filter-selectall {
	position: absolute;
	width: 293px;
	height: 84px;
	top: 43px;
	left: 15px;
	overflow: hidden;
}

.search-filter .selectall-btn {
	top: 30px;
	left: 0;
	position: absolute;
	width: 92px;
	height: 31px;
	background-color: #ffffff;
	border-radius: 20px;
	border: 1.2px solid;
	border-color: #dfdfdf;
}

.search-filter .text-wrapper-3 {
	top: 5px;
	left: 16px;
	font-size: 20px;
	position: absolute;
	width: 133px;
	height: 30px;
	font-family: "Inter-SemiBold", Helvetica;
	font-weight: 600;
	color: #333333;
	letter-spacing: 0;
	line-height: normal;
}
</style>


<!-- 검색결과 css -->

<style>
.search-result {
	position: relative;
	margin-left: 100px;
}

.show-result-by {
	position: relative;
	width: 786px;
	height: 33px;
	background-color: #ffffff;
	overflow: hidden;
}

.content-info-box {
	position: relative;
	width: 750px;
	height: 247px;
}

.show-result-by .text-wrapper {
	position: absolute;
	width: 788px;
	height: 35px;
	top: -3px;
	left: 1px;
	font-family: "Inter-SemiBold", Helvetica;
	font-weight: 600;
	color: #333333;
	font-size: 20px;
	letter-spacing: 0;
	line-height: normal;
}

.content-info-box .hashtag {
	position: absolute;
	width: 296px;
	height: 15px;
	top: 227px;
	left: 490px;
}

.hashtag {
	position: absolute;
	width: 296px;
	height: 15px;
	top: 0px;
	left: 0;
	font-family: "Pretendard";
	font-weight: 600;
	color: #666666;
	font-size: 12px;
	letter-spacing: 0;
	line-height: normal;
	left: 0;
	font-family: "Pretendard";
	font-weight: 600;
	color: #666666;
	font-size: 12px;
	font-family: "Pretendard";
	font-weight: 600;
	color: #666666;
	font-size: 12px;
}

.content-info-box .show-distance {
	position: absolute;
	width: 41px;
	height: 15px;
	top: 60px;
	left: 490px;
	background-color: #e3e3e3;
	border-radius: 5px;
}

.content-info-box .num-km-group {
	width: 35px;
	height: 15px;
	left: 6px;
	position: relative;
	top: -1px;
}

.content-info-box .km {
	position: absolute;
	width: 20px;
	height: 15px;
	top: 2px;
	left: 15px;
	font-family: "Pretendard";
	font-weight: 600;
	color: #000000;
	font-size: 10px;
	letter-spacing: 0;
	line-height: normal;
}

.content-info-box .distance-num {
	position: absolute;
	width: 20px;
	height: 15px;
	top: 2px;
	left: 0;
	font-family: "Pretendard";
	font-weight: 600;
	color: #000000;
	font-size: 10px;
	letter-spacing: 0;
	line-height: normal;
}

.content-info-box .title-review {
	position: absolute;
	width: 25px;
	height: 15px;
	top: 0px;
	left: 0;
	font-family: "Pretendard";
	font-weight: 600;
	color: #000000;
	font-size: 12px;
	letter-spacing: 0;
	line-height: normal;
}

.content-info-box .review-count {
	position: absolute;
	width: 41px;
	height: 15px;
	top: 85px;
	left: 535px;
}

.content-info-box .review-count-num {
	left: 24px;
	position: absolute;
	width: 20px;
	height: 15px;
	top: 0.4px;
	font-family: "Pretendard";
	font-weight: 600;
	color: #000000;
	font-size: 12px;
	letter-spacing: 0;
	line-height: normal;
}

.like-count .material-symbols-outlined {
	position: absolute;
	width: 12px;
	height: 12px;
	top: -1.5px;
	left: 0;
	font-size: 15px;
	color: red;
}

.content-info-box .like-count {
	position: absolute;
	width: 36px;
	height: 15px;
	top: 85px;
	left: 492px;
}

.content-info-box .like-count-num {
	left: 18px;
	position: absolute;
	width: 20px;
	height: 15px;
	top: 0px;
	font-family: "Pretendard";
	font-weight: 600;
	color: #000000;
	font-size: 10px;
	letter-spacing: 0;
	line-height: normal;
}

.content-info-box .name-address {
	position: absolute;
	width: 296px;
	height: 43px;
	top: 6px;
	left: 490px;
}

.content-info-box .cafe-name {
	height: 24px;
	top: 5px;
	font-family: "Pretendard";
	font-weight: 600;
	font-size: 20px;
	position: absolute;
	width: 296px;
	left: 0;
	color: #000000;
	letter-spacing: 0;
	line-height: normal;
}

.content-info-box .cafe-address {
	height: 20px;
	top: 30px;
	font-family: Pretendard;
	font-weight: 500;
	font-size: 14px;
	position: absolute;
	width: 296px;
	left: 0;
	color: #666666;
	letter-spacing: 0;
	line-height: normal;
}

/* 카페 리스트 이미지 hover 하면 이미지 확대 효과 */
.content-info-box .cafe-img-box {
	position: relative; /* 상대적 위치 설정 */
	width: 467px;
	height: 247px;
	border-radius: 20px;
	overflow: hidden; /* 내용이 넘치는 경우 숨김 처리 */
}

.content-info-box .cafe-img-box img {
	position: absolute; /* 절대적 위치 설정 */
	width: 100%; /* 부모 요소에 대해 100% 너비를 갖도록 설정 */
	height: 100%; /* 부모 요소에 대해 100% 높이를 갖도록 설정 */
	top: 0; /* 부모 요소의 맨 위에 위치 */
	left: 0; /* 부모 요소의 맨 왼쪽에 위치 */
	object-fit: cover; /* 이미지를 박스에 맞게 crop */
	transition: transform 0.2s linear; /* 변형 효과 설정 */
}

.content-info-box .cafe-img-box:hover img {
	transform: scale(1.1); /* 이미지 확대 효과 */
}
</style>


</head>

<!-- 페이지제목 -->
<div class="page-title">
	<div class="text-wrapper result">카페 찾기</div>
</div>



<!-- 카페 검색결과 페이지  -->
<section class="find-cafe">

	<!-- 사이드바 - 필터 -->
	<section class="filter-bar">

		<!-- 검색창 -->
		<form action="/usr/findcafe/searchCafes" method="get" id="searchForm">

			<label class="search-menu-item input input-bordered flex items-center gap-2 input-xs" style="width: 65%; margin-left: 10px"> 
				<input type="text" class="searchInput" id="keyword" name="keyword" autocomplete="off" placeholder="Search" value="${keyword }" /> 
				<a href='javascript:loadFilteredCafes( [$("#keyword").val()] , 1 );'>
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70">
	                    <path fill-rule="evenodd"
							d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
							clip-rule="evenodd" />
	                </svg>
				</a>
			</label>

		</form>

		<div class="search-filter">

			<div class="text-wrapper-3">필터</div>

			<div class="filter-selectall">
				<button class="selectall-btn badge badge-lg filterButton">
					<div class="text-wrapper">전체해제</div>
				</button>
				<div class="line"></div>
			</div>

			<div class="filter-area">
				<div class="line"></div>
				<div class="text-wrapper-2 filter-title">지역</div>
				<button class="filter-btn-1 daedukgu badge badge-lg filterButton">
					<div class="text-wrapper">대덕구</div>
				</button>
				<button class="filter-btn-2 yuseonggu badge badge-lg filterButton">
					<div class="text-wrapper">유성구</div>
				</button>
				<button class="filter-btn-3 donggu badge badge-l filterButton">
					<div class="text-wrapper">동구</div>
				</button>
				<button class="filter-btn-4 joongu badge badge-l filterButton">
					<div class="text-wrapper">중구</div>
				</button>
				<button class="filter-btn-5 seogu badge badge-l filterButton">
					<div class="text-wrapper">서구</div>
				</button>
				<button class="filter-btn-6 selectall badge badge-l filterButton">
					<div class="text-wrapper">전체</div>
				</button>
			</div>

			<div class="filter-theme">
				<div class="line"></div>
				<div class="text-wrapper-2 filter-title">분위기</div>
				<button class="filter-btn classic badge badge-l filterButton">
					<div class="text-wrapper">클래식</div>
				</button>
				<button class="filter-btn-1 cozy badge badge-lg filterButton">
					<div class="text-wrapper">아늑한</div>
				</button>
				<button class="filter-btn-2 natural badge badge-lg filterButton">
					<div class="text-wrapper">내추럴</div>
				</button>
				<button class="filter-btn-3 simple badge badge-lg filterButton">
					<div class="text-wrapper">심플</div>
				</button>
				<button class="filter-btn-4 modern badge badge-lg filterButton">
					<div class="text-wrapper">모던</div>
				</button>
				<button class="filter-btn-5 wide badge badge-lg filterButton">
					<div class="text-wrapper">넓은</div>
				</button>
				<button class="filter-btn-6 selectall badge badge-lg filterButton">
					<div class="text-wrapper">전체</div>
				</button>
				<button class="filter-btn-7 photomatzip badge badge-l filterButton">
					<div class="text-wrapper">사진맛집</div>
				</button>
				<button class="filter-btn-8 viewmatzip badge badge-l filterButton">
					<div class="text-wrapper">뷰맛집</div>
				</button>
				<button class="filter-btn-9 study badge badge-l filterButton">
					<div class="text-wrapper">업무/공부</div>
				</button>
				<button class="filter-btn-10 dating badge badge-l filterButton">
					<div class="text-wrapper">데이트</div>
				</button>
				<button class="filter-btn-11 group badge badge-l filterButton">
					<div class="text-wrapper">단체</div>
				</button>
				<button class="filter-btn-12 conversation badge badge-l filterButton">
					<div class="text-wrapper">대화</div>
				</button>
				<button class="filter-btn-13 cute badge badge-l filterButton">
					<div class="text-wrapper">아기자기</div>
				</button>
				<button class="filter-btn-14 retro badge badge-l filterButton">
					<div class="text-wrapper">레트로</div>
				</button>
			</div>

			<div class="filter-facility">
				<div class="line"></div>
				<div class="text-wrapper-2">시설</div>
				<button class="filter-btn comfyseat badge badge-lg filterButton">
					<div class="text-wrapper">편한좌석</div>
				</button>
				<button class="filter-btn-14 photozone badge badge-lg filterButton">
					<div class="text-wrapper">포토존</div>
				</button>
				<button class="filter-btn-1 rent badge badge-lg filterButton">
					<div class="text-wrapper">대관</div>
				</button>
				<button class="filter-btn-2 socket badge badge-lg filterButton">
					<div class="text-wrapper">콘센트</div>
				</button>
				<button class="filter-btn-3 terrace badge badge-lg filterButton">
					<div class="text-wrapper">테라스</div>
				</button>
				<button class="filter-btn-4 pet badge badge-lg filterButton">
					<div class="text-wrapper">반려동물</div>
				</button>
				<button class="filter-btn-5 parking badge badge-lg filterButton">
					<div class="text-wrapper">주차</div>
				</button>
				<button class="filter-btn-6 selectall badge badge-l filterButton">
					<div class="text-wrapper">전체</div>
				</button>
			</div>

		</div>
	</section>

	<!-- 검색결과 -->
	<section class="search-result" id="search-result"></section>

</section>

<!-- 리스트 더보기 -->
<div class="pagination flex justify-center mt-3" style="margin-top: 50px; margin-left: 200px;"></div>



<%@ include file="../common/foot.jspf"%>