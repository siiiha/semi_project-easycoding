const replyCommentsArea = document.querySelector('#comments-area');

// 클릭 처리
replyCommentsArea.addEventListener('click', function (event) {
    const replyButton = event.target.closest('.reply-btn');

    if (!replyButton) {
        return;
    }
    const parentId = replyButton.dataset.commentId;

    createReplyForm(replyButton, parentId);
});

// 입력창 생성
function createReplyForm(replyButton, parentId) {
    const existingReplyForm = document.querySelector('.reply-form');

    if (existingReplyForm) {
        existingReplyForm.remove();
    }
    if (loginMemberId) {
    const commentArea = replyButton.closest('.comment-area');
    const replyForm = document.createElement('form');
    const replyInput = document.createElement('textarea');

    replyForm.classList.add('reply-form');
    replyInput.placeholder = '답글을 입력해주세요.';
    replyInput.maxLength = 300;

    const charCountArea = document.createElement('div');
    charCountArea.classList.add('char-count-area');

    const replyCharCount = document.createElement('span');
    replyCharCount.textContent = '0';

    charCountArea.appendChild(replyCharCount);
    charCountArea.appendChild(document.createTextNode(' / 300자'));

    replyInput.addEventListener('input', function () {
        replyCharCount.textContent = replyInput.value.length;
    });

    const submitButton = document.createElement('button');
    const cancelButton = document.createElement('button');

    submitButton.type = 'submit';
    submitButton.textContent = '등록';

    cancelButton.type = 'button';
    cancelButton.textContent = '취소';

    const replyFormFooter = document.createElement('div');
    replyFormFooter.classList.add('reply-form-footer');

    const replyButtonArea = document.createElement('div');
    replyButtonArea.classList.add('reply-button-area');

    replyButtonArea.appendChild(submitButton);
    replyButtonArea.appendChild(cancelButton);

    replyFormFooter.appendChild(replyButtonArea)

    replyForm.appendChild(replyInput);
    replyForm.appendChild(charCountArea);
    replyForm.appendChild(replyFormFooter);

    cancelButton.addEventListener('click', function () {
        replyForm.remove();
    });

    replyForm.addEventListener('submit', async function (event) {
        event.preventDefault();

        const content = replyInput.value.trim();

        if (!content) {
            CommonModal.open({
                type: 'alert',
                theme: 'warning',
                title: '답글 등록 실패',
                message: '답글 내용을 입력해주세요.'
            });
            return;
        }

        const postId = document.querySelector('#post-key').value;

        const response = await fetch(
            `${contextPath}/comment/insert/${postId}`,
            {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: JSON.stringify({
                    content: content,
                    parentId: Number(parentId)
                })
            }
        );

        const result = await response.json();
        if (!response.ok || !result.success) {
            CommonModal.open({
                type: 'alert',
                theme: 'warning',
                title: '답글 등록 실패',
                message: result.message
            });
            return;
        }
        renderCommentList(result.data);
        replyForm.remove();
    });

    commentArea.appendChild(replyForm);
    }
}

