package com.semi.easycoding.email.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.semi.easycoding.email.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.semi.easycoding.member.service.MemberService;


@RestController
@RequestMapping("/email")
public class EmailController {
    private final EmailService emailService;
    //인증번호를 만들어 이메일로 보냄
    private final MemberService memberService;
    //입력한 이메일이 가입된 이메일인지 확인

    public EmailController(
            EmailService emailService,
            MemberService memberService
    ) {
        this.emailService = emailService;
        this.memberService = memberService;
    }

    @PostMapping("/join/send")  
    public String sendJoinCode(@RequestParam String email, HttpSession session){
        String code = emailService.sendVerificationCode(email);

        //인증번호가 맞는지 확인하기 위해 세션에 저장하는 것들
        session.setAttribute("joinEmail", email);
        session.setAttribute("joinEmailCode", code);
        session.setAttribute("joinEmailVerified", false);
        //인증 전이니까 false

        session.setAttribute(
                "joinEmailCodeExpiresAt",
                System.currentTimeMillis() + 5 * 60 * 1000
        );

        return "인증번호를 발송했습니다.";
    }

    @PostMapping("/password/send")
    public boolean sendPasswordCode(
            @RequestParam String email,
            HttpSession session
    ) {
        if (!memberService.isEmailDuplicate(email)) {
            return false;
        }

        String code = emailService.sendVerificationCode(email);

        session.setAttribute("resetEmail", email);
        session.setAttribute("resetEmailCode", code);
        session.setAttribute("resetEmailVerified", false);

        session.setAttribute("resetEmailCodeExpiresAt",
                System.currentTimeMillis() + 5 * 60 * 1000
        );
        return true;
    }

    @PostMapping("/password/verify")
    public boolean verifyPasswordCode(@RequestParam String code, HttpSession session
    ) {
        String savedCode = (String) session.getAttribute("resetEmailCode");
        Long expiresAt = (Long) session.getAttribute("resetEmailCodeExpiresAt");
        if (savedCode == null || expiresAt == null) {
            return false;
        }

        if (System.currentTimeMillis() > expiresAt) {
            return false;
        }

        if (!savedCode.equals(code)) {
            return false;
        }

        session.setAttribute("resetEmailVerified", true);
        return true;
    }

    @PostMapping("/join/verify")
    public boolean verifyJoinCode(@RequestParam String code, HttpSession session){

        String savedCode = (String) session.getAttribute("joinEmailCode");
        Long expiresAt = (Long) session.getAttribute("joinEmailCodeExpiresAt");

        if (savedCode == null || expiresAt == null) {
            return false;
        }
        //savedCode == null: 저장된 인증번호가 없음
        //expiresAt == null: 저장된 만료 시간이 없음

        if (System.currentTimeMillis() > expiresAt) {
            return false;
        } //만료 시각이 지남

        if (!savedCode.equals(code)) {
            return false;
        } //두 인증번호가 다르다

        session.setAttribute("joinEmailVerified", true);
        return true;


    }
}
