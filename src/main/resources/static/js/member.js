const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const memberJoinForm = document.querySelector("#joinForm");
//memberJoinForm은 회원가입 버튼을 눌러 폼이 제출되는 순간을 감지하기 위해 사용

const memberPasswordInput = document.querySelector("#password");
const memberEmailInput = document.querySelector("#email");
const memberNicknameInput = document.querySelector("#nickname");
const emailResult = document.querySelector("#check-email-result");
const nicknameResult = document.querySelector("#check-nickname-result");
const passwordFormatResult = document.querySelector("#check-password-format-result");
let checkedNickname = null;

function validateEmailFormat() {
    const email = memberEmailInput.value.trim();

    if (email === "") {
        emailResult.textContent = "이메일을 입력해주세요.";
        return false;
    }

    if (!emailPattern.test(email)) {
        emailResult.textContent = "올바른 이메일 형식이 아닙니다.";
        return false;
    }

    return true;
}

function validatePasswordFormat() {
    const password = memberPasswordInput.value;

    if (password === "") {
        passwordFormatResult.textContent = "비밀번호를 입력해주세요.";
        return false;
    }


    //isValidPassword의 함수 결과가 true/false인지에 따라 앞에 !가 붙여지면서
    //true -> false (if실행X) false -> true (is실행)
    if (!isValidPassword(password)) {
        passwordFormatResult.textContent =
            "8~20자의 영문, 숫자, 특수문자(!@#$%^&*)를 모두 포함해주세요.";
        return false;
    }

    passwordFormatResult.textContent = "사용 가능한 비밀번호입니다.";
    return true;
}

async function validateNickname() {
    const nickname = memberNicknameInput.value.trim();
    checkedNickname = null;

    if (nickname === "") {
        nicknameResult.textContent = "닉네임을 입력해주세요.";
        return;
    }

    nicknameResult.textContent = "닉네임 중복 확인 중입니다.";

    try {
        const isDuplicate =
            await isNicknameDuplicate(nickname, memberJoinForm.action);

        if (isDuplicate) {
            nicknameResult.textContent = "이미 사용 중인 닉네임입니다.";
            return;
        }

        checkedNickname = nickname;
        nicknameResult.textContent = "사용 가능한 닉네임입니다.";
    } catch (error) {
        nicknameResult.textContent = "닉네임 중복 확인 중 오류가 발생했습니다.";
    }
}

memberNicknameInput.addEventListener("input", function () {
    checkedNickname = null;
    nicknameResult.textContent = "";
});

//블러도되면 이벤트 발생
memberNicknameInput.addEventListener("blur", validateNickname);
memberEmailInput.addEventListener("blur", validateEmailFormat);
memberPasswordInput.addEventListener("blur", validatePasswordFormat);

memberJoinForm.addEventListener("submit", function (event) {
    if (checkedNickname !== memberNicknameInput.value.trim()) {
        event.preventDefault();
        nicknameResult.textContent = "닉네임 중복 확인이 필요합니다.";
        memberNicknameInput.focus();
        return;
    }

    if (!validateEmailFormat()) {
        event.preventDefault();
        memberEmailInput.focus();
        return;
    }

    if (!validatePasswordFormat()) {
        event.preventDefault();
        memberPasswordInput.focus();
    }
});
