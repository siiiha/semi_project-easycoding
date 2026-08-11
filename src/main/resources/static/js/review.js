(function () {
    var optionLabels = ["A", "B", "C", "D", "E", "F"];

    function getTypeText(typeValue) {
        if (String(typeValue) === "1") {
            return "객관식";
        }
        if (String(typeValue) === "2") {
            return "빈칸 맞추기";
        }
        return "타입 " + typeValue;
    }

    function getOptionLabel(order, index) {
        var orderNumber = Number(order);
        var orderIndex = orderNumber - 1;
        if (orderIndex >= 0 && orderIndex < optionLabels.length) {
            return optionLabels[orderIndex];
        }
        if (orderNumber > 0) {
            return String(orderNumber);
        }
        return optionLabels[index] || String(index + 1);
    }

    function getText(el, selector) {
        var target = el.querySelector(selector);
        return target ? target.textContent.trim() : "";
    }

    function parseReviewData() {
        var cards = document.querySelectorAll(".review-list-panel .review-card");
        return Array.prototype.map.call(cards, function (card, index) {
            var options = Array.prototype.map.call(card.querySelectorAll(".review-data-option"), function (optNode) {
                return {
                    order: Number(optNode.getAttribute("data-order") || 0),
                    correct: optNode.getAttribute("data-correct") === "true",
                    text: optNode.textContent.trim()
                };
            }).sort(function (a, b) {
                return a.order - b.order;
            });

            return {
                index: index,
                orderText: getText(card, ".review-order"),
                title: getText(card, ".review-title"),
                type: Number(card.getAttribute("data-education-type") || 0),
                category: getText(card, ".review-category"),
                question: getText(card, ".review-data-content"),
                explanation: getText(card, ".review-data-explanation"),
                answered: card.getAttribute("data-answered") === "true",
                choseOption: Number(card.getAttribute("data-chose-option") || 0),
                options: options
            };
        });
    }

    function renderOptionList(target, item, choseOrder, correctOrder) {
        target.innerHTML = "";

        for (var i = 0; i < item.options.length; i += 1) {
            var option = item.options[i];
            var row = document.createElement("div");
            row.className = "review-option-item";

            if (option.order === choseOrder) {
                row.classList.add("is-my-answer");
            }
            if (option.order === correctOrder) {
                row.classList.add("is-correct-answer");
            }

            var badge = document.createElement("span");
            badge.className = "review-option-badge";
            badge.textContent = getOptionLabel(option.order, i) + ".";

            var text = document.createElement("span");
            text.textContent = option.text;

            row.appendChild(badge);
            row.appendChild(text);
            target.appendChild(row);
        }
    }

    function bindReviewSlider() {
        var sliderWrap = document.getElementById("review-slider-wrap");
        var listPanel = document.querySelector(".review-list-panel");
        if (!sliderWrap) {
            return;
        }

        var backBtn = document.getElementById("review-back-btn");
        var detailOrder = document.getElementById("detail-order");
        var detailTitle = document.getElementById("detail-title");
        var detailType = document.getElementById("detail-type");
        var detailCategory = document.getElementById("detail-category");
        var detailQuestion = document.getElementById("detail-question");
        var detailMyAnswer = document.getElementById("detail-my-answer");
        var detailCorrectAnswer = document.getElementById("detail-correct-answer");
        var detailOptionList = document.getElementById("detail-option-list");
        var detailExplanation = document.getElementById("detail-explanation");
        var detailCard = document.querySelector(".review-detail-card");

        var reviewItems = parseReviewData();
        var listScrollTop = 0;

        function showDetail(index) {
            var item = reviewItems[index];
            if (!item) {
                return;
            }

            var choseOrder = item.answered ? item.choseOption : 0;
            var choseOption = null;
            var correctOption = null;

            for (var i = 0; i < item.options.length; i += 1) {
                var option = item.options[i];
                if (option.order === choseOrder) {
                    choseOption = option;
                }
                if (option.correct) {
                    correctOption = option;
                }
            }

            detailOrder.textContent = item.orderText;
            detailTitle.textContent = item.title;
            detailType.textContent = getTypeText(item.type);
            detailCategory.textContent = item.category || "-";
            detailQuestion.textContent = item.question || "-";
            detailExplanation.textContent = item.explanation || "해설이 아직 등록되지 않았습니다.";

            if (!item.answered) {
                detailMyAnswer.textContent = "선택한 답안이 없습니다.";
            } else if (choseOption) {
                detailMyAnswer.textContent = getOptionLabel(choseOption.order, 0) + ". " + choseOption.text;
            } else {
                detailMyAnswer.textContent = "선택한 답안 정보를 찾을 수 없습니다.";
            }

            if (correctOption) {
                detailCorrectAnswer.textContent = getOptionLabel(correctOption.order, 0) + ". " + correctOption.text;
            } else {
                detailCorrectAnswer.textContent = "정답 정보가 없습니다.";
            }

            renderOptionList(detailOptionList, item, choseOrder, correctOption ? correctOption.order : 0);
            listScrollTop = window.scrollY || window.pageYOffset || 0;
            sliderWrap.classList.add("is-detail");
            requestAnimationFrame(function () {
                window.scrollTo({ top: 0, behavior: "smooth" });
            });
        }

        if (listPanel) {
            listPanel.addEventListener("click", function (event) {
                var card = event.target.closest(".review-card");
                if (!card || !listPanel.contains(card)) {
                    return;
                }
                var index = Number(card.getAttribute("data-index") || -1);
                showDetail(index);
            });

            listPanel.addEventListener("keydown", function (event) {
                if (event.key !== "Enter" && event.key !== " ") {
                    return;
                }
                var card = event.target.closest(".review-card");
                if (!card || !listPanel.contains(card)) {
                    return;
                }
                event.preventDefault();
                var index = Number(card.getAttribute("data-index") || -1);
                showDetail(index);
            });
        }

        if (backBtn) {
            backBtn.addEventListener("click", function () {
                sliderWrap.classList.remove("is-detail");
                window.scrollTo({ top: listScrollTop, behavior: "smooth" });
            });
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        bindReviewSlider();
    });
})();
