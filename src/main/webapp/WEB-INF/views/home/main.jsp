<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쉽코딩 - 매일 한 걸음, 매일 성장하는 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="main-page">

    <!-- ── 히어로 섹션 ── -->
    <section class="hero-section">
        <div class="hero-content">
            <div class="hero-text">
                <h1 class="hero-title">
                    <span class="text-primary">매일 한 걸음,</span><br>
                    매일 성장하는 <span class="text-primary">쉽코딩</span>
                </h1>
                <p class="hero-sub">Java 학습을 쉽고 재미있게, 꾸준한 습관으로 만들어요.</p>
                <div class="hero-btns">
                    <a href="${pageContext.request.contextPath}/education/daily-quiz" class="btn btn-primary hero-btn-start">학습 시작하기</a>
                    <a href="${pageContext.request.contextPath}/service/guide" class="btn btn-outline hero-btn-about">쉽코딩 알아보기</a>
                </div>
            </div>
            <div class="hero-image">
                <img src="${pageContext.request.contextPath}/images/sheep-coding.png" alt="코딩하는 양 캐릭터">
            </div>
        </div>
    </section>

    <!-- ── 기능 소개 배너 ── -->
    <section class="feature-banner">
        <div class="container">
            <div class="feature-list">
                <div class="feature-item">
                    <div class="feature-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#16A34A" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10"/><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/><line x1="12" y1="17" x2="12.01" y2="17"/>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <span class="feature-name">일일 퀴즈</span>
                        <span class="feature-desc">매일 새로운 문제를 만나보세요.</span>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#16A34A" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <span class="feature-name">카테고리 학습</span>
                        <span class="feature-desc">Java 개념을 체계적으로 학습해요.</span>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#16A34A" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <span class="feature-name">커뮤니티</span>
                        <span class="feature-desc">함께 배우고, 나누며 성장해요.</span>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#16A34A" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/>
                        </svg>
                    </div>
                    <div class="feature-text">
                        <span class="feature-name">루틴 메이커</span>
                        <span class="feature-desc">나만의 공부 습관을 이어가요.</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

<!-- 푸터 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="${pageContext.request.contextPath}/js/modal.js"></script>
</body>
</html>
