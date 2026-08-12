package com.semi.easycoding.common.interceptor;

import com.semi.easycoding.common.util.SessionConst;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

/** 로그인한 회원이 로그인·회원가입 페이지에 다시 접근하지 못하도록 한다. */
public class MemberEntryInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
            Object handler
    ) throws Exception {
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute(SessionConst.LOGIN_USER) != null;

        if (!isLoggedIn) {
            return true;
        }

        response.sendRedirect(request.getContextPath() + "/");
        return false;
    }
}
