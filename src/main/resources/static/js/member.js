const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const contextPath = document.body.dataset.contextPath;
const memberJoinForm = document.querySelector("#joinForm");
//memberJoinForm은 회원가입 버튼을 눌러 폼이 제출되는 순간을 감지하기 위해 사용

const memberPasswordInput = document.querySelector("#password");
const memberEmailInput = document.querySelector("#email");
const memberNicknameInput = document.querySelector("#nickname");
const emailResult = document.querySelector("#check-email-result");
const nicknameResult = document.querySelector("#check-nickname-result");
const passwordFormatResult = document.querySelector("#check-password-format-result");

const passwordConfirmInput = document.querySelector("#passwordConfirm");
const passwordConfirmResult = document.querySelector("#check-password-result");
const sendEmailCodeButton = document.querySelector("#send-email-code-button");

let checkedNickname = null;
let checkedEmail = null;
let isPasswordMatched = false;

async function validateEmailDuplicate() {
    const email = memberEmailInput.value.trim();
    if (!validateEmailFormat()) {
        checkedEmail = null;
        return false;
    }

    if (checkedEmail === email) {
        return true;
    }

    const requestUrl = new URL("check-email", memberJoinForm.action);
    requestUrl.searchParams.set("email", email);

    // requestUrl     → 방금 만든 이메일 확인 주소
    // searchParams   → 주소 뒤의 ?email=... 부분
    // set            → 파라미터 추가
    // "email"        → Controller의 @RequestParam 이름
    // email          → 사용자가 입력한 이메일 값

    try {
        const response = await fetch(requestUrl);

        if (!response.ok) {
            throw new Error("이메일 중복 확인 요청 실패");
        }

        const isDuplicate = await response.json();

        if (memberEmailInput.value.trim() !== email) {
            return false;
        }

        if (isDuplicate) {
            emailResult.textContent = "이미 사용 중인 이메일입니다.";
            emailResult.classList.remove("is-success");
            checkedEmail = null;
            return false;
        }

        emailResult.textContent = "사용 가능한 이메일입니다.";
        emailResult.classList.add("is-success");
        checkedEmail = email;
        return true;
    } catch (error) {
        if (memberEmailInput.value.trim() !== email) {
            return false;
        }

        emailResult.textContent = "이메일 중복 확인 중 오류가 발생했습니다.";
        emailResult.classList.remove("is-success");
        checkedEmail = null;
        return false;
    }
}

async function checkEmailVerification(code) {
    const response = await fetch(
        `${contextPath}/email/join/verify`,
        {
            method: "POST",
            body: new URLSearchParams({code})
        }
    );

    if (!response.ok) {
        throw new Error("인증번호 확인 요청 실패");
    }

    return response.json();
}

async function handleEmailVerification(code) {
    try {
        const isVerified = await checkEmailVerification(code);

        CommonModal.open({
            type: "alert",
            theme: isVerified ? "success" : "danger",
            title: isVerified ? "이메일 인증 완료" : "이메일 인증 실패",
            message: isVerified
                ? "이메일 인증이 완료되었습니다."
                : "인증번호가 일치하지 않습니다."
        });
    } catch (error) {
        CommonModal.open({
            type: "alert",
            theme: "danger",
            title: "이메일 인증 실패",
            message: "인증번호 확인 요청에 실패했습니다."
        });
    }
}

sendEmailCodeButton.addEventListener("click", async function () {
    const email = memberEmailInput.value.trim();

    if (!await validateEmailDuplicate()) {
        memberEmailInput.focus();
        return;
    }

    try {
        const response = await fetch(
            `${contextPath}/email/join/send`,
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams({email})
            }
        );

        if (!response.ok) {
            throw new Error("인증번호 발송 실패");
        }

        const result = await response.json();

        CommonModal.open({
            type: "custom",
            theme: "info",
            title: "이메일 인증",
            message: result.data,
            confirmText: "확인",
            cancelText: "취소",
            onConfirm: handleEmailVerification
        });
    } catch (error) {
        CommonModal.open({
            type: "alert",
            theme: "danger",
            title: "이메일 발송 실패",
            message: "인증번호 발송 중 오류가 발생했습니다."
        });
    }
});

memberEmailInput.addEventListener("input", function () {
    checkedEmail = null;
    emailResult.textContent = "";
    emailResult.classList.remove("is-success");
});

function validatePasswordConfirm() {
    const password = memberPasswordInput.value;
    const passwordConfirm = passwordConfirmInput.value;

    if (passwordConfirm === "") {
        passwordConfirmResult.textContent = "";
        passwordConfirmResult.classList.remove("is-success");
        isPasswordMatched = false;
        return;
    }

    isPasswordMatched = password === passwordConfirm;
    passwordConfirmResult.textContent = isPasswordMatched
        ? "비밀번호가 일치합니다."
        : "비밀번호가 일치하지 않습니다.";
    passwordConfirmResult.classList.toggle("is-success", isPasswordMatched);
}

memberPasswordInput.addEventListener("input", validatePasswordConfirm);
passwordConfirmInput.addEventListener("input", validatePasswordConfirm);

function validateEmailFormat() {
    const email = memberEmailInput.value.trim();

    if (email === "") {
        emailResult.textContent = "이메일을 입력해주세요.";
        emailResult.classList.remove("is-success");
        return false;
    }

    if (!emailPattern.test(email)) {
        emailResult.textContent = "올바른 이메일 형식이 아닙니다.";
        emailResult.classList.remove("is-success");
        return false;
    }

    return true;
}

function validatePasswordFormat() {
    const password = memberPasswordInput.value;

    if (password === "") {
        passwordFormatResult.textContent = "비밀번호를 입력해주세요.";
        passwordFormatResult.classList.remove("is-success");
        return false;
    }
    //isValidPassword의 함수 결과가 true/false인지에 따라 앞에 !가 붙여지면서
    //true -> false (if실행X) false -> true (is실행)
    if (!isValidPassword(password)) {
        passwordFormatResult.textContent =
            "8~20자의 영문, 숫자, 특수문자(!@#$%^&*)를 모두 포함해주세요.";
        passwordFormatResult.classList.remove("is-success");
        return false;
    }

    passwordFormatResult.textContent = "사용 가능한 비밀번호입니다.";
    passwordFormatResult.classList.add("is-success");
    return true;
}

async function validateNickname() {
    const nickname = memberNicknameInput.value.trim();
    checkedNickname = null;

    if (nickname === "") {
        nicknameResult.textContent = "닉네임을 입력해주세요.";
        nicknameResult.classList.remove("is-success");
        return;
    }

    if (!isValidNickname(nickname)) {
        nicknameResult.textContent =
            "1~8자의 한글, 영문, 숫자만 사용할 수 있습니다.";
        nicknameResult.classList.remove("is-success");
        return;
    }

    nicknameResult.textContent = "닉네임 중복 확인 중입니다.";
    nicknameResult.classList.remove("is-success");

    try {
        const isDuplicate =
            await isNicknameDuplicate(nickname, memberJoinForm.action);

        if (isDuplicate) {
            nicknameResult.textContent = "이미 사용 중인 닉네임입니다.";
            nicknameResult.classList.remove("is-success");
            return;
        }

        checkedNickname = nickname;
        nicknameResult.textContent = "사용 가능한 닉네임입니다.";
        nicknameResult.classList.add("is-success");
    } catch (error) {
        nicknameResult.textContent = "닉네임 중복 확인 중 오류가 발생했습니다.";
        nicknameResult.classList.remove("is-success");
    }
}

memberNicknameInput.addEventListener("input", function () {
    checkedNickname = null;
    nicknameResult.textContent = "";
    nicknameResult.classList.remove("is-success");
});

//블러도되면 이벤트 발생
memberNicknameInput.addEventListener("blur", validateNickname);
memberEmailInput.addEventListener("blur", function (event) {
    if (event.relatedTarget?.id === "send-email-code-button") {
        return;
    }

    validateEmailDuplicate();
});
memberPasswordInput.addEventListener("blur", validatePasswordFormat);

memberJoinForm.addEventListener("submit", function (event) {
    if (checkedNickname !== memberNicknameInput.value.trim()) {
        event.preventDefault();
        nicknameResult.textContent = "닉네임 중복 확인이 필요합니다.";
        nicknameResult.classList.remove("is-success");
        memberNicknameInput.focus();
        return;
    }

    if (!validateEmailFormat()) {
        event.preventDefault();
        memberEmailInput.focus();
        return;
    }

    if (checkedEmail !== memberEmailInput.value.trim()) {
        event.preventDefault();
        emailResult.textContent = "이메일 중복 확인이 완료되지 않았습니다.";
        emailResult.classList.remove("is-success");
        memberEmailInput.focus();
        return;
    }

    if (!validatePasswordFormat()) {
        event.preventDefault();
        memberPasswordInput.focus();
        return;
    }

    if (!isPasswordMatched) {
        event.preventDefault();
        passwordConfirmResult.textContent = "비밀번호가 일치하지 않습니다.";
        passwordConfirmResult.classList.remove("is-success");
        passwordConfirmInput.focus();
    }
});
