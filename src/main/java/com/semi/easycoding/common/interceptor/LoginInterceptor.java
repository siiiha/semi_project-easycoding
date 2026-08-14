package com.semi.easycoding.common.interceptor;

import com.semi.easycoding.common.util.SessionConst;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler
    ) throws Exception {
        HttpSession session = request.getSession(false);    // 세션이 없으면 null반환 : 세션이 없는 것을 방지

        // 로그인 여부 : true(로그인), false(비로그인)
        boolean isLogined = session != null && session.getAttribute(SessionConst.LOGIN_USER) != null;

        if (isLogined){
            return true;    // 세션이 로그인 되어있으면 그대로 controller 진행, 비로그인 시 아래 코드들을 통해 응답
        }

        if (isApiRequest(request)) {
            // 데이터만 주고받는 Ajax요청인 경우
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);    // 응답 http상태코드를 401로 전달
            response.setContentType("application/json; charset=UTF-8"); // 응답 데이터를 JSON형태로 보내겠다고 명시

            // 응답 본문을 작성
            try (PrintWriter writer = response.getWriter()) {
                writer.write("{\"success\":false, \"message\":\"로그인이 필요합니다.\"}");
                // JSON {"success": false, "message": "로그인이 필요합니다."} 로 전달하기 위해 응답 데이터를 생성
                // -> 이후 각 페이지에서 modal을 호출하려 "잘못된 접근" or "로그인 필요"를 화면에 표시하면 됩니다.
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            // 일반적인 경우
            String redirectURL = URLEncoder.encode(request.getRequestURI(), StandardCharsets.UTF_8);
            // 요청 객체에서 요청받았을때에 서버 정보를 제외한 URL경로를 가져온다. (localhost:8080은 제외)
            response.sendRedirect("/member/login?redirectURL=" + redirectURL);
            // redirect를 위에 만든 redirectURL로 다시 요청하도록 응답
        }

        return false;
    }

    // Ajax(API)요청인지 구분해주는 메소드
    private boolean isApiRequest(HttpServletRequest request){

        String uri = request.getRequestURI();
        String requestedWith = request.getHeader("X-Requested-With");
        String accept = request.getHeader("Accept");
        return
                uri.startsWith(request.getContextPath() + "/api") // 요청 URL에 /api로 시작하는 경우
                || "XMLHttpRequest".equals(requestedWith)         // Ajax 요청방식인 XMLHttpRequest가 header에 있는 경우
                || (accept != null && accept.contains("application/json")); // JSON응답을 원하는 경우
    }
}