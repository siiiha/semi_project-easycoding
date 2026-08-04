(function () {
    // 선택지 라벨링(A, B, C...) 렌더링용 기준 배열
    var optionLabels = ["A", "B", "C", "D"];

    // 화면을 그리는데 필요한 데이터들을 저장하는 공간
    var state = {
        educations: [],         // educations: 문제 목록
        currentIndex: 0,        // currentIndex: 현재 보고 있는 문제의 인덱스
        selectedByIndex: {}     // selectedByIndex: 사용자가 고른 선택지의 인덱스
    };

    // 특정 요소(item) 안에있는 요소를 요소명(select)을 이용해 꺼내오는 함수
    // 매번 트림쓰고, 선택된 요소가 비어있을 때 오류뱉는게 개빡쳐서 만들었음
    function getElementText(item, select) {
        var el = item.querySelector(select);
        return el ? el.textContent.trim() : "";
        // 해당하는 이름의 엘리먼트가 없거나, 엘리먼트의 값이 null일경우
        // el의 값이 null이 되므로, "" 를 반환하도록 해 null참조 방지
    }

    // educationType 을 확인해서 텍스트로 반환
    function getTypeText(typeValue) {
        if (String(typeValue) === "1") {
            return "객관식";
        }
        else if (String(typeValue) === "2") {
            return "빈칸채우기";
        }

        return "알수없음"
        // 다른 문제타입이 추기된다면, 계속 늘려나가야 함
    }

    // 문제의 타입에 따라서 서로다른 렌더함수를 호출
    function renderByEducationType(quiz) {
        var typeValue = String(quiz.educationType);

        if (typeValue === "1") {
            renderOptions(quiz);
        }
        else if (typeValue === "2") {
            // TODO: 빈칸채우기용 렌더링함수 구현해서 호출하기
        }
        // 다른 문제타입이 추기된다면, 계속 늘려나가야 함
    }

    // JSP에서 저장해둔 todayEducation DOM 데이터를 읽어 JS에서 쓰기 편하게 저장
    function readQuizData() {
        // 문제 데이터 컨테이너 안의 항목 노드 목록
        var nodes = document.querySelectorAll("#today-education-data .quiz-data-item");
        // id: today-education-data안에 담긴 class: quiz-data-item 요소들을 NodeList 형태로 저장

        return Array.prototype.map.call(nodes, function (item) {
            var typeValue = getElementText(item, ".quiz-data-type");

            // 공통 필드 먼저 읽어온 뒤, 타입별 필드를 분기해서 채운다.
            var quizData = {
                educationId: getElementText(item, ".quiz-data-id"),
                educationType: typeValue,
                educationCategoryId: getElementText(item, ".quiz-data-category-id"),
                educationCategoryName: getElementText(item, ".quiz-data-category-name"),
                educationTitle: getElementText(item, ".quiz-data-title"),
                educationContent: getElementText(item, ".quiz-data-content"),
                educationExplanation: getElementText(item, ".quiz-data-explanation"),
                answers: []
            };

            if (typeValue === "1") {
                // 객관식: options 리스트를 순회해서 보기 텍스트 배열을 만든다.
                var optionNodes = item.querySelectorAll(".quiz-data-option-item");
                quizData.answers = Array.prototype.map.call(optionNodes, function (node) {
                    return {
                        order: Number(node.getAttribute("data-order") || 0),
                        text: node.textContent.trim()
                    };
                }).sort(function (a, b) {
                    return a.order - b.order;
                }).map(function (opt) {
                    return opt.text;
                });
            } else if (typeValue === "2") {
                // TODO: 빈칸채우기 타입(EducationBlankTypeDto) 전용 데이터 파싱 로직 추가
            }

            // 화면 렌더링용 표준 문제 객체
            return quizData;
        });
    }

    // 상단 진행 점(dot)에서 현재 문제 인덱스만 active로 표시한다.
    function setActiveDot(index) {
        // 모든 진행 점 노드
        var dots = document.querySelectorAll(".quiz-step-dots .dot");
        Array.prototype.forEach.call(dots, function (dot, dotIndex) {
            if (dotIndex === index) {
                dot.classList.add("active");
            } else {
                dot.classList.remove("active");
            }
        });
    }

    // 현재 문제의 선택지 목록을 DOM으로 렌더링하고 클릭 이벤트를 연결한다.
    function renderOptions(quiz) {
        // 선택지 렌더링 대상 컨테이너
        var optionsWrap = document.getElementById("quiz-options");
        if (!optionsWrap) {
            return;
        }

        // 파싱된 선택지가 없으면 테스트용 기본 선택지 사용
        var options = quiz.answers && quiz.answers.length > 0
            ? quiz.answers
            : ["테스트 선택지 텍스트", "테스트 선택지 텍스트", "테스트 선택지 텍스트", "테스트 선택지 텍스트"];

        optionsWrap.innerHTML = "";

        for (var i = 0; i < options.length; i += 1) {
            var label = document.createElement("label");
            label.className = "quiz-option";

            var input = document.createElement("input");
            input.type = "radio";
            input.name = "answer";
            input.value = String(i);

            var labelSpan = document.createElement("span");
            labelSpan.className = "option-label";
            labelSpan.textContent = (optionLabels[i] || String(i + 1)) + ".";

            var textSpan = document.createElement("span");
            textSpan.className = "option-text";
            textSpan.textContent = options[i];

            label.appendChild(input);
            label.appendChild(labelSpan);
            label.appendChild(textSpan);
            optionsWrap.appendChild(label);
        }

        // 이전에 고른 답이 있으면 복원
        var selectedIndex = state.selectedByIndex[state.currentIndex];
        if (typeof selectedIndex === "number") {
            var selectedOption = optionsWrap.querySelector('input[value="' + selectedIndex + '"]');
            if (selectedOption) {
                selectedOption.checked = true;
                selectedOption.parentElement.classList.add("selected");
            }
        }

        optionsWrap.querySelectorAll(".quiz-option").forEach(function (optionEl) {
            optionEl.addEventListener("click", function () {
                optionsWrap.querySelectorAll(".quiz-option").forEach(function (node) {
                    node.classList.remove("selected");
                    node.classList.remove("is-correct");
                    node.classList.remove("is-wrong");
                });
                // 현재 클릭한 선택지를 선택 상태로 만들고 state에 기록
                optionEl.classList.add("selected");
                optionEl.querySelector('input[type="radio"]').checked = true;
                state.selectedByIndex[state.currentIndex] = Number(optionEl.querySelector('input[type="radio"]').value);
            });
        });
    }

    // 현재 인덱스(state.currentIndex)에 해당하는 문제를 화면 전체에 반영한다.
    function renderCurrentQuiz() {
        // 전체 문제 수
        var totalCount = state.educations.length;
        // 문제 본문 영역
        var questionEl = document.getElementById("quiz-question");
        // 좌측/우측 상단 진행 숫자 영역
        var currentIndexEl = document.getElementById("quiz-current-index");
        var totalCountEl = document.getElementById("quiz-total-count");
        // 문제 메타정보(카테고리/유형/주제) 영역
        var categoryEl = document.getElementById("quiz-category-name");
        var typeEl = document.getElementById("quiz-type-text");
        var topicEl = document.getElementById("quiz-topic-text");
        // 제출/다음 버튼
        var nextBtn = document.getElementById("quiz-next-btn");

        if (!questionEl || !currentIndexEl || !totalCountEl || !nextBtn) {
            return;
        }

        totalCountEl.textContent = String(totalCount);

        if (totalCount === 0) {
            questionEl.textContent = "오늘 할당된 문제가 없습니다.";
            currentIndexEl.textContent = "0";
            nextBtn.textContent = "문제가 없습니다";
            nextBtn.disabled = true;
            nextBtn.style.opacity = "0.5";
            renderOptions({ answers: [] });
            return;
        }

        // 현재 표시할 문제 객체
        var quiz = state.educations[state.currentIndex];
        // 문제 본문은 educationContent를 우선 사용
        questionEl.textContent = quiz.educationContent || "테스트 문제 텍스트";
        currentIndexEl.textContent = String(state.currentIndex + 1);
        if (categoryEl) {
            categoryEl.textContent = quiz.educationCategoryName || "테스트";
        }
        if (typeEl) {
            typeEl.textContent = getTypeText(quiz.educationType);
        }
        if (topicEl) {
            topicEl.textContent = (quiz.educationCategoryName || "Java") + " 개념";
        }
        nextBtn.textContent = state.currentIndex === totalCount - 1 ? "학습 완료 🎉" : "다음 문제 →";

        setActiveDot(state.currentIndex);
        renderByEducationType(quiz);
    }

    // 정답/오답 피드백 박스를 모두 숨긴다.
    function hideFeedback() {
        document.querySelectorAll(".quiz-feedback").forEach(function (node) {
            node.classList.add("is-hidden");
        });
    }

    // 폼 제출 이벤트를 가로채서 페이지 리로드 없이 다음 문제로 이동한다.
    function bindFormSubmit() {
        // 문제 폼 노드
        var form = document.getElementById("quiz-form");
        if (!form) {
            return;
        }

        form.addEventListener("submit", function (event) {
            event.preventDefault();

            if (state.educations.length === 0) {
                return;
            }

            hideFeedback();

            var currentQuiz = state.educations[state.currentIndex];
            var typeValue = String(currentQuiz.educationType);

            if (typeValue === "1") {
                var selected = form.querySelector('input[name="answer"]:checked');
                if (!selected) {
                    return;
                }
            } else if (typeValue === "2") {
                // TODO: educationType=2 빈칸채우기 정답 제출/검증 로직 구현
            }

            // 마지막 문제가 아니면 다음 문제로 이동 후 다시 렌더링
            if (state.currentIndex < state.educations.length - 1) {
                state.currentIndex += 1;
                renderCurrentQuiz();
            }
        });
    }

    // 초기 진입 시: 데이터 로드 -> 이벤트 연결 -> 첫 문제 렌더링
    document.addEventListener("DOMContentLoaded", function () {
        state.educations = readQuizData();
        bindFormSubmit();
        renderCurrentQuiz();
    });
})();