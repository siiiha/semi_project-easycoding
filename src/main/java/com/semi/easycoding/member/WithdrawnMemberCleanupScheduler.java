package com.semi.easycoding.member;

import com.semi.easycoding.member.service.MemberService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class WithdrawnMemberCleanupScheduler {

    private final MemberService memberService;

    public WithdrawnMemberCleanupScheduler(MemberService memberService) {
        this.memberService = memberService;
    }

    //한국시간 기준 매일 새벽 3시
    //0초 0분 3시 *일 *월 *요일
    @Scheduled(cron = "0 0 3 * * *", zone = "Asia/Seoul")
    public void deleteExpiredWithdrawnMembers() {
        memberService.deleteExpiredWithdrawnMembers();
    }
}