-- ERDCloud diagram: https://www.erdcloud.com/d/EYbqxh3Xw8wZuHfwM
USE `project_easycoding`;

CREATE TABLE IF NOT EXISTS `member` (
    `member_id` bigint NOT NULL AUTO_INCREMENT,
    `login_id` varchar(255) NOT NULL,
    `email` varchar(127) NOT NULL,
    `password` varchar(31),
    `nickname` varchar(15) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `profile_id` int2 NOT NULL DEFAULT 1,
    `deleted_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`member_id`)
);

ALTER TABLE member
    ADD CONSTRAINT uq_member_email UNIQUE (email);

ALTER TABLE member
    ADD CONSTRAINT uq_member_nickname UNIQUE (nickname);

ALTER TABLE member
    MODIFY COLUMN password varchar(100);