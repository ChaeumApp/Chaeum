DROP DATABASE IF EXISTS chaeum;
CREATE DATABASE chaeum;
USE chaeum;

CREATE TABLE `user_tb`
(
    `user_id`        INT          NOT NULL primary key auto_increment,
    `user_email`     varchar(50)  NULL,
    `user_pwd`       varchar(100) NOT NULL,
    `user_birthday`  date         NULL,
    `user_gender`    char(5)      NULL,
    `user_activated` boolean      NOT NULL DEFAULT true,
    `vegan_id`       INT          NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `vegan_tb`
(
    `vegan_id`   INT         NOT NULL,
    `vegan_name` varchar(50) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `item_tb`
(
    `item_id`        varchar(128)  NOT NULL primary key,
    `item_name`      varchar(256)  NOT NULL,
    `item_image`     varchar(512) NULL,
    `item_price`     INT          NOT NULL,
    `item_store`     varchar(20)  NOT NULL,
    `item_storelink` varchar(512) NOT NULL,
    `ingr_id`        INT          NOT NULL,
    `item_crawling_date`    DATE    NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `user_allergy_tb`
(
    `user_id` INT      NOT NULL,
    `algy_id` SMALLINT NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `recipe_tb`
(
    `recipe_id`        INT          NOT NULL primary key auto_increment,
    `recipe_name`      varchar(200) NOT NULL,
    `recipe_link`      varchar(100) NULL,
    `recipe_thumbnail` varchar(200) NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `item_preference_tb`
(
    `ingr_pref_pk` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `item_id`     VARCHAR(128) NOT NULL,
    `user_id`     INT    NOT NULL,
    `pref_rating` DOUBLE NOT NULL DEFAULT 0
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `recipe_preference_tb`
(
    `recipe_perf_pk` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `recipe_id`   INT    NOT NULL,
    `user_id`     INT    NOT NULL,
    `pref_rating` DOUBLE NOT NULL DEFAULT 0
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `saved_recipe_tb`
(
    `user_id`   INT NOT NULL,
    `recipe_id` INT NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `ingredient_price_tb`
(
	`ingr_price_id`        INT NOT NULL primary key auto_increment,
    `ingr_id` INT  NOT NULL,
    `date`    DATE NOT NULL,
    `price`   INT  NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `saved_item_tb`
(
    `user_id` INT    NOT NULL,
    `item_id` VARCHAR(128) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `recipe_ingredient_tb`
(
    `recipe_ingr_pk`     BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `recipe_id`          INT          NOT NULL,
    `recipe_ingr_name`   varchar(100) NOT NULL,
    `recipe_ingr_amount` varchar(256) NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `category_tb`
(
    `cat_id`   TINYINT     NOT NULL primary key auto_increment,
    `cat_name` varchar(30) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `ingredient_tb`
(
    `ingr_id`   INT         NOT NULL primary key auto_increment,
    `ingr_name` varchar(30) NOT NULL,
    `subcat_id` SMALLINT    NULL,
    `cat_id`    TINYINT     NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `subcat_tb`
(
    `subcat_id`   SMALLINT    NOT NULL primary key auto_increment,
    `subcat_name` varchar(30) NOT NULL,
    `cat_id`      TINYINT     NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `ingredient_group_tb` (
	`ingr_group_id`	INT	NOT NULL primary key auto_increment,
	`ingr_id`	INT	NOT NULL,
	`group_id`	INT	NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `saved_ingredient_tb`
(
    `user_id` INT NOT NULL,
    `ingr_id` INT NOT NULL
);

CREATE TABLE `ingredient_preference_tb`
(
	`ingr_pref_pk`	INT	NOT NULL primary key auto_increment,
    `user_id`     INT    NOT NULL,
    `ingr_id`     INT    NOT NULL,
    `pref_rating` DOUBLE NULL
);

CREATE TABLE `allergy_tb`
(
    `algy_id`   SMALLINT    NOT NULL primary key,
    `algy_name` varchar(30) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `allergy_ingredient_tb`
(
    `algy_id` SMALLINT NOT NULL,
    `ingr_id` INT      NOT NULL
);

CREATE TABLE `recipe_process_tb`
(
    `recipe_proc_id`      SMALLINT     NOT NULL,
    `recipe_id`           INT          NOT NULL,
    `recipe_proc_content` VARCHAR(512) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `recipe_select_log_tb`
(
    `recipe_select_pk`   BIGINT    NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id`            INT       NOT NULL,
    `recipe_id`          INT       NOT NULL,
    `recipe_select_time` TIMESTAMP NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
CREATE TABLE `ingredient_select_log_tb`
(
    `ingr_select_pk`   BIGINT    NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id`          INT       NOT NULL,
    `ingr_id`          INT       NOT NULL,
    `ingr_select_time` TIMESTAMP NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
CREATE TABLE `item_select_log_tb`
(
    `item_select_pk`  BIGINT    NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id`          INT       NOT NULL,
    `item_id`          VARCHAR(128)    NOT NULL,
    `item_select_time` TIMESTAMP NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `recipe_recommend_tb`
(
    `recipe_recommend_pk`    INT   NOT NULL PRIMARY KEY  AUTO_INCREMENT,
    `recipe_id`              INT   NOT NULL,
    `user_id`                INT   NOT NULL,
    `recipe_recommend_score` FLOAT NOT NULL DEFAULT 0
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `ingredient_recommend_tb`
(
	`ingr_recommend_pk`	INT	NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id`              INT   NOT NULL,
    `ingr_id`              INT   NOT NULL,
    `ingr_recommend_score` FLOAT NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

ALTER TABLE `ingredient_recommend_tb`
    ADD CONSTRAINT  UNIQUE (
                                                             `user_id`,
                                                             `ingr_id`
        );

ALTER TABLE `ingredient_recommend_tb`
    ADD CONSTRAINT `FK_user_tb_TO_ingredient_recommend_tb_1` FOREIGN KEY (
                                                                          `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `ingredient_recommend_tb`
    ADD CONSTRAINT `FK_ingredient_tb_TO_ingredient_recommend_tb_1` FOREIGN KEY (
                                                                                `ingr_id`
        )
        REFERENCES `ingredient_tb` (
                                    `ingr_id`
            );


ALTER TABLE `recipe_recommend_tb`
    ADD CONSTRAINT `FK_recipe_tb_TO_recipe_recommend_tb_1` FOREIGN KEY (
                                                                        `recipe_id`
        )
        REFERENCES `recipe_tb` (
                                `recipe_id`
            );

ALTER TABLE `recipe_recommend_tb`
    ADD CONSTRAINT `FK_user_tb_TO_recipe_recommend_tb_1` FOREIGN KEY (
                                                                      `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );


ALTER TABLE `item_select_log_tb`
    ADD CONSTRAINT `FK_user_tb_TO_item_select_log_tb_1` FOREIGN KEY (
                                                                     `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `item_select_log_tb`
    ADD CONSTRAINT `FK_item_tb_TO_item_select_log_tb_1` FOREIGN KEY (
                                                                     `item_id`
        )
        REFERENCES `item_tb` (
                              `item_id`
            );


ALTER TABLE `ingredient_select_log_tb`
    ADD CONSTRAINT `FK_user_tb_TO_ingredient_select_log_tb_1` FOREIGN KEY (
                                                                           `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `ingredient_select_log_tb`
    ADD CONSTRAINT `FK_ingredient_tb_TO_ingredient_select_log_tb_1` FOREIGN KEY (
                                                                                 `ingr_id`
        )
        REFERENCES `ingredient_tb` (
                                    `ingr_id`
            );

ALTER TABLE `ingredient_group_tb`
    ADD CONSTRAINT `FK_ingredient_tb_TO_ingredient_group_tb_1` FOREIGN KEY (
                                                                          `ingr_id`
        )
        REFERENCES `ingredient_tb` (
                              `ingr_id`
            );


CREATE TABLE `user_devtoken_tb`
(
    `user_id`  INT         NOT NULL,
    `token_id` VARCHAR(128) NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE `item_purchased_log_tb`
(
    `item_purchased_log_pk` BIGINT    NOT NULL AUTO_INCREMENT,
    `user_id`               INT       NOT NULL,
    `item_id`               VARCHAR(128)    NOT NULL,
    `item_purchased_time`   TIMESTAMP NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

ALTER TABLE `item_purchased_log_tb`
    ADD CONSTRAINT `PK_ITEM_PURCHASED_LOG_TB`
        PRIMARY KEY (
                     `item_purchased_log_pk`
            );

ALTER TABLE `vegan_tb`
    ADD CONSTRAINT `PK_VEGAN_TB` PRIMARY KEY (
                                              `vegan_id`
        );


ALTER TABLE `user_allergy_tb`
    ADD CONSTRAINT `PK_USER_ALLERGY_TB` PRIMARY KEY (
                                                     `user_id`,
                                                     `algy_id`
        );

ALTER TABLE `saved_recipe_tb`
    ADD CONSTRAINT `PK_SAVED_RECIPE_TB` PRIMARY KEY (
                                                     `user_id`,
                                                     `recipe_id`
        );

ALTER TABLE `saved_item_tb`
    ADD CONSTRAINT `PK_SAVED_ITEM_TB` PRIMARY KEY (
                                                   `user_id`,
                                                   `item_id`
        );


ALTER TABLE `recipe_ingredient_tb`
    ADD CONSTRAINT `FK_recipe_tb_TO_recipe_ingredient_tb_1` FOREIGN KEY (
                                                                         `recipe_id`
        )
        REFERENCES `recipe_tb` (
                                `recipe_id`
            );


ALTER TABLE `saved_ingredient_tb`
    ADD CONSTRAINT `PK_SAVED_INGREDIENT_TB` PRIMARY KEY (
                                                         `user_id`,
                                                         `ingr_id`
        );

ALTER TABLE `ingredient_preference_tb`
    ADD CONSTRAINT UNIQUE (
                                                              `user_id`,
                                                              `ingr_id`
        );

ALTER TABLE `allergy_ingredient_tb`
    ADD CONSTRAINT `PK_ALLERGY_INGREDIENT_TB` PRIMARY KEY (
                                                           `algy_id`,
                                                           `ingr_id`
        );

ALTER TABLE `recipe_process_tb`
    ADD CONSTRAINT `PK_RECIPE_PROCESS_TB` PRIMARY KEY (
                                                       `recipe_proc_id`,
                                                       `recipe_id`
        );


ALTER TABLE `user_devtoken_tb`
    ADD CONSTRAINT `PK_USER_DEVTOKEN_TB` PRIMARY KEY (
                                                      `user_id`,
                                                      `token_id`
        );

ALTER TABLE `user_allergy_tb`
    ADD CONSTRAINT `FK_user_tb_TO_user_allergy_tb_1` FOREIGN KEY (
                                                                  `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `user_allergy_tb`
    ADD CONSTRAINT `FK_allergy_tb_TO_user_allergy_tb_1` FOREIGN KEY (
                                                                     `algy_id`
        )
        REFERENCES `allergy_tb` (
                                 `algy_id`
            );

ALTER TABLE `item_preference_tb`
    ADD CONSTRAINT `FK_item_tb_TO_item_preference_tb_1` FOREIGN KEY (
                                                                     `item_id`
        )
        REFERENCES `item_tb` (
                              `item_id`
            );

ALTER TABLE `item_preference_tb`
    ADD CONSTRAINT `FK_user_tb_TO_item_preference_tb_1` FOREIGN KEY (
                                                                     `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `recipe_preference_tb`
    ADD CONSTRAINT `FK_recipe_tb_TO_recipe_preference_tb_1` FOREIGN KEY (
                                                                         `recipe_id`
        )
        REFERENCES `recipe_tb` (
                                `recipe_id`
            );

ALTER TABLE `recipe_preference_tb`
    ADD CONSTRAINT `FK_user_tb_TO_recipe_preference_tb_1` FOREIGN KEY (
                                                                       `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `saved_recipe_tb`
    ADD CONSTRAINT `FK_user_tb_TO_saved_recipe_tb_1` FOREIGN KEY (
                                                                  `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `saved_recipe_tb`
    ADD CONSTRAINT `FK_recipe_tb_TO_saved_recipe_tb_1` FOREIGN KEY (
                                                                    `recipe_id`
        )
        REFERENCES `recipe_tb` (
                                `recipe_id`
            );

ALTER TABLE `ingredient_price_tb`
    ADD CONSTRAINT `FK_ingredient_tb_TO_ingredient_price_tb_1` FOREIGN KEY (
                                                                            `ingr_id`
        )
        REFERENCES `ingredient_tb` (
                                    `ingr_id`
            ),
    ADD CONSTRAINT UNIQUE (
                                                              `ingr_id`,
                                                              `date`
        );

ALTER TABLE `saved_item_tb`
    ADD CONSTRAINT `FK_user_tb_TO_saved_item_tb_1` FOREIGN KEY (
                                                                `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `saved_item_tb`
    ADD CONSTRAINT `FK_item_tb_TO_saved_item_tb_1` FOREIGN KEY (
                                                                `item_id`
        )
        REFERENCES `item_tb` (
                              `item_id`
            );

ALTER TABLE `recipe_ingredient_tb`
    ADD CONSTRAINT `FK_recipe_tb_TO_recipe_ingredient_tb_2` FOREIGN KEY (
                                                                         `recipe_id`
        )
        REFERENCES `recipe_tb` (
                                `recipe_id`
            );

ALTER TABLE `saved_ingredient_tb`
    ADD CONSTRAINT `FK_user_tb_TO_saved_ingredient_tb_1` FOREIGN KEY (
                                                                      `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `saved_ingredient_tb`
    ADD CONSTRAINT `FK_ingredient_tb_TO_saved_ingredient_tb_1` FOREIGN KEY (
                                                                            `ingr_id`
        )
        REFERENCES `ingredient_tb` (
                                    `ingr_id`
            );

ALTER TABLE `ingredient_preference_tb`
    ADD CONSTRAINT `FK_user_tb_TO_ingredient_preference_tb_1` FOREIGN KEY (
                                                                           `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `ingredient_preference_tb`
    ADD CONSTRAINT `FK_ingredient_tb_TO_ingredient_preference_tb_1` FOREIGN KEY (
                                                                                 `ingr_id`
        )
        REFERENCES `ingredient_tb` (
                                    `ingr_id`
            );

ALTER TABLE `allergy_ingredient_tb`
    ADD CONSTRAINT `FK_allergy_tb_TO_allergy_ingredient_tb_1` FOREIGN KEY (
                                                                           `algy_id`
        )
        REFERENCES `allergy_tb` (
                                 `algy_id`
            );

ALTER TABLE `allergy_ingredient_tb`
    ADD CONSTRAINT `FK_ingredient_tb_TO_allergy_ingredient_tb_1` FOREIGN KEY (
                                                                              `ingr_id`
        )
        REFERENCES `ingredient_tb` (
                                    `ingr_id`
            );

ALTER TABLE `recipe_process_tb`
    ADD CONSTRAINT `FK_recipe_tb_TO_recipe_process_tb_1` FOREIGN KEY (
                                                                      `recipe_id`
        )
        REFERENCES `recipe_tb` (
                                `recipe_id`
            );

ALTER TABLE `recipe_select_log_tb`
    ADD CONSTRAINT `FK_user_tb_TO_recipe_select_log_tb_1` FOREIGN KEY (
                                                                       `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );

ALTER TABLE `recipe_select_log_tb`
    ADD CONSTRAINT `FK_recipe_tb_TO_recipe_select_log_tb_1` FOREIGN KEY (
                                                                         `recipe_id`
        )
        REFERENCES `recipe_tb` (
                                `recipe_id`
            );

ALTER TABLE `user_devtoken_tb`
    ADD CONSTRAINT `FK_user_tb_TO_user_device_token_1` FOREIGN KEY (
                                                                    `user_id`
        )
        REFERENCES `user_tb` (
                              `user_id`
            );



insert into vegan_tb
values (0, 'hypeboy'),
       (1, 'vegan'),
       (2, 'lacto'),
       (3, 'ovo'),
       (4, 'lacto-ovo'),
       (5, 'pesco'),
       (6, 'polo'),
       (7, 'flexi');

insert into category_tb(`cat_name`)
values ('과일'),
       ('채소'),
       ('곡류/견과'),
       ('정육/달걀'),
       ('수산물'),
       ('유제품'),
       ('김치'),
       ('면/파스타'),
       ('통조림'),
       ('가루/조미료'),
       ('오일/소스'),
       ('빵/잼');

insert into subcat_tb
values (1, '소고기', 4),
       (2, '돼지고기', 4),
       (3, '닭고기', 4),
       (4, '오리고기', 4),
       (5, '양고기', 4),
       (6, '달걀', 4);

insert into user_tb(`user_email`, `user_pwd`, `user_birthday`, `user_gender`, `vegan_id`)
values ('ww@ssafy.com', '{bcrypt}$2a$10$NgAsWB9qRNjfl4OOWALIz.GTAJEzibygrLNwPSWO/2b/c37mbzfE6',
        '2000-01-01', 'm', 0);
		-- ('xx@ssafy.com', '{bcrypt}$2a$10$NgAsWB9qRNjfl4OOWALIz.GTAJEzibygrLNwPSWO/2b/c37mbzfE6',
        -- '1990-01-01', 'm', 0),
		-- ('yy@ssafy.com', '{bcrypt}$2a$10$NgAsWB9qRNjfl4OOWALIz.GTAJEzibygrLNwPSWO/2b/c37mbzfE6',
        -- '1980-01-01', 'f', 1),
		-- ('zz@ssafy.com', '{bcrypt}$2a$10$NgAsWB9qRNjfl4OOWALIz.GTAJEzibygrLNwPSWO/2b/c37mbzfE6',
        -- '1970-01-01', 'f', 2);
        
insert into allergy_tb
values (0, '난류'),
       (1, '우유'),
       (2, '메밀'),
       (3, '땅콩'),
       (4, '대두'),
       (5, '밀'),
       (6, '고등어'),
       (7, '게'),
       (8, '새우'),
       (9, '돼지고기'),
       (10, '복숭아'),
       (11, '토마토'),
       (12, '호두'),
       (13, '닭고기'),
       (14, '쇠고기'),
       (15, '오징어'),
       (16, '조개류(굴, 전복, 홍합)');

CREATE TABLE `ingredient_default_preference_tb` (
	`ingr_default_pref_id`	INT	NOT NULL primary key auto_increment,
	`group_id`	SMALLINT	NOT NULL,
	`ingr_id`	INT	NOT NULL,
	`pref_rating`	DOUBLE	NOT NULL
);

ALTER TABLE `ingredient_default_preference_tb` ADD CONSTRAINT `FK_ingredient_tb_TO_ingredient_default_preference_tb_1` FOREIGN KEY (
	`ingr_id`
)
REFERENCES `ingredient_tb` (
	`ingr_id`
);
