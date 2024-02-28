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

<style>
	/* 배경 이미지 스타일 설정 */
	.background-image {
		/* 배경 이미지 URL 지정 */
		background-image:
			url('https://velog.velcdn.com/images/yunlinit/post/26409ae5-56ae-46b9-846d-5c9e76f4b1e4/image.png');
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
</style>

<div class="background-image">
	<!-- 이미지 위로 페이지 내용 추가 -->

</div>
<!-- 이미지 아래 페이지 내용 추가 -->


<!-- 날씨 테마 섹션 -->
<div class="weather-section mx-auto" style="width: 100%; height: auto; background: rgba(232.69, 215.26, 202.63, 0.19)">

	<div class ="recommendation mx-auto" style="width: 100%; height: 600px; left: 0px; top: 0px; position: relative">
		<div class = "indent" style="padding-left: 100px;">		
			<div class="cremaRecommends" style="width: 595px; height: 20px; left: 0px; top: 50px; position: relative"><span style="color: black; font-size: 80px; font-family: Graditen; font-weight: 400; letter-spacing: 8px; word-wrap: break-word">CREMA<br /></span><span style="color: black; font-size: 64px; font-family: GeosansLight; font-style: italic; font-weight: 500; letter-spacing: 6.40px; word-wrap: break-word">RECOMMENDS</span></div>
		<div class="Recommends mx-auto" style="left: 0px; top: 230px; position: relative; color: 6D6D6D; font-size: 16px; font-family: Pretendard; font-weight: 300; letter-spacing: 1px; word-wrap: break-word">크레마는 오늘같은 날씨에 가기 좋은 카페를 추천해드려요.</div>
		<div class="weather-comment" style="width: 595px; height: 53px; left: 0px; top: 310px; position: relative; color: 6D6D6D; font-size: 18px; font-family: Pretendard; font-weight: 350; letter-spacing: 1.50px; word-wrap: break-word">바스락거리는 셔츠 한장만 걸쳐도 햇살의 온기와 시원한 바람이 어우러지는 날 달콤쌉싸름한 커피 한잔이 생각나요.</div>
			
		</div>
		<div class="weather-img-box"><img class="Weather-img" style="height: 100%; right: 0; top: 0px; position: absolute;" src="https://velog.velcdn.com/images/yunlinit/post/a9ded344-3246-4eb4-bffd-edf07671303c/image.png" /></div>
	</div>

</div>



<!-- 검색어박스 -->
<!-- 코드펜에서는 한참 아래에 있지만, 스프링에 적용시키면 박스 안에 제대로 들어가있음. -->
<div class="search-box" style="width: 593px; height: 82px; top: 1660px; left: 5%; position: absolute">
	<div class = "how-about-here" style="width: 589px; height: 39px; left: 4px; top: 0px; position: absolute; color: #6D6D6D; font-size: 14px; font-family: Pretendard; font-weight: 500; letter-spacing: 1.40px; word-wrap: break-word">오늘은 이런 카페 어떠세요?</div>
	<div class = "line" style="height: 37px; padding-top: 31px; padding-bottom: 6px; padding-left: 1px; padding-right: 8px; left: 3px; top: 45px; position: absolute; background: rgba(255, 255, 255, 0); justify-content: flex-start; align-items: center; display: inline-flex">
			<div style="width: 302px; height: 43px; color: #A9A9A9; font-size: 14px; font-family: Pretendard; font-weight: 400; letter-spacing: 1.40px; word-wrap: break-word"><input type="text" placeholder="테라스 카페" class="input input-sm input-ghost w-full max-w-xs" /> <div class = "search-btn"style="width: 24px; height: 24px; padding-top: 3px; padding-bottom: 2.25px; padding-left: 3px; padding-right: 2.25px; left: 300px; top: 47px; position: absolute; justify-content: center; align-items: center; display: inline-flex"> <a href="" style="width: 589px; height: 39px; left: 20px; top: -27px; position: absolute; color: #6D6D6D; font-size: 20px; font-family: Pretendard; font-weight: 500; letter-spacing: 1px; word-wrap: break-word">GO</a> </div> 
		<div style="width: 308px; height: 0px; border: 1px gray solid;"></div> 
	</div>
	
		
	</div>
	<div class "search-keyword" style="height: 30px; padding-left: 6px; left: 0px; top: 46px; position: absolute; background: rgba(255, 255, 255, 0); justify-content: flex-end; align-items: center; display: inline-flex">

	</div>
</div>
</div>





<%@ include file="../common/foot.jspf"%>








