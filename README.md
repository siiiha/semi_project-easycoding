# Git 사용 가이드

## 1. Repository Clone (최초 1회)

```bash
git clone https://github.com/Organization/Repository.git
```

프로젝트 폴더로 이동

```bash
cd Repository
```

---

## 2. develop 브랜치 생성 (최초 1회)

원격의 develop 브랜치를 로컬에 생성합니다.

```bash
git checkout -b develop origin/develop
```

브랜치 확인

```bash
git branch
```

---

## 3. 새로운 기능 개발 시작

반드시 develop 브랜치로 이동

```bash
git checkout develop
```

최신 내용 가져오기

```bash
git pull origin develop
```

Feature 브랜치 생성

```bash
git checkout -b feature/기능명
```

예시

```bash
git checkout -b feature/login
```

---

## 4. 개발 진행

변경사항 확인

```bash
git status
```

변경사항 Stage

```bash
git add .
```

Commit

```bash
git commit -m "feat: 로그인 기능 구현"
```

최신 develop 반영

```bash
git pull origin develop
```

> 충돌이 발생하면 충돌을 해결한 후 다시 commit합니다.

최초 Push

```bash
git push -u origin feature/login
```

이후 Push

```bash
git push
```

---

## 5. Pull Request 생성

GitHub에서

```
feature/기능명
        ↓
develop
```

Pull Request 생성

---

## 6. Merge 완료 후

develop 브랜치로 이동

```bash
git checkout develop
```

최신 내용 가져오기

```bash
git pull origin develop
```

로컬 브랜치 삭제

```bash
git branch -d feature/기능명
```

예시

```bash
git branch -d feature/login
```

원격 브랜치는 형상관리자가 GitHub에서 **Delete branch** 버튼을 눌러 삭제합니다.

---

# 자주 사용하는 Git 명령어

## 현재 브랜치 확인

```bash
git branch
```

## 변경사항 확인

```bash
git status
```

## 브랜치 이동

```bash
git checkout 브랜치명
```

예시

```bash
git checkout develop
```

## 새로운 브랜치 생성 및 이동

```bash
git checkout -b 브랜치명
```

예시

```bash
git checkout -b feature/login
```

## 최신 내용 가져오기

```bash
git pull origin 브랜치명
```

예시

```bash
git pull origin develop
```

## 변경사항 추가

```bash
git add .
```

## Commit

```bash
git commit -m "커밋메시지"
```

## Push

최초 Push

```bash
git push -u origin 브랜치명
```

이후

```bash
git push
```

## 로컬 브랜치 삭제

```bash
git branch -d 브랜치명
```

## 원격 브랜치 삭제 (형상관리자)

```bash
git push origin --delete 브랜치명
```

또는 GitHub에서 **Delete branch** 버튼 클릭
