-- ERDCloud diagram: https://www.erdcloud.com/d/EYbqxh3Xw8wZuHfwM
USE `project_easycoding`;

-- 퀴즈 카테고리 테이블
-- 일종의 '과목' 개념으로 해당 문제를 푸는데 필요한 지식 도메인을 의미한다
CREATE TABLE IF NOT EXISTS `quiz_category` (
	`category_id` int2 NOT NULL AUTO_INCREMENT,
	`category_name` varchar(127) NOT NULL,
	PRIMARY KEY (`category_id`)
);

alter table `quiz_category`
    MODIFY COLUMN `category_name` varchar(127);