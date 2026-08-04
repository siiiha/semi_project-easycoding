# 공통 모달 사용 가이드

이 모달은 JSP 4개, 공통 스타일css 1개, 공통 JavaScript 1개로 구성됩니다.
페이지별 JavaScript에서는 `CommonModal.open()`만 호출하면 됩니다.

## 1. 최초 설정

모든 화면에서 모달을 사용할 예정이라면 공통 레이아웃 JSP(예: `footer.jsp`)에 한 번만 추가합니다. <br>
개별 화면에서만 사용하는 경우에는 해당 페이지 JSP에 추가해주시면 됩니다.

```jsp
<%-- 공통 CSS: head 영역에 추가합니다. --%>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/modal/modal.css">

<%-- 모달 HTML: body 하단에 추가합니다. --%>
<jsp:include page="/WEB-INF/views/common/modal/alertModal.jsp" />
<jsp:include page="/WEB-INF/views/common/modal/confirmModal.jsp" />
<jsp:include page="/WEB-INF/views/common/modal/inputModal.jsp" />
<jsp:include page="/WEB-INF/views/common/modal/customModal.jsp" />

<%-- 공통 동작 JS: 모달 JSP보다 뒤에 추가합니다. --%>
<script src="${pageContext.request.contextPath}/resources/js/modal.js"></script>
```

> `modal.css`가 사용하는 `--color-primary`, `--color-primary-hover`, `--color-bg-main`, `--transition-fast` 변수는 프로젝트의 공통 CSS에 정의되어 있어야 합니다.

## 2. 공통 호출 형식

```js
CommonModal.open({
  type: 'alert',          // 필수: alert | confirm | input | custom
  theme: 'success',       // 선택: success | danger | warning | info
  title: '제목',           // 선택: 기본값은 '안내'
  message: '내용',         // 선택
  confirmText: '확인',     // 선택: 확인 버튼 문구
  cancelText: '취소',      // 선택: 취소 버튼 문구
  onConfirm: () => {},     // 선택: 확인 버튼을 눌렀을 때
  onCancel: () => {}       // 선택: 취소, 배경 클릭, ESC 입력 시
});
```

`message`에 줄바꿈(`\n`)을 넣으면 모달에도 줄바꿈으로 표시됩니다.

```js
message: '삭제한 게시글은 복구할 수 없습니다.\n정말 삭제하시겠습니까?'
```

## 3. alert 모달

단순 안내 또는 완료 메시지에 사용합니다. 확인 시 별도 작업이 없다면 `onConfirm`은 생략할 수 있습니다.

```js
CommonModal.open({
  type: 'alert',
  theme: 'success',
  title: '회원가입 완료',
  message: '회원가입이 완료되었습니다.'
});
```

완료 후 페이지를 이동해야 하는 경우입니다.

```js
CommonModal.open({
  type: 'alert',
  theme: 'success',
  title: '게시글 작성 완료',
  message: '게시글이 등록되었습니다.',
  onConfirm: () => {
    location.href = contextPath + '/community/list';
  }
});
```

권장 사용처:

| 상황 | theme | title 예시 |
| --- | --- | --- |
| 회원가입 완료 | `success` | 회원가입 완료 |
| 정보 수정 완료 | `success` | 정보 수정 완료 |
| 게시글 임시저장 완료 | `success` | 임시저장 완료 |
| 게시글 작성/수정 완료 | `success` | 게시글 작성 완료 |
| 게시글 삭제 완료 | `success` | 게시글 삭제 완료 |
| 이메일 인증 성공 | `success` | 이메일 인증 완료 |
| 이메일 인증 실패 | `danger` | 이메일 인증 실패 |
| 잘못된 접근/예외 | `warning` | 잘못된 접근입니다 |
| 일일 문제 배정 전 | `info` | 아직 문제를 배정할 수 없어요 |

## 4. confirm 모달

사용자의 확인이 필요한 작업에 사용합니다. 실제 삭제·이동 로직은 반드시 `onConfirm` 안에 작성합니다.

```js
CommonModal.open({
  type: 'confirm',