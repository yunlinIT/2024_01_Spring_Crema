<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원가입"></c:set>
<%@ include file="../common/head.jspf"%>





<section>
	<div class="Join">
		<div class="JoinBox">
			<div class="Rectangle6">
				<section class="mt-8 text-xl px-4">
						<form action="../member/doJoin" method="POST">

							<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" />
							<div class="title">회원가입</div>

							<div class="IdBox">
								<span class="material-symbols-outlined"> person_edit </span> <input id="loginId"
									class="input input-sm w-full max-w-xs" autocomplete="off" type="text" placeholder="아이디를 입력해주세요" name="loginId" />
							</div>
							<div class="PwBox">
								<span class="material-symbols-outlined"> lock </span> <input id="loginPw" class="input input-sm w-full max-w-xs"
									autocomplete="off" type="password" placeholder="비밀번호를 입력해주세요" name="loginPw" />
							</div>
							<div class="PwCheckBox">
								<span class="material-symbols-outlined"> check_circle </span> <input id="loginPwCheck"
									class="input input-sm w-full max-w-xs" autocomplete="off" type="password" placeholder="비밀번호를 확인해주세요"
									name="loginPwCheck" />
							</div>
							<div class="NameBox">
								<span class="material-symbols-outlined"> person </span> <input id="name" class="input input-sm w-full max-w-xs"
									autocomplete="off" type="text" placeholder="이름을 입력해주세요" name="name" />
							</div>
							<div class="NicknameBox">
								<span class="material-symbols-outlined"> person_edit </span> <input id="name"
									class="input input-sm w-full max-w-xs" autocomplete="off" type="text" placeholder="닉네임 입력해주세요" name="nickname" />
							</div>
							<div class="PhoneNumBox">
								<span class="material-symbols-outlined"> call </span> <input id="cellphoneNum"
									class="input input-sm w-full max-w-xs" autocomplete="off" type="text" placeholder="전화번호를 입력해주세요"
									name="cellphoneNum" />
							</div>
							<div class="EmailBox">
								<span class="material-symbols-outlined"> mail </span> <input id="email" class="input input-sm w-full max-w-xs"
									autocomplete="off" type="text" placeholder="이메일을 입력해주세요" name="email" />
							</div>

							<input class="joinBtn btn btn-sm" type="submit" value="회원가입" />

						</form>
						<div class="btns">
							<button class="backBtn" type="button" onclick="history.back();">뒤로가기</button>
							<a class="loginBtn" href="../member/login">로그인</a>

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
	margin-top: 100px;
	align-items: center;
	font-family: Pretendard;
}

.JoinBox {
	width: 500px;
	height: 311px;
	position: relative;
}

.IdBox {
	width: 215px;
	height: 24px;
	left: 120px;
	top: 90px;
	position: absolute;
	display: flex;
	align-items: center;
}

.PwBox {
	width: 222px;
	height: 24px;
	left: 120px;
	top: 160px;
	position: absolute;
	display: flex;
	align-items: center;
}

.PwCheckBox {
	width: 222px;
	height: 24px;
	left: 120px;
	top: 230px;
	position: absolute;
	display: flex;
	align-items: center;
}

.NameBox {
	width: 215px;
	height: 24px;
	left: 120px;
	top: 300px;
	position: absolute;
	display: flex;
	align-items: center;
}

.NicknameBox {
	width: 215px;
	height: 24px;
	left: 120px;
	top: 370px;
	position: absolute;
	display: flex;
	align-items: center;
}

.PhoneNumBox {
	width: 222px;
	height: 24px;
	left: 120px;
	top: 440px;
	position: absolute;
	display: flex;
	align-items: center;
}

.EmailBox {
	width: 215px;
	height: 24px;
	left: 120px;
	top: 510px;
	position: absolute;
	display: flex;
	align-items: center;
}

.IdBox .material-symbols-outlined, .PwBox .material-symbols-outlined,
	.PwCheckBox .material-symbols-outlined, .NameBox .material-symbols-outlined,
	.NicknameBox .material-symbols-outlined, .PhoneNumBox .material-symbols-outlined,
	.EmailBox .material-symbols-outlined {
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

.loginBtn {
	width: 74px;
	height: 39px;
	position: absolute;
	right: 0px;
	top: 40px;
	color: #a9a9a9;
	font-size: 12px;
	font-weight: 600;
}

.joinBtn {
	width: 100px;
	height: 39px;
	position: absolute;
	left: 40%;
	bottom: 30px;
}
</style>

























<%@ include file="../common/foot.jspf"%>