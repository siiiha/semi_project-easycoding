package com.semi.easycoding.common.util;

import java.util.regex.Pattern;

public final class PasswordValidator {

    private static final Pattern PASSWORD_PATTERN =
            Pattern.compile(
                    "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])"
                            + "[A-Za-z\\d!@#$%^&*]{8,20}$"
            );

    private PasswordValidator() {
    }

    public static boolean isValid(String password) {
        return password != null
                && PASSWORD_PATTERN.matcher(password).matches();
    }
}
