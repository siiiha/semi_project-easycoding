const withdrawButton = document.getElementById("withdraw-button");
const withdrawForm = document.getElementById("withdraw-form");

withdrawButton.addEventListener("click", function () {
    CommonModal.open({
        type: "input",
        theme: "danger",
        title: "회원 탈퇴",
        message: "현재 비밀번호를 입력해주세요.",
        confirmText: "탈퇴하기",

        onConfirm: function (password) {
            withdrawForm.elements.password.value = password;
            withdrawForm.submit();
        }
    });
});