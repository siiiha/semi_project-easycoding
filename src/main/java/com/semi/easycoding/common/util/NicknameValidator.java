package com.semi.easycoding.common.util;

import java.util.regex.Pattern;

public final class NicknameValidator {

    private static final Pattern NICKNAME_PATTERN =
            Pattern.compile("^[가-힣A-Za-z0-9]{1,8}$");

    private NicknameValidator() {
    }

    public static boolean isValid(String nickname) {
        return nickname != null
                && NICKNAME_PATTERN.matcher(nickname).matches();
    }
}