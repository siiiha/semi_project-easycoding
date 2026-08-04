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
            <form action="${pageContext.request.contextPath}/member/edit" method="post" id="editForm" enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                <!-- ── 상단: 아바타 + 기본정보 ── -->
                <div class="edit-upper-layout">

                    <!-- 아바타 -->
                    <div class="avatar-section">
                        <div class="avatar-circle avatar-circle-lg">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loginUser.profileImg}">
                                    <img src="${sessionScope.loginUser.profileImg}" alt="프로필 이미지" class="avatar-img">
                                </c:when>
                                <c:otherwise>
                                    <svg width="100" height="100" viewBox="0 0 28 28" fill="none" aria-hidden="true">
                                        <path clip-rule="evenodd" d="M14 2a5 5 0 1 1 0 10A5 5 0 0 1 14 2zm0 12c6 0 10 2.7 10 4v2H4v-2c0-1.3 4-4 10-4z" fill="currentColor" fill-rule="evenodd"/>
                                    </svg>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <label for="profileImage" class="avatar-change-btn" style="cursor:pointer;">이미지 변경</label>
                        <input type="file" id="profileImage" name="profileImage" accept="image/*" style="display:none;">
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

                        <!-- 이메일 + 회원번호 (읽기 전용) -->
                        <div class="edit-readonly-row">
                            <div class="edit-field edit-field-flex">
                                <label class="edit-field-label">이메일</label>
                                <div class="edit-input-wrap edit-input-wrap-readonly">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/>
                                    </svg>
                                    <input type="text" class="edit-input" value="${sessionScope.loginUser.email}" readonly>
                                </div>
                            </div>
                            <div class="edit-field edit-field-flex">
                                <label class="edit-field-label">회원번호</label>
                                <div class="edit-input-wrap edit-input-wrap-readonly">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/>
                                    </svg>
                                    <input type="text" class="edit-input" value="${sessionScope.loginUser.memberId}" readonly>
                                </div>
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
                    </div>

                    <!-- 새 비밀번호 + 확인 -->
                    <div class="edit-readonly-row">
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
                                <input type="password" id="confirmPassword" name="confirmPassword" class="edit-input"
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
<script src="${pageContext.request.contextPath}/js/modal.js"></script>
<script>
/* 비밀번호 일치 확인 */
document.getElementById('editForm').addEventListener('submit', function(e) {
    var np = document.getElementById('newPassword').value;
    var cp = document.getElementById('confirmPassword').value;
    if (np && np !== cp) {
        e.preventDefault();
        alert('새 비밀번호가 일치하지 않습니다.');
    }
});
/* 프로필 이미지 미리보기 */
document.getElementById('profileImage').addEventListener('change', function(e) {
    var file = e.target.files[0];
    if (!file) return;
    var reader = new FileReader();
    reader.onload = function(ev) {
        var circle = document.querySelector('.avatar-circle-lg');
        circle.innerHTML = '<img src="' + ev.target.result + '" alt="프로필 미리보기" class="avatar-img">';
    };
    reader.readAsDataURL(file);
});
</script>
</body>
</html>
