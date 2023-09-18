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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `vegan_tb`
(
    `vegan_id`   INT         NOT NULL,
    `vegan_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `item_tb`
(
    `item_id`        BIGINT       NOT NULL  primary key auto_increment,
    `item_name`      varchar(20)  NOT NULL,
    `item_image`     varchar(512) NULL,
    `item_price`     INT          NOT NULL,
    `item_store`     varchar(20)  NOT NULL,
    `item_storelink` varchar(512) NOT NULL,
    `ingr_id`        INT          NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_allergy_tb`
(
    `user_id` INT      NOT NULL,
    `algy_id` SMALLINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `recipe_tb`
(
    `recipe_id`        INT          NOT NULL primary key auto_increment,
    `recipe_name`      varchar(200)  NOT NULL,
    `recipe_link`      varchar(100) NULL,
    `recipe_thumbnail` varchar(200) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `item_preference_tb`
(
    `item_id`     BIGINT NOT NULL,
    `user_id`     INT    NOT NULL,
    `pref_rating` DOUBLE NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `recipe_preference_tb`
(
    `recipe_id`   INT    NOT NULL,
    `user_id`     INT    NOT NULL,
    `pref_rating` DOUBLE NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `saved_recipe_tb`
(
    `user_id`   INT NOT NULL,
    `recipe_id` INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ingredient_price_tb`
(
    `ingr_id` INT  NOT NULL,
    `date`    DATE NOT NULL,
    `price`   INT  NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `saved_item_tb`
(
    `user_id` INT    NOT NULL,
    `item_id` BIGINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `recipe_ingredient_tb`
(
    `recipe_id` INT NOT NULL,
    `ingr_id`   INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category_tb`
(
    `cat_id`   TINYINT     NOT NULL,
    `cat_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ingredient_tb`
(
    `ingr_id`   INT         NOT NULL primary key auto_increment,
    `ingr_name` varchar(30) NOT NULL,
    `subcat_id` SMALLINT    NULL,
    `cat_id`    TINYINT     NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `subcat_tb`
(
    `subcat_id`   SMALLINT    NOT NULL primary key auto_increment,
    `subcat_name` varchar(30) NOT NULL,
    `cat_id`      TINYINT     NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `saved_ingredient_tb`
(
    `user_id` INT NOT NULL,
    `ingr_id` INT NOT NULL
);

CREATE TABLE `ingredient_preference_tb`
(
    `user_id`     INT    NOT NULL,
    `ingr_id`     INT    NOT NULL,
    `pref_rating` DOUBLE NULL
);

CREATE TABLE `allergy_tb`
(
    `algy_id`   SMALLINT    NOT NULL primary key auto_increment,
    `algy_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `allergy_ingredient_tb`
(
    `algy_id` SMALLINT NOT NULL,
    `ingr_id` INT      NOT NULL
);

CREATE TABLE `recipe_process_tb`
(
    `recipe_proc_id`      SMALLINT    NOT NULL,
    `recipe_id`           INT         NOT NULL,
    `recipe_proc_content` VARCHAR(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `recipe_select_log_tb`
(
    `user_id`            INT       NOT NULL,
    `recipe_id`          INT       NOT NULL,
    `recipe_select_time` TIMESTAMP NOT NULL
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

ALTER TABLE `item_preference_tb`
    ADD CONSTRAINT `PK_ITEM_PREFERENCE_TB` PRIMARY KEY (
                                                        `item_id`,
                                                        `user_id`
        );

ALTER TABLE `recipe_preference_tb`
    ADD CONSTRAINT `PK_RECIPE_PREFERENCE_TB` PRIMARY KEY (
                                                          `recipe_id`,
                                                          `user_id`
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
    ADD CONSTRAINT `PK_RECIPE_INGREDIENT_TB` PRIMARY KEY (
                                                          `ingr_id`,
                                                          `recipe_id`
        );

ALTER TABLE `saved_ingredient_tb`
    ADD CONSTRAINT `PK_SAVED_INGREDIENT_TB` PRIMARY KEY (
                                                         `user_id`,
                                                         `ingr_id`
        );

ALTER TABLE `ingredient_preference_tb`
    ADD CONSTRAINT `PK_INGREDIENT_PREFERENCE_TB` PRIMARY KEY (
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

ALTER TABLE `recipe_select_log_tb`
    ADD CONSTRAINT `PK_RECIPE_SELECT_LOG_TB` PRIMARY KEY (
                                                          `user_id`,
                                                          `recipe_id`
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
    ADD CONSTRAINT `FK_recipe_tb_TO_recipe_ingredient_tb_1` FOREIGN KEY (
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



insert into vegan_tb
values (0, "hypeboy"),
       (1, "vegan"),
       (2, "lacto"),
       (3, "ovo"),
       (4, "lacto-ovo"),
       (5, "pesco"),
       (6, "polo"),
       (7, "flexi");