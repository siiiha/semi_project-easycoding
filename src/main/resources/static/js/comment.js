// 댓글 등록 / 수정 / 삭제
const commentForm = document.querySelector("#comment-form");
const postIdInput = document.querySelector("#post-key");
const commentsArea = document.querySelector("#comments-area");
const commentCountArea = document.querySelector("#comment-count");

document.addEventListener('DOMContentLoaded', async function() {
    const postId = postIdInput.value;
    const response = await fetch(`/comment/select/${postId}`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json", // 서버에게 클라이언트가 보내는 데이터가 json이야
            "X-Requested-With": "XMLHttpRequest"    // 이 요청은 비동기(ajax) 요청이라고 명시하여 서버에게 전달
        }
    });

    const result = await response.json();
    const commentList = result.data;
    if (commentList == null) {
        return;
    }

    commentsArea.innerHTML = "";    // 새로 다시 그리기 전에 영역 비우기
    commentList.forEach(function(comment) {
        reloadComment(comment); // 각 댓글을 하나씩 전달
    })
    commentCountArea.textContent = "댓글수 " + commentList.length;
})

if (commentForm) {
    commentForm.addEventListener("submit", async function (event) {
        event.preventDefault(); // 기본 이벤트를 막고 직접 처리하겠다.

        const contentInput = commentForm.querySelector('textarea');
        const content = contentInput.value.trim();

        if (!content) {
            CommonModal.open({
                type: 'alert',
                theme: 'warning',
                title: '댓글 등록 실패',
                message: '댓글 내용을 입력하세요.'
            });
            return;
        }

        const postId = postIdInput.value;

        const response = await fetch(`/comment/insert/${postId}`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json", // 서버에게 클라이언트가 보내는 데이터가 json이야
                "X-Requested-With": "XMLHttpRequest"    // 이 요청은 비동기(ajax) 요청이라고 명시하여 서버에게 전달
            },
            body: JSON.stringify({content})
        });

        const result = await response.json();

        if (!response.ok || !result.success) {
            CommonModal.open({
                type: 'alert',
                theme: 'warning',
                title: '댓글 등록 실패',
                message: result.message
            });
            return;
        }

        const commentList = result.data;
        if (commentList == null) {
            return;
        }
        commentsArea.innerHTML = "";    // 새로 다시 그리기 전에 영역 비우기
        commentList.forEach(function(comment) {
            reloadComment(comment); // 각 댓글을 하나씩 전달
        })
        commentCountArea.textContent = "댓글수 " + commentList.length;

        contentInput.value = "";
    })
}

// 댓글 목록을 다시 그리는 작업
function reloadComment(comment) {
    const commentArea = document.createElement('div');
    commentArea.classList.add('comment-area');

    if (comment.parentId != null) {
        commentArea.classList.add('comment-reply');
    }

    // 삭제된 댓글 처리
    if (comment.deletedAt) {
        commentArea.classList.add('comment-deleted'); // CSS 스타일링을 위한 클래스 추가

        const deletedMessage = document.createElement('p');
        deletedMessage.classList.add('deleted-msg');
        deletedMessage.textContent = '삭제된 댓글입니다.'; // 대댓글 맥락이므로 '삭제된 댓글'이 더 자연스럽습니다.

        commentArea.appendChild(deletedMessage);
        commentsArea.appendChild(commentArea);

        return;
    }

    // 댓글 영역의 상단 영역(프로필 + 수정/삭제 버튼)
    const topArea = document.createElement('div');
    topArea.classList.add('top-area');

    // 수정/삭제 영역
    const actionArea = document.createElement('div');
    actionArea.classList.add('comment-action');

    // 프로필 영역
    const profileArea = document.createElement('div');
    profileArea.classList.add('profile-area');
    const profile = document.createElement('div');
    profile.classList.add('profile');
    const profileImg = document.createElement('img');
    profileImg.classList.add('profile-img');
    // 프로필 이미지가 있을 경우
    if (comment.profileId) {
        profileImg.src = contextPath + '/images/profile/sheep-' + comment.profileId + '.png';
        profileImg.alt = '프로필 이미지';
    } else {
        // 데이터가 없다면 기본이미지 처리
        profileImg.src = contextPath + '/images/profile/sheep-0.png';
        profileImg.alt = '프로필 이미지';
    }

    // 작성자 영역
    const writerArea = document.createElement('div');
    writerArea.classList.add('writer-area');
    const writer = document.createElement('span');
    writer.classList.add('writer');
    writer.textContent = comment.nickname;
    const createdAt = document.createElement('span');
    createdAt.classList.add('created-at');
    createdAt.textContent = comment.createdAtStr;

    const contentArea = document.createElement('div');
    contentArea.classList.add('content-area');

    const content = document.createElement('p');
    content.classList.add('content');
    content.textContent = comment.content;

    writerArea.appendChild(writer);
    writerArea.appendChild(createdAt);

    profile.appendChild(profileImg);
    profileArea.appendChild(profile);
    profileArea.appendChild(writerArea);

    // ==== 작성자인 경우 수정/삭제 버튼 ====
    if (loginMemberId !== null && comment.memberId === loginMemberId) {
        // 수정 버튼
        const editBtn = document.createElement('button');
        editBtn.textContent = '수정';
        editBtn.classList.add('comment-action-btn');

        editBtn.addEventListener('click', () => {
            createEditForm(commentArea, comment);
        });

        // 삭제 버튼
        const deleteBtn = document.createElement('button');
        deleteBtn.type = 'button';
        deleteBtn.textContent = '삭제';
        deleteBtn.classList.add('comment-action-btn');

        actionArea.appendChild(editBtn);
        actionArea.appendChild(deleteBtn);

        deleteBtn.addEventListener('click', async function() {
            // if (!confirm('삭제하시겠습니까?')) {
            //     return;
            // }
            CommonModal.open({
                type: 'confirm',
                theme: 'danger',
                title: '댓글 삭제',
                message: '정말로 댓글을 삭제하시겠습니까?',
                onConfirm: async function() {
                    const commentId = comment.commentId;
                    const postId = postIdInput.value;
                    try {
                        const response = await fetch(`/comment/delete/${postId}/${commentId}`, {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json", // 서버에게 클라이언트가 보내는 데이터가 json이야
                                "X-Requested-With": "XMLHttpRequest"    // 이 요청은 비동기(ajax) 요청이라고 명시하여 서버에게 전달
                            }
                        });

                        const result = await response.json();

                        if (!response.ok || !result.success) {
                            CommonModal.open({
                                type: 'alert',
                                theme: 'warning',
                                title: '댓글 삭제 실패',
                                message: result.message
                            });
                            return;
                        }

                        const commentList = result.data;
                        if (commentList == null) {
                            return;
                        }
                        commentsArea.innerHTML = "";    // 새로 다시 그리기 전에 영역 비우기
                        commentList.forEach(function(comment) {
                            reloadComment(comment); // 각 댓글을 하나씩 전달
                        })
                        commentCountArea.textContent = "댓글수 " + commentList.length;
                    } catch (error) {
                        CommonModal.open({
                            type: 'alert',
                            theme: 'danger',
                            title: '댓글 삭제 실패',
                            message: '댓글 삭제 중 오류가 발생하였습니다.',
                        });
                    }
                }
            });


        });
    }

    // 상단 영역 구성
    topArea.appendChild(profileArea);
    topArea.appendChild(actionArea);

    // 댓글 내용 구성
    contentArea.appendChild(content);

    if (comment.parentId == null) {
        const replyArea = document.createElement('div');
        const replyBtn = document.createElement('p');

        replyArea.classList.add('reply-area');
        replyBtn.classList.add('reply-btn');
        replyBtn.textContent = '답글 달기';
        replyBtn.dataset.commentId = comment.commentId;

        replyArea.appendChild(replyBtn);
        contentArea.appendChild(replyArea);
    }

    // 최종 조립
    commentArea.appendChild(topArea);
    commentArea.appendChild(contentArea);

    commentsArea.appendChild(commentArea);
}

function createEditForm(commentArea, comment) {
    commentArea.style.display = 'none';

    const editForm = document.createElement('form');
    editForm.classList.add('edit-form');

    const editContentInput = document.createElement('textarea');
    editContentInput.classList.add('edit-content-input');
    editContentInput.maxLength = 300;
    editContentInput.onfocus = (ev) => {
        ev.target.style.borderColor = '#4CAF50';
    }
    editContentInput.onblur = (ev) => {
        ev.target.style.borderColor = '#D9D9D9';
    }
    editContentInput.oninput = (ev) => {
        checkLength(ev.target, charCount);
    }
    editContentInput.textContent = comment.content;

    const charCountArea = document.createElement('div');
    charCountArea.classList.add('char-count-area');
    const charCount = document.createElement('span');
    charCount.textContent = comment.content.length; // 기존 댓글의 글자수로 초기값 설정

    charCountArea.appendChild(charCount);
    charCountArea.appendChild(document.createTextNode(' / 300자'));

    const editBtnArea = document.createElement('div');
    editBtnArea.classList.add('edit-btn-area');

    const btns = document.createElement('span');
    btns.classList.add('btns');

    const editCommentBtn = document.createElement('button');
    editCommentBtn.className = 'edit-comment-btn btn';
    editCommentBtn.type = 'button';
    editCommentBtn.textContent = '수정';

    const cancelBtn = document.createElement('button');
    cancelBtn.className = 'cancel-btn btn';
    cancelBtn.type = 'button';
    cancelBtn.textContent = '취소';

    editForm.appendChild(editContentInput);
    editForm.appendChild(charCountArea);
    btns.appendChild(editCommentBtn);
    btns.appendChild(cancelBtn);
    editBtnArea.appendChild(btns);
    editForm.appendChild(editBtnArea);

    commentArea.after(editForm);

    editCommentBtn.addEventListener('click', async function() {
        const content = editContentInput.value.trim();

        console.log("수정 버튼 클릭됨");
        const commentId = comment.commentId;
        const postId = postIdInput.value;
        const response = await fetch(`/comment/update/${postId}/${commentId}`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json", // 서버에게 클라이언트가 보내는 데이터가 json이야
                "X-Requested-With": "XMLHttpRequest"    // 이 요청은 비동기(ajax) 요청이라고 명시하여 서버에게 전달
            },
            body: JSON.stringify({content})
        });

        const result = await response.json();

        if (!response.ok || !result.success) {
            CommonModal.open({
                type: 'alert',
                theme: 'warning',
                title: '댓글 수정 실패',
                message: result.message
            });
            return;
        }

        const commentList = result.data;
        if (commentList == null) {
            return;
        }
        commentsArea.innerHTML = "";    // 새로 다시 그리기 전에 영역 비우기
        commentList.forEach(function(comment) {
            reloadComment(comment); // 각 댓글을 하나씩 전달
        })
        commentCountArea.textContent = "댓글수 " + commentList.length;
    });

    cancelBtn.addEventListener('click', function() {
        editForm.remove();
        commentArea.style.display = 'flex';
    })


}

// 글자 수 제한 및 보여주는 함수 'oninput' 이벤트로 호출함.
function checkLength(textArea, countSpan) {
    // 300자가 넘는 경우에는 0부터 300개만 값을 가져와서 강제로 제한
    if (textArea.value.length > 300) {
        textArea.value = textArea.value.slice(0, 300);
    }

    // 글자 수 업데이트
    if (countSpan) {
        countSpan.textContent = textArea.value.length;
    }


}

// 댓글 목록을 화면에 다시 표시하는 함수
function renderCommentList(commentList) {
    commentsArea.innerHTML = '';

    commentList.forEach(function (comment) {
        reloadComment(comment);
    });

    commentCountArea.textContent = '댓글수 ' + commentList.length;
}




