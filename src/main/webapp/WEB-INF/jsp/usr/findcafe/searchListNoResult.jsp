<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="카페 찾기"></c:set>

<%@ include file="../common/head.jspf"%>

<!-- 페이지제목 -->
<div class="page-title">
	<div class="text-wrapper result">카페 찾기</div>
</div>


<!-- 카페 검색결과 페이지  -->
<section class="find-cafe">

	<!-- 필터바 -->
	<section class="filter-bar">

		<div class="search-filter">

			<div class="text-wrapper-3">필터</div>

			<div class="filter-selectall">
				<button class="selectall-btn badge badge-lg">
					<div class="text-wrapper">전체해제</div>
				</button>
				<div class="line"></div>
			</div>

			<div class="filter-area">
				<div class="line"></div>
				<div class="text-wrapper-2 filter-title">지역</div>
				<button class="filter-btn-1 daedukgu badge badge-lg">
					<div class="text-wrapper">대덕구</div>
				</button>
				<button class="filter-btn-2 yuseonggu badge badge-lg">
					<div class="text-wrapper">유성구</div>
				</button>
				<button class="filter-btn-3 donggu badge badge-l">
					<div class="text-wrapper">동구</div>
				</button>
				<button class="filter-btn-4 joongu badge badge-l">
					<div class="text-wrapper">중구</div>
				</button>
				<button class="filter-btn-5 seogu badge badge-l">
					<div class="text-wrapper">서구</div>
				</button>
				<button class="filter-btn-6 selectall badge badge-l">
					<div class="text-wrapper">전체</div>
				</button>
			</div>

			<div class="filter-theme">
				<div class="line"></div>
				<div class="text-wrapper-2 filter-title">분위기</div>
				<button class="filter-btn classic badge badge-l">
					<div class="text-wrapper">클래식</div>
				</button>
				<button class="filter-btn-1 cozy badge badge-lg">
					<div class="text-wrapper">아늑한</div>
				</button>
				<button class="filter-btn-2 natural badge badge-lg">
					<div class="text-wrapper">내추럴</div>
				</button>
				<button class="filter-btn-3 simple badge badge-lg">
					<div class="text-wrapper">심플</div>
				</button>
				<button class="filter-btn-4 modern badge badge-lg">
					<div class="text-wrapper">모던</div>
				</button>
				<button class="filter-btn-5 wide badge badge-lg">
					<div class="text-wrapper">넓은</div>
				</button>
				<button class="filter-btn-6 selectall badge badge-lg">
					<div class="text-wrapper">전체</div>
				</button>
				<button class="filter-btn-7 photomatzip badge badge-l">
					<div class="text-wrapper">사진맛집</div>
				</button>
				<button class="filter-btn-8 viewmatzip badge badge-l">
					<div class="text-wrapper">뷰맛집</div>
				</button>
				<button class="filter-btn-9 study badge badge-l">
					<div class="text-wrapper">업무/공부</div>
				</button>
				<button class="filter-btn-10 dating badge badge-l">
					<div class="text-wrapper">데이트</div>
				</button>
				<button class="filter-btn-11 group badge badge-l">
					<div class="text-wrapper">단체</div>
				</button>
				<button class="filter-btn-12 conversation badge badge-l">
					<div class="text-wrapper">대화</div>
				</button>
				<button class="filter-btn-13 cute badge badge-l">
					<div class="text-wrapper">아기자기</div>
				</button>
				<button class="filter-btn-14 retro badge badge-l">
					<div class="text-wrapper">레트로</div>
				</button>
			</div>

			<div class="filter-facility">
				<div class="line"></div>
				<div class="text-wrapper-2">시설</div>
				<button class="filter-btn comfyseat badge badge-lg">
					<div class="text-wrapper">편한좌석</div>
				</button>
				<button class="filter-btn-14 photozone badge badge-lg">
					<div class="text-wrapper">포토존</div>
				</button>
				<button class="filter-btn-1 rent badge badge-lg">
					<div class="text-wrapper">대관</div>
				</button>
				<div class="filter-btn-2 socket badge badge-lg">
					<div class="text-wrapper">콘센트</div>
				</div>
				<button class="filter-btn-3 terrace badge badge-lg">
					<div class="text-wrapper">테라스</div>
					<button>
						<div class="filter-btn-4 pet badge badge-lg">
							<div class="text-wrapper">반려동물</div>
						</div>
						<button class="filter-btn-5 parking badge badge-lg">
							<div class="text-wrapper">주차</div>
						</button>
						<button class="filter-btn-6 selectall badge badge-l">
							<div class="text-wrapper">전체</div>
						</button>
			</div>

		</div>
	</section>


	<!-- 검색결과 -->

	<section class="search-result">
		<div class="show-result-by">
			<div class="text-wrapper">전체보기</div>
		</div>
<br><br><br><br>
		<div class="result" style ="color:#868786; font-size: 18px;font-weight: 800px; text-align:center; margin-top: 16px;">해당 키워드로 검색 된 검색결과가 없습니다 ☕</div>
	</section>
</section>





<!-- 페이지제목 css -->

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
</style>

<!-- 필터 css -->
<style>
.search-filter {
	position: absolute;
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
	margin-left: 430px;
		height: 700px;
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
	top: 0px;
	font-family: "Pretendard";
	font-weight: 600;
	color: #000000;
	font-size: 10px;
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




<%@ include file="../common/foot.jspf"%>