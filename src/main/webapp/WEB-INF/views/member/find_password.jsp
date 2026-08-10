<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap"
          rel="stylesheet">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="find-page">

    <!-- 히어로 -->
    <div class="find-hero">
        <div class="find-hero-text">
            <h1 class="find-hero-title">
                <span class="text-primary">계정 정보를</span><br>잊어버리셨나요?
            </h1>
            <p class="find-hero-sub">쉽코딩과 함께 다시 학습 여정을 이어가요.</p>
        </div>
        <div class="find-hero-image" aria-hidden="true">
            <svg viewBox="0 0 394 336" fill="none" xmlns="http://www.w3.org/2000/svg">
                <ellipse cx="197" cy="168" rx="180" ry="148" fill="#E8F5E9" opacity="0.7"/>
                <ellipse cx="320" cy="80" rx="60" ry="50" fill="#E8F5E9" opacity="0.5"/>
                <ellipse cx="80" cy="260" rx="70" ry="55" fill="#E8F5E9" opacity="0.5"/>
            </svg>
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

            <div id="password-code-section" hidden>
                <label for="password-code">인증번호</label>
                <input type="text"
                       id="password-code"
                       maxlength="6"
                       inputmode="numeric"
                       placeholder="6자리 인증번호를 입력해주세요.">
                <button type="button"
                        id="verify-password-code-button"
                        class="btn btn-outline">
                    인증번호 확인
                </button>
                <p id="password-code-result"></p>
            </div>

            <div id="password-reset-section" hidden>
                <label for="new-password">
                    새 비밀번호
                </label>

                <input type="password"
                       id="new-password"
                       autocomplete="new-password"
                       placeholder="새 비밀번호를 입력해주세요.">

                <label for="new-password-confirm">
                    새 비밀번호 확인
                </label>

                <input type="password"
                       id="new-password-confirm"
                       autocomplete="new-password"
                       placeholder="새 비밀번호를 다시 입력해주세요.">

                <button type="button"
                        id="reset-password-button"
                        class="btn btn-primary">
                    비밀번호 변경
                </button>

                <p id = "reset-password-result"></p>


            </div>



            <!-- 로그인 링크 -->
            <div class="find-alt-link">
                <a href="${pageContext.request.contextPath}/member/login">로그인하러 가기</a>
            </div>

        </div>
    </div>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script src="${pageContext.request.contextPath}/js/find-password.js"></script>


</body>
</html>
