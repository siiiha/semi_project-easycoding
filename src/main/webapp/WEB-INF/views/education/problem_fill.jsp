<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${problem.title} - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/category.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        /* 빈칸 하이라이트 인라인 스타일 */
        .blank-highlight {
            display: inline-flex;
            align-items: center;
            padding: 2px 8px;
            background: #FFF9C4;
            border: 1px dashed #FBC02D;
            border-radius: 4px;
            color: #FBC02D;
            font-weight: 700;
            font-size: 16px;
            vertical-align: middle;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="problem-main">
    <div class="problem-page-inner">

        <!-- ── 브레드크럼 ── -->
        <nav class="breadcrumb" aria-label="breadcrumb">
            <a href="${pageContext.request.contextPath}/learn/category" class="breadcrumb-item">카테고리학습</a>
            <span class="breadcrumb-sep">›</span>
            <span class="breadcrumb-item">Java</span>
            <span class="breadcrumb-sep">›</span>
            <a href="${pageContext.request.contextPath}/learn/category/${category.slug}" class="breadcrumb-item">${category.name}</a>
            <span class="breadcrumb-sep">›</span>
            <span class="breadcrumb-item active">${problem.title}</span>
        </nav>

        <!-- ── 문제 헤더 ── -->
        <div class="problem-header">
            <div class="problem-title-row">
                <h1 class="problem-main-title">${problem.title}</h1>
                <span class="problem-cat-badge">${category.name}</span>
            </div>
            <a href="${pageContext.request.contextPath}/learn/category/${category.slug}" class="exit-btn">목록으로</a>
        </div>

        <!-- ── 문제 카드 ── -->
        <form action="${pageContext.request.contextPath}/learn/category/${category.slug}/problem/${problem.id}/submit" method="post" id="fillForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

            <div class="problem-card">
                <p class="problem-question">${problem.questionText}</p>

                <div class="problem-columns">
                    <!-- 코드 에디터 (빈칸 포함) -->
                    <div class="problem-col-left">
                        <div class="code-editor">
                            <div class="code-line-numbers">
                                <c:forEach begin="1" end="${problem.codeLineCount}" var="ln">
                                    <span>${ln}</span>
                                </c:forEach>
                            </div>
                            <div class="code-lines">
                                <c:forEach var="line" items="${problem.codeLines}">
                                    <c:choose>
                                        <c:when test="${line.hasBlank}">
                                            <div style="display:flex; align-items:center; gap:0;">
                                                <span style="white-space:pre;">${line.before}</span>
                                                <span class="blank-highlight">______</span>
                                                <span style="white-space:pre;">${line.after}</span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="code-line">${line.text}</p>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- 답안 입력 + 힌트 -->
                    <div class="problem-col-right" style="gap: 24px;">
                        <div class="fill-input-section">
                            <label class="fill-input-label" for="answer">답안 입력</label>
                            <input type="text" id="answer" name="answer" class="fill-input-field"
                                   placeholder="빈칸에 들어갈 코드를 입력하세요."
                                   value="${param.answer}" autocomplete="off">
                        </div>
                        <div class="fill-hint">
                            <svg width="16" height="16" viewBox="0 0 16 16" fill="none" style="flex-shrink:0;margin-top:2px;">
                                <circle cx="8" cy="8" r="7" stroke="#767676" stroke-width="2"/>
                                <line x1="8" y1="6" x2="8" y2="11" stroke="#767676" stroke-width="2" stroke-linecap="round"/>
                                <circle cx="8" cy="4.5" r="1" fill="#767676"/>
                            </svg>
                            <p class="fill-hint-text">힌트: ${problem.hint}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ── 제출 ── -->
            <div class="submit-footer" style="margin-top: 0;">
                <button type="submit" class="submit-btn">제출하기</button>
            </div>
        </form>

    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
