package com.semi.easycoding.member.controller;

import com.semi.easycoding.email.constant.EmailSessionKeys;
import com.semi.easycoding.email.constant.VerificationPurpose;
import com.semi.easycoding.email.dto.EmailVerification;
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

    @GetMapping("/check-nickname")
    @ResponseBody
    public boolean checkNickname(@RequestParam String nickname) {
        return memberService.isNicknameDuplicate(nickname.trim());
    }

    //사용자가 입력한 정보를 받는다.
    @PostMapping("/join")
    public String join(MemberDto memberDto,
                       HttpSession session,
                       Model model) {

        if (memberDto.getNickname() == null
                || memberDto.getNickname().trim().isEmpty()) {
            model.addAttribute("errorMsg", "닉네임을 입력해주세요.");
            return "member/join";
        }
        memberDto.setNickname(memberDto.getNickname().trim());

        EmailVerification verification =
                (EmailVerification) session.getAttribute(
                        EmailSessionKeys.EMAIL_VERIFICATION
                );

        if (verification == null
                || !verification.isVerified()
                || verification.isExpired()
                || verification.getPurpose() != VerificationPurpose.JOIN
                || !verification.getEmail().equals(memberDto.getEmail())) {

            model.addAttribute(
                    "errorMsg", "이메일 인증이 필요합니다."
            );
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

        if (memberService.isNicknameDuplicate(memberDto.getNickname())) {
            model.addAttribute(
                    "errorMsg",
                    "이미 사용중인 닉네임입니다."
            );
            return "member/join";
        }

        int result = memberService.join(memberDto);

        if (result > 0) {
            session.removeAttribute(
                    EmailSessionKeys.EMAIL_VERIFICATION
            );

            return "redirect:/member/login";
        }

        model.addAttribute("errorMsg", "회원가입에 실패했습니다.");
        return "member/join";
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
        EmailVerification verification =
                (EmailVerification) session.getAttribute(
                        EmailSessionKeys.EMAIL_VERIFICATION
                );
        if (verification == null
                || !verification.isVerified()
                || verification.isExpired()
                || verification.getPurpose()
                      != VerificationPurpose.PASSWORD_RESET) {
            return false;
        }

        String resetEmail = verification.getEmail();

        if (newPassword.isBlank()) {
            return false;
        }

        boolean result = memberService.resetPassword(
                resetEmail,
                newPassword
        );

        if (result) {
            session.removeAttribute(
                    EmailSessionKeys.EMAIL_VERIFICATION
            );
        }
        return result;
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
        model.addAttribute("member", loginUser);
        model.addAttribute("postCount", postCount);
        model.addAttribute("commentCount", commentCount);

        return "mypage/mypage";
    }

    // 회원정보 화면-데이터를 가져옴!
    @GetMapping("/edit")
    public String memberEditPage(HttpSession session) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }
        return "mypage/edit";
    }

    // 회원정보 수정 페이지 이동
    @PostMapping("/edit")
    public String memberEdit(
            @RequestParam String nickname, HttpSession session, Model model) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        String trimmedNickname = nickname.trim();

        if (trimmedNickname.isEmpty()) {
            model.addAttribute("errorMsg", "닉네임을 입력해주세요.");
            return "mypage/edit";
        }

        if (trimmedNickname.length() > 8) {
            model.addAttribute(
                    "errorMsg", "닉네임은 8자 이하로 입력해주세요."
            );
            return "mypage/edit";
        }

        if (!loginUser.getNickname().equals(trimmedNickname)
                && memberService.isNicknameDuplicate(trimmedNickname)) {
            model.addAttribute("errorMsg", "이미 사용중인 닉네임입니다.");
            return "mypage/edit";
        }

        //현재 로그인한 회원의 닉네임을 실제 DB에서 변경하고, 수정 결과를 받는 코드
        int result = memberService.updateNickname(
                loginUser.getMemberId(),
                trimmedNickname
        );
        if (result == 0) {
            model.addAttribute("errorMsg", "회원정보 수정에 실패했습니다.");
            return "mypage/edit";
        }

        //DB에서 최신 회원정보 다시 조회
        MemberDto updatedMember = memberService.findByMemberId(loginUser.getMemberId());
        //세션 정보를 최신 값으로 교체
        session.setAttribute("loginUser", updatedMember);
        return "redirect:/member/mypage";
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
