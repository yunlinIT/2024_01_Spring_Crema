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

<script>
    function submitSearchForm() {
        document.getElementById("searchForm").submit();
    }
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
			<div class="CrMa">
				<img src="https://velog.velcdn.com/images/yunlinit/post/29de0688-d442-4346-8d16-16101822b4b3/image.png" alt="Crèma" />
			</div>
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



<!-- 이미지 아래 페이지 내용 추가 -->


<script>

<!-- 조건에 따라 온도와 날씨 ID를 기반으로 날씨 코멘트와 이미지를 업데이트 -->
    function fetchWeather() {
        var city = "Daejeon";
        var apiKey = "4aeb4c84293bc9b4109638849c3b309c";
        var lang = "kr";

        var apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + apiKey + "&lang=" + lang + "&units=metric";

        fetch(apiUrl)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                console.log(data);

                var temperature = data.main.temp;
                var weatherId = data.weather[0].id;

                var weatherCommentElement = document.querySelector('.weather-section .weather-comment');
                var weatherImageElement = document.querySelector('.weather-section .Weather-img');

                if (temperature <= 4 && (weatherId < 200 || weatherId > 699)) { //cold
                    weatherCommentElement.textContent = "한기가 서릿발을 타고 들어와 어느새 마음도 서늘해지는 추운 날 따뜻한 커피 한잔의 온기로 녹아든 순간이 행복할 것 같아요.";
                    weatherImageElement.src = "https://velog.velcdn.com/images/yunlinit/post/35f11685-7a4a-44a7-a854-6512fc43ec83/image.png";
                } else if (temperature >= 5 && temperature <= 11.99 && (weatherId < 200 || weatherId > 699)) { //chilly
                    weatherCommentElement.textContent = "찬바람이 불어오는 날 코 끝에 쌀쌀한 공기가 느껴질때면 항상 따뜻한 커피 한잔이 생각나요.";
                    weatherImageElement.src = "https://velog.velcdn.com/images/yunlinit/post/8e174410-44d9-4d24-b972-c303f6b197bf/image.png";
                } else if (temperature >= 12 && temperature <= 19.99 && (weatherId < 200 || weatherId > 699)) { //cool
                    weatherCommentElement.textContent = "바람이 부드럽게 스치는 서늘한 날, 한 모금의 커피 향기가 나를 감싸 안아요.";
                    weatherImageElement.src = "https://velog.velcdn.com/images/yunlinit/post/51c47653-7837-4f70-bdcb-203ec2cf32a5/image.png";
                } else if (temperature >= 20 && temperature <= 27.99 && (weatherId < 200 || weatherId > 699)) { //warm
                    weatherCommentElement.textContent = "바스락거리는 셔츠 한장만 걸쳐도 햇살의 온기와 시원한 바람이 어우러지는 날 달콤 쌉싸름한 커피 한잔이 생각나요.";
                    weatherImageElement.src = "https://velog.velcdn.com/images/yunlinit/post/0bed2c81-5d07-4dcf-a928-25c987ace1f9/image.png";
                } else if (temperature >= 28 && (weatherId < 200 || weatherId > 699)) { //hot
                    weatherCommentElement.textContent = "한낮의 뜨거운 뙤약볕 아래 얼음이 스르륵 녹는 시원한 아이스 커피 한 잔으로 산뜻함을 느리고 싶은 날이에요.";
                    weatherImageElement.src = "https://velog.velcdn.com/images/yunlinit/post/0cf48676-5563-424b-b823-06f6a5c86efb/image.png";
                }  else if (temperature <= 15.99 && (weatherId >= 200 && weatherId <= 599)) { //rainy and chilly
                    weatherCommentElement.textContent = "유리창을 가볍게 두드리는 빗소리에 둘러싸여 습하고 쌀쌀한 공기 속에서도 갓 내린 커피의 따뜻함을 느낄 수 있는 날이에요.";
                    weatherImageElement.src = "https://velog.velcdn.com/images/yunlinit/post/ca97aaa8-afcd-4828-a6ff-dd15ddb7f0c8/image.png";
                } else if (temperature >= 16 && (weatherId >= 200 && weatherId <= 599)) { //rainy and hot/warm
                    weatherCommentElement.textContent = "비오는 날 창가에 앉아 빗소리를 들으며 마시는 아이스 커피는 후덥지근함도 비와 함께 씻겨 내려 줄 것만 같아요.";
                    weatherImageElement.src = "https://velog.velcdn.com/images/yunlinit/post/2be5b88b-bcdb-4f68-9337-bc764f082015/image.png";
                } else if (temperature <= 10 && (weatherId >= 600 && weatherId <= 699)) { //snowy
                    weatherCommentElement.textContent = "눈 내리는 날 창가에 앉아 커피 한 모금의 따뜻함으로 마음을 녹여주고 겨울의 서늘함을 잊게 해줘요.";
                    weatherImageElement.src = "https://velog.velcdn.com/images/yunlinit/post/2f491c13-ec4e-4a98-aac9-140b9583cbb6/image.png";
                } else { //n/a
                    weatherCommentElement.textContent = "Life is like a cup of coffee. It's all about how you make it.";
                    weatherImageElement.src = "https://velog.velcdn.com/images/yunlinit/post/203c7e7f-df3f-40d3-8eec-e02996d22372/image.png";
                }

                
				//날씨 조건에 따라 검색창의 value를 업데이트하여 추천검색어를 보여줌
                var keywordInput = document.getElementById('keyword');
                var newValue = "";

                if (temperature <= 4 && (weatherId < 200 || weatherId > 699)) { //cold
                    newValue = "아늑한";
                } else if (temperature >= 5 && temperature <= 11 && (weatherId < 200 || weatherId > 699)) { //chilly
                    newValue = "에스프레소바";
                } else if (temperature >= 12 && temperature <= 19 && (weatherId < 200 || weatherId > 699)) { //cool
                    newValue = "테라스";
                } else if (temperature >= 20 && temperature <= 27 && (weatherId < 200 || weatherId > 699)) { //warm
                    newValue = "테라스";
                } else if (temperature >= 28 && (weatherId < 200 || weatherId > 699)) { //hot
                    newValue = "디저트맛집";
                } else if (temperature <= 15 && (weatherId >= 200 || weatherId <= 599)) { //rainy and chilly
                    newValue = "로스터리";
                } else if (temperature >= 16 && (weatherId >= 200 || weatherId <= 599)) { //rainy and hot/warm
                    newValue = "대형카페";
                } else if (temperature <= 10 && (weatherId >= 600 || weatherId <= 699)) { //snowy
                    newValue = "뷰맛집";
                } else { //n/a
                    newValue = "";
                }

                keywordInput.value = newValue;
            })
            .catch(function(error) {
                console.error('Error:', error);
            });
    }


    fetchWeather(); // Call the function to fetch weather on page load
    
    
    
    

    
    
</script>





<!-- 날씨위젯 -->
<a class="weatherwidget-io" href="https://forecast7.com/en/36d35127d38/daejeon/" data-icons="Climacons Animated"
	data-mode="Current" data-days="3" data-theme="pure">Daejeon, South Korea</a>
<script>
!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src='https://weatherwidget.io/js/widget.min.js';fjs.parentNode.insertBefore(js,fjs);}}(document,'script','weatherwidget-io-js');
</script>

<style>
.weatherwidget-io {
	max-width: 225px !important;
	background-color: transparent !important;
	margin-left: 30px !important;
	margin-bottom: 30px !important;
}
</style>


<!-- 날씨 테마 섹션 -->


<div class="weather-section mx-auto">
	<div class="recommendation mx-auto">
		<div class="indent">
			<div class="cremaRecommends">
				<span> CREMA <br />
				</span> <span>RECOMMENDS</span>
			</div>
			<div class="Recommends mx-auto">크레마는 오늘같은 날씨에 가기 좋은 카페를 추천해드려요.</div>
			<div class="weather-comment">-</div>
		</div>
		<div class="weather-img-box">
			<img class="Weather-img" src="-" />
		</div>

		<!-- 		날씨조건에 따라 추천검색어를 보여주는 검색창 -->
		<div class="search-box">
			<div class="how-about-here">오늘은 이런 카페 어떠세요?</div>
			<form action="/usr/findcafe/searchCafes" method="get" id="searchForm">
				<label class="search-menu-item input input-bordered flex items-center gap-2 input-xs max-w-xs"> <input
					type="text" class="grow" id="keyword" name="keyword" autocomplete="off" placeholder="검색어를 입력해주세요" value=""
					style="color: black;" ;/> <a href="javascript:;" onclick="submitSearchForm()">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="w-4 h-4 opacity-70">
                    <path fill-rule="evenodd"
								d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
								clip-rule="evenodd" />
                </svg>
					</a>
				</label>
			</form>
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
	width: 490px;
	height: 53px;
	position: relative;
	/* 	color: #6D6D6D; */
	color: #755a44;
	font-style: italic;
	font-size: 18px;
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




<!--   <div class="cafe-item"> -->
<!--                 <a href="cafeDetail?id=`+cafe.id+`" class="linkbox１"> -->
<!--                     <div class="content-info-box" style="margin-bottom: 50px"> -->
<!--                         <div class="cafe-img-box"> -->
<!--                             <img src="`+cafe.cafeImgUrl1+`" alt="카페 이미지" /> -->
<!--                         </div> -->
<!--                         <div class="name-address"> -->
<!--                             <div class="cafe-name">`+cafe.name+`</div> -->
<!--                             <p class="cafe-address">`+cafe.address+`</p> -->
<!--                         </div> -->
<!--                         <div class="like-count"> -->
<!--                             <span class="material-symbols-outlined"> favorite </span> -->
<!--                             <div class="like-count-num">`+cafe.cafeScrapCount+`</div> -->
<!--                         </div> -->
<!--                         <div class="review-count"> -->
<!--                             <div class="title-review">리뷰</div> -->
<!--                             <div class="review-count-num">`+cafe.reviewCount+`</div> -->
<!--                         </div> -->
<!--                         <div class="show-distance"> -->
<!--                             <div class="num-km-group"> -->
<!--                                 <div class="km">km</div> -->
<!--                                 <div class="distance-num">1.8</div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <div class="hashtag">`+cafe.hashtag+`</div> -->
<!--                     </div> -->
<!--                 </a> -->
<!--             </div> -->




<!-- 카페추천 박스 -->

<div class="CafeRecom mx-auto">
	<a href="../findcafe/cafeDetail?id=${getNewestCafe.id}" class="NewCafe">
		<div>크레마 신규 카페</div>
		<div class="hover-img-zoom-in">
			<img class="NewCafeImg" src="${getNewestCafe.cafeImgUrl1}" />
			<div class="InfoBox">
				<div class="name">${getNewestCafe.name}</div>
				<div class="address">${getNewestCafe.address}</div>
			</div>
		</div>
	</a>

	<a href="../findcafe/cafeDetail?id=${getPopularCafe.id}" class="PopularCafe">
		<div>크레마 인기 카페</div>
		<div class="hover-img-zoom-in">
			<img class="PopularCafeImg" src="${getPopularCafe.cafeImgUrl1}" />
			<div class="InfoBox">
				<div class="name">${getPopularCafe.name}</div>
				<div class="address">${getPopularCafe.address}</div>
			</div>
		</div>
	</a>
	<a href="../findcafe/cafeDetail?id=${getRecommendedCafe.id}" class="RecomCafe">
		<div>크레마 추천 카페</div>
		<div class="hover-img-zoom-in">
			<img class="RecomCafeImg" src="${getRecommendedCafe.cafeImgUrl1}" />
			<div class="InfoBox">
				<div class="name">${getRecommendedCafe.name}</div>
				<div class="address">${getRecommendedCafe.address}</div>
			</div>
		</div>
	</a>
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
	font-weight: 600;
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

.hover-img-zoom-in img {
	width: 400px;
	height: 500px;
	margin: 0px auto;
	overflow: hidden;
	object-fit: cover;
}
</style>


</div>





<%@ include file="../common/foot.jspf"%>