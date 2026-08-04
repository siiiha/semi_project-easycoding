<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    사용자 선택을 받는 확인 모달입니다.
    사용 예: StudyModal.open({ type: 'confirm', theme: 'danger', title: '게시글을 삭제할까요?', message: '삭제 후 복구할 수 없습니다.', onConfirm: deletePost });
--%>
<div class="modal" data-modal-root data-modal-type="confirm" aria-hidden="true">
    <button type="button" class="modal__backdrop" data-modal-close aria-label="모달 닫기"></button>

    <section class="modal__card" role="dialog" aria-modal="true" aria-labelledby="confirmModalTitle">
        <div class="modal__icon" data-modal-icon aria-hidden="true"></div>
        <h2 id="confirmModalTitle" class="modal__title" data-modal-title></h2>
        <p class="modal__message" data-modal-message></p>

        <div class="modal__actions">
            <button type="button" class="modal__button modal__button--secondary" data-modal-close data-modal-cancel>취소</button>
            <button type="button" class="modal__button modal__button--primary" data-modal-confirm>확인</button>
        </div>
    </section>
</div>
