document.addEventListener("DOMContentLoaded", function () {
    if (ErrorMsg && ErrorMsg.trim() !== "") {
        CommonModal.open({
            type: 'alert',
            theme: 'warning',
            title: '잘못된 접근',
            message: ErrorMsg
        });
    }

    if (successMsg && successMsg.trim() !== "") {
        CommonModal.open({
            type: 'alert',
            theme: 'success',
            title: successMsg
        });
    }

    const deletePostForm = document.querySelector('#delete-post-form');
    const deletePostBtn = document.querySelector('#delete-post-btn');
    if (deletePostBtn) {
        deletePostBtn.addEventListener('click', function (ev) {
            // form안에 submit 동작을 차단
            ev.preventDefault();

            CommonModal.open({
                type: 'confirm',
                theme: 'danger',
                title: '게시글을 삭제하시겠습니까?',
                onConfirm: () => {
                    deletePostForm.submit();
                }
            });
        });
    }
});

