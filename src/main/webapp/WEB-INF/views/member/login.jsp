<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="auth-page">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="auth-main">

    <!-- 좌측 브랜딩 -->
    <div class="auth-branding">
        <div class="branding-text">
            <h1 class="branding-title">
                <span class="text-primary">하루하루</span> 꾸준하게,<br>키워가는 <span class="text-primary">코딩습관</span>
            </h1>
            <p class="branding-sub">쉽코딩과 함께 오늘의 한 문제로 내일의 실력을 키워요.</p>
        </div>
        <div class="branding-image">
            <img src="${pageContext.request.contextPath}/images/sheep-running.png" alt="달리는 양 캐릭터">
        </div>
    </div>

    <!-- 로그인 카드 -->
    <div class="auth-card-wrap">
        <div class="auth-card">

            <div class="auth-card-header">
                <h2 class="auth-title">로그인</h2>
                <p class="auth-subtitle">쉽코딩 계정으로 로그인하세요.</p>
            </div>

            <!-- 오류 메시지 -->
            <c:if test="${not empty errorMsg}">
                <div class="auth-error">${errorMsg}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/member/login" method="post" class="auth-form">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                <!-- 이메일 -->
                <div class="form-group">
                    <label class="form-label" for="email">이메일</label>
                    <div class="input-wrap">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#9CA3AF" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/>
                        </svg>
                        <input type="email" id="email" name="email" class="form-input-inner"
                               placeholder="이메일을 입력해주세요." value="${param.email}" autocomplete="email" required>
                    </div>
                </div>

                <!-- 비밀번호 -->
                <div class="form-group">
                    <label class="form-label" for="password">비밀번호</label>
                    <div class="input-wrap">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#9CA3AF" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                        </svg>
                        <input type="password" id="password" name="password" class="form-input-inner"
                               placeholder="비밀번호를 입력해주세요." autocomplete="current-password" required>
                    </div>
                </div>

                <!-- 로그인 유지 / 비밀번호 찾기 -->
                <div class="auth-options">
                    <label class="checkbox-label">
                        <input type="checkbox" name="rememberMe" value="true">
                        <span>로그인 상태 유지</span>
                    </label>
                    <a href="${pageContext.request.contextPath}/find-password" class="auth-link">비밀번호 찾기</a>
                </div>

                <button type="submit" class="btn btn-primary auth-submit-btn">로그인</button>
            </form>

            <!-- 구분선 -->
            <div class="auth-divider"><span>또는</span></div>

            <!-- 소셜 로그인 -->
            <div class="social-btns">
                <a href="${pageContext.request.contextPath}/oauth2/authorization/google" class="social-btn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                        <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                        <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                        <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                        <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                    </svg>
                    <span>Google로 로그인</span>
                </a>
                <a href="${pageContext.request.contextPath}/oauth2/authorization/github" class="social-btn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="#181717" aria-hidden="true">
                        <path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12"/>
                    </svg>
                    <span>GitHub로 로그인</span>
                </a>
            </div>

            <!-- 회원가입 유도 -->
            <p class="auth-switch">
                아직 계정이 없으신가요?
                <a href="${pageContext.request.contextPath}/member/join" class="auth-link-primary">회원가입</a>
            </p>

        </div>
    </div>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
