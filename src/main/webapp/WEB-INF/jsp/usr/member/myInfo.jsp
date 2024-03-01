<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value=""></c:set>
<%@ include file="../common/head.jspf"%>


<section>
	<div class="Join">
		<div class="JoinBox">
			<div class="Rectangle6">
				<section class="mt-8 text-xl px-4">
					<div class="mx-auto">

						<div class="title">회원정보</div>

						<div class="regDate">
							<span class="material-symbols-outlined"> calendar_month </span>
							<div class="ContentName">가입날짜</div>
							${rq.loginedMember.regDate }
						</div>
						<div class="loginId">
							<span class="material-symbols-outlined"> person_edit </span>
							<div class="ContentName">아이디</div>
							${rq.loginedMember.loginId }
						</div>
						<div class="name">
							<span class="material-symbols-outlined"> person </span>
							<div class="ContentName">이름</div>
							${rq.loginedMember.name }
						</div>
						<div class="nickname">
							<span class="material-symbols-outlined"> person_edit </span>
							<div class="ContentName">닉네임</div>
							${rq.loginedMember.nickname }
						</div>
						<div class="cellphoneNum">
							<span class="material-symbols-outlined"> call </span>
							<div class="ContentName">전화번호</div>
							${rq.loginedMember.cellphoneNum }
						</div>
						<div class="email">
							<span class="material-symbols-outlined"> mail </span>
							<div class="ContentName">이메일</div>
							${rq.loginedMember.email }
						</div>


						<a class="modifyBtn btn btn-sm" href="../member/checkPw" >회원정보 수정</a>

						<div class="btns">

							<button class="backBtn" type="button" onclick="history.back();">뒤로가기</button>

							<a class="loginBtn" href="../member/login">회원탈퇴</a>

						</div>
					</div>
				</section>
			</div>
		</div>
	</div>
</section>

<style>
.title {
	font-weight: 600;
	color: #666666;
	margin-left: 10px;
}

.Join {
	width: 100%;
	height: 100vh;
	display: flex;
	flex-direction: column;
	margin-top: 170px;
	align-items: center;
	font-family: Pretendard;
}

.JoinBox {
	width: 500px;
	height: 311px;
	position: relative;
}

.ContentName {
	color: #a9a9a9;
	font-size: 14px;
	font-weight: 500;
	margin-right: 60px;
	margin-left: 40px;
}

.regDate {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 130px;
	position: absolute;
	display: flex;
	align-items: center;
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	right: 0px;
}

.loginId {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 200px;
	position: absolute;
	display: flex;
	align-items: center;
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	right: 0px;
}

.name {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 270px;
	position: absolute;
	display: flex;
	align-items: center;
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	right: 0px;
}

.nickname {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 340px;
	position: absolute;
	display: flex;
	align-items: center;
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	right: 0px;
}

.cellphoneNum {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 410px;
	position: absolute;
	display: flex;
	align-items: center;
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	right: 0px;
}

.email {
	width: 400px;
	height: 24px;
	left: 120px;
	top: 480px;
	position: absolute;
	display: flex;
	align-items: center;
	color: #666666;
	font-size: 14px;
	font-weight: 500;
	right: 0px;
}

.regDate .material-symbols-outlined, .loginId .material-symbols-outlined,
	.name .material-symbols-outlined, .nickname .material-symbols-outlined,
	.cellphoneNum .material-symbols-outlined, .email .material-symbols-outlined
	{
	/* 변경 */
	margin-right: 30px;
	color: #666666;
}

.Rectangle6 {
	width: 500px;
	height: 670px;
	left: 0px;
	top: 0px;
	position: absolute;
	background: rgba(255, 255, 255, 0);
	border-radius: 15px;
	border: 1px #a9a9a9 solid;
}

.loginBtn {
	width: 74px;
	height: 39px;
	position: absolute;
	right: 0px;
	top: 40px;
	color: #a9a9a9;
	font-size: 12px;
	font-weight: 400;
}

.modifyBtn {
	width: 100px;
	height: 39px;
	position: absolute;
	left: 40%;
	bottom: 30px;
		font-size: 13px;
}

.backBtn {
	width: 74px;
	height: 39px;
	position: absolute;
	right: 15px;
	bottom: 20px;
	color: #a9a9a9;
	font-size: 12px;
	font-weight: 600;
}
</style>




<div>1${loginedMember }</div>
<div>2${rq.loginedMember }</div>
<div>${loginedMember.loginId }</div>
<div>${rq.loginedMember.loginId }</div>
<div>${rq.loginedMember.getLoginId() }</div>



<%@ include file="../common/foot.jspf"%>