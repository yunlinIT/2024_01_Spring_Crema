<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE WRITE"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<!-- Article write 관련 -->
<script type="text/javascript">
	let ArticleWrite__submitFormDone = false;
	function ArticleWrite__submit(form) {
		if (ArticleWrite__submitFormDone) {
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value == 0) {
			alert('제목을 입력해주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		if (markdown.length == 0) {
			alert('내용 써라');
			editor.focus();
			return;
		}
		form.body.value = markdown;
		ArticleWrite__submitFormDone = true;
		form.submit();
	}
</script>

<section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<form action="../article/doWrite" method="POST" onsubmit="ArticleWrite__submit(this); return false;">
			<input type="hidden" name="body">
			<table class="write-box table-box-1" border="1">
				<tbody>
					<tr>
						<th>작성자</th>
						<td>
							<div>${rq.loginedMember.nickname }</div>
						</td>
					</tr>
					<tr>
						<th>게시판</th>
						<td>
							<select class="select select-ghost w-full max-w-xs" name="boardId">
								<!-- 									<option selected="selected" disabled>게시판을 선택해주세요</option> -->
								<option value="1">공지사항</option>
								<option value="2">자유</option>
								<option value="3">QNA</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<input class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
								placeholder="제목을 입력해주세요" name="title" />
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<div class="toast-ui-editor">
								<script type="text/x-template">
      </script>
							</div>
						</td>
					</tr>


					<tr>
						<th></th>
						<td>
							<button class="btn btn-outline btn-info" type="submit" value="작성">작성</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns">
			<button class="btn btn-outline" class="" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>