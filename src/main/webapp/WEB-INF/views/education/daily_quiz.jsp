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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/daily_quiz.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:set var="totalCount" value="${fn:length(todayEducation)}" />

<main class="daily-quiz-page">
    <div class="daily-quiz-wrap">
        <div class="quiz-top-row">
            <a class="quiz-back-link" href="${pageContext.request.contextPath}/education/daily">← 일일학습으로</a>

            <div class="quiz-step-dots" aria-label="퀴즈 진행도">
                <c:if test="${totalCount > 0}">
                    <c:forEach begin="1" end="${totalCount}" var="idx">
                        <span class="dot ${idx == 1 ? 'active' : ''}"></span>
                    </c:forEach>
                </c:if>
            </div>

            <p class="quiz-step-text">
                <span id="quiz-current-index">${totalCount > 0 ? 1 : 0}</span> /
                <span id="quiz-total-count">${totalCount}</span>
            </p>
        </div>

        <section class="quiz-card">
            <div class="quiz-card-head">
                <div class="quiz-badges">
                    <span class="badge-level" id="quiz-category-name">일일 문제</span>
                    <span class="badge-type" id="quiz-type-text">객관식</span>
                </div>
                <span class="badge-lang" id="quiz-topic-text">Java 개념</span>
            </div>

            <div class="quiz-divider"></div>

            <h1 class="quiz-question" id="quiz-question">테스트 문제 텍스트</h1>

            <form class="quiz-form" id="quiz-form" action="#" method="post">
                <div id="quiz-options"></div>

                <div class="quiz-feedback quiz-feedback-correct is-hidden">
                    <span class="feedback-icon">✓</span>
                    <div>
                        <p class="feedback-title">테스트 정답 안내 텍스트</p>
                        <p class="feedback-desc">테스트 설명 텍스트입니다.</p>
                    </div>
                </div>

                <div class="quiz-feedback quiz-feedback-wrong is-hidden">
                    <span class="feedback-icon">✕</span>
                    <div>
                        <p class="feedback-title">테스트 오답 안내 텍스트</p>
                        <p class="feedback-desc">테스트 설명 텍스트입니다.</p>
                    </div>
                </div>

                <button type="submit" class="quiz-submit-btn" id="quiz-next-btn">다음 문제 →</button>
            </form>
        </section>

        <section id="today-education-data" class="is-hidden">
            <c:forEach var="edu" items="${todayEducation}">
                <article class="quiz-data-item">
                    <p class="quiz-data-id"><c:out value="${edu.educationId}" /></p>
                    <p class="quiz-data-type"><c:out value="${edu.educationType}" /></p>
                    <p class="quiz-data-category-id"><c:out value="${edu.educationCategoryID}" /></p>
                    <p class="quiz-data-category-name"><c:out value="${edu.educationCategoryName}" /></p>
                    <p class="quiz-data-title"><c:out value="${edu.educationTitle}" /></p>
                    <p class="quiz-data-content"><c:out value="${edu.educationContent}" /></p>
                    <p class="quiz-data-explanation"><c:out value="${edu.educationExplanation}" /></p>
                    <div class="quiz-data-options">
                        <c:forEach var="opt" items="${edu.options}">
                            <p class="quiz-data-option-item"
                               data-order="${opt.orderingNumber}"
                               data-correct="${opt.correct}">
                                <c:out value="${opt.optionContents}" />
                            </p>
                        </c:forEach>
                    </div>
                </article>
            </c:forEach>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/daily_quiz.js"></script>
</body>
</html>
