/**
 * 공통 모달 관리자
 *
 * - StudyModal.open(options): type, theme, title, message, 콜백을 받아 모달을 엽니다.
 * - StudyModal.close(): 현재 열려 있는 모달을 닫습니다.
 */
(function () {
    'use strict';

    // 현재 열린 모달과 전달받은 옵션을 한 곳에서 관리합니다.
    var activeModal = null;
    var activeOptions = null;
    var lastFocusedElement = null;

    // 테마별 아이콘입니다. 필요하면 프로젝트 아이콘(SVG)으로 교체해도 됩니다.
    var themeIcons = {
        success: '✓',
        danger: '!',
        warning: '!',
        info: 'i'
    };

    /** 지정한 모달을 열고 공통 데이터(type/theme/title/message)를 화면에 적용합니다. */
    function open(options) {
        options = options || {};

        if (!options.type) {
            console.error('StudyModal.open()에는 type 값이 필요합니다.');
            return;
        }

        var modal = document.querySelector('[data-modal-root][data-modal-type="' + options.type + '"]');
        if (!modal) {
            console.error('등록되지 않은 modal type입니다: ' + options.type);
            return;
        }

        // 다른 모달이 열려 있다면 먼저 닫습니다. 이때 취소 콜백은 실행하지 않습니다.
        if (activeModal) close(false);

        activeModal = modal;
        activeOptions = options;
        lastFocusedElement = document.activeElement;

        var theme = options.theme || 'success';
        modal.dataset.theme = theme;
        setText(modal, '[data-modal-title]', options.title || '안내');
        setText(modal, '[data-modal-message]', options.message || '');
        setText(modal, '[data-modal-icon]', themeIcons[theme] || themeIcons.success);
        setText(modal, '[data-modal-confirm]', options.confirmText || defaultConfirmText(options.type));
        setText(modal, '[data-modal-cancel]', options.cancelText || '취소');

        initializeTypeFields(modal, options.type, options);

        modal.classList.add('is-open');
        modal.setAttribute('aria-hidden', 'false');

        // input/custom은 입력창에, 나머지는 확인 버튼에 포커스를 둡니다.
        var focusTarget = modal.querySelector('[data-modal-input], [data-modal-code], [data-modal-confirm]');
        if (focusTarget) focusTarget.focus();
    }

    /** 현재 열린 모달을 닫습니다. isCancelled가 true면 onCancel을 호출합니다. */
    function close(isCancelled) {
        if (!activeModal) return;

        var options = activeOptions;
        activeModal.classList.remove('is-open');
        activeModal.setAttribute('aria-hidden', 'true');

        activeModal = null;
        activeOptions = null;

        // 모달을 열었던 버튼으로 포커스를 돌려 접근성을 유지합니다.
        if (lastFocusedElement && typeof lastFocusedElement.focus === 'function') {
            lastFocusedElement.focus();
        }
        lastFocusedElement = null;

        if (isCancelled && options && typeof options.onCancel === 'function') {
            options.onCancel();
        }
    }

    /** 확인 버튼 클릭 시 타입별 입력값을 검증하고 onConfirm에 전달합니다. */
    function confirm() {
        if (!activeModal || !activeOptions) return;

        var value;
        var type = activeOptions.type;

        if (type === 'input') {
            value = activeModal.querySelector('[data-modal-input]').value;
            if (!value) {
                showError(activeModal, activeOptions.requiredMessage || '비밀번호를 입력해 주세요.');
                activeModal.querySelector('[data-modal-input]').focus();
                return;
            }
        }

        if (type === 'custom') {
            var inputs = activeModal.querySelectorAll('[data-modal-code]');
            value = Array.prototype.map.call(inputs, function (input) { return input.value; }).join('');
            if (value.length !== inputs.length) {
                showError(activeModal, activeOptions.requiredMessage || '6자리 인증번호를 모두 입력해 주세요.');
                return;
            }
        }

        var onConfirm = activeOptions.onConfirm;
        close(false);
        if (typeof onConfirm === 'function') onConfirm(value);
    }

    /** input/custom 모달을 열 때 이전 입력과 오류 메시지를 비웁니다. */
    function initializeTypeFields(modal, type, options) {
        clearError(modal);

        if (type === 'input') {
            var passwordInput = modal.querySelector('[data-modal-input]');
            passwordInput.value = '';
            passwordInput.placeholder = options.placeholder || '비밀번호를 입력해 주세요.';
        }

        if (type === 'custom') {
            modal.querySelectorAll('[data-modal-code]').forEach(function (input) { input.value = ''; });
        }
    }

    function defaultConfirmText(type) {
        return type === 'custom' ? '인증 확인' : '확인';
    }

    function setText(modal, selector, text) {
        var element = modal.querySelector(selector);
        if (element) element.textContent = text;
    }

    function showError(modal, message) { setText(modal, '[data-modal-error]', message); }
    function clearError(modal) { setText(modal, '[data-modal-error]', ''); }

    // 클릭 이벤트를 한 번만 등록합니다. JSP를 여러 개 include해도 중복 등록되지 않습니다.
    document.addEventListener('click', function (event) {
        if (!activeModal) return;

        if (event.target.closest('[data-modal-confirm]')) {
            confirm();
            return;
        }

        if (event.target.closest('[data-modal-close]')) {
            close(true);
            return;
        }

        if (event.target.closest('[data-modal-resend]') && typeof activeOptions.onResend === 'function') {
            activeOptions.onResend();
        }
    });

    // 인증번호는 숫자만 입력하고, 한 자리를 입력하면 다음 칸으로 이동합니다.
    document.addEventListener('input', function (event) {
        if (!activeModal || !event.target.matches('[data-modal-code]')) return;

        var inputs = Array.prototype.slice.call(activeModal.querySelectorAll('[data-modal-code]'));
        var index = inputs.indexOf(event.target);
        event.target.value = event.target.value.replace(/\D/g, '').slice(-1);

        if (event.target.value && index < inputs.length - 1) inputs[index + 1].focus();
    });

    document.addEventListener('keydown', function (event) {
        if (!activeModal) return;

        if (event.key === 'Escape') {
            close(true);
            return;
        }

        // Enter는 인증번호/비밀번호 입력 후 확인 버튼과 동일하게 동작합니다.
        if (event.key === 'Enter' && (event.target.matches('[data-modal-input]') || event.target.matches('[data-modal-code]'))) {
            event.preventDefault();
            confirm();
        }

        // 빈 인증번호 칸에서 Backspace를 누르면 이전 칸으로 이동합니다.
        if (event.key === 'Backspace' && event.target.matches('[data-modal-code]') && !event.target.value) {
            var inputs = Array.prototype.slice.call(activeModal.querySelectorAll('[data-modal-code]'));
            var index = inputs.indexOf(event.target);
            if (index > 0) inputs[index - 1].focus();
        }
    });

    // 페이지에서 사용할 전역 객체입니다.
    window.StudyModal = {
        open: open,
        close: function () { close(false); }
    };
})();
 