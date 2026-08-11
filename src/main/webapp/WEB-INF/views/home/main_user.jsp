<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홈 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_user.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap"
          rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="user-main-page">

    <!-- ── 히어로 배너 ── -->
    <section class="user-hero">
        <div class="user-hero-inner">

            <!-- 인사말 + 미션 설정 -->
            <div class="hero-banner-card">
                <div class="hero-banner-left">
                    <div class="hero-greeting">
                        <h1 class="hero-greeting-title">안녕하세요, <span
                                class="text-primary">${sessionScope.loginUser.nickname}</span> 님! 👋🏻</h1>
                        <p class="hero-greeting-sub">오늘도 꾸준한 하루를 만들어봐요.</p>
                    </div>

                    <form class="mission-card"
                          action="${pageContext.request.contextPath}/home/daily/quiz/start"
                          method="post">
                        <h2 class="mission-title">오늘의 미션</h2>
                        <c:if test="${not empty missionError}">
                            <p class="mission-error">
                                <c:out value="${missionError}"/>
                            </p>
                        </c:if>
                        <div class="mission-fields">
                            <div class="mission-field">
                                <label class="mission-field-label">풀 문제 수</label>
                                <select class="mission-select" name="problemCount">
                                    <option value="3">3문제</option>
                                    <option value="5" selected>5문제</option>
                                    <option value="10">10문제</option>
                                    <option value="20">20문제</option>
                                </select>
                            </div>
                            <div class="mission-field">
                                <label class="mission-field-label">문제 카테고리</label>
                                <select class="mission-select" name="categoryId">
                                    <option value="">전체</option>

                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.categoryId}">
                                            <c:out value="${category.categoryName}"/>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!-- 진행 상황 -->
                        <c:if test="${not empty todayProgress}">
                            <div class="mission-progress">
                                <p class="mission-progress-label">
                                    <span class="mission-progress-current">${todayProgress.done}</span>
                                    <span class="mission-progress-total"> / ${todayProgress.total}</span>
                                    <span class="mission-progress-text"> 문제완료</span>
                                </p>
                                <div class="mission-progress-bar-wrap">
                                    <div class="mission-progress-bar" style="width: ${todayProgress.percent}%"></div>
                                </div>
                            </div>
                        </c:if>

                        <button type="submit" class="btn mission-start-btn">오늘의 학습 시작하기</button>
                    </form>
                </div>

                <!-- 양 캐릭터 이미지 -->
                <div class="hero-banner-right">
                    <img src="${pageContext.request.contextPath}/images/코딩_집중_양.png" alt="집중하는 양 캐릭터"
                         class="hero-sheep-img">
                </div>
            </div>
        </div>
    </section>

    <!-- ── 나의 학습 잔디 ── -->
    <section class="grass-section">
        <div class="grass-inner">
            <h2 class="grass-title">나의 학습 잔디</h2>
            <div class="grass-layout">

                <!-- 잔디 그리드 카드 -->
                <div class="grass-card">
                    <div class="grass-calendars">
                        <c:forEach var="grassMonth" items="${grassMonths}">
                            <div class="grass-month">
                                <span class="grass-month-label">
                                    ${grassMonth.month}월
                                </span>

                                <div class="grass-month-grid">
                                    <c:if test="${grassMonth.leadingEmptyCellCount > 0}">
                                        <c:forEach
                                                begin="1"
                                                end="${grassMonth.leadingEmptyCellCount}">
                                            <div class="grass-cell grass-cell-empty"></div>
                                        </c:forEach>
                                    </c:if>

                                    <c:forEach var="cell" items="${grassMonth.cells}">
                                        <div
                                                class="grass-cell grass-lv${cell.level}"
                                                title="${cell.date}">
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- 통계 카드 사이드바 -->
                <div class="grass-stats">
                    <!-- 연속학습 -->
                    <div class="stat-card streak-card">
                        <p class="stat-card-label">연속학습</p>
                        <p class="stat-card-value">
                            <span class="stat-big">${learningStats != null ? learningStats.streak : 0}</span>
                            <span class="stat-unit">일</span>
                        </p>
                    </div>
                    <!-- 총문제 / 정답률 -->
                    <div class="stat-card record-card">
                        <div class="record-row">
                            <p class="record-sub-label">총 문제 풀이</p>
                            <p class="record-sub-value">
                                <span class="record-big">${learningStats != null ? learningStats.totalSolved : 0}</span>
                                <span class="record-unit">문제</span>
                            </p>
                        </div>
                        <div class="record-divider"></div>
                        <div class="record-row">
                            <p class="record-sub-label">정답률</p>
                            <p class="record-sub-value">
                            <span class="record-big">
                                <fmt:formatNumber
                                        value="${learningStats != null ? learningStats.correctRate : 0}"
                                        pattern="0.0"
                                />
                            </span> <span class="record-unit">%</span>
                            </p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
</body>
</html>
