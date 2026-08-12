const editNicknameInput = document.querySelector("#nickname");
const editNicknameResult = document.querySelector("#check-edit-nickname-result");
const editForm = document.querySelector("#editForm");

const currentPasswordInput = document.querySelector("#currentPassword");
const newPasswordInput = document.querySelector("#newPassword");
const confirmPasswordInput = document.querySelector("#confirmPassword");

const currentPasswordResult = document.querySelector("#check-current-password-result");
const newPasswordResult = document.querySelector("#check-new-password-result");
const confirmPasswordResult = document.querySelector("#check-confirm-password-result");

const originalNickname = editNicknameInput.dataset.originalNickname;
let checkedNickname = originalNickname;

const profileIdInputs =
    document.querySelectorAll('input[name="profileId"]');
const profilePreview = document.querySelector(".avatar-circle-lg");

function getSelectedProfileId() {
    return document.querySelector(
        'input[name="profileId"]:checked'
    )?.value ?? "";
}

const originalProfileId = getSelectedProfileId();

editNicknameInput.addEventListener("input", function () {
    checkedNickname = null;
    editNicknameResult.classList.remove("is-success");

    const nickname = editNicknameInput.value.trim();

    if (nickname !== "" && !isValidNickname(nickname)) {
        editNicknameResult.textContent =
            "1~8자의 한글, 영문, 숫자만 사용할 수 있습니다.";
        return;
    }

    editNicknameResult.textContent = "";
});

async function validateEditNickname() {
    const nickname = editNicknameInput.value.trim();

    if (nickname === "") {
        checkedNickname = null;
        editNicknameResult.textContent = "닉네임을 입력해주세요.";
        editNicknameResult.classList.remove("is-success");
        return false;
    }

    if (!isValidNickname(nickname)) {
        checkedNickname = null;
        editNicknameResult.textContent =
            "1~8자의 한글, 영문, 숫자만 사용할 수 있습니다.";
        editNicknameResult.classList.remove("is-success");
        return false;
    }

    if (nickname === originalNickname) {
        checkedNickname = originalNickname;
        editNicknameResult.textContent = "현재 사용 중인 닉네임입니다.";
        editNicknameResult.classList.add("is-success");
        return true;
    }

    editNicknameResult.textContent = "닉네임 중복 확인 중입니다.";
    editNicknameResult.classList.remove("is-success");

    try {
        const isDuplicate =
            await isNicknameDuplicate(nickname, editForm.action);

        if (isDuplicate) {
            checkedNickname = null;
            editNicknameResult.textContent =
                "이미 사용 중인 닉네임입니다.";
            editNicknameResult.classList.remove("is-success");
            return false;
        }

        checkedNickname = nickname;
        editNicknameResult.textContent =
            "사용 가능한 닉네임입니다.";
        editNicknameResult.classList.add("is-success");
        return true;
    } catch (error) {
        checkedNickname = null;
        editNicknameResult.textContent =
            "닉네임 중복 확인 중 오류가 발생했습니다.";
        editNicknameResult.classList.remove("is-success");
        return false;
    }
}

editNicknameInput.addEventListener(
    "blur",
    validateEditNickname
);

function validateCurrentPassword() {
    const isPasswordEmpty =
        newPasswordInput.value === ""
        && confirmPasswordInput.value === "";

    if (isPasswordEmpty) {
        currentPasswordResult.textContent = "";
        return true;
    }


    if (currentPasswordInput.value === "") {
        currentPasswordResult.textContent = "현재 비밀번호를 입력해주세요.";
        return false;
    }

    if (currentPasswordInput.value === newPasswordInput.value) {
        currentPasswordResult.textContent = "새 비밀번호는 현재 비밀번호와 다르게 입력해주세요.";
        return false;
    }

    currentPasswordResult.textContent = "";
    return true;
}


editForm.addEventListener("submit", async function (event) {
    const isCurrentPasswordValid = validateCurrentPassword();
    const isValidPasswordFormat = validateNewPassword();
    const isPasswordMatched = validatePasswordConfirm();

    if (!isCurrentPasswordValid
        || !isValidPasswordFormat
        || !isPasswordMatched) {
        event.preventDefault();

        if (!isCurrentPasswordValid) {
            currentPasswordInput.focus();
        } else if (!isValidPasswordFormat) {
            newPasswordInput.focus();
        } else {
            confirmPasswordInput.focus();
        }

        return;
    }

    const currentNickname = editNicknameInput.value.trim();
    const isNicknameUnchanged =
        currentNickname === originalNickname;

    const isPasswordUnchanged =
        newPasswordInput.value === "";

    const selectedProfileId = getSelectedProfileId();

    const isProfileUnchanged =
        selectedProfileId === originalProfileId;

    if (isNicknameUnchanged
        && isPasswordUnchanged
        && isProfileUnchanged) {
        event.preventDefault();
        editNicknameResult.textContent =
            "변경된 회원정보가 없습니다.";
        editNicknameInput.focus();
        return;
    }


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

newPasswordInput.addEventListener("input", function () {
    validateNewPassword();
    validatePasswordConfirm();
});

confirmPasswordInput.addEventListener("input", validatePasswordConfirm);

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

profileIdInputs.forEach((profileIdInput) => {
    profileIdInput.addEventListener("change", function () {
        const previewImage =
            this.nextElementSibling.cloneNode();

        previewImage.className = "avatar-img";
        profilePreview.replaceChildren(previewImage);
    });
});
