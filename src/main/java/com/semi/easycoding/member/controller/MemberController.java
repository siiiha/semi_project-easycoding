package com.semi.easycoding.member.controller;

import com.semi.easycoding.member.dto.MemberDto;
import com.semi.easycoding.member.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;
    //회원목록 조회
    //요청 : Get/member/list
    //파라미터 X
    //결과 : 회원목록 페이지 포워딩

    @GetMapping("/check-email")
    @ResponseBody
    //@ResponseBody는 메서드가 반환한 값을 화면 이름으로 찾지 말고, 요청한 곳에 데이터로 바로 보내라는 어노테이션
    public boolean checkEmail(@RequestParam String email) {
        return memberService.isEmailDuplicate(email);
    }


    //사용자가 입력한 정보를 받는다.
    @PostMapping("/join")
    public String join(MemberDto memberDto, //email, nickname, password가 있음
                       @RequestParam String passwordConfirm, //passwordConfirm : 두 번째 비밀번호 확인
                       HttpSession session, //EmailController 인증 결과
                       Model model) {

        Boolean emailVerified = (Boolean) session.getAttribute("joinEmailVerified");

        String verifiedEmail = (String) session.getAttribute("joinEmail");

        if (!Boolean.TRUE.equals(emailVerified)
            || !memberDto.getEmail().equals(verifiedEmail)) {
            model.addAttribute(
                    "errorMsg", "이메일 인증이 필요합니다."
            );
            return "member/join";
        }
        //emailVerified : 이메일 인증 성공 여부
        //verifiedEmail : 실제로 인증번호를 받은 이메일
        //memberDto.getEmail() : 회원가입을 눌렀을 때 입력되어 있던 이메일
        //이메일 인증을 완료하지 않은 경우, 인증받은 이메일과 가입하려는 이메일이 다른 경우 방지

        //memberDto.getPassword() : 첫 번째 비밀번호
        //passwordConfirm : 두 번째 비밀번호 확인
        //Model : 서로 다를 때 화면에 오류 문구를 전달한다.
        if (!memberDto.getPassword().equals(passwordConfirm)) {
            model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
            return "member/join";
        }

        if (memberService.isEmailDuplicate(memberDto.getEmail())) {
            //메서드가 실행 될 때 값이 true면 이미 사용 중, false면 사용 가능.
            model.addAttribute(
                    "errorMsg",
                    "이미 사용중인 이메일입니다."
            );
            return "member/join";
        }

        //위는 비밀번호가 일치하지 않을 경우. 아래는 일치할 경우.
        //회원이 추가되면 1, 추가되지 않으면 0
        int result = memberService.join(memberDto);
        //회원가입 처리 숫자를 담는다.

        if (result > 0) {
            session.removeAttribute("joinEmail");
            session.removeAttribute("joinEmailCode");
            session.removeAttribute("joinEmailVerified");
            session.removeAttribute("joinEmailCodeExpiresAt");
            //인증 정보를 지우는 이유
            //회원가입이 끝났는데 인증 정보가 남아 있다면 이전 인증 결과를 다시 사용할 수 있기 때문이다.
            //seesion.incalidate()는 사용하지 않는다. : 이메일 인증값뿐만아니라 세션의 모든 값을 지우기 때문.
            return "redirect:/member/login";
        }

        model.addAttribute("errorMsg", "회원가입에 실패했습니다.");
        return "member/join";

    }


    @PostMapping("/login")
    public String login(MemberDto memberDto, HttpSession session, Model model) {

        MemberDto loginMember = memberService.login(memberDto);
        //호출!

        if (loginMember != null) {
            session.setAttribute("loginUser", loginMember);
            return "redirect:/";
            //DB에서 일치하는 회원을 찾아 loginMember가 null이 아니라면,
            //그 회원정보를 loginUser라는 이름으로 세션에 저장하고 메인 주소로 이동
        }
        model.addAttribute("errorMsg", "이메일 또는 비밀번호가 올바르지 않습니다.");
        return "member/login";  //이메일과 비밀번호가 올바르지 않을 때는 로그인 화면으로 다시 이동

    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
        //작업이 끝났으니 메인 페이지로 가라.

    }

    // ---- 페이지 이동을 위한 메소드 ----

    // 로그인 페이지 이동
    @GetMapping("/login")
    public String loginPage() {
        return "member/login";
    }

    // 회원가입 페이지 이동
    @GetMapping("/join")
    public String joinPage() {
        return "member/join";
    }

    // 마이페이지 이동
    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model) {

        //세션에 저장된 로그인 회원 정보 가져오기
        MemberDto loginUser =
                (MemberDto) session.getAttribute("loginUser");
        //로그인 하지 않은 경우 로그인 페이지로 이동
        if (loginUser == null) {
            return "redirect:/member/login";
        }
        String memberId = loginUser.getMemberId();

        //해당 회원이 작성한 게시글과 댓글 개수 조회
        int postCount = memberService.countPostByMemberId(memberId);
        int commentCount = memberService.countCommentByMemberId(memberId);

        //조회 결과 전달
        model.addAttribute("postCount", postCount);
        model.addAttribute("commentCount", commentCount);

        return "mypage/mypage";
    }

    // 회원정보 수정 페이지 이동
    @GetMapping("/edit")
    public String memberEditPage() {
        return "mypage/edit";
    }

    // 회원탈퇴 페이지 이동
    @GetMapping("/withdraw")
    public String memberWithdrawPage(HttpSession session) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }
        return "mypage/withdraw";
    }

    @PostMapping("/withdraw")
    public String withdraw(@RequestParam String password, HttpSession session, Model model) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        boolean result = memberService.withdraw(
                loginUser.getMemberId(), password
        );

        if (!result) {
            model.addAttribute(
                    "errorMsg", "비밀번호가 일치하지 않습니다."
            );
            return "mypage/withdraw";
        }
        session.invalidate();
        return "redirect:/";
    }

    //비밀번호 찾기
    @GetMapping("/find-password")
    public String findPasswordPage() {
        return "member/find_password";
    }

    @PostMapping("/reset-password")
    @ResponseBody
    public boolean resetPassword(
            @RequestParam String newPassword,
            HttpSession session
    ) {
        Boolean emailVerified = (Boolean) session.getAttribute("resetEmailVerified");
        String resetEmail = (String) session.getAttribute("resetEmail");

        if (!Boolean.TRUE.equals(emailVerified) || resetEmail == null) {
            return false;
        }

        if (newPassword.isBlank()) {
            return false;
        }

        boolean result = memberService.resetPassword(
                resetEmail,
                newPassword
        );

        if (result) {
            session.removeAttribute("resetEmail");
            session.removeAttribute("resetEmailCode");
            session.removeAttribute("resetEmailVerified");
            session.removeAttribute("resetEmailCodeExpiresAt");
            //삭제하는 이유는 같은 이메일 인증 결과를 재사용하지 못하게 하기 위해서.
        }

        return result;
    }



}