package com.semi.easycoding.common;

import com.semi.easycoding.common.util.SessionConst;
import com.semi.easycoding.education.service.EducationService;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private final EducationService educationService;

    public HomeController(EducationService educationService) {
        this.educationService = educationService;
    }

    // 메인화면 로드
    @GetMapping("/")
    public String home(HttpSession session, Model model) {
        MemberDto loginUser = (MemberDto) session.getAttribute(SessionConst.LOGIN_USER);
        if (loginUser != null) {
            Long memberId = Long.valueOf(loginUser.getMemberId());

            model.addAttribute(
                    "categories",
                    educationService.getAllEduCategory()
            );
            model.addAttribute(
                    "todayProgress",
                    educationService.getTodayProgress(memberId)
            );

            return "home/main_user";
        }
        return "home/main";
    }
}
