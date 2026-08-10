package com.semi.easycoding.common;

import com.semi.easycoding.common.util.SessionConst;
import com.semi.easycoding.education.service.EducationService;
import com.semi.easycoding.home.service.HomeDashboardService;
import com.semi.easycoding.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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

    // 로그인 여부에 따라 메인 화면을 반환한다.
    @GetMapping("/")
    public String home(HttpSession session, Model model) {
        MemberDto loginUser =
                (MemberDto) session.getAttribute(SessionConst.LOGIN_USER);

        if (loginUser == null) {
            return "home/main";
        }

        Long memberId = Long.valueOf(loginUser.getMemberId());

        model.addAttribute("categories", educationService.getAllEduCategory());
        model.addAttribute(
                "todayProgress",
                homeDashboardService.getTodayProgress(memberId));
        model.addAttribute(
                "grassCells",
                homeDashboardService.getGrassCells(memberId));
        model.addAttribute(
                "learningStats",
                homeDashboardService.getLearningStats(memberId));

        return "home/main_user";
    }
}
