<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문제 해설 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/category.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="problem-main">
    <div class="problem-page-inner">

        <!-- ── 해설 카드 ── -->
        <div class="explanation-card">

            <!-- 헤더 -->
            <div class="explanation-header">
                <div class="explanation-header-left">
                    <h1 class="explanation-problem-title">문제 ${problem.number} 해설</h1>
                    <span class="explanation-cat-badge">${category.name}</span>
                </div>
                <c:choose>
                    <c:when test="${result.correct}">
                        <span class="explanation-status correct">정답 상태</span>
                    </c:when>
                    <c:otherwise>
                        <span class="explanation-status wrong">오답 상태</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="explanation-divider"></div>

            <!-- 문제 텍스트 -->
            <p class="explanation-question">${problem.questionText}</p>

            <!-- 코드 블록 -->
            <div class="explanation-code">
                <div class="code-line-numbers">
                    <c:forEach begin="1" end="${problem.codeLineCount}" var="ln">
                        <p style="line-height:1.6; margin:0;">${ln}</p>
                    </c:forEach>
                </div>
                <div class="code-lines">
                    <c:forEach var="line" items="${problem.codeLines}">
                        <p style="line-height:1.6; margin:0; white-space:pre-wrap;">${line.text}</p>
                    </c:forEach>
                </div>
            </div>

            <!-- 선택지 (객관식인 경우) -->
            <c:if test="${problem.type == 'mcq'}">
                <div class="explanation-choices">
                    <c:forEach var="opt" items="${problem.options}" varStatus="st">
                        <c:choose>
                            <c:when test="${opt.value == result.userAnswer and not result.correct}">
                                <div class="explanation-choice wrong">
                                    <div class="explanation-choice-marker">X</div>
                                    <span class="explanation-choice-text">${opt.label}</span>
                                </div>
                            </c:when>
                            <c:when test="${opt.value == result.correctAnswer}">
                                <div class="explanation-choice correct">
                                    <div class="explanation-choice-marker">
                                        <svg width="12" height="12" viewBox="0 0 14 14" fill="none">
                                            <path d="M2.5 7L5.5 10L11.5 4" stroke="white" stroke-width="2" stroke-linecap="round"/>
                                        </svg>
                                    </div>
                                    <span class="explanation-choice-text">${opt.label}</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="explanation-choice neutral">
                                    <div class="explanation-choice-marker" style="background:#D9D9D9;"></div>
                                    <span class="explanation-choice-text">${opt.label}</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:if>

            <div class="explanation-divider"></div>

            <!-- 해설 -->
            <div>
                <p class="explanation-section-title">문제 해설</p>
                <div class="explanation-block">
                    <p class="explanation-block-heading">[해설 요약]</p>
                    <p style="white-space: pre-line; line-height: 1.7;">${result.explanation}</p>
                </div>
            </div>

            <div class="explanation-divider"></div>

            <!-- 하단 버튼 -->
            <div class="explanation-bottom-btns">
                <a href="${pageContext.request.contextPath}/learn/category/${category.slug}" class="btn-back-list">목록으로</a>
                <c:if test="${not empty nextProblem}">
                    <a href="${pageContext.request.contextPath}/learn/category/${category.slug}/problem/${nextProblem.id}" class="btn-next-problem">다음 문제 풀기 &gt;</a>
                </c:if>
            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
