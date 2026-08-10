const postForm = document.querySelector('#writeForm');

// 임시 저장 목록 불러오는 Ajax 비동기 함수
async function selectTemporaryPost() {
    const response = await fetch(`/api/select/temporaryPost`, {
       method: "GET",
       headers: {
           "X-Requested-With": "XMLHttpRequest"    // 이 요청은 비동기(ajax) 요청이라고 명시하여 서버에게 전달
       }
    });

    const result = await response.json();

    if (!response.ok || !result.success) {
        CommonModal.open({
            type: 'alert',
            theme: 'warning',
            title: '경고',
            message: '임시저장 목록을 불러오지 못하였습니다.'
        });
    }

    const temporaryPostList = result.data;
    if (temporaryPostList == null) {
        return;
    }
    temporaryPostList.forEach(function(temporaryPost) {
       renderTemporaryPosts(temporaryPost);
    });
}

// 임시저장 글을 그려주는 함수
function renderTemporaryPosts(temporaryPost) {
    // 임시저장 목록을 표시할 영역
    const draftList = document.querySelector('#draft-list');

    // 임시저장 게시글 정보가 들어갈 요소 생성
    const item = document.createElement('div');
    item.classList.add('comm-draft-item');

    // 제목: 15자 초과 시 ... 처리
    const titleButton = document.createElement('button');
    titleButton.type = 'button';
    titleButton.classList.add('comm-draft-title');

    const title = temporaryPost.title || '제목 없음';
    titleButton.textContent =
        title.length > 15 ? title.substring(0, 15) + '...' : title;

    // 마우스를 올리면 전체 제목 확인
    titleButton.title = title;

    // 이후 작성 폼에 데이터를 채우는 함수를 연결
    titleButton.addEventListener('click', function () {
        loadTemporaryPost(temporaryPost);
    });

    const date = document.createElement('span');
    date.classList.add('comm-draft-date');
    date.textContent = temporaryPost.createdAt;

    const deleteButton = document.createElement('button');
    deleteButton.type = 'button';
    deleteButton.classList.add('comm-draft-delete');
    deleteButton.textContent = '삭제';

    // 삭제 버튼 클릭 시 삭제하는 Ajax함수로 이동
    deleteButton.addEventListener('click', function () {
        deleteTemporaryPost(temporaryPost.postId);
    });

    item.appendChild(titleButton);
    item.appendChild(date);
    item.appendChild(deleteButton);
    draftList.appendChild(item);

}

// 작성 폼에 임시저장한 게시글의 데이터를 채우는 함수
function loadTemporaryPost(temporaryPost) {
    const category = temporaryPost.category;
    const selectedCategory = document.querySelector('#postType option[value=' + category + ']');
    document.querySelector('#selectPlaceHolder').selected(false);
    selectedCategory.selected(true);

    const titleEl = document.querySelector('#title');
    titleEl.value = temporaryPost.title;
    const contentEl = document.querySelector('#content');
    contentEl.value = temporaryPost.content

    // postId를 input:hidden에 넣어서 form에 넣는 작업
    const postIdInput = document.createElement('input');
    postIdInput.type = 'hidden';
    postIdInput.name = 'postId';
    postIdInput.value = temporaryPost.postId;

    // form의 첫번째 자식으로 추가
    postForm.prepend(postIdInput);
}

// 임시저장한 게시글을 삭제하는 Ajax 비동기 함수
async function deleteTemporaryPost(postId) {
    const response = await fetch(`/api/delete/temporaryPost/` + postId, {
        method: "POST",
        headers: {
            "X-Requested-With": "XMLHttpRequest"    // 이 요청은 비동기(ajax) 요청이라고 명시하여 서버에게 전달
        }
    });

    const result = await response.json();

    if (!response.ok || !result.success) {
        CommonModal.open({
            type: 'alert',
            theme: 'warning',
            title: '경고',
            message: '임시저장 목록을 삭제하지 못하였습니다.'
        });
    }

    const temporaryPostList = result.data;
    if (temporaryPostList == null) {
        return;
    }
    temporaryPostList.forEach(function(temporaryPost) {
        renderTemporaryPosts(temporaryPost);
    });
}

// 임시저장함 켜고, 끄는 기능
function toggleDraftPanel(open) {
    const panel = document.querySelector('#draft-panel');

    panel.classList.toggle('is-open', open);
}

function saveDraft() {
    postForm.submit();
}