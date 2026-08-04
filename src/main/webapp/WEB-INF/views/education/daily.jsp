<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일일 퀴즈 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/daily.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:set var="totalCount" value="${fn:length(todayEducationHistory)}" />
<c:set var="completedCount" value="0" />
<c:forEach var="historys" items="${todayEducationHistory}">
    <c:if test="${historys.answered}">
        <c:set var="completedCount" value="${completedCount + 1}" />
    </c:if>
</c:forEach>
<c:set var="progressPercent" value="${totalCount == 0 ? 0 : (completedCount * 100 / totalCount)}" />

<main class="daily-mission-page">
    <div class="daily-mission-wrap">
        <h1 class="daily-mission-title">일일학습</h1>
        <p class="daily-mission-subtitle">매일 꾸준히 학습하고 성장해요!</p>

        <section class="daily-mission-card">
            <div class="daily-mission-head">
                <span class="daily-mission-label">오늘의 일일 미션</span>
                <span class="daily-mission-rate">🎯 ${progressPercent}% 달성</span>
            </div>

            <p class="daily-mission-count"><strong>${completedCount}</strong> / ${totalCount}</p>
            <p class="daily-mission-text">문제를 완료했어요</p>

            <div class="daily-mission-progress-track">
                <div class="daily-mission-progress-fill" style="width: ${progressPercent}%"></div>
            </div>

            <a class="daily-mission-btn" href="${pageContext.request.contextPath}/education/daily-quiz/quiz">
                오늘의 문제 바로가기 →
            </a>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
