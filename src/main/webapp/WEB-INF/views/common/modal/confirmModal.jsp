<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- StudyModal.open({ type:'confirm', theme:'danger', title:'게시글을 삭제할까요?', message:'삭제한 게시글은 복구할 수 없습니다.', onConfirm: deletePost }); --%>
<div id="confirmModal" class="modal" aria-hidden="true">
    <div class="modal-backdrop" data-cancel></div>
    <section class="modal-card" role="dialog" aria-modal="true" aria-labelledby="studyConfirmTitle">
        <div class="modal-icon" aria-hidden="true">!</div>
        <h2 id="studyConfirmTitle" class="modal-title"></h2>
        <p class="modal-message"></p>
        <div class="modal-actions">
            <button type="button" class="modal-button modal-button--secondary" data-cancel>취소</button>
            <button type="button" class="modal-button modal-button--primary" data-confirm>확인</button>
        </div>
    </section>
</div>
<style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1050;
        inset: 0;
        align-items: center;
        justify-content: center;
        font-family: inherit
    }

    .modal.is-open {
        display: flex
    }

    .modal-backdrop {
        position: absolute;
        inset: 0;
        background: rgba(17, 24, 39, .5)
    }

    .modal-card {
        position: relative;
        box-sizing: border-box;
        width: min(420px, calc(100% - 32px));
        padding: 28px;
        border-radius: 16px;
        background: #fff;
        box-shadow: 0 20px 45px rgba(0, 0, 0, .2);
        text-align: center
    }

    .modal-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 48px;
        height: 48px;
        margin: 0 auto 14px;
        border-radius: 50%;
        background: #e8f5e9;
        color: #2e7d32;
        font-size: 27px;
        font-weight: 700
    }

    .modal-title {
        margin: 0;
        color: #1f2937;
        font-size: 20px
    }

    .modal-message {
        margin: 10px 0 24px;
        color: #6b7280;
        line-height: 1.55;
        white-space: pre-line
    }

    .modal-actions {
        display: flex;
        gap: 8px;
        justify-content: center
    }

    .modal-button {
        min-width: 110px;
        border: 0;
        border-radius: 8px;
        padding: 11px 16px;
        font: inherit;
        font-weight: 600;
        cursor: pointer
    }

    .modal-button--primary {
        background: #4caf50;
        color: #fff
    }

    .modal-button--secondary {
        background: #f3f4f6;
        color: #374151
    }

    .modal[data-theme="danger"] .modal-icon {
        background: #ffebee;
        color: #d32f2f
    }

    .modal[data-theme="danger"] .modal-button--primary {
        background: #e53935
    }

    .modal[data-theme="warning"] .modal-icon {
        background: #fff8e1;
        color: #f57c00
    }

    .modal[data-theme="warning"] .modal-button--primary {
        background: #f59e0b
    }

    .modal[data-theme="info"] .modal-icon {
        background: #e3f2fd;
        color: #1976d2
    }

    .modal[data-theme="info"] .modal-button--primary {
        background: #1976d2
    }
</style>
<script>
    (function () {
        var root = document.getElementById('confirmModal'), title = root.querySelector('.modal-title'),
            message = root.querySelector('.modal-message'), confirm = root.querySelector('[data-confirm]'),
            current = {};

        function close(cancelled) {
            root.classList.remove('is-open');
            root.setAttribute('aria-hidden', 'true');
            if (cancelled && typeof current.onCancel === 'function') current.onCancel();
        }

        function open(options) {
            current = options || {};
            root.dataset.theme = current.theme || 'warning';
            title.textContent = current.title || '확인';
            message.textContent = current.message || '';
            confirm.textContent = current.confirmText || '확인';
            root.querySelector('[data-cancel]').textContent = current.cancelText || '취소';
            root.classList.add('is-open');
            root.setAttribute('aria-hidden', 'false');
            confirm.focus();
        }

        confirm.addEventListener('click', function () {
            var callback = current.onConfirm;
            close(false);
            if (typeof callback === 'function') callback();
        });
        root.querySelectorAll('[data-cancel]').forEach(function (button) {
            button.addEventListener('click', function () {
                close(true);
            });
        });
        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape' && root.classList.contains('is-open')) close(true);
        });
        window.StudyModal = window.StudyModal || {registry: {}};
        window.StudyModal.registry.confirm = {open: open, close: close};
        window.StudyModal.open = function (options) {
            var modal = this.registry[options && options.type];
            if (!modal) throw new Error('등록되지 않은 modal type입니다.');
            modal.open(options);
        };
    })();
</script>
