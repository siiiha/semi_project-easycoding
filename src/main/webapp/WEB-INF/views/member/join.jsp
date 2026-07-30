<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Noto+Sans+KR:wght@400;500;600;700&display=swap"
          rel="stylesheet">
</head>
<body class="auth-page">

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="auth-main">

    <!-- 좌측 브랜딩 -->
    <div class="auth-branding">
        <div class="branding-text">
            <h1 class="branding-title">
                <span class="text-primary">쉽코딩</span>에<br>오신 것을 환영해요!
            </h1>
            <p class="branding-sub">매일 함께 성장해요.</p>
        </div>
        <div class="branding-image">
            <img src="${pageContext.request.contextPath}/images/인사하는_양.png" alt="인사하는 양 캐릭터">
        </div>
    </div>

    <!-- 회원가입 카드 -->
    <div class="auth-card-wrap">
        <div class="auth-card">

            <div class="auth-card-header">
                <h2 class="auth-title">회원가입</h2>
                <p class="auth-subtitle">쉽코딩 계정을 만들어보세요.</p>
            </div>

            <!-- 오류 메시지 -->
            <c:if test="${not empty errorMsg}">
                <div class="auth-error">${errorMsg}</div>
            </c:if>

            <!-- 회원가입 버튼을 누르면 <from>이 실행된다. -->
            <form action="${pageContext.request.contextPath}/member/join" method="post" class="auth-form" id="joinForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                <!-- 닉네임 -->
                    <div class="form-group">
                        <label class="form-label" for="nickname">닉네임</label>
                        <div class="input-wrap">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                 fill="none" stroke="#49454F" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                <circle cx="12" cy="7" r="4"/>
                            </svg>
                            <input type="text" id="nickname" name="nickname" class="form-input-inner"
                                   placeholder="닉네임을 입력해주세요." value="${param.nickname}" required>
                        </div>
                    </div>

                <!-- 아이디(이메일) -->
                    <div class="form-group">
                        <label class="form-label" for="email">아이디</label>
                        <div class="input-wrap">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                 fill="none" stroke="#9CA3AF" stroke-width="2.5" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                                <polyline points="22,6 12,13 2,6"/>
                            </svg>
                            <input type="email" id="email" name="email" class="form-input-inner"
                                   placeholder="이메일을 입력해주세요." value="${param.email}"
                                   autocomplete="email" required>

                            <button type="button" id="check-email-button" class="btn btn-outline">
                                중복확인
                            </button>
                        </div>
                        <p id="check-email-result"></p>
                    </div>

                <!-- 비밀번호 -->
                    <div class="form-group">
                        <label class="form-label" for="password">비밀번호</label>
                        <div class="input-wrap">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                 fill="none" stroke="#9CA3AF" stroke-width="2.5" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2"/>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                            </svg>
                            <input type="password" id="password" name="password" class="form-input-inner"
                                   placeholder="비밀번호를 입력해주세요." autocomplete="new-password" required>
                        </div>
                    </div>

                <!-- 비밀번호 확인 -->
                    <div class="form-group">
                        <label class="form-label" for="passwordConfirm">비밀번호 확인</label>
                        <div class="input-wrap">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                 fill="none" stroke="#9CA3AF" stroke-width="2.5" stroke-linecap="round"
                                 stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2"/>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                            </svg>
                            <input type="password" id="passwordConfirm" name="passwordConfirm" class="form-input-inner"
                                   placeholder="비밀번호를 다시 입력해주세요." autocomplete="new-password" required>
                            <p id="check-password-result"></p>
                            <!-- 이 부분은 패스워드 체크의 결과값이 들어간다.-->
                            <!-- "check-password-result"는 Java변수가 아니라 HTML의 id이기 때문에 구글 자바 컨벤션의 적용 대상이 아니다.-->
                        </div>
                    </div>

                <button type="submit" class="btn btn-primary auth-submit-btn">회원가입</button>
            </form>

            <%-- 소셜 연동 회원가입 영역
            <!-- 구분선 -->
            <div class="auth-divider"><span>또는</span></div>

            <!-- 소셜 로그인 -->
            <div class="social-btns">
                <a href="${pageContext.request.contextPath}/oauth2/authorization/google" class="social-btn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                         aria-hidden="true">
                        <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                              fill="#4285F4"/>
                        <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                              fill="#34A853"/>
                        <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                              fill="#FBBC05"/>
                        <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                              fill="#EA4335"/>
                    </svg>
                    <span>Google로 로그인</span>
                </a>
                <a href="${pageContext.request.contextPath}/oauth2/authorization/github" class="social-btn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="#181717"
                         aria-hidden="true">
                        <path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12"/>
                    </svg>
                    <span>GitHub로 로그인</span>
                </a>
            </div>
            --%>

            <!-- 로그인 유도 -->
            <p class="auth-switch">
                이미 계정이 있으신가요?
                <a href="${pageContext.request.contextPath}/member/login" class="auth-link-primary">로그인</a>
            </p>

        </div>
    </div>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script>
    const emailInput = document.getElementById('email');
    //이메일 입력창 요소
    const checkEmailButton = document.getElementById('check-email-button');
    //이메일 중복 확인 버튼 요소
    const checkEmailResult = document.getElementById('check-email-result');
    //이메일 체크 결과를 표시할 요소

    let checkedEmail = null;
    //중복 확인을 통과한 이메일을 기억할 변수 (이메일 문자열을 저장할 예정이다.)

    //이메일이 비어있으면 안내문구를 표시하고 중복 확인을 중단한다.
    checkEmailButton.addEventListener('click', async function () {
        const email = emailInput.value.trim();

        if (email === '') {
            checkEmailResult.textContent = '이메일을 입력해주세요.';
            checkedEmail = null;
            emailInput.focus();
            return;
        }
        //이메일이 공백일 경우 실행될 코드.
        //focus() : 이메일 입력창으로 커서 이동

        try {
            const response = await fetch('${pageContext.request.contextPath}/member/check-email?email='
                + encodeURIComponent(email)
            );
            //pageContext.request.contextPath : 현제 웹 애플리케이션의 시작 경로
            //pageContext : 현재 JSP페이지의 정보
            //request : 현재 들어온 요청 정보
            //contextPath : 그 요청에서 프로젝트의 시작 경로


            if (!response.ok) {
                throw new Error('이메일 중복 확인 요청 실패');
            }

            const isDuplicate = await response.json();
            //response에는 서버가 보낸 응답 전체가 들어있다.
            //response.json() : 그리고 그 응답 안에 있는 실제 데이터를 자바 스크립트에서 사용할 수 있도록 꺼내는 것
            //현재 Controller는 boolean을 반환한다. 결과값은 true 또는 false
            //await : 서버의 응답을 기다린 후에 실행!

            if (isDuplicate) {
                checkEmailResult.textContent =
                    '이미 사용 중인 이메일입니다.';
                checkedEmail = null;
            } else {
                checkEmailResult.textContent =
                    '사용 가능한 이메일입니다.';
                checkedEmail = email;
            }
        } catch (error) {
            checkEmailResult.textContent =
                '이메일 중복 확인 중 오류가 발생했습니다.';
            checkedEmail = null;
        }


    });

    emailInput.addEventListener('input', function () {
        checkedEmail = null;
        checkEmailResult.textContent = '';
    });

    const passwordInput = document.getElementById('password');
    //첫번째 비밀번호 입력요소
    const passwordConfirmInput = document.getElementById('passwordConfirm');
    //두번쨰 비밀번호 입력요소
    const checkPasswordResult = document.getElementById('check-password-result');
    //비밀번호 일치 여부 메세지를 표시할 요소
    let isPasswordMatched = false;

    //비밀번호 일치 여부를 기억하는 변수

    function validatePasswordConfirm() {
        if (passwordConfirmInput.value === '') {
            checkPasswordResult.textContent = '';
            isPasswordMatched = false;
            return;
            //만약에 빈 문자열이라면, 기존 결과의 문장을 지우고 패스워드 일치 여부를 실패로 변경 > return으로 함수를 종료한다.
        }
        isPasswordMatched =
            passwordInput.value === passwordConfirmInput.value;
        checkPasswordResult.textContent = isPasswordMatched
            ? '비밀번호가 일치합니다.' : '비밀번호가 일치하지 않습니다.';
    }   //두 입력값이 동일한지 비교하고 isPasswordMatched에 결과를 저장한다.
        //그 결과 값 (true인지 false) 에 따라서 지정 문구 출력

    passwordInput.addEventListener('input', validatePasswordConfirm);
    passwordConfirmInput.addEventListener('input', validatePasswordConfirm);
    const joinForm = document.getElementById('joinForm');
    //첫 번째 비밀번호 입력창에 입력이 발생하면 비교 함수(validatePasswordConfirm)를 실행
    //두 번째 비밀번호 확인 입력창에 입력이 발생하면 비교 함수(validatePasswordConfirm)를 실행


    joinForm.addEventListener('submit', function (event) {

        const currentEmail = emailInput.value.trim();
        //회원가입 버튼을 누르는 순간 이메일 입력칸에 들어있는 이메일의 앞뒤 공백을 제거하는 값을 currenEmail에 저장한다.

        if (checkedEmail !== currentEmail) {
            event.preventDefault();
            alert('이메일 중복 확인을 진행해주세요.');
            emailInput.focus();
            return;
        }

        if (!isPasswordMatched) {
            event.preventDefault();
            alert('비밀번호가 일치하지 않습니다.');
            passwordConfirmInput.focus();
        }   //위에 있는 것과의 차이는 위는 작성할시 바로바로 비교. 아래는 버튼을 누르면 비교하여 문구가 나온다.


    });
</script>
</body>
</html>
