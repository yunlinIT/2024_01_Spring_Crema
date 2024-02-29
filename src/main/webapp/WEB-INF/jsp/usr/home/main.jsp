<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value=""></c:set>
<%@ include file="../common/head.jspf"%>




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
      background-image: url('https://velog.velcdn.com/images/yunlinit/post/19af9bf9-7b10-4c41-abaf-7af2ac3991d4/image.jpg');
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

    .Vector,
    .CrMa,
    .ForTheBestCoffeeMoments,
    .MyCafeFinder {
      color: white;
      text-align: center;
      word-wrap: break-word;
      opacity: 0; /* 처음에는 투명하게 설정 */
      transition: opacity 2s ease; /* 투명도 변화에 애니메이션 적용 */
    }

    .Vector {
      font-size: 25px;
      font-family: Gill Sans MT;
      font-weight: 1000;
      letter-spacing: 3.20px;
      position: absolute;
      top: 705px;
      left: 50%;
      transform: translateX(-50%) rotate(90deg);
    }

    .CrMa {
      font-size: 220px;
      font-family: Bavarian;
      font-weight: 400;
      position: absolute;
      top: 240px;
      left: 50%;
      transform: translateX(-50%);
    }

    .ForTheBestCoffeeMoments {
      font-size: 16px;
      font-family: Gill Sans MT;
      font-weight: 400;
      letter-spacing: 3.20px;
      position: absolute;
      top: 569px;
      left: 50%;
      transform: translateX(-50%);
    }

    .MyCafeFinder {
      font-size: 32px;
      font-family: GeosansLight;
      font-weight: 500;
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
      <div class="CrMa">Crèma</div>
      <div class="ForTheBestCoffeeMoments">FOR THE BEST COFFEE MOMENTS </div>
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
      if (vectorDelay < 0) setTimeout(() => vector.style.opacity = 0.9, 200); // 0.5초 지연
      if (crmaDelay < 0) setTimeout(() => crma.style.opacity = 0.9, 200); // 0.5초 지연
      if (coffeeMomentsDelay < 0) setTimeout(() => coffeeMoments.style.opacity = 0.9, 200); // 0.5초 지연
      if (cafeFinderDelay < 0) setTimeout(() => cafeFinder.style.opacity = 0.9, 200); // 0.5초 지연
    }

    // 스크롤 이벤트 리스너 등록
    window.addEventListener('scroll', appearOnScroll);

    // 초기에 한 번 호출하여 초기 화면에서도 적용되게 함
    appearOnScroll();

    // 스크롤 내릴 때 요소들이 다시 투명해지는 효과
    window.addEventListener('scroll', function() {
      // 스크롤된 양 계산
      var scroll = window.scrollY;

      // 스크롤된 양에 따라 투명도 조절
      var opacity = 1 - scroll / 500; // 500은 투명도가 0이 되는 스크롤 양입니다.

      // 각 요소에 투명도 적용
      var elements = document.querySelectorAll('.Vector, .CrMa, .ForTheBestCoffeeMoments, .MyCafeFinder');
      elements.forEach(function(element) {
        element.style.opacity = opacity;
      });
    });
  </script>

</body>

</html>




<!-- 이미지 위로 페이지 내용 추가 -->

</div>
<!-- 이미지 아래 페이지 내용 추가 -->


<!-- 날씨위젯 -->
<div class = "weather-widget" style="margin-left:20; margin-bottom:20; position: relative"><div id="ww_dd38e1ffbef2c" v='1.3' loc='id' a='{"t":"responsive","lang":"ko","sl_lpl":1,"ids":["wl2308"],"font":"Arial","sl_ics":"one_a","sl_sot":"celsius","cl_bkg":"#FFFFFF00","cl_font":"rgba(120,120,120,1)","cl_cloud":"#d4d4d4","cl_persp":"#2196F3","cl_sun":"#FFC107","cl_moon":"#FFC107","cl_thund":"#FF5722","sl_tof":"3","el_wfc":3,"cl_odd":"#00000000"}' style="width: 230px;">More forecasts: <a href="https://oneweather.org/seoul/30_days/" id="ww_dd38e1ffbef2c_u" target="_blank">Weather forecast Seoul 30 days</a></div>
<script async src="https://app2.weatherwidget.org/js/?id=ww_dd38e1ffbef2c"></script></div>




<script>
    // 폰트 크기를 조절하는 함수
    function changeFontSize() {
        var weatherWidget = document.getElementById("ww_dd38e1ffbef2c");
        var temperatureElement = weatherWidget.querySelector(".ww_temperature");

        // 폰트 크기 조절
        if (temperatureElement) {
            temperatureElement.style.fontSize = "12px"; // 변경할 폰트 크기 설정
        }
    }

    // 페이지 로드 후 폰트 크기 조절 함수 호출
    window.addEventListener("load", changeFontSize);
</script>




<!-- 날씨 테마 섹션 -->
<div class="weather-section mx-auto" style="width: 100%; height: auto; background: rgba(232.69, 215.26, 202.63, 0.19)">

	<div class="recommendation mx-auto" style="width: 100%; height: 600px; left: 0px; top: 0px; position: relative">
		<div class="indent" style="padding-left: 100px;">
			<div class="cremaRecommends" style="width: 595px; height: 20px; left: 0px; top: 50px; position: relative">
				<span
					style="color: black; font-size: 80px; font-family: Graditen; font-weight: 400; letter-spacing: 8px; word-wrap: break-word">CREMA<br /></span><span
					style="color: black; font-size: 64px; font-family: GeosansLight; font-style: italic; font-weight: 500; letter-spacing: 6.40px; word-wrap: break-word">RECOMMENDS</span>
			</div>
			<div class="Recommends mx-auto"
				style="left: 0px; top: 230px; position: relative; color: 6D6D6D; font-size: 16px; font-family: Pretendard; font-weight: 300; letter-spacing: 1px; word-wrap: break-word">크레마는
				오늘같은 날씨에 가기 좋은 카페를 추천해드려요.</div>
			<div class="weather-comment"
				style="width: 595px; height: 53px; left: 0px; top: 310px; position: relative; color: 6D6D6D; font-size: 18px; font-family: Pretendard; font-weight: 350; letter-spacing: 1.50px; word-wrap: break-word">바스락거리는
				셔츠 한장만 걸쳐도 햇살의 온기와 시원한 바람이 어우러지는 날 달콤쌉싸름한 커피 한잔이 생각나요.</div>

		</div>
		<div class="weather-img-box">
			<img class="Weather-img" style="height: 100%; right: 0; top: 0px; position: absolute;"
				src="https://velog.velcdn.com/images/yunlinit/post/a9ded344-3246-4eb4-bffd-edf07671303c/image.png" />
		</div>
	</div>

</div>



<!-- 검색어박스 -->
<!-- 코드펜에서는 한참 아래에 있지만, 스프링에 적용시키면 박스 안에 제대로 들어가있음. -->
<div class="search-box" style="width: 593px; height: 82px; top: 1750px; left: 5%; position: absolute">
	<div class="how-about-here"
		style="width: 589px; height: 39px; left: 4px; top: 0px; position: absolute; color: #6D6D6D; font-size: 14px; font-family: Pretendard; font-weight: 500; letter-spacing: 1.40px; word-wrap: break-word">오늘은
		이런 카페 어떠세요?</div>
	<div class="line"
		style="height: 37px; padding-top: 31px; padding-bottom: 6px; padding-left: 1px; padding-right: 8px; left: 3px; top: 45px; position: absolute; background: rgba(255, 255, 255, 0); justify-content: flex-start; align-items: center; display: inline-flex">
		<div
			style="width: 302px; height: 43px; color: #A9A9A9; font-size: 14px; font-family: Pretendard; font-weight: 400; letter-spacing: 1.40px; word-wrap: break-word">
			<input type="text" placeholder="테라스 카페" class="input input-sm input-ghost w-full max-w-xs" />
			<div class="search-btn"
				style="width: 24px; height: 24px; padding-top: 3px; padding-bottom: 2.25px; padding-left: 3px; padding-right: 2.25px; left: 300px; top: 47px; position: absolute; justify-content: center; align-items: center; display: inline-flex">
				<a href=""
					style="width: 589px; height: 39px; left: 20px; top: -27px; position: absolute; color: #6D6D6D; font-size: 20px; font-family: Pretendard; font-weight: 500; letter-spacing: 1px; word-wrap: break-word">GO</a>
			</div>
			<div style="width: 308px; height: 0px; border: 1px gray solid;"></div>
		</div>


	</div>
	<div class "search-keyword" style="height: 30px; padding-left: 6px; left: 0px; top: 46px; position: absolute; background: rgba(255, 255, 255, 0); justify-content: flex-end; align-items: center; display: inline-flex">

	</div>
</div>
</div>





<%@ include file="../common/foot.jspf"%>








