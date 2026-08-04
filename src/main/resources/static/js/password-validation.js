//패스워드 형식 확인 함수
const PASSWORD_PATTERN = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/;

function isValidPassword(password) {

    return PASSWORD_PATTERN.test(password);

}