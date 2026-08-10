const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const memberJoinForm = document.querySelector("#joinForm");
//memberJoinForm은 회원가입 버튼을 눌러 폼이 제출되는 순간을 감지하기 위해 사용

const memberPasswordInput = document.querySelector("#password");
const memberEmailInput = document.querySelector("#email");
const memberNicknameInput = document.querySelector("#nickname");
const emailResult = document.querySelector("#check-email-result");
const nicknameResult = document.querySelector("#check-nickname-result");
const passwordFormatResult = document.querySelector("#check-password-format-result");

const checkEmailButton = document.querySelector("#check-email-button");
const passwordConfirmInput = document.querySelector("#passwordConfirm");
const passwordConfirmResult = document.querySelector("#check-password-result");

let checkedNickname = null;
let checkedEmail = null;
let isPasswordMatched = false;

checkEmailButton.addEventListener("click", async function () {
    const email = memberEmailInput.value.trim();
    if (!validateEmailFormat()) {
        checkedEmail = null;
        memberEmailInput.focus();
        return;
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

        if (isDuplicate) {
            emailResult.textContent = "이미 사용 중인 이메일입니다.";
            emailResult.classList.remove("is-success");
            checkedEmail = null;
        } else {
            emailResult.textContent = "사용 가능한 이메일입니다.";
            emailResult.classList.add("is-success");
            checkedEmail = email;
        }

    } catch (error) {
        emailResult.textContent = "이메일 중복 확인 중 오류가 발생했습니다.";
        emailResult.classList.remove("is-success");
        checkedEmail = null;
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
memberEmailInput.addEventListener("blur", validateEmailFormat);
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
        emailResult.textContent = "이메일 중복 확인을 진행해주세요.";
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
