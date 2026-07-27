<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학습 완료 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/daily_quiz.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="quiz-complete-page">
    <div class="complete-card">

        <!-- ── 왼쪽 패널 ── -->
        <div class="complete-left">

            <!-- 축하 일러스트 -->
            <div class="complete-celebrate">
                <!-- 장식 다이아몬드 -->
                <span class="confetti-diamond c-green c-lg" style="top:40px;left:30px;"></span>
                <span class="confetti-diamond c-green c-md" style="top:30px;left:63px;"></span>
                <span class="confetti-diamond c-green c-sm" style="top:40px;left:30px;transform:rotate(45deg);"></span>
                <span class="confetti-star" style="top:40px;left:30px;">✦</span>
                <span class="confetti-star c-sm" style="top:155px;left:55px;">✦</span>
                <span class="confetti-star c-xs" style="top:130px;left:390px;">✦</span>
                <span class="confetti-diamond c-green c-md" style="top:50px;right:28px;"></span>
                <span class="confetti-diamond c-yellow c-sm" style="top:90px;right:45px;"></span>
                <span class="confetti-diamond c-yellow c-sm" style="top:120px;left:74px;"></span>
                <span class="confetti-diamond c-yellow c-md" style="top:30px;right:73px;"></span>
                <img src="${pageContext.request.contextPath}/images/sheep-thumbsup.png"
                     alt="엄지척 양 캐릭터" class="complete-sheep-img">
            </div>

            <!-- 완료 텍스트 -->
            <div class="complete-title-wrap">
                <h1 class="complete-title">오늘의 학습을 <span class="text-primary">완료</span>했어요! 🎉</h1>
                <p class="complete-subtitle">정말 대단해요! 꾸준한 노력이 쌓이고 있어요.</p>
            </div>

            <!-- 이번달 잔디 트래커 -->
            <div class="complete-grass-card">
                <div class="complete-grass-header">
                    <span class="complete-grass-icon">🌱</span>
                    <span class="complete-grass-label">학습 트래커</span>
                </div>
                <p class="complete-grass-sub">오늘의 잔디가 채워졌어요!</p>
                <div class="complete-grass-nav">
                    <button class="grass-nav-btn" type="button">&lt; 6월</button>
                    <span class="grass-nav-current">7월</span>
                    <button class="grass-nav-btn" type="button">8월 &gt;</button>
                </div>
                <div class="complete-grass-week-labels">
                    <span>월</span><span>화</span><span>수</span><span>목</span><span>금</span><span>토</span><span>일</span>
                </div>
                <div class="complete-grass-grid">
                    <c:choose>
                        <c:when test="${not empty monthGrassCells}">
                            <c:forEach var="cell" items="${monthGrassCells}">
                                <div class="cg-cell cg-lv${cell.level} ${cell.isToday ? 'cg-today' : ''}" title="${cell.date}"></div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <%-- 플레이스홀더 3주 (21칸) --%>
                            <div class="cg-cell cg-lv2"></div>
                            <div class="cg-cell cg-lv2"></div>
                            <div class="cg-cell cg-lv2"></div>
                            <div class="cg-cell cg-lv1"></div>
                            <div class="cg-cell cg-lv1"></div>
                            <div class="cg-cell cg-lv1"></div>
                            <div class="cg-cell cg-lv1"></div>

                            <div class="cg-cell cg-lv2"></div>
                            <div class="cg-cell cg-lv2"></div>
                            <div class="cg-cell cg-lv1"></div>
                            <div class="cg-cell cg-lv1"></div>
                            <div class="cg-cell cg-today"></div>
                            <div class="cg-cell cg-lv0"></div>
                            <div class="cg-cell cg-lv0"></div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 액션 버튼 -->
            <div class="complete-actions">
                <a href="${pageContext.request.contextPath}/learn/wrong-note" class="complete-btn-outline">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/>
                        <line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/>
                    </svg>
                    오답 노트 보기
                </a>
                <a href="${pageContext.request.contextPath}/learn/category" class="complete-btn-primary">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/>
                    </svg>
                    추가 학습하기
                </a>
            </div>
        </div>

        <!-- ── 오른쪽 패널 ── -->
        <div class="complete-right">

            <!-- 문제 풀이 기록 -->
            <div class="result-record-card">
                <h2 class="result-record-title">문제 풀이 기록</h2>
                <div class="result-stats">
                    <div class="result-stat correct">
                        <p class="result-stat-label">정답</p>
                        <p class="result-stat-num">${result.correct != null ? result.correct : 0}</p>
                    </div>
                    <div class="result-stat wrong">
                        <p class="result-stat-label">오답</p>
                        <p class="result-stat-num">${result.wrong != null ? result.wrong : 0}</p>
                    </div>
                    <div class="result-stat rate">
                        <p class="result-stat-label">정답률</p>
                        <p class="result-stat-num result-rate-num">${result.rate != null ? result.rate : 0}%</p>
                    </div>
                </div>
            </div>

            <!-- 학습 트래커 기록 추가 -->
            <div class="result-tracker-card">
                <div class="result-tracker-icon">🌱</div>
                <div class="result-tracker-text">
                    <p class="result-tracker-title">학습 트래커에 <span class="text-primary">새로운 기록</span>이 추가되었어요! 🌱</p>
                    <p class="result-tracker-sub">매일 꾸준히 학습하고<br>나만의 잔디를 키워보세요!</p>
                </div>
            </div>

            <!-- 팁 카드 -->
            <div class="result-tip-card">
                <div class="result-tip-icon">💡</div>
                <div class="result-tip-text">
                    <p class="result-tip-title">매일 한 문제씩 꾸준히!</p>
                    <p class="result-tip-sub">작은 습관이 큰 성장을 만들어요.</p>
                </div>
            </div>

            <!-- 격려 카드 -->
            <div class="result-cheer-card">
                <div class="result-cheer-icon">🐑</div>
                <div class="result-cheer-text">
                    <p class="result-cheer-title text-primary">한 걸음 더 성장했어요!</p>
                    <p class="result-cheer-sub">내일도 쉽코딩과 함께해요! 💚</p>
                </div>
            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
</body>
</html>
