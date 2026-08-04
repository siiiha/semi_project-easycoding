<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    이메일 인증번호 입력 모달입니다.
    onConfirm 콜백의 첫 번째 인자로 6자리 인증번호 문자열이 전달됩니다.
    onResend 콜백을 전달하면 인증번호 재발송 버튼에서 실행됩니다.
--%>
<div class="modal" data-modal-root data-modal-type="custom" aria-hidden="true">
    <button type="button" class="modal__backdrop" data-modal-close aria-label="모달 닫기"></button>

    <section class="modal__card" role="dialog" aria-modal="true" aria-labelledby="customModalTitle">
        <div class="modal__icon" data-modal-icon aria-hidden="true"></div>
        <h2 id="customModalTitle" class="modal__title" data-modal-title></h2>
        <p class="modal__message" data-modal-message></p>

        <%-- 인증번호는 숫자 한 자리씩 입력합니다. --%>
        <div class="modal__code-inputs" aria-label="6자리 이메일 인증번호">
            <input type="text" data-modal-code maxlength="1" inputmode="numeric" aria-label="인증번호 1자리">
            <input type="text" data-modal-code maxlength="1" inputmode="numeric" aria-label="인증번호 2자리">
            <input type="text" data-modal-code maxlength="1" inputmode="numeric" aria-label="인증번호 3자리">
            <input type="text" data-modal-code maxlength="1" inputmode="numeric" aria-label="인증번호 4자리">
            <input type="text" data-modal-code maxlength="1" inputmode="numeric" aria-label="인증번호 5자리">
            <input type="text" data-modal-code maxlength="1" inputmode="numeric" aria-label="인증번호 6자리">
        </div>
        <p class="modal__error" data-modal-error aria-live="polite"></p>
        <button type="button" class="modal__link" data-modal-resend>인증번호 재발송</button>

        <div class="modal__actions">
            <button type="button" class="modal__button modal__button--secondary" data-modal-close data-modal-cancel>취소</button>
            <button type="button" class="modal__button modal__button--primary" data-modal-confirm>인증 확인</button>
        </div>
    </section>
</div>
