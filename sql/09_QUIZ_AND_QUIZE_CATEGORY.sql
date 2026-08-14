-- ERDCloud diagram: https://www.erdcloud.com/d/EYbqxh3Xw8wZuHfwM
USE `project_easycoding`;

CREATE TABLE IF NOT EXISTS `quiz_and_quiz_category` (
	`quiz_id` bigint NOT NULL AUTO_INCREMENT,
	`category_id` int2 NOT NULL,
	PRIMARY KEY (`quiz_id`, `category_id`),
	CONSTRAINT `fk_quiz_and_quiz_category_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`quiz_id`),
	CONSTRAINT `fk_quiz_and_quiz_category_category_id` FOREIGN KEY (`category_id`) REFERENCES `quiz_category` (`category_id`)
);

drop table if exists `quiz_and_quiz_category`;