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

<c:set var="totalCount"/>

<main class="daily-quiz-page">
    <div class="daily-quiz-wrap">
        <div class="quiz-top-row">
            <a class="quiz-back-link" href="${pageContext.request.contextPath}/education/daily">← 일일학습으로</a>

            <div class="quiz-step-dots" aria-label="퀴즈 진행도">
                <span class="dot active"></span>
                <span class="dot"></span>
                <span class="dot"></span>
            </div>

            <p class="quiz-step-text">${currentIndex} / <span>${totalCount == 0 ? 1 : totalCount}</span></p>
        </div>

        <section class="quiz-card">
            <div class="quiz-card-head">
                <div class="quiz-badges">
                    <span class="badge-level">변수 ◆</span>
                    <span class="badge-level-num">초급</span>
                    <span class="badge-type">객관식</span>
                </div>
                <span class="badge-lang">Java 개념</span>
            </div>

            <div class="quiz-divider"></div>

            <h1 class="quiz-question">Java에서 정수형 변수를 선언하는 올바른 방법은?</h1>

            <form class="quiz-form" action="#" method="post">
                <label class="quiz-option is-correct">
                    <input type="radio" name="answer" value="A" checked>
                    <span class="option-label">A.</span>
                    <span class="option-text">테스트 선택지 텍스트</span>
                </label>

                <label class="quiz-option is-wrong">
                    <input type="radio" name="answer" value="B">
                    <span class="option-label">B.</span>
                    <span class="option-text">테스트 선택지 텍스트</span>
                </label>

                <label class="quiz-option">
                    <input type="radio" name="answer" value="C">
                    <span class="option-label">C.</span>
                    <span class="option-text">테스트 선택지 텍스트</span>
                </label>

                <label class="quiz-option">
                    <input type="radio" name="answer" value="D">
                    <span class="option-label">D.</span>
                    <span class="option-text">테스트 선택지 텍스트</span>
                </label>

                <div class="quiz-feedback quiz-feedback-correct is-hidden">
                    <span class="feedback-icon">✓</span>
                    <div>
                        <p class="feedback-title">테스트 정답 안내 텍스트</p>
                        <p class="feedback-desc">테스트 설명 텍스트입니다.</p>
                    </div>
                </div>

                <div class="quiz-feedback quiz-feedback-wrong">
                    <span class="feedback-icon">✕</span>
                    <div>
                        <p class="feedback-title">테스트 오답 안내 텍스트</p>
                        <p class="feedback-desc">테스트 설명 텍스트입니다.</p>
                    </div>
                </div>

                <button type="submit" class="quiz-submit-btn">테스트 버튼 텍스트</button>
            </form>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/daily.js"></script>
</body>
</html>
