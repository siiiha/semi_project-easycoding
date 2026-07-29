<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서비스 소개 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/service_intro.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<c:choose>
    <c:when test="${not empty sessionScope.loginUser}">
        <jsp:include page="/WEB-INF/views/common/header_user.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/common/header_guest.jsp" />
    </c:otherwise>
</c:choose>

<main class="intro-page">

    <!-- ── 히어로 ── -->
    <section class="intro-hero">
        <div class="intro-hero-inner">
            <h1 class="intro-hero-title">코딩, 쉽게 시작하세요</h1>
            <p class="intro-hero-sub">
                누구나 쉽고 재미있게 프로그래밍을 배울 수 있는<br>
                온라인 코딩 학습 플랫폼, 쉽코딩
            </p>
            <div class="intro-hero-btns">
                <a href="${pageContext.request.contextPath}/member/join" class="btn intro-btn-primary">무료로 시작하기 →</a>
                <a href="${pageContext.request.contextPath}/service/guide" class="btn intro-btn-outline">학습 가이드 보기</a>
            </div>
        </div>
    </section>

    <!-- ── 기능 카드 ── -->
    <section class="intro-features">
        <div class="intro-section-inner">
            <p class="intro-label">왜 쉽코딩인가요?</p>
            <h2 class="intro-section-title">탄탄한 학습 과정</h2>
            <div class="feature-cards">
                <div class="feature-card">
                    <div class="feature-card-icon">📚</div>
                    <h3 class="feature-card-name">체계적 커리큘럼</h3>
                    <p class="feature-card-desc">
                        단계별로 설계된 학습 경로로<br>
                        기초부터 실전까지 체계적으로<br>
                        프로그래밍을 학습합니다.
                    </p>
                </div>
                <div class="feature-card">
                    <div class="feature-card-icon">💻</div>
                    <h3 class="feature-card-name">실습 중심 학습</h3>
                    <p class="feature-card-desc">
                        이론만이 아닌 직접 코드를<br>
                        작성하며 실력을 키우는<br>
                        실습 환경을 제공합니다.
                    </p>
                </div>
                <div class="feature-card">
                    <div class="feature-card-icon">🏆</div>
                    <h3 class="feature-card-name">성장 트래킹</h3>
                    <p class="feature-card-desc">
                        학습 진도와 성취도를<br>
                        한눈에 확인하고 꾸준히<br>
                        성장해 나갈 수 있습니다.
                    </p>
                </div>
                <div class="feature-card">
                    <div class="feature-card-icon">👥</div>
                    <h3 class="feature-card-name">활발한 커뮤니티</h3>
                    <p class="feature-card-desc">
                        다른 학습자들과 함께<br>
                        질문하고 답변하며<br>
                        함께 성장하는 공간입니다.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- ── 통계 ── -->
    <section class="intro-stats">
        <div class="stats-inner">
            <div class="stat-item">
                <p class="stat-number">10,000+</p>
                <p class="stat-label">누적 학습자</p>
            </div>
            <div class="stat-item">
                <p class="stat-number">500+</p>
                <p class="stat-label">코딩 문제</p>
            </div>
            <div class="stat-item">
                <p class="stat-number">98%</p>
                <p class="stat-label">수강 만족도</p>
            </div>
            <div class="stat-item">
                <p class="stat-number">24/7</p>
                <p class="stat-label">학습 지원</p>
            </div>
        </div>
    </section>

    <!-- ── 수강생 후기 ── -->
    <section class="intro-reviews">
        <div class="intro-section-inner">
            <p class="intro-label">수강생 후기</p>
            <h2 class="intro-section-title">학습자들의 생생한 이야기</h2>
            <div class="review-cards">
                <div class="review-card">
                    <p class="review-stars">⭐⭐⭐⭐⭐</p>
                    <p class="review-content">"코딩을 전혀 몰랐는데 쉽코딩 덕분에 첫 프로젝트를 완성했어요! 단계별 학습이 정말 도움이 됐습니다."</p>
                    <hr class="review-divider">
                    <p class="review-author"><strong>김지수</strong> <span>· 대학생</span></p>
                </div>
                <div class="review-card">
                    <p class="review-stars">⭐⭐⭐⭐⭐</p>
                    <p class="review-content">"퇴근 후 조금씩 배우고 있는데, 짧은 미션 단위라 부담 없이 할 수 있어서 좋아요."</p>
                    <hr class="review-divider">
                    <p class="review-author"><strong>이민호</strong> <span>· 직장인</span></p>
                </div>
                <div class="review-card">
                    <p class="review-stars">⭐⭐⭐⭐⭐</p>
                    <p class="review-content">"학교에서 배우는 것보다 훨씬 재미있어요! 커뮤니티에서 친구들과 함께 풀면 더 재밌습니다."</p>
                    <hr class="review-divider">
                    <p class="review-author"><strong>박서연</strong> <span>· 고등학생</span></p>
                </div>
            </div>
        </div>
    </section>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
