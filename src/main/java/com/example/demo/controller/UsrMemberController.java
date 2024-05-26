package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrMemberController {

    @Autowired // Rq 객체 주입
    private Rq rq;

    @Autowired // MemberService 객체 주입
    private MemberService memberService;

    @RequestMapping("/usr/member/doDeleteId") // 회원 탈퇴 요청을 처리하는 메서드 매핑
    @ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정
    public String doDeleteId(HttpServletRequest req, @RequestParam(defaultValue = "/") String afterLogoutUri) {
        Rq rq = (Rq) req.getAttribute("rq"); // 요청 속성에서 Rq 객체를 가져옴
        System.err.println("rq.loginedId: " + rq.getLoginedMember().getLoginId()); // 로그인을 확인하는 출력문

        if (!rq.isLogined()) { // 로그인 여부 확인
            return Ut.jsHistoryBack("F-A", "로그인 후 이용해주세요"); // 로그인이 안 되어 있으면 경고 메시지 반환
        }

        memberService.deleteId(rq.getLoginedMember().getLoginId()); // 회원 탈퇴 처리
        rq.logout(); // 로그아웃 처리

        return Ut.jsReplace("S-1", "탈퇴가 완료되었습니다", afterLogoutUri); // 탈퇴 완료 메시지 반환
    }

    @RequestMapping("/usr/member/getLoginIdDup") // 아이디 중복 확인 요청을 처리하는 메서드 매핑
    @ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정
    public ResultData getLoginIdDup(String loginId) {

        if (Ut.isEmpty(loginId)) { // 아이디가 비어 있는지 확인
            return ResultData.from("F-1", "아이디를 입력해주세요"); // 아이디가 비어 있으면 경고 메시지 반환
        }

        Member existsMember = memberService.getMemberByLoginId(loginId); // 아이디로 회원 조회

        if (existsMember != null) { // 이미 존재하는 아이디인지 확인
            return ResultData.from("F-2", "해당 아이디는 이미 사용중입니다", "loginId", loginId); // 중복 아이디 경고 메시지 반환
        }

        return ResultData.from("S-1", "사용 가능한 아이디입니다", "loginId", loginId); // 사용 가능한 아이디 메시지 반환
    }

    @RequestMapping("/usr/member/doLogout") // 로그아웃 요청을 처리하는 메서드 매핑
    @ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정
    public String doLogout(HttpServletRequest req, @RequestParam(defaultValue = "/") String afterLogoutUri) {
        Rq rq = (Rq) req.getAttribute("rq"); // 요청 속성에서 Rq 객체를 가져옴

        if (!rq.isLogined()) { // 로그인 여부 확인
            return Ut.jsHistoryBack("F-A", "이미 로그아웃 상태입니다"); // 이미 로그아웃 상태면 경고 메시지 반환
        }

        rq.logout(); // 로그아웃 처리

        return Ut.jsReplace("S-1", "로그아웃 되었습니다", afterLogoutUri); // 로그아웃 완료 메시지 반환
    }

    @RequestMapping("/usr/member/login") // 로그인 페이지 요청을 처리하는 메서드 매핑
    public String showLogin(HttpServletRequest req) {

        Rq rq = (Rq) req.getAttribute("rq"); // 요청 속성에서 Rq 객체를 가져옴

        if (rq.isLogined()) { // 로그인 여부 확인
            return Ut.jsHistoryBack("F-A", "이미 로그인 상태입니다"); // 이미 로그인 상태면 경고 메시지 반환
        }

        return "usr/member/login"; // 로그인 페이지로 이동
    }

    @RequestMapping("/usr/member/doLogin") // 로그인 처리 요청을 처리하는 메서드 매핑
    @ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정
    public String doLogin(HttpServletRequest req, String loginId, String loginPw,
                          @RequestParam(defaultValue = "/") String afterLoginUri) {

        Rq rq = (Rq) req.getAttribute("rq"); // 요청 속성에서 Rq 객체를 가져옴

        if (rq.isLogined()) { // 로그인 여부 확인
            return Ut.jsHistoryBack("F-A", "이미 로그인 상태입니다"); // 이미 로그인 상태면 경고 메시지 반환
        }

        if (Ut.isNullOrEmpty(loginId)) { // 아이디가 비어 있는지 확인
            return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요"); // 아이디가 비어 있으면 경고 메시지 반환
        }
        if (Ut.isNullOrEmpty(loginPw)) { // 비밀번호가 비어 있는지 확인
            return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요"); // 비밀번호가 비어 있으면 경고 메시지 반환
        }

        Member member = memberService.getMemberByLoginId(loginId); // 아이디로 회원 조회

        if (member == null) { // 회원이 존재하지 않는지 확인
            return Ut.jsHistoryBack("F-3", Ut.f("%s(은)는 존재하지 않는 아이디입니다", loginId)); // 존재하지 않는 아이디 경고 메시지 반환
        }

        if (!member.getLoginPw().equals(loginPw)) { // 비밀번호가 일치하지 않는지 확인
            return Ut.jsHistoryBack("F-4", "비밀번호가 일치하지 않습니다"); // 비밀번호 불일치 경고 메시지 반환
        }

        if (member.getDelStatus() == 0) { // 탈퇴 여부 확인
            rq.login(member); // 탈퇴하지 않았다면 로그인 처리
        } else {
            return Ut.jsHistoryBack("F-5", Ut.f("%s(은)는 탈퇴한 회원입니다.", loginId)); // 탈퇴한 회원 경고 메시지 반환
        }

        if (afterLoginUri.length() > 0) { // 로그인 후 이동할 URI가 있는지 확인
            return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getNickname()), afterLoginUri); // 로그인 성공 메시지 반환 후 리다이렉트
        }

        return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getNickname()), "/"); // 로그인 성공 메시지 반환 후 리다이렉트
    }

    @RequestMapping("/usr/member/join") // 회원가입 페이지 요청을 처리하는 메서드 매핑
    public String showJoin(HttpServletRequest req) {
        return "usr/member/join"; // 회원가입 페이지로 이동
    }

    @RequestMapping("/usr/member/doJoin") // 회원가입 처리 요청을 처리하는 메서드 매핑
    @ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정
    public String doJoin(HttpServletRequest req, String loginId, String loginPw, String name, String nickname,
                         String cellphoneNum, String email) {
        Rq rq = (Rq) req.getAttribute("rq"); // 요청 속성에서 Rq 객체를 가져옴

        if (rq.isLogined()) { // 로그인 여부 확인
            return Ut.jsHistoryBack("F-A", "이미 로그인 상태입니다"); // 이미 로그인 상태면 경고 메시지 반환
        }

        if (Ut.isNullOrEmpty(loginId)) { // 아이디가 비어 있는지 확인
            return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요"); // 아이디가 비어 있으면 경고 메시지 반환
        }
        if (Ut.isNullOrEmpty(loginPw)) { // 비밀번호가 비어 있는지 확인
            return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요"); // 비밀번호가 비어 있으면 경고 메시지 반환
        }
        if (Ut.isNullOrEmpty(name)) { // 이름이 비어 있는지 확인
            return Ut.jsHistoryBack("F-3", "이름을 입력해주세요"); // 이름이 비어 있으면 경고 메시지 반환
        }
        if (Ut.isNullOrEmpty(nickname)) { // 닉네임이 비어 있는지 확인
            return Ut.jsHistoryBack("F-4", "닉네임을 입력해주세요"); // 닉네임이 비어 있으면 경고 메시지 반환
        }
        if (Ut.isNullOrEmpty(cellphoneNum)) { // 전화번호가 비어 있는지 확인
            return Ut.jsHistoryBack("F-5", "전화번호를 입력해주세요"); // 전화번호가 비어 있으면 경고 메시지 반환
        }
        if (Ut.isNullOrEmpty(email)) { // 이메일이 비어 있는지 확인
            return Ut.jsHistoryBack("F-6", "이메일을 입력해주세요"); // 이메일이 비어 있으면 경고 메시지 반환
        }

        ResultData<Integer> joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNum, email); // 회원가입 처리

        if (joinRd.isFail()) { // 회원가입 실패 여부 확인
            return Ut.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg()); // 회원가입 실패 시 경고 메시지 반환
        }

        Member member = memberService.getMember(joinRd.getData1()); // 가입된 회원 정보 가져오기

        return Ut.jsReplace(joinRd.getResultCode(), joinRd.getMsg(), "../member/login"); // 회원가입 성공 시 로그인 페이지로 이동
    }

    @RequestMapping("/usr/member/myPage") // 마이 페이지 요청을 처리하는 메서드 매핑
    public String showMyPage(HttpServletRequest req, Model model) {
        Rq rq = (Rq) req.getAttribute("rq"); // 요청 속성에서 Rq 객체를 가져옴

        Integer memberId = rq.getLoginedMemberId(); // 현재 로그인한 회원의 아이디 가져오기

        int myWriteCount = memberService.getMyWriteCount(memberId); // 내가 작성한 글 수 가져오기
        int myReplyCount = memberService.getMyReplyCount(memberId); // 내가 작성한 댓글 수 가져오기
        int myQuestionCount = memberService.getMyQuestionCount(memberId); // 내가 작성한 질문 수 가져오기
        int myScrapCount = memberService.getMyScrapCount(memberId); // 내가 스크랩한 글 수 가져오기

        model.addAttribute("myWriteCount", myWriteCount); // 모델에 내가 작성한 글 수 추가
        model.addAttribute("myReplyCount", myReplyCount); // 모델에 내가 작성한 댓글 수 추가
        model.addAttribute("myQuestionCount", myQuestionCount); // 모델에 내가 작성한 질문 수 추가
        model.addAttribute("myScrapCount", myScrapCount); // 모델에 내가 스크랩한 글 수 추가

        return "usr/member/myPage"; // 마이 페이지로 이동
    }

    @RequestMapping("/usr/member/myInfo") // 내 정보 페이지 요청을 처리하는 메서드 매핑
    public String showMyInfo() {
        return "usr/member/myInfo"; // 내 정보 페이지로 이동
    }

    @RequestMapping("/usr/member/checkPw") // 비밀번호 확인 페이지 요청을 처리하는 메서드 매핑
    public String showCheckPw() {
        return "usr/member/checkPw"; // 비밀번호 확인 페이지로 이동
    }

    @RequestMapping("/usr/member/doCheckPw") // 비밀번호 확인 요청을 처리하는 메서드 매핑
    public String doCheckPw(String loginPw) {

        if (Ut.isNullOrEmpty(loginPw)) { // 비밀번호가 비어 있는지 확인
            return rq.historyBackOnView("비밀번호를 입력해주세요"); // 비밀번호가 비어 있으면 경고 메시지 반환
        }

        if (!rq.getLoginedMember().getLoginPw().equals(loginPw)) { // 입력한 비밀번호가 일치하지 않는지 확인
            return rq.historyBackOnView("비밀번호가 틀렸습니다"); // 비밀번호가 일치하지 않으면 경고 메시지 반환
        }

        return "usr/member/modify"; // 비밀번호가 일치하면 회원 정보 수정 페이지로 이동
    }

    @RequestMapping("/usr/member/doModify") // 회원 정보 수정 요청을 처리하는 메서드 매핑
    @ResponseBody // 반환되는 값이 HTTP 응답 본문에 직접 쓰이도록 지정
    public String doModify(HttpServletRequest req, String loginPw, String name, String nickname, String cellphoneNum,
                           String email) {
        Rq rq = (Rq) req.getAttribute("rq"); // 요청 속성에서 Rq 객체를 가져옴

        // 비밀번호 안바꿀 수도 있어서 비번 null 체크는 제거

        if (Ut.isNullOrEmpty(name)) { // 이름이 비어 있는지 확인
            return Ut.jsHistoryBack("F-3", "이름을 입력해주세요"); // 이름이 비어 있으면 경고 메시지 반환
        }
        if (Ut.isNullOrEmpty(nickname)) { // 닉네임이 비어 있는지 확인
            return Ut.jsHistoryBack("F-4", "닉네임을 입력해주세요"); // 닉네임이 비어 있으면 경고 메시지 반환
        }
        if (Ut.isNullOrEmpty(cellphoneNum)) { // 전화번호가 비어 있는지 확인
            return Ut.jsHistoryBack("F-5", "전화번호를 입력해주세요"); // 전화번호가 비어 있으면 경고 메시지 반환
        }
        if (Ut.isNullOrEmpty(email)) { // 이메일이 비어 있는지 확인
            return Ut.jsHistoryBack("F-6", "이메일을 입력해주세요"); // 이메일이 비어 있으면 경고 메시지 반환
        }

        ResultData modifyRd;

        if (Ut.isNullOrEmpty(loginPw)) { // 비밀번호가 비어 있는지 확인
            modifyRd = memberService.modifyWithoutPw(rq.getLoginedMemberId(), name, nickname, cellphoneNum, email); // 비밀번호 변경 없이 회원 정보 수정
        } else {
            modifyRd = memberService.modify(rq.getLoginedMemberId(), loginPw, name, nickname, cellphoneNum, email); // 회원 정보 수정
        }

        return Ut.jsReplace(modifyRd.getResultCode(), modifyRd.getMsg(), "../member/myInfo"); // 회원 정보 수정 결과 반환
    }
}
