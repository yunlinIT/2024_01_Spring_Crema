package com.example.demo.controller;

import java.util.List;

// 필요한 스프링 프레임워크 클래스들을 임포트합니다.
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.ReactionPointService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class UsrArticleController {

	// Rq 주입
	@Autowired
	private Rq rq;

	// ArticleService 주입
	@Autowired
	private ArticleService articleService;

	// BoardService 주입
	@Autowired
	private BoardService boardService;

	// ReplyService 주입
	@Autowired
	private ReplyService replyService;

	// ReactionPointService 주입
	@Autowired
	private ReactionPointService reactionPointService;

	// 기본 생성자
	public UsrArticleController() {

	}

	// 액션 메서드
	
	@RequestMapping("/usr/article/writeEmail")
	public String sendEmail(HttpServletRequest req) {
		// 이메일 작성 페이지를 반환
		return "usr/article/writeEmail";
	}

	@RequestMapping("/usr/article/list")
	public String showList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		// rq 객체를 요청 속성에서 가져옴
		Rq rq = (Rq) req.getAttribute("rq");

		// 주어진 boardId로 게시판 정보를 가져옴
		Board board = boardService.getBoardById(boardId);

		// 주어진 검색 조건에 맞는 게시글 수를 가져옴
		int articlesCount = articleService.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);

		// 게시판이 존재하지 않는 경우
		if (board == null) {
			return rq.historyBackOnView("없는 게시판이야");
		}

		// 한 페이지에 표시할 항목 수를 설정.
		int itemsInAPage = 10;

		// 총 페이지 수를 계산
		int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

		// 주어진 조건에 맞는 게시글 리스트를 가져옴
		List<Article> articles = articleService.getForPrintArticles(boardId, itemsInAPage, page, searchKeywordTypeCode,
				searchKeyword);

		// 모델에 속성들을 추가
		model.addAttribute("board", board);
		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);

		// 게시글 리스트 페이지를 반환
		return "usr/article/list";
	}
	
	@RequestMapping("/usr/article/myList")
	public String showMyList(HttpServletRequest req, Model model,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		// rq 객체를 요청 속성에서 가져옴
		Rq rq = (Rq) req.getAttribute("rq");
		
		// 로그인된 회원의 ID를 가져옴
		Integer memberId = rq.getLoginedMemberId();

		// 주어진 검색 조건에 맞는 회원의 게시글 수를 가져옴
		int articlesCount = articleService.getMyListCount(memberId, searchKeywordTypeCode, searchKeyword);

		// 한 페이지에 표시할 항목 수를 설정
		int itemsInAPage = 10;

		// 총 페이지 수를 계산
		int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

		// 주어진 조건에 맞는 회원의 게시글 리스트를 가져옴
		List<Article> articles = articleService.getForPrintMyList(memberId, itemsInAPage, page, searchKeywordTypeCode,
				searchKeyword);

		// 모델에 속성들을 추가
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);
		
		// 디버깅을 위해 회원 ID를 출력
		System.err.println(memberId);
		
		// 회원의 게시글 리스트 페이지를 반환
		return "usr/article/myList";
	}
	
	@RequestMapping("/usr/article/myQnA")
	public String showMyQnA(HttpServletRequest req, Model model,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		// rq 객체를 요청 속성에서 가져옴
		Rq rq = (Rq) req.getAttribute("rq");
		
		// 로그인된 회원의 ID를 가져옴
		Integer memberId = rq.getLoginedMemberId();

		// 주어진 검색 조건에 맞는 회원의 QnA 게시글 수를 가져옴
		int articlesCount = articleService.getMyQnACount(memberId, searchKeywordTypeCode, searchKeyword);

		// 한 페이지에 표시할 항목 수를 설정
		int itemsInAPage = 10;

		// 총 페이지 수를 계산
		int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

		// 주어진 조건에 맞는 회원의 QnA 게시글 리스트를 가져
		List<Article> articles = articleService.getForPrintMyQnA(memberId, itemsInAPage, page, searchKeywordTypeCode,
				searchKeyword);

		// 모델에 속성들을 추가
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);
		
		// 디버깅을 위해 회원 ID를 출력
		System.err.println(memberId);
		
		// 회원의 QnA 게시글 리스트 페이지를 반환
		return "usr/article/myQnA";
	}
	
	@RequestMapping("/usr/article/myReply")
	public String showMyReplies(HttpServletRequest req, Model model,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		// rq 객체를 요청 속성에서 가져옴
		Rq rq = (Rq) req.getAttribute("rq");
		
		// 로그인된 회원의 ID를 가져옴
		Integer memberId = rq.getLoginedMemberId();

		// 주어진 검색 조건에 맞는 회원의 댓글 수를 가져옴
		int articlesCount = articleService.getMyRepliesCount(memberId, searchKeywordTypeCode, searchKeyword);

		// 한 페이지에 표시할 항목 수를 설정
		int itemsInAPage = 10;

		// 총 페이지 수를 계산
		int pagesCount = (int) Math.ceil(articlesCount / (double) itemsInAPage);

		// 주어진 조건에 맞는 회원의 댓글 리스트를 가져옴
		List<Article> articles = articleService.getForPrintMyReplies(memberId, itemsInAPage, page, searchKeywordTypeCode,
				searchKeyword);

		// 모델에 속성들을 추가
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("articles", articles);
		
		// 디버깅을 위해 회원 ID를 출력
		System.err.println(memberId);
		
		// 회원의 댓글 리스트 페이지를 반환
		return "usr/article/myReply";
	}
	
	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Model model, int id) {
		// rq 객체를 요청 속성에서 가져옴
		Rq rq = (Rq) req.getAttribute("rq");

		// 게시글 ID로 게시글 정보를 가져옴
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);
		
		// 사용자의 반응 정보를 가져옴
		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), "article", id);

		// 사용자가 반응할 수 있는지 확인
		if (usersReactionRd.isSuccess()) {
			model.addAttribute("userCanMakeReaction", usersReactionRd.isSuccess());
		}

		// 게시글에 대한 댓글 리스트를 가져옴
		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "article", id);

		// 댓글 수를 가져옴
		int repliesCount = replies.size();

		// 모델에 속성들을 추가
		model.addAttribute("article", article);
		model.addAttribute("replies", replies);
		model.addAttribute("repliesCount", repliesCount);
		model.addAttribute("isAlreadyAddGoodRp",
				reactionPointService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), id, "article"));
		model.addAttribute("isAlreadyAddBadRp",
				reactionPointService.isAlreadyAddBadRp(rq.getLoginedMemberId(), id, "article"));

		// 게시글 상세 페이지를 반환.
		return "usr/article/detail";
	}

	@RequestMapping("/usr/article/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData doIncreaseHitCountRd(int id) {

		// 게시글 조회수 증가 요청을 처리
		ResultData increaseHitCountRd = articleService.increaseHitCount(id);

		// 요청이 실패한 경우, 해당 결과를 반환
		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		// 조회수 증가 후의 게시글 조회수를 가져옴
		ResultData rd = ResultData.newData(increaseHitCountRd, "hitCount", articleService.getArticleHitCount(id));

		// 게시글 ID를 추가.
		rd.setData2("id", id);

		// 최종 결과를 반환
		return rd;
	}

	@RequestMapping("/usr/article/write")
	public String showJoin(HttpServletRequest req) {
		// 게시글 작성 페이지를 반환.
		return "usr/article/write";
	}

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, String title, String body, int boardId) {

		// rq 객체를 요청 속성에서 가져옴
		Rq rq = (Rq) req.getAttribute("rq");

		// 제목이 비어있는 경우
		if (Ut.isNullOrEmpty(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력해주세요");
		}
		// 내용이 비어있는 경우
		if (Ut.isNullOrEmpty(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
		}

		// 게시글 작성 요청을 처리
		ResultData<Integer> writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body, boardId);

		// 작성된 게시글의 ID를 가져옴
		int id = (int) writeArticleRd.getData1();

		// 작성된 게시글 정보를 가져옴
		Article article = articleService.getArticle(id);

		// 게시글 상세 페이지로 리다이렉트
		return Ut.jsReplace(writeArticleRd.getResultCode(), writeArticleRd.getMsg(), "../article/detail?id=" + id);
	}

	@RequestMapping("/usr/article/modify")
	public String showModify(HttpServletRequest req, Model model, int id) {
		// rq 객체를 요청 속성에서 가져옴
		Rq rq = (Rq) req.getAttribute("rq");

		// 게시글 ID로 게시글 정보를 가져옴
		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		// 게시글이 존재하지 않는 경우
		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		// 모델에 게시글 정보를 추가
		model.addAttribute("article", article);

		// 게시글 수정 페이지를 반환
		return "usr/article/modify";
	}

	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int id, String title, String body) {
		// rq 객체를 요청 속성에서 가져옴
		Rq rq = (Rq) req.getAttribute("rq");

		// 게시글 ID로 게시글 정보를 가져옴.
		Article article = articleService.getArticle(id);

		// 게시글이 존재하지 않는 경우
		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		// 로그인된 회원이 수정 권한이 있는지 확인
		ResultData loginedMemberCanModifyRd = articleService.userCanModify(rq.getLoginedMemberId(), article);

		// 수정 권한이 있는 경우, 게시글을 수정
		if (loginedMemberCanModifyRd.isSuccess()) {
			articleService.modifyArticle(id, title, body);
		}

		// 게시글 상세 페이지로 리다이렉트
		return Ut.jsReplace(loginedMemberCanModifyRd.getResultCode(), loginedMemberCanModifyRd.getMsg(),
				"../article/detail?id=" + id);
	}

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {
		// rq 객체를 요청 속성에서 가져옴
		Rq rq = (Rq) req.getAttribute("rq");

		// 게시글 ID로 게시글 정보를 가져옴
		Article article = articleService.getArticle(id);

		// 게시글이 존재하지 않는 경우
		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글은 존재하지 않습니다", id));
		}

		// 로그인된 회원이 삭제 권한이 있는지 확인
		ResultData loginedMemberCanDeleteRd = articleService.userCanDelete(rq.getLoginedMemberId(), article);

		// 삭제 권한이 있는 경우, 게시글을 삭제
		if (loginedMemberCanDeleteRd.isSuccess()) {
			articleService.deleteArticle(id);
		}

		// 게시글 리스트 페이지로 리다이렉트
		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(),
				"../article/list");
	}
}
