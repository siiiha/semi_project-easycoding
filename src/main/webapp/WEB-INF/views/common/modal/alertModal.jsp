<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
  사용 예시
  StudyModal.open({
    type: 'alert', theme: 'success', title: '게시글 작성 완료',
    message: '게시글이 등록되었습니다.', onConfirm: function () { location.href = '/community'; }
  });
--%>
<div id="studyAlertModal" class="study-modal" aria-hidden="true">
    <div class="study-modal__backdrop" data-close></div>
    <section class="study-modal__card" role="alertdialog" aria-modal="true" aria-labelledby="studyAlertTitle">
        <div class="study-modal__icon" aria-hidden="true">✓</div>
        <h2 id="studyAlertTitle" class="study-modal__title"></h2>
        <p class="study-modal__message"></p>
        <div class="study-modal__actions">
            <button type="button" class="study-modal__button study-modal__button--primary" data-confirm>확인</button>
        </div>
    </section>
</div>

<style>
.study-modal{display:none;position:fixed;z-index:1050;inset:0;align-items:center;justify-content:center;font-family:inherit}.study-modal.is-open{display:flex}.study-modal__backdrop{position:absolute;inset:0;background:rgba(17,24,39,.5)}.study-modal__card{position:relative;box-sizing:border-box;width:min(420px,calc(100% - 32px));padding:28px;border-radius:16px;background:#fff;box-shadow:0 20px 45px rgba(0,0,0,.2);text-align:center}.study-modal__icon{display:flex;align-items:center;justify-content:center;width:48px;height:48px;margin:0 auto 14px;border-radius:50%;background:#e8f5e9;color:#2e7d32;font-size:27px;font-weight:700}.study-modal__title{margin:0;color:#1f2937;font-size:20px}.study-modal__message{margin:10px 0 24px;color:#6b7280;line-height:1.55;white-space:pre-line}.study-modal__actions{display:flex;gap:8px;justify-content:center}.study-modal__button{min-width:110px;border:0;border-radius:8px;padding:11px 16px;font:inherit;font-weight:600;cursor:pointer}.study-modal__button--primary{background:#4caf50;color:#fff}.study-modal[data-theme="danger"] .study-modal__icon{background:#ffebee;color:#d32f2f}.study-modal[data-theme="danger"] .study-modal__button--primary{background:#e53935}.study-modal[data-theme="warning"] .study-modal__icon{background:#fff8e1;color:#f57c00}.study-modal[data-theme="warning"] .study-modal__button--primary{background:#f59e0b}.study-modal[data-theme="info"] .study-modal__icon{background:#e3f2fd;color:#1976d2}.study-modal[data-theme="info"] .study-modal__button--primary{background:#1976d2}
</style>

<script>
(function () {
    var root = document.getElementById('studyAlertModal');
    var title = root.querySelector('.study-modal__title');
    var message = root.querySelector('.study-modal__message');
    var confirm = root.querySelector('[data-confirm]');
    var current = {};
    function close() { root.classList.remove('is-open'); root.setAttribute('aria-hidden', 'true'); if (typeof current.onClose === 'function') current.onClose(); }
    function open(options) {
        current = options || {};
        root.dataset.theme = current.theme || 'success';
        title.textContent = current.title || '안내';
        message.textContent = current.message || '';
        confirm.textContent = current.confirmText || '확인';
        root.classList.add('is-open'); root.setAttribute('aria-hidden', 'false'); confirm.focus();
    }
    confirm.addEventListener('click', function () { var callback = current.onConfirm; close(); if (typeof callback === 'function') callback(); });
    root.querySelector('[data-close]').addEventListener('click', close);
    document.addEventListener('keydown', function (event) { if (event.key === 'Escape' && root.classList.contains('is-open')) close(); });
    window.StudyModal = window.StudyModal || { registry: {} };
    window.StudyModal.registry.alert = { open: open, close: close };
    window.StudyModal.open = function (options) { var modal = this.registry[options && options.type]; if (!modal) throw new Error('등록되지 않은 modal type입니다.'); modal.open(options); };
})();
</script>
