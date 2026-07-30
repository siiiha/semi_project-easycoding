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
                       Model model) {

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
        return "redirect:/member/login";
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
}