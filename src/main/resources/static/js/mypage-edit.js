const editNicknameInput = document.querySelector("#nickname");
const editNicknameResult = document.querySelector("#check-edit-nickname-result");
const editForm = document.querySelector("#editForm");

const currentPasswordInput = document.querySelector("#currentPassword");
const newPasswordInput = document.querySelector("#newPassword");
const confirmPasswordInput = document.querySelector("#confirmPassword");

const newPasswordResult = document.querySelector("#check-new-password-result");
const confirmPasswordResult = document.querySelector("#check-confirm-password-result");

const originalNickname = editNicknameInput.dataset.originalNickname;
let checkedNickname = originalNickname;


editNicknameInput.addEventListener("input", function () {
    checkedNickname = null;
    editNicknameResult.textContent = "";
});

async function validateEditNickname() {
    const nickname = editNicknameInput.value.trim();

    if (nickname === "") {
        checkedNickname = null;
        editNicknameResult.textContent = "닉네임을 입력해주세요.";
        return false;
    }

    if (nickname === originalNickname) {
        checkedNickname = originalNickname;
        editNicknameResult.textContent = "현재 사용 중인 닉네임입니다.";
        return true;
    }

    editNicknameResult.textContent = "닉네임 중복 확인 중입니다.";

    try {
        const isDuplicate =
            await isNicknameDuplicate(nickname, editForm.action);

        if (isDuplicate) {
            checkedNickname = null;
            editNicknameResult.textContent =
                "이미 사용 중인 닉네임입니다.";
            return false;
        }

        checkedNickname = nickname;
        editNicknameResult.textContent =
            "사용 가능한 닉네임입니다.";
        return true;
    } catch (error) {
        checkedNickname = null;
        editNicknameResult.textContent =
            "닉네임 중복 확인 중 오류가 발생했습니다.";
        return false;
    }
}

editNicknameInput.addEventListener(
    "blur",
    validateEditNickname
);

editForm.addEventListener("submit", async function (event) {
    const currentNickname = editNicknameInput.value.trim();

    if (checkedNickname === currentNickname) {
        return;
    }

    event.preventDefault();

    const isValidNickname = await validateEditNickname();
    const latestNickname = editNicknameInput.value.trim();

    if (isValidNickname && checkedNickname === latestNickname) {
        editForm.requestSubmit();
        return;
    }

    editNicknameInput.focus();
});

// 새 비밀번호 형식 검사
function validateNewPassword() {
    const newPassword = newPasswordInput.value;

    if (newPassword === "") {
        newPasswordResult.textContent = "";
        return true;
    }
    if (!isValidPassword(newPassword)) {
        newPasswordResult.textContent =
            "8~20자의 영문, 숫자, 특수문자(!@#$%^&*)를 모두 포함해주세요.";
        return false;
    }

    newPasswordResult.textContent = "사용 가능한 비밀번호입니다.";
    return true;
}

newPasswordInput.addEventListener("blur", validateNewPassword);

function validatePasswordConfirm() {
    const newPassword = newPasswordInput.value;
    const confirmPassword = confirmPasswordInput.value;

    if (newPassword === "" && confirmPassword === "") {
        confirmPasswordResult.textContent = "";
        return true;
    }

    if (confirmPassword === "") {
        confirmPasswordResult.textContent = "새 비밀번호를 다시 입력해주세요.";
        return false;
    }

    if (newPassword !== confirmPassword) {
        confirmPasswordResult.textContent = "비밀번호가 일치하지 않습니다.";
        return false;
    }

    confirmPasswordResult.textContent = "비밀번호가 일치합니다.";
    return true;
}

