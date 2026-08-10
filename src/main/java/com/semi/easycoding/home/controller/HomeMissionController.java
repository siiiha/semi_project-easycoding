package com.semi.easycoding.home.controller;

import com.semi.easycoding.common.util.SessionUtil;
import com.semi.easycoding.home.service.HomeDashboardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeMissionController {

    private final HomeDashboardService homeDashboardService;

    public HomeMissionController(HomeDashboardService homeDashboardService) {
        this.homeDashboardService = homeDashboardService;
    }

    // 선택한 문제 수와 카테고리에 맞춰 오늘의 문제를 준비한다.
    @PostMapping("/home/daily/quiz/start")
    public String startDailyQuiz(
            @RequestParam int problemCount,
            @RequestParam(required = false) Long categoryId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Long memberId = SessionUtil.getLoginMemberId(session);

        try {
            homeDashboardService.prepareDailyQuiz(memberId, problemCount, categoryId);
        } catch (IllegalArgumentException exception) {
            redirectAttributes.addFlashAttribute(
                    "missionError",
                    exception.getMessage());
            return "redirect:/";
        }

        return "redirect:/education/daily/quiz";
    }
}
