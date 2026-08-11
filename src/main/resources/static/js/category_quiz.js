(function () {
    // 선택지 라벨(A, B, C...) 표시에 사용
    var optionLabels = ["A", "B", "C", "D"];

    // 퀴즈 진행 상태 저장
    var state = {
        educations: [],
        currentIndex: 0,
        submitted: false,
        submitting: false
    };

    // 안전하게 텍스트를 읽어오고 없으면 빈 문자열 반환
    function getElementText(item, select) {
        var el = item.querySelector(select);
        return el ? el.textContent.trim() : "";
    }

    // 문제 타입 코드를 사용자에게 보여줄 텍스트로 변환
    function getTypeText(typeValue) {
        if (String(typeValue) === "1") {
            return "객관식";
        }
        else if (String(typeValue) === "2") {
            return "빈칸채우기";
        }
        return "알수없음";
    }

    // JSP에 숨겨둔 문제 데이터를 JS에서 사용할 구조로 파싱
    function readQuizData() {
        var nodes = document.querySelectorAll("#today-education-data .quiz-data-item");
        return Array.prototype.map.call(nodes, function (item) {
            var typeValue = getElementText(item, ".quiz-data-type");
            var quizData = {
                educationId: getElementText(item, ".quiz-data-id"),
                educationType: typeValue,
                educationCategoryName: getElementText(item, ".quiz-data-category-name"),
                educationContent: getElementText(item, ".quiz-data-content"),
                educationExplanation: getElementText(item, ".quiz-data-explanation"),
                answers: []
            };

            if (typeValue === "1") {
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
            }

            return quizData;
        });
    }

    // 상단 진행 점(dot)에서 현재 문제 위치를 활성화
    function setActiveDot(index) {
        var dots = document.querySelectorAll(".quiz-step-dots .dot");
        Array.prototype.forEach.call(dots, function (dot, dotIndex) {
            if (dotIndex === index) {
                dot.classList.add("active");
            } else {
                dot.classList.remove("active");
            }
        });
    }

    // 버튼 상태(선택 전/선택 후/제출 후)에 맞는 시각 효과 클래스 갱신
    function updateSubmitButtonVisual() {
        var form = document.getElementById("quiz-form");
        if (!form) {
            return;
        }

        if (state.submitted) {
            form.classList.remove("pending-selection");
            form.classList.remove("has-selection");
            form.classList.add("submitted-selection");
            return;
        }

        form.classList.remove("submitted-selection");
        form.classList.add("pending-selection");

        var selectedInput = form.querySelector('input[name="answer"]:checked');
        if (selectedInput) {
            form.classList.add("has-selection");
        } else {
            form.classList.remove("has-selection");
        }
    }

    // 정답/오답 피드백 박스를 모두 숨김
    function hideFeedback() {
        document.querySelectorAll(".quiz-feedback").forEach(function (node) {
            node.classList.add("is-hidden");
        });
    }

    // 채점 결과에 따라 피드백 문구와 해설을 표시
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

    // 현재 문제의 선택지를 렌더링하고 클릭 이벤트를 연결
    function renderOptions(quiz) {
        var optionsWrap = document.getElementById("quiz-options");
        var options = quiz.answers && quiz.answers.length > 0 ? quiz.answers : [];
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
            textSpan.textContent = options[i].text;

            label.appendChild(input);
            label.appendChild(labelSpan);
            label.appendChild(textSpan);
            optionsWrap.appendChild(label);
        }

        optionsWrap.querySelectorAll(".quiz-option").forEach(function (optionEl) {
            optionEl.addEventListener("click", function () {
                if (state.submitted) {
                    return;
                }
                optionsWrap.querySelectorAll(".quiz-option").forEach(function (node) {
                    node.classList.remove("selected");
                    node.classList.remove("is-correct");
                    node.classList.remove("is-wrong");
                });
                optionEl.classList.add("selected");
                optionEl.querySelector('input[type="radio"]').checked = true;
                updateSubmitButtonVisual();
            });
        });
    }

    // 현재 문제 정보를 화면 전체(문항/메타/버튼/보기)에 반영
    function renderCurrentQuiz() {
        var totalCount = state.educations.length;
        var questionEl = document.getElementById("quiz-question");
        var currentIndexEl = document.getElementById("quiz-current-index");
        var totalCountEl = document.getElementById("quiz-total-count");
        var typeEl = document.getElementById("quiz-type-text");
        var topicEl = document.getElementById("quiz-topic-text");
        var nextBtn = document.getElementById("quiz-next-btn");

        if (!questionEl || !currentIndexEl || !totalCountEl || !typeEl || !topicEl || !nextBtn) {
            return;
        }

        totalCountEl.textContent = String(totalCount);
        var quiz = state.educations[state.currentIndex];

        if (!quiz) {
            questionEl.textContent = "현재 풀 수 있는 문제가 없습니다.";
            currentIndexEl.textContent = "0";
            typeEl.textContent = "-";
            topicEl.textContent = "-";
            document.getElementById("quiz-options").innerHTML = "";
            hideFeedback();
            nextBtn.textContent = "문제가 없습니다";
            nextBtn.disabled = true;
            var form = document.getElementById("quiz-form");
            if (form) {
                form.classList.remove("pending-selection");
                form.classList.remove("has-selection");
                form.classList.remove("submitted-selection");
            }
            return;
        }

        nextBtn.disabled = false;
        questionEl.textContent = quiz.educationContent || "문제 텍스트";
        currentIndexEl.textContent = String(state.currentIndex + 1);
        typeEl.textContent = getTypeText(quiz.educationType);
        topicEl.textContent = quiz.educationCategoryName || "알수없음";
        nextBtn.textContent = state.submitted
            ? (state.currentIndex === totalCount - 1 ? "학습 완료" : "다음 문제 →")
            : "정답확인";

        setActiveDot(state.currentIndex);
        hideFeedback();
        renderOptions(quiz);
        updateSubmitButtonVisual();
    }

    // 객관식 선택값을 기준으로 정답 여부를 계산
    function gradeMultipleChoice(quiz) {
        var form = document.getElementById("quiz-form");
        var selectedInput = form.querySelector('input[name="answer"]:checked');
        if (!selectedInput) {
            return null;
        }

        var selectedIndex = Number(selectedInput.value);
        var correctIndex = -1;
        for (var i = 0; i < quiz.answers.length; i++) {
            if (quiz.answers[i].correct) {
                correctIndex = i;
                break;
            }
        }

        return {
            selectedIndex: selectedIndex,
            correctIndex: correctIndex,
            isCorrect: selectedIndex === correctIndex
        };
    }

    // 채점 결과를 선택지 스타일/피드백/버튼 상태에 반영
    function applyMultipleChoiceResult(quiz, gradeResult) {
        var optionsWrap = document.getElementById("quiz-options");
        var nextBtn = document.getElementById("quiz-next-btn");

        var optionEls = optionsWrap.querySelectorAll(".quiz-option");
        Array.prototype.forEach.call(optionEls, function (optEl, i) {
            optEl.style.pointerEvents = "none";
            optEl.classList.remove("selected");
            if (i === gradeResult.correctIndex) {
                optEl.classList.add("is-correct");
            }
            if (i === gradeResult.selectedIndex && !gradeResult.isCorrect) {
                optEl.classList.add("is-wrong");
            }
        });

        showFeedback(gradeResult.isCorrect, quiz);
        state.submitted = true;
        nextBtn.textContent = state.currentIndex === state.educations.length - 1 ? "학습 완료" : "다음 문제 →";
        updateSubmitButtonVisual();
    }

    // 답안을 서버에 제출하고 성공 시에만 결과 UI를 반영
    async function submitMultipleChoiceAnswer(quiz) {
        var form = document.getElementById("quiz-form");
        var gradeResult = gradeMultipleChoice(quiz);
        if (!gradeResult) {
            return false;
        }

        var submitValue = {
            educationID: Number(quiz.educationId),
            correct: gradeResult.isCorrect,
            choseOption: gradeResult.selectedIndex + 1
        };

        var submitUrl = form && form.getAttribute("data-submit-url")
            ? form.getAttribute("data-submit-url")
            : "/education/submit";

        try {
            var response = await fetch(submitUrl, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(submitValue)
            });

            if (!response.ok) {
                return false;
            }

            var resultText = (await response.text()).trim();
            if (resultText !== "성공") {
                return false;
            }
        } catch (error) {
            return false;
        }

        applyMultipleChoiceResult(quiz, gradeResult);
        return true;
    }

    // 제출 버튼 이벤트: 미제출이면 채점, 제출 후면 다음 문제로 이동
    function bindFormSubmit() {
        var form = document.getElementById("quiz-form");
        if (!form) {
            return;
        }

        form.addEventListener("submit", async function (event) {
            event.preventDefault();

            if (state.educations.length === 0 || state.submitting) {
                return;
            }

            var currentQuiz = state.educations[state.currentIndex];
            var isSubmitted = state.submitted;
            var nextBtn = document.getElementById("quiz-next-btn");

            if (!isSubmitted) {
                var selected = form.querySelector('input[name="answer"]:checked');
                if (!selected) {
                    return;
                }

                state.submitting = true;
                if (nextBtn) {
                    nextBtn.disabled = true;
                }
                try {
                    await submitMultipleChoiceAnswer(currentQuiz);
                } finally {
                    state.submitting = false;
                    if (nextBtn) {
                        nextBtn.disabled = false;
                    }
                }
            } else {
                if (state.currentIndex < state.educations.length - 1) {
                    state.currentIndex += 1;
                    state.submitted = false;
                    renderCurrentQuiz();
                } else {
                    window.location.href = "/education/category";
                }
            }
        });
    }

    // 초기화: 데이터 읽기 -> 이벤트 연결 -> 첫 문제 렌더링
    document.addEventListener("DOMContentLoaded", function () {
        state.educations = readQuizData();
        bindFormSubmit();
        renderCurrentQuiz();
    });
})();
