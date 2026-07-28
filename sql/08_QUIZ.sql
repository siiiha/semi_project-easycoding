-- ERDCloud diagram: https://www.erdcloud.com/d/EYbqxh3Xw8wZuHfwM
USE `project_easycoding`;

-- 문제의 몸통에 해당하는 테이블
-- 정답부분을 따로 저장하여 다양항 타입의 문제에 대응할 수 있도록 설계
CREATE TABLE IF NOT EXISTS `quiz` (
	`quiz_id` bigint NOT NULL AUTO_INCREMENT,
	`type_id` int2 NOT NULL,
	`title` varchar(127) NOT NULL,
	`content` text NOT NULL,
	`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`quiz_id`),
	CONSTRAINT `fk_quiz_type_id` FOREIGN KEY (`type_id`) REFERENCES `quiz_type` (`type_id`)
);

ALTER TABLE `quiz` ADD COLUMN `explanation` text;