<%-- 회원 탈퇴 비밀번호 확인 모달
     사용법: JS에서 document.getElementById('withdrawModal').classList.add('active') 로 열기
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="withdrawModal" class="modal-backdrop">
    <div class="modal-card" role="dialog" aria-modal="true" aria-labelledby="withdrawTitle">

        <form id="withdrawForm"
              action="${pageContext.request.contextPath}/member/withdraw"
              method="post">

            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}">
            <!-- CSRF 토큰 : 받은 요청이 사이트에서 정상적으로 만들어진 요청인지 체크하는 보안값 (일회성에 가깝다) -->
            <!-- 서버: 정상적인 쉽코딩 화면에만 CSRF 토큰을 넣어줌 -->
            <!-- 폼을 제출하면 폼에서 받은 CSRF 토큰이 서버가 발급했던 CSRF 토큰과 동일한지 확인
                 동일한 토큰이라면 정상 요청으로 판단하지만 다르다면 403오류로 차단한다. -->

        <!-- 헤더 -->
        <div class="modal-header">
            <h2 id="withdrawTitle" class="modal-title text-danger">회원 탈퇴</h2>
            <p class="modal-subtitle">안전한 탈퇴 진행을 위해 비밀번호를 입력해주세요.</p>
        </div>

        <!-- 비밀번호 필드 -->
        <div class="modal-field">
            <label class="modal-field-label" for="withdrawPassword">비밀번호</label>
            <div class="modal-input-wrap danger">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#9CA3AF" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                    <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                </svg>
                <input type="password" id="withdrawPassword" name="password" placeholder="비밀번호를 입력해주세요.">
            </div>
        </div>

        <!-- 버튼 -->
        <div class="modal-actions">
            <button type="button" class="modal-btn modal-btn-danger" id="withdrawConfirmBtn">탈퇴하기</button>
            <button type="button" class="modal-btn modal-btn-cancel" onclick="closeModal('withdrawModal')">취소</button>
        </div>
        </form>
    </div>

</div>

<script>
document.getElementById('withdrawConfirmBtn').addEventListener('click', function () {
    var pw = document.getElementById('withdrawPassword').value;
    if (!pw) {
        alert('비밀번호를 입력해주세요.');
        return;
    }
    // TODO: 탈퇴 처리 폼 서밋 또는 AJAX
    document.getElementById('withdrawForm').submit();
});
</script>
