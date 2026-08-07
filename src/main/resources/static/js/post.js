document.addEventListener("DOMContentLoaded", function () {
    if (editErrorMsg && editErrorMsg.trim() !== "") {
        console.log("모달 open함수 들어옴")
        CommonModal.open({
            type: 'alert',
            theme: 'warning',
            title: '게시글 수정 실패',
            message: editErrorMsg
        });
        console.log("모달 open함수 뒤")
    }
});

