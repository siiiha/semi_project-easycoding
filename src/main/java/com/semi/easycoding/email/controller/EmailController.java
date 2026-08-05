package com.semi.easycoding.email.controller;

import com.semi.easycoding.common.dto.ApiResponse;
import com.semi.easycoding.email.constant.EmailSessionKeys;
import com.semi.easycoding.email.constant.VerificationPurpose;
import com.semi.easycoding.email.dto.EmailVerification;
import com.semi.easycoding.email.service.EmailService;
import com.semi.easycoding.member.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.time.Duration;

@RestController
@RequestMapping("/email")
public class EmailController {

    private static final Duration VERIFICATION_CODE_TTL =
            Duration.ofMinutes(5);

    private final EmailService emailService;
    private final MemberService memberService;

    public EmailController(
            EmailService emailService,
            MemberService memberService
    ) {
        this.emailService = emailService;
        this.memberService = memberService;
    }

    @PostMapping("/join/send")
    public ResponseEntity<ApiResponse<String>> sendJoinCode(
            @RequestParam String email,
            HttpSession session
    ) {
        String code = emailService.sendVerificationCode(email);
        if (code == null || code.isBlank()) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.fail("인증번호 발송에 실패했습니다."));
        }

        saveVerification(
                session,
                email,
                code,
                VerificationPurpose.JOIN
        );

        return ResponseEntity.ok(
                ApiResponse.success("인증번호를 발송했습니다.")
        );
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

        saveVerification(
                session,
                email,
                code,
                VerificationPurpose.PASSWORD_RESET
        );

        return true;
    }

    @PostMapping("/password/verify")
    public boolean verifyPasswordCode(
            @RequestParam String code,
            HttpSession session
    ) {
        return verifyCode(
                code,
                session,
                VerificationPurpose.PASSWORD_RESET
        );
    }

    @PostMapping("/join/verify")
    public boolean verifyJoinCode(
            @RequestParam String code,
            HttpSession session
    ) {
        return verifyCode(
                code,
                session,
                VerificationPurpose.JOIN
        );
    }

    private void saveVerification(
            HttpSession session,
            String email,
            String code,
            VerificationPurpose purpose
    ) {
        EmailVerification verification =
                new EmailVerification(
                        email,
                        code,
                        System.currentTimeMillis()
                                + VERIFICATION_CODE_TTL.toMillis(),
                        purpose
                );

        session.setAttribute(
                EmailSessionKeys.EMAIL_VERIFICATION,
                verification
        );
    }

    private boolean verifyCode(
            String code,
            HttpSession session,
            VerificationPurpose expectedPurpose
    ) {
        EmailVerification verification =
                (EmailVerification) session.getAttribute(
                        EmailSessionKeys.EMAIL_VERIFICATION
                );

        if (verification == null) {
            return false;
        }

        if (verification.getPurpose() != expectedPurpose) {
            return false;
        }

        if (verification.isExpired()) {
            session.removeAttribute(
                    EmailSessionKeys.EMAIL_VERIFICATION
            );
            return false;
        }

        if (!verification.matchesCode(code)) {
            return false;
        }

        verification.markVerified();

        session.setAttribute(
                EmailSessionKeys.EMAIL_VERIFICATION,
                verification
        );
        return true;
    }
}
