(function () {
    var optionLabels = ["A", "B", "C", "D"];

    var state = {
        educations: [],
        currentIndex: 0,
        submitted: false,
        submitting: false
    };

    function getElementText(item, select) {
        var el = item.querySelector(select);
        return el ? el.textContent.trim() : "";
    }

    function getTypeText(typeValue) {
        if (String(typeValue) === "1") {
            return "객관식";
        }
        else if (String(typeValue) === "2") {
            return "빈칸채우기";
        }
        return "알수없음";
    }

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

    function hideFeedback() {
        document.querySelectorAll(".quiz-feedback").forEach(function (node) {
            node.classList.add("is-hidden");
        });
    }

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
            });
        });
    }

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
    }

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
    }

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

    document.addEventListener("DOMContentLoaded", function () {
        state.educations = readQuizData();
        bindFormSubmit();
        renderCurrentQuiz();
    });
})();
