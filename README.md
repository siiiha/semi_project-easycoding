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

원격의 develop브랜치의 최신 내용 가져오기

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

코드 작성 후

변경사항 확인

```bash
git status
```
> 변경사항이 빨간색 글씨로 리스트업 되어있으면 됨

변경사항 전부 Stage

```bash
git add .
```

Stage에 올라갔는지 한번 더 확인

```bash
git status
```
> 변경사항이 초록색 으로 반영 되었으면 잘 올라간 것임.

Commit

```bash
git commit -m "feat: 로그인 기능 구현"
```

최신 develop 반영

```bash
git pull origin develop
```
> 충돌이 발생하면 충돌을 해결한 후 다시 commit합니다.<br>
> **(git commit -m "conflict clear")**

최초 Push

```bash
git push -u origin feature/login
```

이후 Push

```bash
git push origin "로컬에서 작업한 브랜치명"
```

예시

```bash
git push origin feature/login
```

---

## 5. Pull Request 생성

GitHub에서

```
Pull requests 메뉴 클릭
        ↓
우측 상단에 [New pull request] 녹색 버튼 클릭
        ↓
작업한 브랜치 [feature/기능명] 클릭
        ↓
왼쪽 상단에 merge하는 base브랜치를 develop으로 변경
        ↓
[Create pull request] 녹색 버튼 클릭
        ↓
충돌나는 부분 없는지 확인 / 충돌 난다면 local에서 해결 후 push까지 다시 진행
```

Pull Request 생성

---

## 6. Merge(병합) 완료 후
#### local에 develop브랜치를 원격에서 병합한 develop브랜치의 최신상태로 최신화

develop 브랜치로 이동

```bash
git checkout develop
```

최신 내용 가져오기

```bash
git pull origin develop
```

로컬에 있는 브랜치 리스트 확인
```bash
git branch
```

로컬 브랜치 삭제

```bash
git branch -d "삭제하려는 로컬 브랜치명"
```

예시

```bash
git branch -d feature/login
```

원격 브랜치는 형상관리자가 GitHub에서 **Delete branch** 버튼을 눌러 삭제합니다.

---

# 자주 사용하는 Git 명령어

## 현재 로컬 브랜치 확인

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
git push origin 브랜치명
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
