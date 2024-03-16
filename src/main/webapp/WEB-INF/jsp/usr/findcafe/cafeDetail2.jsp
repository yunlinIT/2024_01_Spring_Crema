<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="카페 상세보기"></c:set>
<%@ include file="../common/head.jspf"%>






<div class="cafe-detail-page">

	<div class="cafe-detail-page">
		<div class="detail-imgs">
			<div class="cafe-img-box-big li">
				<a
					href="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_195%2F1704272884978ICiRw_JPEG%2FIMG_5251.jpeg">
					<img class="big-img"
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240103_195%2F1704272884978ICiRw_JPEG%2FIMG_5251.jpeg"
						alt="이미지1" />
				</a>
			</div>
			<div class="cafe-img-box1 li">
				<a
					href="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230827_60%2F1693138311417unuel_JPEG%2FKakaoTalk_20230827_210945131_05.jpg">
					<img class="sm-img1"
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230827_60%2F1693138311417unuel_JPEG%2FKakaoTalk_20230827_210945131_05.jpg
						alt=" 이미지2" />
				</a>
			</div>
			<div class="cafe-img-box2 li">
				<a
					href="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231124_5%2F1700804165871ysxEr_JPEG%2FIMG_4819.jpeg">
					<img class="sm-img2"
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231124_5%2F1700804165871ysxEr_JPEG%2FIMG_4819.jpeg"
						alt="이미지3" />
				</a>
			</div>
			<div class="cafe-img-box3 li">
				<a
					href="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231116_176%2F17000645900099ILlk_JPEG%2F1F8F17A6-BA64-451E-99D8-F02979F38561.jpeg">
					<img class="sm-img3"
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20231116_176%2F17000645900099ILlk_JPEG%2F1F8F17A6-BA64-451E-99D8-F02979F38561.jpeg"
						alt="이미지4" />
				</a>
			</div>
			<div class="cafe-img-box4 li">
				<a
					href="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230827_57%2F1693138302167NjXBQ_JPEG%2FKakaoTalk_20230827_210945131_01.jpg">
					<img class="sm-img4"
						src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230827_57%2F1693138302167NjXBQ_JPEG%2FKakaoTalk_20230827_210945131_01.jpg"
						alt="이미지5" />
				</a>
			</div>
		</div>



	</div>
	<!-- 사진 아래 부분 -->
	<div class="info-and-review section-under-imgs">
		<!-- 카페 정보 -->
		<div class="cafe-info">
			<div class="cafe-name">빈이어</div>
			<p class="cafe-address">대전 서구 계룡로 399 2층</p>
			<div class="cafe-time">매일 12:00 - 22:00</div>
			<div class="cafe-phone">0507-1335-1396</div>
			<p class="cafe-facility">무선 인터넷, 포장, 반려동물 동반, 배달</p>
			<div class="like-count">
				<span class="material-symbols-outlined heart"> favorite </span>
				<div class="like-count-num">2</div>
			</div>
			<div class="review-count">
				<div class="review-badge">리뷰</div>
				<div class="review-count-num">3</div>
			</div>

			<span class="material-symbols-outlined clock-circle" style="color: #a9a9a9"> schedule </span>
			<span class="material-symbols-outlined phone" style="color: #a9a9a9"> call </span>
			<span class="material-symbols-outlined store" style="color: #a9a9a9"> storefront </span>

			<p class="hashtag">#모던 #아늑한 #디저트맛집 #데이트 #반려동물동반</p>
		</div>
		<!-- 카페 지도 -->
		<div class="cafe-map">
			<img class="map-img" src="/" />
			<div class="map-title">지도보기</div>
		</div>

		<!-- 카페정보 하단 -->
		<div class="review-group reviewlist-and-write">
			<!-- 리뷰 부분 -->
			<div class="review-section">
				<!-- 리뷰 작성 -->

				<div class="write-review-section">
					<div class="write-review">리뷰 작성</div>
					<div class="review-input-area">
						<input type="text" placeholder="리뷰를 남겨주세요" class="review-input-box input input-bordered input-md w-full " />
						<button class="review-write-btn btn btn-sm">등록</button>
					</div>
				</div>
				<!-- 리뷰 목록 -->
				<div class="review-list">
					<div class="review-title">리뷰</div>

					<div class="show-review-box">
						<div class="user-nickname">crema_user2</div>
						<p class="review-body">맛있어요!</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="slide-overlay">
	<button class="close-btn">
		<span class="material-symbols-outlined close"> close </span>
	</button>
	<button class="slide-btn --prev">
		<span class="material-symbols-outlined left "> chevron_left </span>
	</button>
	<button class="slide-btn --next">
		<span class="material-symbols-outlined right"> chevron_right </span>
	</button>
	<div class="slide__container">
		<ul class="slides">
			<li>
				<img src="" alt="이미지1">
			</li>
			<li>
				<img src="" alt="이미지2">
			</li>
			<li>
				<img src="" alt="이미지3">
			</li>
			<li>
				<img src="" alt="이미지4">
			</li>
			<li>
				<img src="" alt="이미지5">
			</li>
		</ul>
	</div>
</div>



<style>
/* 슬라이드 팝업창 */
.slide-overlay {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(0, 0, 0, 0.8);
	display: none;
	z-index: 999; /* 다른 요소 위에 보이도록 설정 */
}

.slide__container {
	position: absolute;
	height: 100%; /* 이미지에 맞게 자동 조정되도록 변경 */
 	max-width: 80%; /* 최대 너비 설정 */ 
 	max-height: 70%; /* 최대 높이 설정 */ 
	top: 50%;
	left: 50%;
 	transform: translate(-50%, -45%); 
	overflow: hidden;
	
}

.slide__container>img {
	position: absolute;
	left: 50%;
	transform: translate(-50%, -50%);
	max-width: 100%; /* 이미지의 원본 비율을 유지하면서 이미지의 더 긴쪽에 맞춤 */
	max-height: 100%; /* 이미지의 원본 비율을 유지하면서 이미지의 더 긴쪽에 맞춤 */
}

.slides {
	display: flex; /* Flexbox를 사용하여 이미지를 가로로 나열 */
	justify-content: center;
}

.slides>li {
	flex: 0 0 auto; /* Flex 아이템이 컨테이너 크기에 맞게 자동으로 크기 조정 */
	list-style: none; /* 목록 마커 제거 */
	margin-right:; /* 이미지 간격 조정 */
	display: none; /* 이미지 간격 없애고 숨김 */
}

.slides>li:first-child {
	display: block; /* 첫 번째 이미지만 보이도록 설정 */
}

/*------------- 요기부터 수정 하지마~-------------*/
.slide-btn {
	color: white;
	font-size: 200px;
	font-weight: 800;
	position: absolute;
	width: 50px;
	height: 50px;
	border-radius: 50%;
	border: none;
	background-color: transparent;
	cursor: pointer;
	top: 50%;
	transform: translateY(-50%);
	z-index: 999; /* 다른 요소 위에 보이도록 설정 */
}

.--prev {
	left: 20%;
}

.--next {
	right: 20%;
	
}

 .close { 
	text-align: center; 
	font-size: 50px;
 }
 
 .left, .right { 
	text-align: center; 
	font-size: 60px;
 }
 
 

.close-btn {

	right: 20%;
	color: white;
	font-weight: 600;
	position: absolute;
/*  	width: 50px;  */
/*  	height: 50px;  */
/*  	border-radius: 50%;  */
/*  	border: none;  */
	background-color: transparent;
	cursor: pointer;
	top: 15%;
	transform: translateY(-50%);
	z-index: 999; /* 다른 요소 위에 보이도록 설정 */
}

#bullets {
	position: absolute;
	bottom: 3%;
	left: 50%;
	transform: translateX(-50%);
}

#bullets>li {
	float: left;
	margin: 0 8px;
	list-style: none; /* 목록 마커 제거 */
}

#bullets>li>a {
	display: block;
	text-decoration: none;
	color: transparent;
	width: 1em;
	height: 1em;
	background-color: rgb(165, 165, 165);
	border-radius: 50%;
	transition: 0.2s;
}

#bullets>li>a.on {
	background-color: white;
}

/* -----------------여기는 기본 레이아웃------------------------- */
.cafe-detail-page {
	margin: 0 auto; /* 화면 좌우 가운데 정렬 */
	/* 그 외의 스타일 속성들 */
}

.cafe-detail-page {
	background-color: #ffffff;
	display: flex;
	flex-direction: row;
	justify-content: center;
	margin-top: 80px;
	/* 	width: 100%; */
}

.cafe-detail-page {
	background-color: #ffffff;
	width: 1155px;
	height: 1024px;
	position: relative;
}

/* .cafe-detail-page .detail-section { */
/* 	position: absolute; */
/* 	width: 1287px; */
/* 	height: 908px; */
/* 	top: 116px; */
/* 	left: 78px; */
/* 	background-color: #ffffff; */
/* 	overflow: hidden; */
/* 	overflow-y: scroll; */
/* } */
.cafe-detail-page .section-under-imgs {
	position: absolute;
	width: 1160px;
	height: 1130px;
	top: 508px;
	/* 	left: 60px; */
}

.cafe-detail-page .review-group {
	position: absolute;
	width: 1155px;
	height: 1120px;
	top: 10px;
	left: 5px;
}

.cafe-detail-page .review-section {
	position: absolute;
	width: 1155px;
	height: 811px;
	top: 309px;
	left: 0;
	overflow: hidden;
}

.cafe-detail-page .review-box {
	position: absolute;
	width: 1155px;
	height: 130px;
	top: 401px;
	left: 0;
	background-color: #f5f5f5;
	border-radius: 10px;
}

.cafe-detail-page .user-nickname {
	position: absolute;
	width: 207px;
	height: 32px;
	top: 10px;
	left: 17px;
	font-weight: 600;
	color: #333333;
	font-size: 18px;
	letter-spacing: 0;
	line-height: normal;
}

.cafe-detail-page .review-body {
	position: absolute;
	width: 1084px;
	height: 70px;
	top: 47px;
	left: 17px;
	font-weight: 500;
	color: #333333;
	font-size: 15px;
	letter-spacing: 0;
	line-height: 20px;
}

.cafe-detail-page .review-list {
	position: absolute;
	width: 1155px;
	height: 531px;
	top: 223px;
	left: 0;
}

.cafe-detail-page .review-box-2 {
	top: 0;
	position: absolute;
	width: 1155px;
	height: 130px;
	left: 0;
	background-color: #f5f5f5;
	border-radius: 10px;
}

.cafe-detail-page .text-wrapper {
	all: unset;
	box-sizing: border-box;
	width: 30px;
	top: 12px;
	left: 135px;
	color: #6d6d6d;
	position: absolute;
	height: 32px;
	font-weight: 600;
	font-size: 12px;
	text-align: center;
	letter-spacing: 0;
	line-height: normal;
}

.cafe-detail-page .show-review-box {
	top: 53px;
	position: absolute;
	width: 1155px;
	height: 130px;
	left: 0;
	background-color: #f5f5f5;
	border-radius: 10px;
}

.cafe-detail-page .review-title {
	width: 814px;
	height: 39px;
	top: -1px;
	left: 2px;
	font-weight: 600;
	color: #222222;
	font-size: 24px;
	letter-spacing: 0;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .write-review-section {
	width: 1171px;
	height: 129px;
	top: 59px;
	position: absolute;
	left: 0;
}

.cafe-detail-page .review-input-box {
	position: relative;
	width: 1148px;
	height: 83px;
	top: 0;
	left: 4px;
	background-color: #ffffff;
	border-radius: 10px;
	border: 1px solid;
	border-color: #d9d9d9;
}

.cafe-detail-page .review-write-btn {
	margin-top: 10px;
	margin-left: 4px;
}

.cafe-detail-page .placeholder {
	width: 243px;
	height: 43px;
	top: 5px;
	left: 16px;
	font-weight: 400;
	color: #a8a8a8;
	font-size: 15px;
	letter-spacing: 0;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .write-review {
	width: 814px;
	height: 39px;
	top: -54px;
	left: 2px;
	font-weight: 600;
	color: #222222;
	font-size: 24px;
	letter-spacing: 0;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .cafe-map {
	width: 525px;
	height: 323px;
	left: 627px;
	position: absolute;
	top: 0;
}

.cafe-detail-page .map-img {
	position: absolute;
	width: 397px;
	height: 235px;
	top: 47px;
	left: 36px;
	object-fit: cover;
	background-color: #a9a9a9;
}

.cafe-detail-page .map-title {
	width: 269px;
	height: 28px;
	top: 16px;
	left: 50px;
	font-weight: 600;
	color: #222222;
	font-size: 20px;
	letter-spacing: 0;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .cafe-info {
	width: 621px;
	height: 309px;
	left: 0;
	overflow: hidden;
	position: absolute;
	top: 0;
}

.cafe-detail-page .cafe-name {
	width: 814px;
	height: 39px;
	top: 10px;
	left: 6px;
	font-weight: 600;
	color: #222222;
	font-size: 32px;
	letter-spacing: 0;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .cafe-address {
	width: 796px;
	height: 17px;
	top: 60px;
	left: 6px;
	font-weight: 600;
	color: #666666;
	font-size: 16px;
	letter-spacing: 0;
	white-space: nowrap;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .cafe-time {
	width: 796px;
	height: 17px;
	top: 173px;
	left: 44px;
	font-weight: 500;
	color: #333333;
	font-size: 16px;
	letter-spacing: 0;
	white-space: nowrap;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .cafe-phone {
	position: absolute;
	width: 796px;
	height: 17px;
	top: 219px;
	left: 44px;
	font-weight: 500;
	color: #333333;
	font-size: 16px;
	letter-spacing: 0;
	line-height: normal;
	white-space: nowrap;
}

.cafe-detail-page .cafe-facility {
	width: 796px;
	height: 17px;
	top: 265px;
	left: 44px;
	font-weight: 500;
	color: #333333;
	font-size: 16px;
	letter-spacing: 0;
	white-space: nowrap;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .like-count {
	position: absolute;
	width: 63px;
	height: 21px;
	top: 100px;
	left: 7px;
}

.cafe-detail-page .heart {
	position: absolute;
	color: red;
	font-size: 20px;
	top: 1px;
}

.cafe-detail-page .like-count-num {
	left: 23px;
	position: absolute;
	width: 20px;
	height: 15px;
	top: 2px;
	font-weight: 500;
	color: #000000;
	font-size: 16px;
	letter-spacing: 0;
	line-height: normal;
	white-space: nowrap;
}

.cafe-detail-page .review-count {
	position: absolute;
	width: 63px;
	height: 21px;
	top: 100px;
	left: 78px;
}

.cafe-detail-page .review-badge {
	width: 30px;
	height: 15px;
	top: 2px;
	left: 1px;
	font-weight: 500;
	color: #000000;
	font-size: 16px;
	letter-spacing: 0;
	white-space: nowrap;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .review-count-num {
	left: 34px;
	position: absolute;
	width: 20px;
	height: 15px;
	top: 2px;
	font-weight: 500;
	color: #000000;
	font-size: 16px;
	letter-spacing: 0;
	line-height: normal;
	white-space: nowrap;
}

.cafe-detail-page .clock-circle {
	position: absolute;
	width: 24px;
	height: 24px;
	top: 171px;
	left: 6px;
}

.cafe-detail-page .phone {
	position: absolute;
	width: 24px;
	height: 24px;
	top: 217px;
	left: 6px;
}

.cafe-detail-page .store {
	position: absolute;
	width: 24px;
	height: 24px;
	top: 263px;
	left: 6px;
}

.cafe-detail-page .hashtag {
	width: 500x;
	height: 15px;
	top: 136px;
	left: 7px;
	font-weight: 500;
	color: #333333;
	font-size: 13px;
	letter-spacing: 0;
	position: absolute;
	line-height: normal;
}

.cafe-detail-page .detail-imgs {
	position: absolute;
	width: 1149px;
	height: 466px;
	top: -60px;
	overflow: hidden;
	background-color: white;
}

.cafe-detail-page .sm-img4 {
	position: absolute;
	width: 261px;
	height: 229px;
	top: 237px;
	left: 889px;
}

.cafe-detail-page .sm-img3 {
	position: absolute;
	width: 261px;
	height: 230px;
	top: 0;
	left: 889px;
	object-fit: cover;
}

.cafe-detail-page .sm-img2 {
	position: absolute;
	width: 261px;
	height: 229px;
	top: 237px;
	left: 621px;
	object-fit: cover;
}

.cafe-detail-page .sm-img1 {
	position: absolute;
	width: 261px;
	height: 230px;
	top: 0;
	left: 621px;
}

/* 제일 큰 사진 */
.cafe-detail-page .big-img {
	position: absolute;
	width: 614px;
	height: 466px;
	top: 0;
	left: 0;
	object-fit: cover;
}
</style>

<script>


const overlay = document.querySelector(".slide-overlay");
const slides = document.querySelectorAll(".slides > li > img");
const thumbnails = document.querySelectorAll(
  ".cafe-detail-page .detail-imgs .li img"
);
const photoCount = slides.length;
const duration = 400;
let bullets = 0;
let photoIndex = 0;

thumbnails.forEach((thumbnail, index) => {
  thumbnail.addEventListener("click", (e) => {
    e.preventDefault();
    overlay.style.display = "block";
    photoIndex = index;
    setCurrentSlide(photoIndex);
  });
});

document.querySelector(".close-btn").addEventListener("click", () => {
  overlay.style.display = "none";
});

function setCurrentSlide(index) {
  slides.forEach((slide, i) => {
    slide.src = thumbnails[(index + i) % thumbnails.length].src;
  });
}

function createBullets() {
  const bulletsList = document.createElement("ul");
  bulletsList.setAttribute("id", "bullets");
  overlay.appendChild(bulletsList);
  slides.forEach((slide, index) => {
    const a = document.createElement("a");
    a.setAttribute("href", "#");
    a.innerHTML = `${index}`;
    const li = document.createElement("li");
    li.appendChild(a);
    bulletsList.appendChild(li);
  });
  return (bullets = document.querySelectorAll("#bullets > li > a"));
}
createBullets();
bulletLink();

function bulletLink() {
  bullets.forEach((bullet, index) => {
    bullet.addEventListener("click", (e) => {
      e.preventDefault();
      const clickedIndex = index;
      let step = clickedIndex - photoIndex;
      photoIndex = clickedIndex;
      bulletClassReset();
      bullets[clickedIndex].classList.add("on");
      slides.forEach((slide, i) => {
        slide.src = thumbnails[(photoIndex + i) % thumbnails.length].src;
      });
    });
  });
}

thumbnails.forEach((thumbnail, index) => {
  thumbnail.addEventListener("click", (e) => {
    e.preventDefault();
    const clickedIndex = index;
    photoIndex = clickedIndex;
    bulletClassReset();
    bullets[clickedIndex].classList.add("on");
    slides.forEach((slide, i) => {
      slide.src = thumbnails[(photoIndex + i) % thumbnails.length].src;
    });
  });
});

document.querySelector(".--next").addEventListener("click", nextSlideImage);
document.querySelector(".--prev").addEventListener("click", prevSlideImage);

function nextSlideImage() {
  photoIndex++;
  photoIndex %= photoCount;
  bulletClassReset();
  bullets[photoIndex].classList.add("on");
  slides.forEach((slide, i) => {
    slide.src = thumbnails[(photoIndex + i) % thumbnails.length].src;
  });
}

function prevSlideImage() {
  photoIndex--;
  if (photoIndex < 0) {
    photoIndex = photoCount - 1;
  }
  bulletClassReset();
  bullets[photoIndex].classList.add("on");
  slides.forEach((slide, i) => {
    slide.src = thumbnails[(photoIndex + i) % thumbnails.length].src;
  });
}

function bulletClassReset() {
  bullets.forEach((bullet) => {
    bullet.classList.remove("on");
  });
}


</script>




<%@ include file="../common/foot.jspf"%>