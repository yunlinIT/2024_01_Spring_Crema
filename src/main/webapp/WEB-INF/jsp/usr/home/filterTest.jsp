<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value=""></c:set>

<%@ include file="../common/head.jspf"%>

<section>
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


<style>


.search-filter {
	position: fixed;
	width: 309px;
	height: 908px;
	background-color: #ffffff;
	top: 70px;
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





<%@ include file="../common/foot.jspf"%>