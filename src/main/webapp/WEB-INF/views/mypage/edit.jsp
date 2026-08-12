<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정 - 쉽코딩</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">

    <script src="${pageContext.request.contextPath}/js/nickname-validation.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/password-validation.js" defer></script>
    <script src="${pageContext.request.contextPath}/js/mypage-edit.js" defer></script>

</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="mypage-main">
    <div class="mypage-inner">

        <h1 class="mypage-title">회원정보 수정</h1>

        <div class="mypage-card">
            <form action="${pageContext.request.contextPath}/member/edit" method="post" id="editForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                <!-- ── 상단: 아바타 + 기본정보 ── -->
                <div class="edit-upper-layout">

                    <!-- 아바타 -->
                    <div class="avatar-section">
                        <div class="avatar-circle avatar-circle-lg">
                            <img
                                    src="${pageContext.request.contextPath}/images/profile/sheep-${sessionScope.loginUser.profileId}.png"
                                    alt="프로필 이미지"
                                    class="avatar-img"
                            >
                        </div>
                    </div>

                    <!-- 필드 그리드 -->
                    <div class="edit-fields-grid">
                        <!-- 닉네임 -->
                        <div class="edit-field">
                            <label class="edit-field-label" for="nickname">닉네임</label>
                            <div class="edit-input-wrap">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
                                </svg>
                                <input type="text" id="nickname" name="nickname" class="edit-input"
                                       value="${sessionScope.loginUser.nickname}"
                                       data-original-nickname="${sessionScope.loginUser.nickname}"
                                       maxlength="8"
                                       required>
                            </div>
                            <p id="check-edit-nickname-result"></p>
                        </div>

                        <div class="edit-field">
                            <span class="edit-field-label">프로필 이미지 선택</span>
                            <div class="profile-options">
                                <c:forEach var="number" begin="1" end="6">
                                    <label class="profile-option">
                                        <input
                                                type="radio"
                                                name="profileId"
                                                value="${number}"
                                        <c:if test="${sessionScope.loginUser.profileId eq number}">
                                                checked
                                        </c:if>
                                        >
                                        <img
                                                src="${pageContext.request.contextPath}/images/profile/sheep-${number}.png"
                                                alt="양 프로필 ${number}"
                                        >
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mypage-divider"></div>

                <!-- ── 비밀번호 변경 ── -->
                <div class="password-section">
                    <h2 class="password-section-title">비밀번호 변경</h2>

                    <!-- 현재 비밀번호 -->
                    <div class="edit-field">
                        <label class="edit-field-label" for="currentPassword">현재 비밀번호</label>
                        <div class="edit-input-wrap">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                            </svg>
                            <input type="password" id="currentPassword" name="currentPassword" class="edit-input"
                                   placeholder="현재 비밀번호를 입력해주세요.">
                        </div>
                        <p id="check-current-password-result"></p>
                    </div>

                    <!-- 새 비밀번호 + 확인 -->
                    <div class="edit-two-column-row">
                        <div class="edit-field edit-field-flex">
                            <label class="edit-field-label" for="newPassword">새 비밀번호</label>
                            <div class="edit-input-wrap">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                                </svg>
                                <input type="password" id="newPassword" name="newPassword" class="edit-input"
                                       placeholder="새 비밀번호를 입력해주세요.">
                            </div>
                            <p id="check-new-password-result"></p>
                        </div>

                        <div class="edit-field edit-field-flex">
                            <label class="edit-field-label" for="confirmPassword">새 비밀번호 확인</label>
                            <div class="edit-input-wrap">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                                </svg>
                                <input type="password" id="confirmPassword" class="edit-input"
                                       placeholder="새 비밀번호를 다시 입력해주세요.">
                            </div>
                            <p id="check-confirm-password-result"></p>
                        </div>
                    </div>

                    <!-- 에러 메시지 -->
                    <c:if test="${not empty errorMsg}">
                        <p class="edit-error">${errorMsg}</p>
                    </c:if>
                </div>

                <!-- ── 액션 버튼 ── -->
                <div class="form-actions">
                    <button type="submit" class="btn-save">저장하기</button>
                    <a href="${pageContext.request.contextPath}/member/mypage" class="btn-cancel">취소</a>
                </div>

            </form>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
