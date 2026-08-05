(function () {
    // 선택지 라벨링(A, B, C...) 렌더링용 기준 배열
    var optionLabels = ["A", "B", "C", "D"];

    // 화면을 그리는데 필요한 데이터들을 저장하는 공간
    var state = {
        educations: [],         // educations: 문제 목록
        currentIndex: 0,        // currentIndex: 현재 보고 있는 문제의 인덱스
        submitted: false        // submitted: 현재 문제의 제출 완료 여부
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
        // id: today-education-data안에 담긴 class: quiz-data-item 요소들을 NodeList 형태로 저장
        var nodes = document.querySelectorAll("#today-education-data .quiz-data-item");

        // nodes를 배열형태로 변환 후 순회하면서 배열 만들고 반환
        return Array.prototype.map.call(nodes, function (item) {
            // 문제 타입이 다르면 읽어야하는 데이터타입도 다르기 때문에 판별을 위해 별도로 읽어두기
            var typeValue = getElementText(item, ".quiz-data-type");

            // 공통부문 먼저채워넣고, 타입별로 달라지는 부분은 비워놓기
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
                // 객관식: options 리스트를 순회해서 보기 텍스트 배열을 answers에 저장
                var optionNodes = item.querySelectorAll(".quiz-data-option-item");
                quizData.answers = Array.prototype.map.call(optionNodes, function (node) {
                    return {
                        order: Number(node.getAttribute("data-order") || 0),
                        correct: node.getAttribute("data-correct") === "true",
                        text: node.textContent.trim()
                    };
                }).sort(function (a, b) {
                    return a.order - b.order;
                });
            } else if (typeValue === "2") {
                // TODO: 빈칸채우기 타입(EducationBlankTypeDto) 전용 데이터 파싱 로직 추가
            }

            // 완성된 문제 객체 반환(최종적으로 반환될 리스트에 추가됨)
            return quizData;
        });
    }

    // 상단 진행도를 표시하는 dots에서 현 인덱스를 선택해 활성화상태로 변경(active 클래스 삽입)
    // 나머지는 비활성화 상태로 만들기
    function setActiveDot(index) {
        // 모든 진행 점 노드 배열순회
        var dots = document.querySelectorAll(".quiz-step-dots .dot");
        Array.prototype.forEach.call(dots, function (dot, dotIndex) {
            if (dotIndex === index) {
                dot.classList.add("active");
            } else {
                dot.classList.remove("active");
            }
        });
    }

    // 현재 문제의 선택지 목록을 DOM으로 렌더링하고 클릭 이벤트를 연결
    function renderOptions(quiz) {
        // 선택지 렌더링 대상 컨테이너
        var optionsWrap = document.getElementById("quiz-options");

        // 파싱된 선택지가 없으면 테스트용 기본 선택지 사용하기위해 초기화
        var options = quiz.answers && quiz.answers.length > 0
            ? quiz.answers
            : [
                { text: "니가 코딩을 잘못했으면 이거 표시됨", correct: false },
                { text: "니가 파싱을 잘못했으면 이거 표시됨", correct: true },
                { text: "니가 코딩을 잘못했으면 이거 표시됨", correct: false },
                { text: "니가 파싱을 잘못했으면 이거 표시됨", correct: false }
            ];

        // 테스트용 텍스트를 jsp에서 채워넣었으니 일단 비우기
        optionsWrap.innerHTML = "";

        // 객관식 보기를 생성할 각종 구성요소들을 생성하고, 선택지 텍스트를 채워넣고, DOM에 추가
        for (var i = 0; i < options.length; i += 1) {
            var label = document.createElement("label");
            label.className = "quiz-option";
            label.setAttribute("data-correct", String(options[i].correct));

            var input = document.createElement("input");
            input.type = "radio";
            input.name = "answer";
            input.value = String(i);

            var labelSpan = document.createElement("span");
            labelSpan.className = "option-label";
            labelSpan.textContent = (optionLabels[i] || String(i + 1)) + ".";

            var textSpan = document.createElement("span");
            textSpan.className = "option-text";
            textSpan.textContent = options[i].text;

            label.appendChild(input);
            label.appendChild(labelSpan);
            label.appendChild(textSpan);
            optionsWrap.appendChild(label);
        }

        // 각 선택지에 클릭 이벤트를 연결
        optionsWrap.querySelectorAll(".quiz-option").forEach(function (optionEl) {
            optionEl.addEventListener("click", function () {
                // 이미 제출된 상태의 문제는 해당 이벤트가 작동하지 않도록 방지
                if (state.submitted) {
                    return;
                }
                optionsWrap.querySelectorAll(".quiz-option").forEach(function (node) {
                    node.classList.remove("selected");
                    node.classList.remove("is-correct");
                    node.classList.remove("is-wrong");
                });
                // 현재 클릭한 선택지를 선택 상태로 만들기
                optionEl.classList.add("selected");
                optionEl.querySelector('input[type="radio"]').checked = true;
            });
        });
    }

    // 현재 인덱스(state.currentIndex)에 해당하는 문제를 화면에 렌더링하는 오케스트레이션
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

        // 중요한거 뭐 하나라도 null이면 중지
        if (!questionEl || !currentIndexEl || !totalCountEl || !categoryEl || !typeEl || !topicEl || !nextBtn) {
            return;
        }

        totalCountEl.textContent = String(totalCount);

        // 현재 표시할 문제 객체
        var quiz = state.educations[state.currentIndex];

        // 문제 본문은 educationContent를 우선 사용
        questionEl.textContent = quiz.educationContent || "테스트 문제 텍스트";
        currentIndexEl.textContent = String(state.currentIndex + 1);
        if (categoryEl) {
            categoryEl.textContent = "일일 문제";
        }
        if (typeEl) {
            typeEl.textContent = getTypeText(quiz.educationType);
        }
        if (topicEl) {
            topicEl.textContent = (quiz.educationCategoryName || "알수없음");
        }

        // if문으로 지저분하게 늘어져서 AI한테 방법없냐고 물어보니까 겁나 스마트하게 삼항연산자 중첩으로 압축해줌
        // 문제를 푼 상태가 아니라면 "제출하기" || 제출한 상태라면 마지막 문제인지 확인해서 다음문제, 아니라면 학습완료
        nextBtn.textContent = state.submitted
            ? (state.currentIndex === totalCount - 1 ? "학습 완료 🎉" : "다음 문제 →")
            : "정답확인";

        // 상단 도트 갱신하고, 풀제풀이 부분 숨기고, 현 문제의 타입에 맞는 화면그리기 호출
        setActiveDot(state.currentIndex);
        hideFeedback();
        renderByEducationType(quiz);
    }

    // 정답/오답 피드백 박스 숨기기
    function hideFeedback() {
        document.querySelectorAll(".quiz-feedback").forEach(function (node) {
            node.classList.add("is-hidden");
        });
    }

    // 채점 결과에 따라 피드백 박스 노출
    function showFeedback(isCorrect, quiz) {
        hideFeedback();
        var feedbackEl = document.querySelector(isCorrect ? ".quiz-feedback-correct" : ".quiz-feedback-wrong");
        if (!feedbackEl) {
            return;
        }

        var titleEl = feedbackEl.querySelector(".feedback-title");
        var descEl = feedbackEl.querySelector(".feedback-desc");

        if (isCorrect) {
            if (titleEl) {
                titleEl.textContent = "정답입니다!";
            }
        } else {
            var correctText = "";
            for (var i = 0; i < quiz.answers.length; i++) {
                if (quiz.answers[i].correct) {
                    correctText = quiz.answers[i].text;
                    break;
                }
            }
            if (titleEl) {
                titleEl.textContent = "오답입니다. 정답: " + correctText;
            }
        }

        if (descEl) {
            descEl.textContent = quiz.educationExplanation || "";
        }

        feedbackEl.classList.remove("is-hidden");
    }

    // 객관식 문제를 채점하고 결과를 화면에 반영
    function gradeMultipleChoice(quiz) {
        var optionsWrap = document.getElementById("quiz-options");
        var form = document.getElementById("quiz-form");
        var nextBtn = document.getElementById("quiz-next-btn");

        var selectedInput = form.querySelector('input[name="answer"]:checked');
        if (!selectedInput) {
            return;
        }

        var selectedIndex = Number(selectedInput.value);
        var correctIndex = -1;
        for (var i = 0; i < quiz.answers.length; i++) {
            if (quiz.answers[i].correct) {
                correctIndex = i;
                break;
            }
        }

        var isCorrect = selectedIndex === correctIndex;

        // 정답/오답 클래스 적용 및 선택 잠금
        var optionEls = optionsWrap.querySelectorAll(".quiz-option");
        Array.prototype.forEach.call(optionEls, function (optEl, i) {
            optEl.style.pointerEvents = "none";
            optEl.classList.remove("selected");
            if (i === correctIndex) {
                optEl.classList.add("is-correct");
            }
            if (i === selectedIndex && !isCorrect) {
                optEl.classList.add("is-wrong");
            }
        });

        showFeedback(isCorrect, quiz);

        // 제출 완료 상태로 기록 후 버튼 텍스트 변경
        state.submitted = true;
        var totalCount = state.educations.length;
        nextBtn.textContent = state.currentIndex === totalCount - 1 ? "학습 완료 🎉" : "다음 문제 →";
    }

    // 폼 제출 이벤트를 가로채서 페이지 리로드 없이 다음 문제로 이동
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

            var currentQuiz = state.educations[state.currentIndex];
            var typeValue = String(currentQuiz.educationType);
            var isSubmitted = state.submitted;

            if (!isSubmitted) {
                // 1단계: 답안 제출 및 채점
                if (typeValue === "1") {
                    var selected = form.querySelector('input[name="answer"]:checked');
                    if (!selected) {
                        return;
                    }
                    gradeMultipleChoice(currentQuiz);
                } else if (typeValue === "2") {
                    // TODO: educationType=2 빈칸채우기 정답 제출/검증 로직 구현
                }
            } else {
                // 2단계: 다음 문제로 이동
                if (state.currentIndex < state.educations.length - 1) {
                    state.currentIndex += 1;
                    state.submitted = false;
                    renderCurrentQuiz();
                } else {
                    // TODO: 전체 학습 완료 처리 (결과 페이지 이동 등)
                }
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