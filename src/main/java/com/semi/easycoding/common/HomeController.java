package com.semi.easycoding.common;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // 메인화면 로드
    @GetMapping("/")
    public String home(HttpSession session) {
        if (session.getAttribute("loginUser") != null) {
            return "home/main_user";
        }

        return "home/main";
    }

}
