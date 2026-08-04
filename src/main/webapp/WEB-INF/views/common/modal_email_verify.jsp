<%-- 이메일 인증 모달
     사용법: 이 파일을 jsp:include 또는 직접 페이지에 삽입 후
             JS에서 document.getElementById('emailVerifyModal').classList.add('active') 로 열기
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="emailVerifyModal" class="modal-backdrop">
    <div class="modal-card" role="dialog" aria-modal="true" aria-labelledby="emailVerifyTitle">

        <!-- 헤더 -->
        <div class="modal-header">
            <h2 id="emailVerifyTitle" class="modal-title">이메일 인증</h2>
            <p class="modal-subtitle">인증 코드가 발송되었습니다. 이메일을 확인해주세요.</p>
        </div>

        <!-- 코드 입력 -->
        <div class="code-input-container">
            <input type="text" class="code-digit" maxlength="1" inputmode="numeric" pattern="[0-9]" autocomplete="one-time-code">
            <input type="text" class="code-digit" maxlength="1" inputmode="numeric" pattern="[0-9]">
            <input type="text" class="code-digit" maxlength="1" inputmode="numeric" pattern="[0-9]">
            <input type="text" class="code-digit" maxlength="1" inputmode="numeric" pattern="[0-9]">
            <input type="text" class="code-digit" maxlength="1" inputmode="numeric" pattern="[0-9]">
            <input type="text" class="code-digit" maxlength="1" inputmode="numeric" pattern="[0-9]">
        </div>

        <!-- 재발송 -->
        <div class="resend-row">
            <span>인증코드를 받지 못하셨나요?</span>
            <a href="#" id="resendCodeBtn"> 재발송</a>
        </div>

        <!-- 버튼 -->
        <div class="modal-actions">
            <button type="button" class="modal-btn modal-btn-primary" id="emailVerifyConfirmBtn">인증 확인</button>
            <button type="button" class="modal-btn modal-btn-cancel" onclick="closeModal('emailVerifyModal')">취소</button>
        </div>

    </div>
</div>

<script>
    (function () {
    const digits = document.querySelectorAll('#emailVerifyModal .code-digit');

    digits.forEach(function (input, idx) {
        input.addEventListener('input', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
            if (this.value && idx < digits.length - 1) {
                digits[idx + 1].focus();
            }
        });
        input.addEventListener('keydown', function (e) {
            if (e.key === 'Backspace' && !this.value && idx > 0) {
                digits[idx - 1].focus();
            }
        });
    });

    document.getElementById('resendCodeBtn').addEventListener('click', function (e) {
        e.preventDefault();
        digits.forEach(function (input) {
            input.value = '';
            //input : 인증번호 입력칸 한 개
        });
        document.getElementById('send-email-code-button').click();
    }); //기존에 입력했던 인증번호 삭제 후 다시 이메일 인증 버튼 클릭

    document.getElementById('emailVerifyConfirmBtn').addEventListener('click', async function () {
        var code = Array.from(digits).map(function (d) { return d.value; }).join('');
        if (code.length < 6) {
            alert('6자리 코드를 모두 입력해주세요.');
            return;
        }
        const response = await fetch(
            '${pageContext.request.contextPath}/email/join/verify', //인증번호 확인 주소
            {
                method: 'POST',
                headers: {
                    'Content-Type':
                        'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    code: code
                })
            }
        );

        if (!response.ok) {
            alert('인증 요청 중 오류가 발생했습니다.');
            return;
        }
        const verified = await response.json();

        if (verified) {
            alert('이메일 인증이 완료되었습니다.');
            closeModal('emailVerifyModal');
        } else {
            alert('인증번호가 올바르지 않거나 만료되었습니다.');
        }
    });
})();
</script>
