<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학습 완료 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/daily_quiz_complete.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:set var="completedCount" value="${not empty summary ? summary.completedCount : 0}" />
<c:set var="correctCount" value="${not empty summary ? summary.correctCount : 0}" />
<c:set var="accuracyRate" value="${not empty summary ? summary.accuracyRate : 0}" />
<c:set var="streakDays" value="${not empty streakDays ? streakDays : 0}" />

<main class="daily-complete-page">
    <div class="daily-complete-wrap">
        <div class="complete-check-icon" aria-hidden="true">✓</div>

        <h1 class="complete-main-title">오늘의 학습 완료! 🎉</h1>
        <p class="complete-main-desc">훌륭해요! 오늘 하루도 꾸준히 학습했어요.</p>

        <section class="complete-result-card">
            <h2 class="result-card-title">오늘의 결과</h2>

            <div class="result-stats-grid">
                <div class="result-stat">
                    <p class="result-stat-num is-complete">${completedCount}</p>
                    <p class="result-stat-label">완료한 문제</p>
                </div>
                <div class="result-stat">
                    <p class="result-stat-num is-correct">${correctCount}</p>
                    <p class="result-stat-label">맞힌 문제</p>
                </div>
                <div class="result-stat">
                    <p class="result-stat-num is-rate"><fmt:formatNumber value="${accuracyRate}" maxFractionDigits="0" />%</p>
                    <p class="result-stat-label">정답률</p>
                </div>
            </div>

            <div class="result-divider"></div>

            <div class="result-streak-row">
                <p class="streak-label">연속 학습일</p>
                <p class="streak-value">🔥 ${streakDays}일 달성!</p>
            </div>
        </section>

        <section class="complete-streak-card">
            <p class="streak-card-title">🔥 ${streakDays}일 연속 학습 달성!</p>
            <p class="streak-card-desc">꾸준함이 최고의 실력이에요. 내일도 함께해요!</p>
        </section>

        <div class="complete-actions">
            <a href="${pageContext.request.contextPath}/" class="complete-action-btn is-primary">홈으로 돌아가기</a>
            <a href="${pageContext.request.contextPath}/education/category" class="complete-action-btn is-outline">선택학습 더 풀기</a>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
