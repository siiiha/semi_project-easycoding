<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modal.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>

<body data-context-path="${pageContext.request.contextPath}">

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="find-page">

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
                <a href="${pageContext.request.contextPath}/member/find-id" class="find-tab">아이디 찾기</a>
                <a href="${pageContext.request.contextPath}/member/find-password" class="find-tab active">비밀번호 찾기</a>
            </div>

            <!-- 폼 -->
            <form action="${pageContext.request.contextPath}/member/find-password"
                  method="post"
                  class="find-form"
                  id="passwordEmailForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <div class="form-group">
                    <label class="find-field-label" for="email">아이디 (이메일)</label>
                    <div class="input-wrap">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                             stroke="#9CA3AF" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"
                             aria-hidden="true">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                            <polyline points="22,6 12,13 2,6"/>
                        </svg>
                        <input type="email"
                               id="email"
                               name="email"
                               class="form-input-inner"
                               placeholder="가입하신 이메일 주소를 입력해주세요."
                               value="${param.email}"
                               required>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary find-submit-btn">인증 메일 발송</button>
            </form>

            <p id="password-email-result"></p>

            <div id="password-reset-section" hidden>
                <div class="password-reset-fields">
                    <div class="form-group">
                        <label class="form-label" for="new-password">새 비밀번호</label>
                        <div class="input-wrap">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2.5" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2"/>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                            </svg>
                            <input type="password"
                                   id="new-password"
                                   class="form-input-inner"
                                   autocomplete="new-password"
                                   placeholder="새 비밀번호를 입력해주세요.">
                        </div>
                        <p id="reset-password-result"></p>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="new-password-confirm">새 비밀번호 확인</label>
                        <div class="input-wrap">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                 stroke="currentColor" stroke-width="2.5" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2"/>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                            </svg>
                            <input type="password"
                                   id="new-password-confirm"
                                   class="form-input-inner"
                                   autocomplete="new-password"
                                   placeholder="새 비밀번호를 다시 입력해주세요.">
                        </div>
                        <p id="reset-password-confirm-result"></p>
                    </div>
                </div>

                <button type="button"
                        id="reset-password-button"
                        class="btn btn-primary find-submit-btn">
                    비밀번호 변경
                </button>
            </div>

            <!-- 로그인 링크 -->
            <div class="find-alt-link">
                <a href="${pageContext.request.contextPath}/member/login">로그인하러 가기</a>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<jsp:include page="/WEB-INF/views/common/modal/customModal.jsp"/>
<jsp:include page="/WEB-INF/views/common/modal/alertModal.jsp"/>
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
<script src="${pageContext.request.contextPath}/js/password-validation.js"></script>
<script src="${pageContext.request.contextPath}/js/find-password.js"></script>


</body>
</html>
