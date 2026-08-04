<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    비밀번호 입력 전용 모달입니다. 회원 탈퇴, 비밀번호 변경 전 확인에 사용합니다.
    onConfirm 콜백의 첫 번째 인자로 입력한 비밀번호가 전달됩니다.
--%>
<div class="modal" data-modal-root data-modal-type="input" aria-hidden="true">
    <button type="button" class="modal__backdrop" data-modal-close aria-label="모달 닫기"></button>

    <section class="modal__card" role="dialog" aria-modal="true" aria-labelledby="inputModalTitle">
        <div class="modal__icon" data-modal-icon aria-hidden="true"></div>
        <h2 id="inputModalTitle" class="modal__title" data-modal-title></h2>
        <p class="modal__message" data-modal-message></p>

        <%-- label은 화면에서는 숨기지만 스크린 리더에는 전달됩니다. --%>
        <label class="modal__sr-only" for="modalPasswordInput">비밀번호</label>
        <input id="modalPasswordInput" class="modal__input" type="password" data-modal-input
               autocomplete="current-password" placeholder="비밀번호를 입력해 주세요.">
        <p class="modal__error" data-modal-error aria-live="polite"></p>

        <div class="modal__actions">
            <button type="button" class="modal__button modal__button--secondary" data-modal-close data-modal-cancel>취소</button>
            <button type="button" class="modal__button modal__button--primary" data-modal-confirm>확인</button>
        </div>
    </section>
</div>
