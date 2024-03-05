<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="나의 찜 목록"></c:set>

<%@ include file="../common/head.jspf"%>

<!-- 페이지제목 -->
<div class="page-title">
	<div class="result">'${rq.loginedMember.nickname }'님의 찜한 카페 보기 <span class="material-symbols-outlined heart title-heart" >
favorite
</span></div>
</div>

<style>
.heart {
color: #eb4034;
font-size: 25px;
  font-variation-settings:
  'FILL' 1,
  'wght' 400,
  'GRAD' 0,
  'opsz' 30
}


</style>

<!-- 찜 한 카페 페이지  -->
<section class="like-cafe">

	<!-- 찜한 카페목록 -->

	<section class="like-list">
		<div class="show-like-list-by">
		</div>

		<a href="cafeDetail" class="linkbox１">
			<div class="content-info-box content-1">
				<div class="cafe-img-box">
					<img
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_195%2F1704272884978ICiRw_JPEG%2FIMG_5251.jpeg"
						alt="카페 이미지" />
				</div>
				<div class="name-address">
					<div class="cafe-name">빈이어</div>
					<p class="cafe-address">대전 서구 계룡로 399 2층</p>
				</div>

				<div class="like-count">
					<span class="material-symbols-outlined heart"> favorite </span>
					<div class="like-count-num">0</div>
				</div>

				<div class="review-count">
					<div class="title-review">리뷰</div>
					<div class="review-count-num">0</div>
				</div>

				<div class="show-distance">
					<div class="num-km-group">
						<div class="km">km</div>
						<div class="distance-num">8.2</div>
					</div>
				</div>
				<div class="hashtag">#모던 #아늑한 #디저트맛집 #반려동물동반 #데이트</div>
			</div>
		</a>

		<a href="cafeDetail" class="linkbox１">
			<div class="content-info-box content-2" style="top: 50px;">
				<div class="cafe-img-box">
					<img
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_195%2F1704272884978ICiRw_JPEG%2FIMG_5251.jpeg"
						alt="카페 이미지" />
				</div>
				<div class="name-address">
					<div class="cafe-name">빈이어</div>
					<p class="cafe-address">대전 서구 계룡로 399 2층</p>
				</div>

				<div class="like-count">
					<span class="material-symbols-outlined heart"> favorite </span>
					<div class="like-count-num">0</div>
				</div>

				<div class="review-count">
					<div class="title-review">리뷰</div>
					<div class="review-count-num">0</div>
				</div>

				<div class="show-distance">
					<div class="num-km-group">
						<div class="km">km</div>
						<div class="distance-num">8.2</div>
					</div>
				</div>
				<div class="hashtag">#모던 #아늑한 #디저트맛집 #반려동물동반 #데이트</div>
			</div>
		</a>

		<a href="cafeDetail" class="linkbox１">
			<div class="content-info-box content-3" style="top: 100px;">
				<div class="cafe-img-box">
					<img
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_195%2F1704272884978ICiRw_JPEG%2FIMG_5251.jpeg"
						alt="카페 이미지" />
				</div>
				<div class="name-address">
					<div class="cafe-name">빈이어</div>
					<p class="cafe-address">대전 서구 계룡로 399 2층</p>
				</div>

				<div class="like-count">
					<span class="material-symbols-outlined heart"> favorite </span>
					<div class="like-count-num">0</div>
				</div>

				<div class="review-count">
					<div class="title-review">리뷰</div>
					<div class="review-count-num">0</div>
				</div>

				<div class="show-distance">
					<div class="num-km-group">
						<div class="km">km</div>
						<div class="distance-num">8.2</div>
					</div>
				</div>
				<div class="hashtag">#모던 #아늑한 #디저트맛집 #반려동물동반 #데이트</div>
			</div>
		</a>

		<a href="cafeDetail" class="linkbox１">
			<div class="content-info-box content-4" style="top: 150px;">
				<div class="cafe-img-box">
					<img
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_195%2F1704272884978ICiRw_JPEG%2FIMG_5251.jpeg"
						alt="카페 이미지" />
				</div>
				<div class="name-address">
					<div class="cafe-name">빈이어</div>
					<p class="cafe-address">대전 서구 계룡로 399 2층</p>
				</div>

				<div class="like-count">
					<span class="material-symbols-outlined heart"> favorite </span>
					<div class="like-count-num">0</div>
				</div>

				<div class="review-count">
					<div class="title-review">리뷰</div>
					<div class="review-count-num">0</div>
				</div>

				<div class="show-distance">
					<div class="num-km-group">
						<div class="km">km</div>
						<div class="distance-num">8.2</div>
					</div>
				</div>
				<div class="hashtag">#모던 #아늑한 #디저트맛집 #반려동물동반 #데이트</div>
			</div>
		</a>

		<a href="cafeDetail" class="linkbox１">
			<div class="content-info-box content-5" style="top: 200px;">
				<div class="cafe-img-box">
					<img
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_195%2F1704272884978ICiRw_JPEG%2FIMG_5251.jpeg"
						alt="카페 이미지" />
				</div>
				<div class="name-address">
					<div class="cafe-name">빈이어</div>
					<p class="cafe-address">대전 서구 계룡로 399 2층</p>
				</div>

				<div class="like-count">
					<span class="material-symbols-outlined heart"> favorite </span>
					<div class="like-count-num">0</div>
				</div>

				<div class="review-count">
					<div class="title-review">리뷰</div>
					<div class="review-count-num">0</div>
				</div>

				<div class="show-distance">
					<div class="num-km-group">
						<div class="km">km</div>
						<div class="distance-num">8.2</div>
					</div>
				</div>
				<div class="hashtag">#모던 #아늑한 #디저트맛집 #반려동물동반 #데이트</div>
			</div>
		</a>

		<a href="cafeDetail" class="linkbox１">
			<div class="content-info-box content-6" style="top: 250px;">
				<div class="cafe-img-box">
					<img
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_195%2F1704272884978ICiRw_JPEG%2FIMG_5251.jpeg"
						alt="카페 이미지" />
				</div>
				<div class="name-address">
					<div class="cafe-name">빈이어</div>
					<p class="cafe-address">대전 서구 계룡로 399 2층</p>
				</div>

				<div class="like-count">
					<span class="material-symbols-outlined heart"> favorite </span>
					<div class="like-count-num">0</div>
				</div>

				<div class="review-count">
					<div class="title-review">리뷰</div>
					<div class="review-count-num">0</div>
				</div>

				<div class="show-distance">
					<div class="num-km-group">
						<div class="km">km</div>
						<div class="distance-num">8.2</div>
					</div>
				</div>
				<div class="hashtag">#모던 #아늑한 #디저트맛집 #반려동물동반 #데이트</div>
			</div>
		</a>

	</section>
</section>





<!-- 페이지제목 css -->

<style>
.page-title {
	position: relative;
	top: 100px;
	text-align: center; font-family : "Pretendard";
	font-weight: 600;
	font-family: "Pretendard"; font-weight : 600;
	font-size: 30px;
}

/* 카페검색결과 */
.like-cafe {
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

.search-filter .result {
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

</style>


<!-- 검색결과 css -->

<style>
.like-list {
	position: relative;
/* 	margin-left: 430px; */
}

.show-like-list-by {
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

.show-like-list-by .result {
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

.like-count .heart {
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