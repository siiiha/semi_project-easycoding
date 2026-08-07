document.addEventListener("DOMContentLoaded", function () {
    if (editErrorMsg && editErrorMsg.trim() !== "") {
        CommonModal.open({
            type: 'alert',
            theme: 'warning',
            title: '잘못된 접근',
            message: editErrorMsg
        });
    }
});