package com.semi.easycoding.email.dto;

import com.semi.easycoding.email.constant.VerificationPurpose;
import lombok.Getter;

@Getter
public class EmailVerification {

    private final String email;
    private final String code;
    private boolean verified;
    private final long expiresAt;
    private final VerificationPurpose purpose;

    public EmailVerification(
            String email,
            String code,
            long expiresAt,
            VerificationPurpose purpose
    ) {
        this.email = email;
        this.code = code;
        this.verified = false;
        this.expiresAt = expiresAt;
        this.purpose = purpose;
    }

    public boolean isExpired() {
        return System.currentTimeMillis() > expiresAt;
    }

    public boolean matchesCode(String inputCode) {
        return code.equals(inputCode);
    }

    public void markVerified() {
        this.verified = true;
    }
}
