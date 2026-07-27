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
        <form action="${pageContext.request.contextPath}/learn/category/${category.slug}/problem/${problem.id}/submit" method="post" id="mcqForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

            <div class="problem-card">
                <p class="problem-question">${problem.questionText}</p>

                <div class="problem-columns">
                    <!-- 코드 에디터 -->
                    <div class="problem-col-left">
                        <div class="code-editor">
                            <div class="code-line-numbers">
                                <c:forEach begin="1" end="${problem.codeLineCount}" var="ln">
                                    <span>${ln}</span>
                                </c:forEach>
                            </div>
                            <div class="code-lines">
                                <c:forEach var="line" items="${problem.codeLines}">
                                    <p class="code-line">${line}</p>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- 선택지 -->
                    <div class="problem-col-right">
                        <c:forEach var="opt" items="${problem.options}" varStatus="st">
                            <label class="choice-option ${selectedAnswer == opt.value ? 'selected' : ''}">
                                <input type="radio" name="answer" value="${opt.value}"
                                       style="display:none"
                                       ${selectedAnswer == opt.value ? 'checked' : ''}>
                                <span class="choice-option-text">${opt.label}</span>
                                <c:if test="${selectedAnswer == opt.value}">
                                    <div class="choice-check">
                                        <svg width="10" height="10" viewBox="0 0 10 10" fill="none">
                                            <path d="M1.5 5L4 7.5L8.5 2.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
                                        </svg>
                                    </div>
                                </c:if>
                            </label>
                        </c:forEach>
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

<script>
document.querySelectorAll('.choice-option').forEach(function(label) {
    label.addEventListener('click', function() {
        document.querySelectorAll('.choice-option').forEach(function(l) { l.classList.remove('selected'); });
        this.classList.add('selected');
        this.querySelector('input[type=radio]').checked = true;
    });
});
</script>
</body>
</html>
