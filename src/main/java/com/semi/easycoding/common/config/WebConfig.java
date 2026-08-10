package com.semi.easycoding.common.config;

import com.semi.easycoding.common.interceptor.LoginInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration  // Spring MVC의 공통 설정 구현체를 명시
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns(
                        // 로그인을 해야만 접근이 가능한 경로
                        "/member/mypage",
                        "/member/withdraw",
                        "/community/write",
                        "/community/{postId}/edit",
                        "/education/**"
                        // 필요한 경로 추가 하시면 됩니다.
                        // 로그인 요청 시 redirect를 이전 화면으로 갈 수 있게 수정해주세요.
                );
    }
}
