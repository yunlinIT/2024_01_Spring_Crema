<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="제휴 문의"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<script data-cfasync="false" type="text/javascript"
		src="https://cdn.rawgit.com/dwyl/html-form-send-email-via-google-script-without-server/master/form-submission-handler.js"></script>



<style>
.backBtn {
	color: #a9a9a9;
}
</style>



<section class="mt-8 text-xl px-4">
    <h1 style="text-align: center; font-size: 25; margin-top: 100px; font-weight: 600;">장윤린에게 이메일 보내기</h1>
    <div class="mx-auto">
        <form class="gform" method="POST" data-email="yunlinit@gmail.com"
            action="https://script.google.com/macros/s/AKfycbxkZTwkACh8C2St2dGm8mxtr3Yuj91yE1f92s-gEhghKd0kle5RHSEXSTuwGjPdZwlmxA/exec">
           

            <table class="write-box table-box-1 mx-auto mt-10" border="1">
                <tbody>
                    <tr>
                        <th style="font-weight: 600">이름</th>
                        <td><input class="title input input-bordered input-md w-full max-w-xs" autocomplete="off" type="text"
                            placeholder="이름을 입력해주세요" name="name" />
                            <div style="display: inline-block; font-weight: 600; margin-left: 4em;">연락처</div> <input
                            class="title input input-bordered input-md w-full max-w-xs" autocomplete="off" type="text"
                            placeholder="전화번호를 입력해주세요" name="contact" style="margin-left: 1.8em" /></td>
                    </tr>

                    <tr>
                        <th style="font-weight: 600">이메일</th>
                        <td><input class="title input input-bordered input-md w-full " autocomplete="off" type="text"
                            placeholder="id@email.com" name="email" style="width: 780px" /></td>
                    </tr>
                    <tr>
                        <th style="font-weight: 600">내용</th>
                        <td><textarea placeholder="내용을 입력해주세요" name="body" class="textarea textarea-bordered textarea-lg"
                                style="width: 780px; height: 300px;"></textarea> 
                            </div></td>
                    </tr>
                    <tr>
                        <th></th>
                        </br>
                        <td style="text-align: left;">
                            <button class="writeBtn btn btn-sm" id="submitBtn" type="submit" value="등록" style="margin-left: 320px; margin-top: 10px;">보내기</button> <span
                            style="float: right;">
                                <button class="backBtn btn btn-sm btn-ghost" id ="backBtn" class="" type="button" onclick="history.back();">뒤로가기</button>
                        </span>
                        </td>

                    </tr>
                </tbody>
            </table>
        </form>


    </div>

</section>

<script>

document.querySelector(".gform").addEventListener("submit", function(event) {
    var checkbox = document.getElementById("checkbox");
        // 이메일 전송 알림
        setTimeout(function() {
            alert("이메일이 성공적으로 전송되었습니다!");
            document.getElementById("submitBtn").disabled = false; // 문의하기 버튼 활성화
            document.getElementById("backBtn").disabled = false; // 뒤로가기 버튼 활성화
        }, 100); // 1초 후에 알림을 표시합니다.
  
});

</script> 






<%@ include file="../common/foot.jspf"%>