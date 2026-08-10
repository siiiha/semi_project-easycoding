package com.semi.easycoding.common.util;

import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;

public final class SessionUtil {

    private SessionUtil() {
    }
    // 세션에서 로그인 회원의 ID를 꺼내 반환
    public static Long getLoginMemberId(HttpSession session) {
        MemberDto loginUser =
                (MemberDto) session.getAttribute(SessionConst.LOGIN_USER);

        return Long.valueOf(loginUser.getMemberId());
    }
}