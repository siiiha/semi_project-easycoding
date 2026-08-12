const contextPath = document.body.dataset.contextPath;

const passwordEmailForm = document.getElementById('passwordEmailForm');
const passwordEmailInput = document.getElementById('email');
const passwordEmailResult = document.getElementById('password-email-result');

const passwordResetSection = document.getElementById('password-reset-section');
const newPasswordInput = document.getElementById('new-password');
const newPasswordConfirmInput = document.getElementById('new-password-confirm');
const resetPasswordButton = document.getElementById('reset-password-button');
const resetPasswordResult = document.getElementById('reset-password-result');
const resetPasswordConfirmResult = document.getElementById(
    'reset-password-confirm-result'
);

function validateResetPasswordConfirm() {
    const newPassword = newPasswordInput.value;
    const newPasswordConfirm = newPasswordConfirmInput.value;

    resetPasswordConfirmResult.classList.remove('is-success');

    if (newPasswordConfirm === '') {
        resetPasswordConfirmResult.textContent = '';
        return false;
    }

    if (newPassword !== newPasswordConfirm) {
        resetPasswordConfirmResult.textContent =
            '두 비밀번호가 일치하지 않습니다.';
        return false;
    }

    resetPasswordConfirmResult.textContent =
        '두 비밀번호가 일치합니다.';
    resetPasswordConfirmResult.classList.add('is-success');
    return true;
}

newPasswordInput.addEventListener('input', function () {
    resetPasswordResult.textContent = '';
    validateResetPasswordConfirm();
});

newPasswordConfirmInput.addEventListener(
    'input',
    validateResetPasswordConfirm
);

resetPasswordButton.addEventListener(
    'click',
    async function () {
        const newPassword = newPasswordInput.value;
        const newPasswordConfirm = newPasswordConfirmInput.value;

        resetPasswordResult.textContent = '';

        if (newPassword === '' || newPasswordConfirm === '') {
            resetPasswordResult.textContent =
                '새 비밀번호를 모두 입력해주세요.';
            return;
        }

        if (!isValidPassword(newPassword)) {
            resetPasswordResult.textContent =
                '8~20자의 영문, 숫자, 특수문자(!@#$%^&*)를 모두 포함해주세요.';
            return;
        }

        if (newPassword !== newPasswordConfirm) {
            resetPasswordConfirmResult.textContent =
                '두 비밀번호가 일치하지 않습니다.';
            return;
        }

        try {
            const response = await fetch(
                `${contextPath}/member/reset-password`, {
                    method: 'POST',
                    headers: {
                        'Content-Type':
                            'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        newPassword
                    })
                });

            if (!response.ok) {
                throw new Error('비밀번호 변경 요청 실패');
            }

            const changed = await response.json();

            if (changed) {
                CommonModal.open({
                    type: 'alert',
                    theme: 'success',
                    title: '비밀번호 변경 완료',
                    message: '비밀번호가 변경되었습니다.',
                    onConfirm: function () {
                        window.location.href =
                            `${contextPath}/member/login`;
                    }
                });
            } else {
                CommonModal.open({
                    type: 'alert',
                    theme: 'danger',
                    title: '비밀번호 변경 실패',
                    message: '비밀번호 변경에 실패했습니다.'
                });
            }
        } catch (error) {
            CommonModal.open({
                type: 'alert',
                theme: 'danger',
                title: '비밀번호 변경 실패',
                message: '비밀번호 변경 요청 중 오류가 발생했습니다.'
            });
        }
    }
);

async function handlePasswordCodeVerification(code) {
    try {
        const response = await fetch(
            `${contextPath}/email/password/verify`,
            {
                method: 'POST',
                headers: {
                    'Content-Type':
                        'application/x-www-form-urlencoded'
                    //application: 애플리케이션 데이터
                    // x-: 과거에 비표준 형식임을 표시하던 접두사
                    // www-form: 웹 폼
                    // urlencoded: URL 방식으로 변환됨
                },
                body: new URLSearchParams({
                    code
                })
            }
        );

        if (!response.ok) {
            throw new Error('인증번호 확인 요청 실패');
        }

        const verified = await response.json();

        if (verified) {
            passwordResetSection.hidden = false;
            CommonModal.open({
                type: 'alert',
                theme: 'success',
                title: '이메일 인증 완료',
                message: '이메일 인증이 완료되었습니다.'
            });
            return;
        }

        CommonModal.open({
            type: 'alert',
            theme: 'danger',
            title: '이메일 인증 실패',
            message: '인증번호가 올바르지 않거나 만료되었습니다.',
            onConfirm: openPasswordCodeModal
        });
    } catch (error) {
        CommonModal.open({
            type: 'alert',
            theme: 'danger',
            title: '이메일 인증 실패',
            message: '인증번호 확인 중 오류가 발생했습니다.',
            onConfirm: openPasswordCodeModal
        });
    }
}

function openPasswordCodeModal() {
    CommonModal.open({
        type: 'custom',
        theme: 'info',
        title: '이메일 인증',
        message: '이메일로 받은 6자리 인증번호를 입력해주세요.',
        confirmText: '인증 확인',
        cancelText: '취소',
        onConfirm: handlePasswordCodeVerification,
        onResend: function () {
            passwordEmailForm.requestSubmit();
        }
    });
}

passwordEmailForm.addEventListener(
    'submit',
    async function (event) {
        event.preventDefault();

        const email = passwordEmailInput.value.trim();

        try {
            const response = await fetch(
                `${contextPath}/email/password/send`,
                {
                    method: 'POST',
                    headers: {
                        'Content-Type':
                            'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        email
                    })
                }
            );
            if (!response.ok) {
                throw new Error('인증번호 발송 요청 실패');
            }

            const sent = await response.json();

            if (sent) {
                passwordEmailResult.textContent = '';
                passwordResetSection.hidden = true;
                newPasswordInput.value = '';
                newPasswordConfirmInput.value = '';
                resetPasswordResult.textContent = '';

                openPasswordCodeModal();
            } else {
                passwordEmailResult.textContent = '가입되지 않은 이메일입니다.';
                // 가입되지 않은 이메일 문구
            }
        } catch (error) {
            passwordEmailResult.textContent = '인증번호 발송 중 오류가 발생했습니다.';
        }
    }
);
