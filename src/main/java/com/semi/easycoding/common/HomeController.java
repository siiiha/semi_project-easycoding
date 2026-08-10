package com.semi.easycoding.common;

import com.semi.easycoding.common.util.SessionConst;
import com.semi.easycoding.education.service.EducationService;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.semi.easycoding.home.service.HomeDashboardService;

@Controller
public class HomeController {

    private final EducationService educationService;
    private final HomeDashboardService homeDashboardService;

    public HomeController(
            EducationService educationService,
            HomeDashboardService homeDashboardService) {
        this.educationService = educationService;
        this.homeDashboardService = homeDashboardService;
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
                    homeDashboardService.getTodayProgress(memberId)
            );

            model.addAttribute(
                    "grassCells",
                    homeDashboardService.getGrassCells(memberId)
            );

            model.addAttribute(
                    "learningStats",
                    homeDashboardService.getLearningStats(memberId)
            );

            return "home/main_user";
        }

        return "home/main";
    }



}
