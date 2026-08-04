<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    알림 전용 모달입니다.
    사용 예: StudyModal.open({ type: 'alert', theme: 'success', title: '회원가입 완료', message: '환영합니다.' });
--%>
<div class="modal" data-modal-root data-modal-type="alert" aria-hidden="true">
    <%-- 배경 또는 취소 버튼 클릭 시 모달을 닫습니다. --%>
    <button type="button" class="modal__backdrop" data-modal-close aria-label="모달 닫기"></button>

    <section class="modal__card" role="alertdialog" aria-modal="true" aria-labelledby="alertModalTitle">
        <%-- 아이콘은 modal.js가 theme에 맞추어 설정합니다. --%>
        <div class="modal__icon" data-modal-icon aria-hidden="true"></div>
        <h2 id="alertModalTitle" class="modal__title" data-modal-title></h2>
        <p class="modal__message" data-modal-message></p>

        <div class="modal__actions">
            <button type="button" class="modal__button modal__button--primary" data-modal-confirm>확인</button>
        </div>
    </section>
</div>
