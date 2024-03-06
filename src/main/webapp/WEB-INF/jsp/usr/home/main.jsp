<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value=""></c:set>
<%@ include file="../common/mainHead.jspf"%>



<script>
    // 스크롤 이벤트 리스너 등록
    window.addEventListener('scroll', function() {
        // 스크롤된 양 계산
        var scroll = window.scrollY;
        
        // 배경 이미지 요소 선택
        var backgroundImage = document.querySelector('.background-image');
        
        // 배경 이미지 크기를 동적으로 조절
        backgroundImage.style.backgroundSize = 100 + scroll / 5 + '%';
    });
    

    
</script>






<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Main Page</title>
<style>
/* 배경 이미지 스타일 설정 */
.background-image {
	/* 배경 이미지 URL 지정 */
	background-image:
		url('https://velog.velcdn.com/images/yunlinit/post/19af9bf9-7b10-4c41-abaf-7af2ac3991d4/image.jpg');
	/* 이미지를 가득 채우도록 설정 */
	background-size: cover;
	/* 이미지가 반복되지 않도록 설정 */
	background-repeat: no-repeat;
	/* 이미지의 위치를 가운데 정렬 */
	background-position: center;
	/* 선택적으로 이미지에 대한 기타 스타일을 지정할 수 있습니다. */
	/* 페이지의 전체 높이를 이미지의 높이와 동일하게 설정하여 스크롤이 가능하도록 합니다. */
	height: 100vh;
	/* overflow를 숨겨서 스크롤이 생기지 않도록 합니다. */
	overflow: auto;
	/* 배경 이미지 아래쪽에 간격 추가 */
	margin-bottom: 235px;
	/* 조절하고 싶은 간격(px)을 지정하세요. */
}

.Main1 {
	position: relative;
	width: 100%;
	height: 100%;
}

.CrMa, .ForTheBestCoffeeMoments, .MyCafeFinder {
	color: white;
	text-align: center;
	word-wrap: break-word;
	opacity: 0; /* 처음에는 투명하게 설정 */
	transition: opacity 3s ease; /* 투명도 변화에 애니메이션 적용 */
}

.CrMa {
	font-size: 220px;
/* 	font-family: Bavarian; */
	font-weight: 400;
	position: absolute;
	top: 300px;
	left: 50%;
	transform: translateX(-50%);
}




.Vector {
	font-size: 25px;
	font-family: Gill Sans MT;
	font-weight: 1000;
	color: white;
	letter-spacing: 3.20px;
	position: absolute;
	top: 705px;
	left: 50%;
	transform: translateX(-50%) rotate(90deg);
}

.ForTheBestCoffeeMoments {
	font-size: 16px;
	font-family: Cantarell;
	font-weight: 400;
	letter-spacing: 3.20px;
	position: absolute;
	top: 569px;
	left: 50%;
	transform: translateX(-50%);
}

.MyCafeFinder {
	font-size: 32px;
 font-family: "Julius Sans One", sans-serif;
/* 	font-weight: 500; */
	letter-spacing: 6.40px;
	position: absolute;
	top: 214px;
	left: 50%;
	transform: translateX(-50%);
}
</style>
</head>

<body>

	<div class="background-image">
		<div class="Main1">
			<div class="Vector">〉〉</div>
			<div class="CrMa"><img src="https://velog.velcdn.com/images/yunlinit/post/29de0688-d442-4346-8d16-16101822b4b3/image.png" alt="Crèma" /></div>
			<div class="ForTheBestCoffeeMoments">FOR THE BEST COFFEE MOMENTS</div>
			<div class="MyCafeFinder">MY CAFE FINDER</div>
		</div>
	</div>

	<script>
    // 요소들이 화면에 나타나는 시점을 계산하는 함수
    function appearOnScroll() {
      var vector = document.querySelector('.Vector');
      var crma = document.querySelector('.CrMa');
      var coffeeMoments = document.querySelector('.ForTheBestCoffeeMoments');
      var cafeFinder = document.querySelector('.MyCafeFinder');

      var vectorDelay = vector.getBoundingClientRect().top - window.innerHeight;
      var crmaDelay = crma.getBoundingClientRect().top - window.innerHeight;
      var coffeeMomentsDelay = coffeeMoments.getBoundingClientRect().top - window.innerHeight;
      var cafeFinderDelay = cafeFinder.getBoundingClientRect().top - window.innerHeight;

      // 투명도를 0에서 1로 변경하여 나타나게 함
      if (vectorDelay < 0) setTimeout(() => vector.style.opacity = 0.9, 150); // 0.15초 지연
      if (crmaDelay < 0) setTimeout(() => crma.style.opacity = 0.9, 100); // 0.15초 지연
      if (coffeeMomentsDelay < 0) setTimeout(() => coffeeMoments.style.opacity = 0.9, 150); // 0.15초 지연
      if (cafeFinderDelay < 0) setTimeout(() => cafeFinder.style.opacity = 0.9, 150); // 0.15초 지연
    }

    // 스크롤 이벤트 리스너 등록
    window.addEventListener('scroll', appearOnScroll);

    // 초기에 한 번 호출하여 초기 화면에서도 적용되게 함
    appearOnScroll();


    
  </script>

</body>

</html>




<!-- 이미지 위로 페이지 내용 추가 -->

</div>
<!-- 이미지 아래 페이지 내용 추가 -->

<!-- 날씨위젯 -->
<div class="weather-widget" style="margin-left: 20px; margin-bottom: 50px; position: relative; ">
    <div id="ww_dd38e1ffbef2c" v='1.3' loc='id'
        a='{"t":"responsive","lang":"ko","sl_lpl":1,"ids":["wl2308"],"font":"Arial","sl_ics":"one_a","sl_sot":"celsius","cl_bkg":"#FFFFFF00","cl_font":"rgba(120,120,120,1)","cl_cloud":"#d4d4d4","cl_persp":"#2196F3","cl_sun":"#FFC107","cl_moon":"#FFC107","cl_thund":"#FF5722","sl_tof":"3","el_wfc":3,"cl_odd":"#00000000"}'
        style="width: 230px;">
        More forecasts:
        <a href="https://oneweather.org/seoul/30_days/" id="ww_dd38e1ffbef2c_u" target="_blank">Weather forecast Seoul
            30days</a>
    </div>
    <script async src="https://app2.weatherwidget.org/js/?id=ww_dd38e1ffbef2c"></script>
</div>

<style>

</style>


<!-- 날씨 테마 섹션 -->
<div class="weather-section mx-auto">
	<div class="recommendation mx-auto">
		<div class="indent">
			<div class="cremaRecommends">
				<span>CREMA<br /></span> <span>RECOMMENDS</span>
			</div>
			<div class="Recommends mx-auto">크레마는 오늘같은 날씨에 가기 좋은 카페를 추천해드려요.</div>
			<div class="weather-comment">바람이 부드럽게 스치는 서늘한 날, 한 모금의 커피 향기가 나를 감싸 안아요.</div>
		</div>
		<div class="weather-img-box">
			<img class="Weather-img"
				src="https://velog.velcdn.com/images/yunlinit/post/3654e399-5a73-4acf-a263-e24167d3871d/image.jpg" />
		</div>

		<div class="search-box">
			<div class="how-about-here">오늘은 이런 카페 어떠세요?</div>

			<label class="search-menu-item input input-bordered flex items-center gap-2 input-xs max-w-xs"> <input
				type="text" class="grow" placeholder="테라스 카페" /> <a href="/">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70">
								<path fill-rule="evenodd"
							d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
							clip-rule="evenodd" /></svg>
				</a>
		</div>
	</div>

</div>

<!-- 날씨테마 CSS -->

<style>
.weather-section {
	width: 100%;
	height: auto;
	background: rgba(232.69, 215.26, 202.63, 0.19);
}

.recommendation {
	width: 100%;
	height: 600px;
	position: relative;
}

.indent {
	padding-left: 100px;
	padding-top: 50px;
}

.cremaRecommends {
	width: 595px;
	height: 20px;
	position: relative;
}

.cremaRecommends span {
	font-size: 70px;
  font-family: "Vidaloka", serif;
	font-weight: 400;
	letter-spacing: 1px;
	word-wrap: break-word;
	color: #66666;
	
	
}

.Recommends {
	color: #6D6D6D;
	font-size: 16px;
	font-family: Pretendard;
	font-weight: 300;
	letter-spacing: 1px;
	word-wrap: break-word;
	position: relative;
	top: 230px;
}

.weather-comment {
	width: 600px;
	height: 53px;
	position: relative;
	/* 	color: #6D6D6D; */
	color: #755a44;
	font-style: italic; font-size : 18px;
	font-family: Pretendard;
	font-weight: 500;
	letter-spacing: 1.5px;
	word-wrap: break-word;
	top: 270px;
	font-size: 18px;
}

.weather-img-box {
	position: absolute;
	top: 0;
	right: 0;
	height: 100%;
}

.Weather-img {
	height: 100%;
}
</style>


<!-- 검색어박스 CSS-->
<style>
.search-box {
	/*   width: 350px; */
	height: 82px;
	top: 75%;
	position: absolute;
	padding-left: 100px;
	z-index: 999;
}

.search-menu-item {
	margin-top: 30px;
}

.how-about-here {
	width: 589px;
	height: 39px;
	/* 	padding-left: 100px; */
	top: 0px;
	position: absolute;
	color: #6D6D6D;
	font-size: 14px;
	font-family: Pretendard;
	font-weight: 500;
	letter-spacing: 1.40px;
	word-wrap: break-word;
}

.line {
	height: 37px;
	padding: 6px 0 6px 1px;
	left: 3px;
	top: 39px;
	position: absolute;
	background: rgba(255, 255, 255, 0);
	justify-content: flex-start;
	align-items: center;
	display: flex; /* 수정된 부분 */
	width: 100%;
}

.input-container {
	width: calc(100% - 50px); /* 수정된 부분 */
	position: relative;
	margin-top: 30px;
}

.input {
	width: 100%;
	height: 43px;
	color: #A9A9A9;
	font-size: 14px;
	font-family: Pretendard;
	font-weight: 400;
	letter-spacing: 1.40px;
	word-wrap: break-word;
	padding-left: 6px;
}

.search-btn {
	width: 50px;
	height: 43px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.search-btn a {
	color: #6D6D6D;
	font-size: 20px;
	font-family: Pretendard;
	font-weight: 500;
	letter-spacing: 1px;
	word-wrap: break-word;
}

.search-btn {
	position: absolute;
	right: 0;
	top: 30;
}
</style>









<!-- 카페추천 박스 -->

<div class="CafeRecom mx-auto">
	<div class="NewCafe">
		<div>크레마 신규 카페</div>
		<div class="hover-img-zoom-in">
			<img class="NewCafeImg"
				src="https://velog.velcdn.com/images/yunlinit/post/5eb36e34-5c06-43ee-bd12-87a687399533/image.png" />
			<div class="InfoBox">
				<div class="name">파티세리러츠</div>
				<div class="address">대전 서구 둔산로74번길 12 1층</div>
			</div>
		</div>
	</div>

	<div class="PopularCafe">
		<div>크레마 인기 카페</div>
		<div class="hover-img-zoom-in">
			<img class="PopularCafeImg"
				src="https://velog.velcdn.com/images/yunlinit/post/15f7855c-973d-46bc-bf54-4b83e7145181/image.png" />
			<div class="InfoBox">
				<div class="name">빈이어</div>
				<div class="address">대전 서구 계룡로 399 2층</div>
			</div>
		</div>
	</div>
	<div class="RecomCafe">
		<div>크레마 추천 카페</div>
		<div class="hover-img-zoom-in">
			<img class="RecomCafeImg"
				src="https://velog.velcdn.com/images/yunlinit/post/c17b45c9-344d-4f29-afdb-2e30e89a24e3/image.jpg" />
			<div class="InfoBox">
				<div class="name">코너</div>
				<div class="address">대전 동구 홍도로46번길 67 101호</div>
			</div>
		</div>
	</div>
</div>

<style>
.CafeRecom {
	width: 1440px;
	height: 1129px;
	position: relative;
	background: white;
	margin: auto;
}

.NewCafe, .PopularCafe, .RecomCafe {
	position: absolute;
	flex-direction: column;
	justify-content: flex-end;
	align-items: flex-start;
	gap: 12px;
	display: inline-flex;
}

.NewCafe, .PopularCafe, .RecomCafe {
	width: 346px;
	left: 131px; /* 수정 필요 */
	top: 240px; /* 수정 필요 */
}

.PopularCafe {
	left: 547px; /* 수정 필요 */
	top: 241px; /* 수정 필요 */
}

.RecomCafe {
	left: 963px; /* 수정 필요 */
	top: 240px; /* 수정 필요 */
}

.NewCafe div, .PopularCafe div, .RecomCafe div {
	width: 100%;
	height: auto;
	color: black;
	font-size: 16px;
	font-family: Pretendard;
	word-wrap: break-word;
}

.InfoBox {
	width: 319px;
	height: 103px;
	left: 54px;
	top: 480px;
	position: absolute;
	background: white;
	border-radius: 20px;
	border: 1px rgba(168.94, 168.94, 168.94, 0.49) solid;
}

.InfoBox div {
	width: 100%;
	height: 50px;
	color: #333333;
	font-family: Pretendard;
	word-wrap: break-word;
	padding-top: 15px;
	padding-left: 15px;
}

.InfoBox .name {
	font-size: 20px;
	font-weight: 600;
}

.InfoBox .address {
	font-size: 14px;
	font-weight: 400;
}

/* hover시 이미지 확대 효과 */
.hover-img-zoom-in img {
	transition: all 0.2s linear;
}

.hover-img-zoom-in:hover img {
	transform: scale(1.1);
}

.hover-img-zoom-in {
	width: 400px;
	margin: 0px auto;
	overflow: hidden;
}
</style>


</div>





<%@ include file="../common/foot.jspf"%>








