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
            alert("댓글 내용을 입력하세요.");
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
            alert(result.message || "댓글 등록에 실패했습니다.");
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
    // 💡 프로필 이미지 경로 바인딩 (데이터에 없다면 기본이미지 처리)
    // profile.src = comment.profileId || '/images/default-profile.png';
    // 프로필 이미지가 있을 경우
    // if (comment.authorProfileImage) {
    //     profileImg.src = comment.authorProfileImage;
    //     profileImg.alt = comment.nickname;
    // }

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

    const replyArea = document.createElement('div');
    replyArea.classList.add('reply-area');

    const replyBtn = document.createElement('p');
    replyBtn.classList.add('reply-btn');
    replyBtn.textContent = '답글 달기';

    writerArea.appendChild(writer);
    writerArea.appendChild(createdAt);

    profile.appendChild(profileImg);
    profileArea.appendChild(profile);
    profileArea.appendChild(writerArea);

    // ==== 작성자인 경우 수정/삭제 버튼 ====
    if (comment.nickname === loginNickname) {
        // 수정 버튼
        const editBtn = document.createElement('button');
        editBtn.textContent = '수정';
        editBtn.classList.add('comment-action-btn');
        editBtn.onclick = () => toggleCommentEdit(comment.commentId);

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
            if (!confirm('삭제하시겠습니까?')) {
                return;
            }
            const commentId = comment.commentId;
            const postId = postIdInput.value;
            const response = await fetch(`/comment/delete/${postId}/${commentId}`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json", // 서버에게 클라이언트가 보내는 데이터가 json이야
                    "X-Requested-With": "XMLHttpRequest"    // 이 요청은 비동기(ajax) 요청이라고 명시하여 서버에게 전달
                }
            });

            const result = await response.json();

            if (!response.ok || !result.success) {
                alert(result.message || "댓글 삭제에 실패했습니다.");
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
    }

    // 상단 영역 구성
    topArea.appendChild(profileArea);
    topArea.appendChild(actionArea);

    // 댓글 내용 구성
    contentArea.appendChild(content);
    // 답글달기 버튼
    replyArea.appendChild(replyBtn);
    contentArea.appendChild(replyArea);

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
    editContentInput.textContent = comment.content;

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
            alert(result.message || "댓글 수정에 실패했습니다.");
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



