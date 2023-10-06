# DELETE FROM `ingredient_preference_tb`;
#
INSERT INTO `ingredient_preference_tb` (`user_id`, `ingr_id`, `pref_rating`)
VALUES (1, 188, 5),
       (1, 166, 10),
       (1, 50, 523),
       (1, 273, 123),

       (2, 188, 10),
       (2, 166, 20),
       (2, 50, 555),

       (3, 1, 10),
       (3, 2, 20),
       (3, 3, 30),
       (3, 4, 50),
       (3, 5, 100),
       (3, 6, 200),

       (4, 4, 60),
       (4, 5, 70),
       (4, 6, 90),
       (4, 7, 50),
       (4, 8, 100),
       (4, 9, 200);