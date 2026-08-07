document.addEventListener("DOMContentLoaded", function () {
    if (ErrorMsg && editErrorMsg.trim() !== "") {
        CommonModal.open({
            type: 'alert',
            theme: 'warning',
            title: '잘못된 접근',
            message: editErrorMsg
        });
    }
});