//닉네임 DB 중복 확인 요청 함수

const NICKNAME_PATTERN = /^[가-힣A-Za-z0-9]{1,8}$/;

function isValidNickname(nickname) {
    return NICKNAME_PATTERN.test(nickname);
}

// 닉네임 DB 중복 확인 요청 함수
async function isNicknameDuplicate(nickname, requestBaseUrl) {
    const url = new URL("check-nickname", requestBaseUrl);
    url.searchParams.set("nickname", nickname);

    const response = await fetch(url);

    if (!response.ok) {
        throw new Error("닉네임 중복 확인 요청 실패");
    }

    return response.json();
}
