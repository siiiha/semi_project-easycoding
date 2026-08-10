<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="find-page find-page-compact">

    <!-- 히어로 -->
    <div class="find-hero">
        <div class="find-hero-text">
            <h1 class="find-hero-title">
                쉽코딩과 함께 <span class="text-primary">오늘의 한 문제</span>로<br>
                <span class="text-primary">내일의 실력</span>을 키워요.
            </h1>
            <p class="find-hero-sub">쉽코딩과 함께 다시 학습 여정을 이어가요.</p>
        </div>
    </div>

    <!-- 카드 -->
    <div class="find-card-section">
        <div class="find-card">

            <!-- 탭 -->
            <div class="find-tabs">
                <a href="${pageContext.request.contextPath}/member/find-id" class="find-tab active">아이디 찾기</a>
                <a href="${pageContext.request.contextPath}/member/find-password" class="find-tab">비밀번호 찾기</a>
            </div>

            <!-- 폼 -->
            <form action="${pageContext.request.contextPath}/member/find-id" method="post" class="find-form">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <div class="form-group">
                    <label class="find-field-label" for="nickname">닉네임</label>
                    <div class="input-wrap">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#9CA3AF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
                        </svg>
                        <input type="text" id="nickname" name="nickname" class="form-input-inner"
                               placeholder="닉네임을 입력해주세요." value="${param.nickname}">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary find-submit-btn">아이디 찾기</button>
            </form>

            <!-- 결과 (닉네임으로 조회 후 model에 결과 담아서 전달) -->
            <c:if test="${not empty foundEmail}">
                <div class="find-result">
                    <p class="find-result-title">아이디 찾기 결과</p>
                    <div class="find-result-row">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#4CAF50" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/>
                        </svg>
                        <span>회원님의 아이디는 <span class="result-email">${foundEmail}</span> 입니다.</span>
                    </div>
                    <p class="find-result-note">보안을 위해 아이디의 일부만 표시됩니다.</p>
                </div>
            </c:if>
            <c:if test="${not empty notFoundMsg}">
                <div class="auth-error">${notFoundMsg}</div>
            </c:if>

            <!-- 로그인 링크 -->
            <div class="find-alt-link">
                <a href="${pageContext.request.contextPath}/member/login">로그인하러 가기</a>
            </div>

        </div>
    </div>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
