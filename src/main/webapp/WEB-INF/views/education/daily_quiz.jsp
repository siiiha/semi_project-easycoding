<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="quiz-page">
    <div class="quiz-card">

        <!-- 문제 번호 + 카테고리 + 진행 바 -->
        <div class="quiz-header">
            <div class="quiz-header-top">
                <h1 class="quiz-problem-num">문제 ${currentIndex} / ${totalCount}</h1>
                <span class="quiz-category-badge">${quiz.categoryName}</span>
            </div>
            <div class="quiz-progress-bar-wrap">
                <div class="quiz-progress-bar" style="width: ${progressPercent}%"></div>
            </div>
        </div>

        <!-- 문제 본문 -->
        <div class="quiz-body">
            <p class="quiz-question">${quiz.questionText}</p>

            <!-- 코드 블록 (코드 문제인 경우만 표시) -->
            <c:if test="${not empty quiz.codeSnippet}">
            <div class="quiz-code-block">
                <div class="quiz-code-lines">
                    <c:forEach var="line" items="${quiz.codeLines}" varStatus="s">
                    <div class="quiz-code-row">
                        <span class="quiz-code-linenum">${s.index + 1}</span>
                        <span class="quiz-code-text">${line}</span>
                    </div>
                    </c:forEach>
                </div>
            </div>
            </c:if>

            <!-- 보기 선택지 -->
            <form action="${pageContext.request.contextPath}/learn/daily-quiz/answer" method="post" id="quizForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <input type="hidden" name="quizId" value="${quiz.id}">
                <input type="hidden" name="sessionId" value="${quizSessionId}">
                <div class="quiz-choices">
                    <c:forEach var="choice" items="${quiz.choices}" varStatus="s">
                    <label class="quiz-choice ${not empty selectedAnswer && selectedAnswer == choice.number ? 'selected' : ''}">
                        <input type="radio" name="answer" value="${choice.number}"
                               ${not empty selectedAnswer && selectedAnswer == choice.number ? 'checked' : ''}>
                        <span class="quiz-choice-num">
                            <c:choose>
                                <c:when test="${s.index == 0}">❶</c:when>
                                <c:when test="${s.index == 1}">②</c:when>
                                <c:when test="${s.index == 2}">③</c:when>
                                <c:otherwise>④</c:otherwise>
                            </c:choose>
                        </span>
                        <span class="quiz-choice-text">${choice.text}</span>
                    </label>
                    </c:forEach>
                </div>
            </form>
        </div>

        <!-- 구분선 + 이전/다음 버튼 -->
        <div class="quiz-footer">
            <div class="quiz-footer-divider"></div>
            <div class="quiz-nav-btns">
                <c:choose>
                    <c:when test="${currentIndex > 1}">
                        <a href="${pageContext.request.contextPath}/learn/daily-quiz?index=${currentIndex - 1}&sessionId=${quizSessionId}"
                           class="quiz-btn quiz-btn-prev">&lt;&nbsp; 이전 문제</a>
                    </c:when>
                    <c:otherwise>
                        <span class="quiz-btn quiz-btn-prev disabled">&lt;&nbsp; 이전 문제</span>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${currentIndex < totalCount}">
                        <button type="button" class="quiz-btn quiz-btn-next"
                                onclick="submitAndNext()">다음 문제 &nbsp;&gt;</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="quiz-btn quiz-btn-next quiz-btn-finish"
                                onclick="submitAndFinish()">학습 완료 &nbsp;✓</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
<script>
function submitAndNext() {
    var form = document.getElementById('quizForm');
    var action = form.action;
    form.action = action + '?next=true';
    form.submit();
}
function submitAndFinish() {
    var form = document.getElementById('quizForm');
    var action = form.action;
    form.action = action + '?finish=true';
    form.submit();
}
</script>
</body>
</html>
