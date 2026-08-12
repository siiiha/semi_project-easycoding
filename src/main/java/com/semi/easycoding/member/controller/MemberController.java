package com.semi.easycoding.member.controller;

import com.semi.easycoding.common.util.PasswordValidator;
import com.semi.easycoding.common.util.NicknameValidator;
import com.semi.easycoding.email.constant.EmailSessionKeys;
import com.semi.easycoding.email.constant.VerificationPurpose;
import com.semi.easycoding.email.dto.EmailVerification;
import com.semi.easycoding.member.dto.MemberDto;
import com.semi.easycoding.member.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member")
public class MemberController {

    private static final String PASSWORD_RULE_MESSAGE =
            "8~20자의 영문, 숫자, 특수문자(!@#$%^&*)를 모두 포함해주세요.";

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
    public String join(
            MemberDto memberDto,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes
    ) {

        String trimmedNickname =
                memberDto.getNickname() == null
                        ? null
                        : memberDto.getNickname().trim();

        if (!NicknameValidator.isValid(trimmedNickname)) {
            model.addAttribute(
                    "errorMsg",
                    "닉네임은 1~8자의 한글, 영문, 숫자만 사용할 수 있습니다."
            );
            return "member/join";
        }

        memberDto.setNickname(trimmedNickname);

        if (!PasswordValidator.isValid(memberDto.getPassword())) {
            model.addAttribute(
                    "errorMsg",
                    PASSWORD_RULE_MESSAGE
            );
            return "member/join";
        }

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

            redirectAttributes.addFlashAttribute(
                    "successTitle",
                    "회원가입 완료"
            );

            redirectAttributes.addFlashAttribute(
                    "successMsg",
                    "회원가입을 완료했습니다."
            );

            return "redirect:/member/login";
        }

        model.addAttribute("errorMsg", "회원가입에 실패했습니다.");
        return "member/join";
    }

    @GetMapping("/find-id")
    public String findIdPage() {
        return "member/find_id";
    }

    @PostMapping("/find-id")
    public String findId(
            @RequestParam String nickname,
            Model model) {
        String email = memberService.findMaskedEmailByNickname(nickname);

        if (email == null || email.isEmpty()) {
            model.addAttribute("notFoundMsg", "찾을 수 없는 닉네임입니다.");
            return "member/find_id";
        }

        model.addAttribute("foundEmail", email);

        return "member/find_id";
    }

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

        if (!PasswordValidator.isValid(newPassword)) {
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
    public String login(
            @RequestParam(required = false) String redirectURL,
            MemberDto memberDto,
            HttpSession session,
            Model model
    ) {

        MemberDto loginMember = memberService.login(memberDto);
        //호출!

        if (loginMember != null) {
            session.setAttribute("loginUser", loginMember);

            if (redirectURL != null
                    && redirectURL.startsWith("/")
                    && !redirectURL.startsWith("//")) {
                return "redirect:" + redirectURL;
            }

            return "redirect:/";
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
        Long memberId = loginUser.getMemberId();

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
            @RequestParam String nickname,
            @RequestParam String currentPassword,
            @RequestParam String newPassword,
            @RequestParam(required = false) Short profileId,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
        MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        String trimmedNickname = nickname.trim();

        if (!NicknameValidator.isValid(trimmedNickname)) {
            model.addAttribute(
                    "errorMsg",
                    "닉네임은 1~8자의 한글, 영문, 숫자만 사용할 수 있습니다."
            );
            return "mypage/edit";
        }

        if (!loginUser.getNickname().equals(trimmedNickname)
                && memberService.isNicknameDuplicate(trimmedNickname)) {
            model.addAttribute("errorMsg", "이미 사용중인 닉네임입니다.");
            return "mypage/edit";
        }

        if (!newPassword.isBlank()) {
            if (!PasswordValidator.isValid(newPassword)) {
                model.addAttribute(
                        "errorMsg",
                        PASSWORD_RULE_MESSAGE
                );
                return "mypage/edit";
            }

            if (currentPassword.equals(newPassword)) {
                model.addAttribute(
                        "errorMsg", "새 비밀번호는 현재 비밀번호와 다르게 입력해주세요."
                );
                return "mypage/edit";
            }

            boolean passwordUpdated =
                    memberService.updatePassword(
                            loginUser.getMemberId(),
                            currentPassword,
                            newPassword
                    );

            if (!passwordUpdated) {
                model.addAttribute(
                        "errorMsg", "현재 비밀번호가 일치하지 않습니다."
                );
                return "mypage/edit";
            }
        }

        if (!loginUser.getNickname().equals(trimmedNickname)) {
            int result = memberService.updateNickname(
                    loginUser.getMemberId(),
                    trimmedNickname
            );

            if (result == 0) {
                model.addAttribute("errorMsg", "회원정보 수정에 실패했습니다.");
                return "mypage/edit";
            }
        }

        if (profileId != null
                && !profileId.equals(loginUser.getProfileId())) {
            int result = memberService.updateProfileId(
                    loginUser.getMemberId(),
                    profileId
            );

            if (result == 0) {
                model.addAttribute(
                        "errorMsg",
                        "프로필 이미지 변경에 실패했습니다."
                );
                return "mypage/edit";
            }
        }

        //DB에서 최신 회원정보 다시 조회
        MemberDto updatedMember =
                memberService.findByMemberId(loginUser.getMemberId());
        //세션 정보를 최신 값으로 교체
        session.setAttribute("loginUser", updatedMember);

        redirectAttributes.addFlashAttribute(
                "successMsg",
                "회원정보 수정이 완료되었습니다."
        );

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
    public String withdraw(
            @RequestParam String password,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes
    ) {
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

        redirectAttributes.addFlashAttribute(
                "successTitle",
                "회원탈퇴 완료"
        );
        redirectAttributes.addFlashAttribute(
                "successMsg",
                "회원탈퇴가 완료되었습니다."
        );

        return "redirect:/member/login";
    }
}
