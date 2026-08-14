package com.semi.easycoding.email.constant;
//중복되어 사용되는 세션키 문자열이 많아 가독성과 유지보수성을 고려하여 상수화 작업을 진행했음.

public final class EmailSessionKeys {

    public static final String EMAIL_VERIFICATION =
            "emailVerification";

    private EmailSessionKeys() {
    }
}