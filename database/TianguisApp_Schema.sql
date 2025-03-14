-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tianguisapp
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tianguisapp` ;

-- -----------------------------------------------------
-- Schema tianguisapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tianguisapp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `tianguisapp` ;

-- -----------------------------------------------------
-- Table `tianguis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguis` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `address` VARCHAR(500) NULL DEFAULT NULL,
  `location` MULTILINESTRING SRID 4326 NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `disable` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `idx_Tianguis_name` (`name` ASC) VISIBLE,
  INDEX `idx_Tianguis_address` (`address` ASC) VISIBLE,
  SPATIAL INDEX `idx_Tianguis_location` (`location`) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguis_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguis_schedule` (
  `day` ENUM('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') NOT NULL,
  `tianguis` BIGINT NOT NULL,
  `open_time` TIME NULL DEFAULT NULL,
  `close_time` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`day`, `tianguis`),
  INDEX `idx_Schedule_Day_day` (`day` ASC) VISIBLE,
  CONSTRAINT `fk_Schedule_Day_tianguis`
    FOREIGN KEY (`tianguis`)
    REFERENCES `tianguis` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `category` (
  `code` VARCHAR(5) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `disable` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stand` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `description` VARCHAR(514) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disable` TINYINT NOT NULL DEFAULT '0',
  `owner` BIGINT NOT NULL,
  `category` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Stand_owner` (`owner` ASC) VISIBLE,
  INDEX `fk_Stand_category` (`category` ASC) VISIBLE,
  INDEX `idx_Stand_name` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_Stand_category`
    FOREIGN KEY (`category`)
    REFERENCES `category` (`code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Stand_owner`
    FOREIGN KEY (`owner`)
    REFERENCES `user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `image` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(514) NOT NULL,
  `order` INT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tianguis` BIGINT NULL DEFAULT NULL,
  `item` BIGINT NULL DEFAULT NULL,
  `stand` BIGINT NULL DEFAULT NULL,
  `user` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Image_tianguis` (`tianguis` ASC) VISIBLE,
  INDEX `fk_Image_item` (`item` ASC) VISIBLE,
  INDEX `fk_Image_stand` (`stand` ASC) VISIBLE,
  INDEX `fk_image_1_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `fk_Image_item`
    FOREIGN KEY (`item`)
    REFERENCES `item` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Image_stand`
    FOREIGN KEY (`stand`)
    REFERENCES `stand` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Image_tianguis`
    FOREIGN KEY (`tianguis`)
    REFERENCES `tianguis` (`id`),
  CONSTRAINT `fk_image_1`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  `phone` VARCHAR(12) NULL DEFAULT NULL,
  `role` ENUM('seller', 'customer') NOT NULL DEFAULT 'seller',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disable` TINYINT NOT NULL DEFAULT '0',
  `photo` BIGINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uc_User_email` (`email` ASC) VISIBLE,
  INDEX `fk_user_avatar_idx` (`photo` ASC) VISIBLE,
  CONSTRAINT `fk_user_avatar`
    FOREIGN KEY (`photo`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `status` (
  `code` VARCHAR(5) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `disable` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `description` VARCHAR(1028) NULL DEFAULT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `selled` TINYINT NOT NULL DEFAULT '0',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `disable` TINYINT NOT NULL DEFAULT '0',
  `stand` BIGINT NULL DEFAULT NULL,
  `owner` BIGINT NOT NULL,
  `status` VARCHAR(5) NULL DEFAULT NULL,
  `category` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Item_stand` (`stand` ASC) VISIBLE,
  INDEX `fk_Item_category` (`category` ASC) VISIBLE,
  INDEX `fk_Item_owner` (`owner` ASC) VISIBLE,
  INDEX `fk_Item_status` (`status` ASC) VISIBLE,
  CONSTRAINT `fk_Item_category`
    FOREIGN KEY (`category`)
    REFERENCES `category` (`code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Item_owner`
    FOREIGN KEY (`owner`)
    REFERENCES `user` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Item_stand`
    FOREIGN KEY (`stand`)
    REFERENCES `stand` (`id`),
  CONSTRAINT `fk_Item_status`
    FOREIGN KEY (`status`)
    REFERENCES `status` (`code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `favorite` (
  `item` BIGINT NOT NULL,
  `user` BIGINT NOT NULL,
  PRIMARY KEY (`item`, `user`),
  INDEX `fk_Favorite_user` (`user` ASC) VISIBLE,
  CONSTRAINT `fk_Favorite_item`
    FOREIGN KEY (`item`)
    REFERENCES `item` (`id`),
  CONSTRAINT `fk_Favorite_user`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stand_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stand_location` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(500) NULL DEFAULT NULL,
  `location` POINT SRID 4326 NOT NULL,
  `tianguis_dependece` TINYINT NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disable` TINYINT NOT NULL DEFAULT '0',
  `tianguis` BIGINT NULL DEFAULT NULL,
  `stand_info` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Stand_Location_tianguis` (`tianguis` ASC) VISIBLE,
  INDEX `fk_Stand_Location_stand_info` (`stand_info` ASC) VISIBLE,
  INDEX `idx_Stand_Location_address` (`address` ASC) VISIBLE,
  CONSTRAINT `fk_Stand_Location_stand_info`
    FOREIGN KEY (`stand_info`)
    REFERENCES `stand` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Stand_Location_tianguis`
    FOREIGN KEY (`tianguis`)
    REFERENCES `tianguis` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguis_suggestion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguis_suggestion` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `new_name` VARCHAR(128) NULL,
  `new_address` VARCHAR(500) NULL DEFAULT NULL,
  `new_location` MULTILINESTRING SRID 4326 NOT NULL,
  `points` BIGINT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disable` TINYINT NOT NULL DEFAULT 0,
  `tianguis_base` BIGINT NOT NULL,
  `user` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_Tianguis_name` (`new_name` ASC) VISIBLE,
  INDEX `idx_Tianguis_address` (`new_address` ASC) VISIBLE,
  SPATIAL INDEX `idx_Tianguis_location` (`new_location`) VISIBLE,
  INDEX `fk_tianguis_suggestion_1_idx` (`tianguis_base` ASC) VISIBLE,
  INDEX `fk_tianguis_user_suggestion_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `fk_tianguis_suggestion`
    FOREIGN KEY (`tianguis_base`)
    REFERENCES `tianguis` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tianguis_user_suggestion`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `schedule_suggestion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `schedule_suggestion` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `day` ENUM('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') NOT NULL,
  `new_open_time` TIME NULL DEFAULT NULL,
  `new_close_time` TIME NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `tianguis_suggestion` BIGINT NOT NULL,
  `user` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_suggestion_user_idx` (`user` ASC) VISIBLE,
  INDEX `fk_suggestion_schedule_idx` (`tianguis_suggestion` ASC) VISIBLE,
  CONSTRAINT `fk_suggestion_schedule`
    FOREIGN KEY (`tianguis_suggestion`)
    REFERENCES `tianguis_suggestion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suggestion_user`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `suggestion_response`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suggestion_response` (
  `suggestion` BIGINT NOT NULL,
  `user` BIGINT NOT NULL,
  `approve` TINYINT NOT NULL,
  PRIMARY KEY (`suggestion`, `user`),
  INDEX `fk_tianguis_suggestion_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `fk_suggestion_user_response`
    FOREIGN KEY (`suggestion`)
    REFERENCES `tianguis_suggestion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tianguis_base_suggestion`
    FOREIGN KEY (`user`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stand_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stand_schedule` (
  `day` ENUM('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') NOT NULL,
  `stand` BIGINT NOT NULL,
  `open_time` TIME NULL DEFAULT NULL,
  `close_time` TIME NULL DEFAULT NULL,
  `tianguis_dependence` TINYINT NOT NULL DEFAULT 1,
  INDEX `fk_schedule_stand_location_idx` (`stand` ASC) VISIBLE,
  PRIMARY KEY (`day`, `stand`),
  CONSTRAINT `fk_schedule_stand_location`
    FOREIGN KEY (`stand`)
    REFERENCES `stand_location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `tianguis`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `tianguis` (`id`, `name`, `address`, `location`, `created_at`, `updated_at`, `disable`) VALUES (1, 'Tianguis Otay Centenario', 'Calle de la Industria 123 Otay Centenario', ST_GeomFromText('MULTILINESTRING((32.5378 -116.9556, 32.5380 -116.9552, 32.5377 -116.9550))', 4326), '2024-03-05 10:00:00', '2024-03-05 10:00:00', 0);
INSERT INTO `tianguis` (`id`, `name`, `address`, `location`, `created_at`, `updated_at`, `disable`) VALUES (2, 'Mercado La Presa', 'Avenida Tecnologico 456 La Presa', ST_GeomFromText('MULTILINESTRING((32.5450 -116.9401, 32.5452 -116.9398, 32.5449 -116.9395))', 4326), '2024-03-05 11:00:00', '2024-03-05 11:00:00', 0);
INSERT INTO `tianguis` (`id`, `name`, `address`, `location`, `created_at`, `updated_at`, `disable`) VALUES (3, 'Tianguis Dominical Otay', 'Calle Fronteriza 789 Otay', ST_GeomFromText('MULTILINESTRING((32.5336 -116.9612, 32.5338 -116.9608, 32.5335 -116.9605))', 4326), '2024-03-05 12:00:00', '2024-03-05 12:00:00', 0);
INSERT INTO `tianguis` (`id`, `name`, `address`, `location`, `created_at`, `updated_at`, `disable`) VALUES (4, 'Tianguis La Bola', 'Boulevard Altiplano Altiplano 22204', ST_GeomFromText('MULTILINESTRING((32.52328110638213 -116.85320346303305, 32.52428409308614 -116.8547010671798, 32.52465567683318 -116.8555028113125, 32.52518919314974 -116.85634986920091, 32.52657573950401 -116.85740493571353, 32.52691464012686 -116.85767610672045, 32.527626772836285 -116.85817447020929),(32.525331498823235 -116.8568006653006, 32.52570452199497 -116.85630791844977),(32.52598229883871 -116.8569507880027, 32.526203627581594 -116.85662841558783),(32.52691301655602 -116.8576894231444, 32.526792645801166 -116.85785060935186))', 4326), '2024-03-05 13:00:00', '2024-03-05 13:00:00', 0);
INSERT INTO `tianguis` (`id`, `name`, `address`, `location`, `created_at`, `updated_at`, `disable`) VALUES (5, 'Tianguis Salesianos', 'Av. Melchor Ocampo Valle Verde', ST_GeomFromText('MULTILINESTRING((32.5133238495948 -116.85405315735375, 32.52187432519253 -116.8680530603099),(32.52095840360458 -116.86653785140852, 32.52167849812574 -116.86591489230034, 32.522538941337515 -116.86731901061785),(32.52059089443844 -116.8659359674451, 32.52033729605091 -116.86614621851645),(32.52085390686611 -116.866417021622, 32.5204694016557 -116.86673455806326),(32.5211501236744 -116.8668627293512, 32.52091841293516 -116.86705177602764),(32.52142440866639 -116.86732197312685, 32.52131571570081 -116.86742362572055))', 4326), '2024-03-05 14:00:00', '2024-03-05 14:00:00', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tianguis_schedule`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('monday', 1, '7:00:00', '16:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('saturday', 1, '7:00:00', '16:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('sunday', 1, '7:00:00', '16:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('friday', 1, '7:00:00', '16:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('saturday', 2, '7:00:00', '14:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('sunday', 2, '7:00:00', '14:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('monday', 2, '12:00:00', '21:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('sunday', 3, '9:30:00', '18:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('saturday', 3, '9:30:00', '18:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('monday', 4, '9:00:00', '17:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('wednesday', 4, '9:00:00', '17:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('saturday', 4, '9:00:00', '17:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('friday', 5, '9:00:00', '17:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('saturday', 5, '8:30:00', '16:00:00');
INSERT INTO `tianguis_schedule` (`day`, `tianguis`, `open_time`, `close_time`) VALUES ('sunday', 5, '8:30:00', '16:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `category` (`code`, `name`, `disable`) VALUES ('ALIME', 'Alimentos y Bebidas', 0);
INSERT INTO `category` (`code`, `name`, `disable`) VALUES ('ARTES', 'Artesanías', 0);
INSERT INTO `category` (`code`, `name`, `disable`) VALUES ('ROPA', 'Ropa y Accesorios', 0);
INSERT INTO `category` (`code`, `name`, `disable`) VALUES ('HOGAR', 'Hogar y Decoración', 0);
INSERT INTO `category` (`code`, `name`, `disable`) VALUES ('JARDI', 'Jardinería', 0);
INSERT INTO `category` (`code`, `name`, `disable`) VALUES ('ELEC', 'Electronica', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `stand`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `stand` (`id`, `name`, `description`, `created_at`, `disable`, `owner`, `category`) VALUES (1, 'Antojitos María', 'Comida tradicional', '2024-01-01 8:00:00', 0, 1, 'ALIME');
INSERT INTO `stand` (`id`, `name`, `description`, `created_at`, `disable`, `owner`, `category`) VALUES (2, 'Artesanías México', 'Arte popular', '2024-01-02 9:00:00', 0, 3, 'ARTES');
INSERT INTO `stand` (`id`, `name`, `description`, `created_at`, `disable`, `owner`, `category`) VALUES (5, 'Plantas y Más', 'Vivero móvil', '2024-01-05 12:00:00', 0, 5, 'JARDI');
INSERT INTO `stand` (`id`, `name`, `description`, `created_at`, `disable`, `owner`, `category`) VALUES (3, 'Ropa Usada', 'Ropa de segunda mano', '2024-01-03 10:00:00', 0, 6, 'ROPA');
INSERT INTO `stand` (`id`, `name`, `description`, `created_at`, `disable`, `owner`, `category`) VALUES (4, 'Muebles Viejitos', 'Muebles antiguos', '2024-01-04 11:00:00', 0, 6, 'HOGAR');
INSERT INTO `stand` (`id`, `name`, `description`, `created_at`, `disable`, `owner`, `category`) VALUES (6, 'Celuphones', 'Electronica y más', '2025-03-06 0:00:00', 0, 6, 'ELEC');

COMMIT;


-- -----------------------------------------------------
-- Data for table `image`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (1, '1_item5.jpg', 0, '2024-03-05 14:00:00', NULL, 5, NULL, 2);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (2, '2_tacos1.jpg', 1, '2024-05-03 10:00:00', NULL, 1, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (3, '3_tacos2.jpg', 2, '2024-05-03 10:05:00', NULL, 1, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (4, '4_pulsera1.jpg', 1, '2024-05-03 10:59:00', NULL, 2, NULL, 2);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (5, '5_jeans1.jpg', 1, '2024-05-03 12:00:00', NULL, 3, NULL, 3);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (6, '6_sofa1.jpg', 1, '2024-05-03 13:00:00', NULL, 4, NULL, 4);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (7, '7_suculenta1.jpg', 1, '2024-05-03 13:59:00', NULL, 5, NULL, 5);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (8, '8_smartphone1.jpg', 1, '2024-05-03 15:00:00', NULL, 6, NULL, 6);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (9, '9_quesadillas1.jpg', 1, '2024-05-03 16:00:00', NULL, 7, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (10, '10_collar1.jpg', 1, '2024-05-03 16:59:00', NULL, 8, NULL, 2);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (11, '11_playera1.jpg', 1, '2024-05-03 18:00:00', NULL, 9, NULL, 3);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (12, '12_tacos3.jpg', 3, '2024-06-03 09:00:00', NULL, 1, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (13, '13_pulsera2.jpg', 2, '2024-06-03 10:00:00', NULL, 2, NULL, 2);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (14, '14_jeans2.jpg', 2, '2024-06-03 10:59:00', NULL, 3, NULL, 3);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (15, '15_sofa2.jpg', 2, '2024-06-03 12:00:00', NULL, 4, NULL, 4);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (16, '16_suculenta2.jpg', 2, '2024-06-03 13:00:00', NULL, 5, NULL, 5);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (17, '17_smartphone2.jpg', 2, '2024-06-03 13:59:00', NULL, 6, NULL, 6);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (18, '18_quesadillas2.jpg', 2, '2024-06-03 15:00:00', NULL, 7, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (19, '19_collar2.jpg', 2, '2024-06-03 16:00:00', NULL, 8, NULL, 2);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (20, '20_playera2.jpg', 2, '2024-06-03 16:59:00', NULL, 9, NULL, 3);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (21, '21_maceta1.jpg', 1, '2024-05-03 19:00:00', NULL, 10, NULL, 5);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (22, '22_audifonos1.jpg', 1, '2024-05-03 19:59:00', NULL, 11, NULL, 6);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (23, '23_tamales1.jpg', 1, '2024-05-03 21:00:00', NULL, 12, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (24, '24_aretes1.jpg', 1, '2024-05-03 22:00:00', NULL, 13, NULL, 2);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (25, '25_pantalones1.jpg', 1, '2024-05-03 22:59:00', NULL, 14, NULL, 3);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (26, '26_sabila1.jpg', 1, '2024-06-03 07:59:00', NULL, 15, NULL, 5);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (27, '27_tianguis_otay.jpg', 1, '2024-05-03 10:00:00', 1, NULL, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (28, '28_tianguis_presa.jpg', 1, '2024-05-03 10:59:00', 2, NULL, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (29, '29_tianguis_dominical.jpg', 1, '2024-05-03 12:00:00', 3, NULL, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (30, '30_tianguis_la_bola.jpg', 1, '2024-05-03 13:00:00', 4, NULL, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (31, '31_tianguis_salesianos.jpg', 1, '2024-05-03 13:59:00', 5, NULL, NULL, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (32, '32_stand_antojitos.jpg', 1, '2024-05-03 15:00:00', NULL, NULL, 1, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (33, '33_stand_artesanias.jpg', 1, '2024-05-03 16:00:00', NULL, NULL, 2, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (34, '34_stand_plantas.jpg', 1, '2024-05-03 16:59:00', NULL, NULL, 5, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (35, '35_stand_ropa.jpg', 1, '2024-05-03 18:00:00', NULL, NULL, 3, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (36, '36_stand_muebles.jpg', NULL, '2024-05-03 19:00:00', NULL, NULL, 4, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (37, '37_stand_celuphones.jpg', NULL, '2024-05-03 19:59:00', NULL, NULL, 6, 1);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (38, '38_jhondue.jpg', NULL, '2025-03-10 00:00:00', NULL, NULL, NULL, 6);
INSERT INTO `image` (`id`, `url`, `order`, `created_at`, `tianguis`, `item`, `stand`, `user`) VALUES (39, 'default.jpg', NULL, '2025-03-10 00:00:00', NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `phone`, `role`, `created_at`, `disable`, `photo`) VALUES (1, 'Ana', 'García Perez', 'ana@example.com', 'password1', '526641047883', 'seller', '2024-01-01 08:00:00', 0, 39);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `phone`, `role`, `created_at`, `disable`, `photo`) VALUES (2, 'Luis Felipe', 'Hernández Sanchez', 'luis@example.com', 'password2', '526641012787', 'customer', '2024-01-02 09:15:00', 0, 39);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `phone`, `role`, `created_at`, `disable`, `photo`) VALUES (3, 'María Jose', 'López Herrera', 'maria@example.com', 'password3', '526639466532', 'seller', '2024-01-03 10:30:00', 0, 39);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `phone`, `role`, `created_at`, `disable`, `photo`) VALUES (4, 'Pedro', 'Martínez', 'pedro@example.com', 'password4', '526641234669', 'customer', '2024-01-04 11:45:00', 0, 39);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `phone`, `role`, `created_at`, `disable`, `photo`) VALUES (5, 'Carmen', 'Díaz', 'carmen@example.com', 'password5', '523327499647', 'seller', '2024-01-05 12:00:00', 0, 39);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `phone`, `role`, `created_at`, `disable`, `photo`) VALUES (6, 'Jhon', 'Due', 'jhondue@example.com', 'jhondue', '016195551234', 'seller', '2025-03-06 00:00:00', 0, 38);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `phone`, `role`, `created_at`, `disable`, `photo`) VALUES (7, 'Andres', 'Lopez', 'amlo@example.com', 'nocorrupcion', '525510247336', 'customer', '2025-03-06 00:00:00', 0, 39);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `favorite` (`item`, `user`) VALUES (2, 2);
INSERT INTO `favorite` (`item`, `user`) VALUES (3, 4);
INSERT INTO `favorite` (`item`, `user`) VALUES (5, 2);
INSERT INTO `favorite` (`item`, `user`) VALUES (1, 4);
INSERT INTO `favorite` (`item`, `user`) VALUES (4, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `stand_location`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `stand_location` (`id`, `address`, `location`, `tianguis_dependece`, `created_at`, `disable`, `tianguis`, `stand_info`) VALUES (1, 'Calle de la Industria 123 Local 1', ST_GeomFromText('POINT(32.5379 -116.9555)', 4326), 1, '2024-03-05 10:00:00', 0, 1, 1);
INSERT INTO `stand_location` (`id`, `address`, `location`, `tianguis_dependece`, `created_at`, `disable`, `tianguis`, `stand_info`) VALUES (6, 'Calle Fronteriza 789 Local 6', ST_GeomFromText('POINT(32.5336 -116.9607)', 4326), 0, '2024-03-06 14:00:00', 0, 3, 1);
INSERT INTO `stand_location` (`id`, `address`, `location`, `tianguis_dependece`, `created_at`, `disable`, `tianguis`, `stand_info`) VALUES (2, 'Calle de la Industria 123 Local 2', ST_GeomFromText('POINT(32.5378 -116.9553)', 4326), 1, '2024-03-05 11:00:00', 0, 1, 2);
INSERT INTO `stand_location` (`id`, `address`, `location`, `tianguis_dependece`, `created_at`, `disable`, `tianguis`, `stand_info`) VALUES (4, 'Calle Fronteriza 789 Local 4', ST_GeomFromText('POINT(32.5337 -116.9610)', 4326), 1, '2024-03-05 13:00:00', 0, 2, 4);
INSERT INTO `stand_location` (`id`, `address`, `location`, `tianguis_dependece`, `created_at`, `disable`, `tianguis`, `stand_info`) VALUES (3, 'Avenida Tecnologico 456 Local 3', ST_GeomFromText('POINT(32.5451 -116.9399)', 4326), 1, '2024-03-05 12:00:00', 0, 2, 5);
INSERT INTO `stand_location` (`id`, `address`, `location`, `tianguis_dependece`, `created_at`, `disable`, `tianguis`, `stand_info`) VALUES (5, 'Calle Fronteriza 789 Local 5', ST_GeomFromText('POINT(32.5336 -116.9607)', 4326), 0, '2024-03-05 14:00:00', 0, 3, 5);
INSERT INTO `stand_location` (`id`, `address`, `location`, `tianguis_dependece`, `created_at`, `disable`, `tianguis`, `stand_info`) VALUES (7, 'Altiplano', ST_GeomFromText('POINT(32.5336 -116.9607)', 4326), 0, '2024-03-07 14:00:00', 0, 5, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tianguis_suggestion`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `tianguis_suggestion` 
(`id`, `new_name`, `new_address`, `new_location`, `points`, `created_at`, `disable`, `tianguis_base`, `user`) VALUES 
(1,     NULL,       'Calle Nueva 200 Otay', ST_GeomFromText('MULTILINESTRING((32.5382 -116.9560, 32.5384 -116.9555, 32.5381 -116.9552))', 4326), 5, '2024-03-05 10:00:00', 0, 1, 2);
INSERT INTO `tianguis_suggestion` (`id`, `new_name`, `new_address`, `new_location`, `points`, `created_at`, `disable`, `tianguis_base`, `user`) 
VALUES (2, 'Mercado Extendido La Presa', 'Avenida Tecnologico 600 La Presa', ST_GeomFromText('MULTILINESTRING((0 0, 0 0))', 4326), 3, '2024-03-05 11:00:00', 0, 2, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `schedule_suggestion`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `schedule_suggestion` (`id`, `day`, `new_open_time`, `new_close_time`, `created_at`, `tianguis_suggestion`, `user`) VALUES (1, 'saturday', '7:30:00', '16:30:00', '2024-03-05 10:00:00', 1, 2);
INSERT INTO `schedule_suggestion` (`id`, `day`, `new_open_time`, `new_close_time`, `created_at`, `tianguis_suggestion`, `user`) VALUES (2, 'wednesday', '8:00:00', '17:00:00', '2024-03-05 11:00:00', 2, 4);
INSERT INTO `schedule_suggestion` (`id`, `day`, `new_open_time`, `new_close_time`, `created_at`, `tianguis_suggestion`, `user`) VALUES (3, 'monday', '9:00:00', '18:00:00', '2024-03-06 11:00:00', 2, 4);
INSERT INTO `schedule_suggestion` (`id`, `day`, `new_open_time`, `new_close_time`, `created_at`, `tianguis_suggestion`, `user`) VALUES (4, 'tuesday', '10:00:00', '19:00:00', '2024-03-07 11:00:00', 2, 4);
INSERT INTO `schedule_suggestion` (`id`, `day`, `new_open_time`, `new_close_time`, `created_at`, `tianguis_suggestion`, `user`) VALUES (5, 'sunday', '11:00:00', '20:00:00', '2024-03-08 11:00:00', 2, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `suggestion_response`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `suggestion_response` (`suggestion`, `user`, `approve`) VALUES (1, 3, 1);
INSERT INTO `suggestion_response` (`suggestion`, `user`, `approve`) VALUES (1, 5, 1);
INSERT INTO `suggestion_response` (`suggestion`, `user`, `approve`) VALUES (2, 1, 0);
INSERT INTO `suggestion_response` (`suggestion`, `user`, `approve`) VALUES (2, 3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `stand_schedule`
-- -----------------------------------------------------
START TRANSACTION;
USE `tianguisapp`;
INSERT INTO `stand_schedule` 
(`day`, `stand`, `open_time`, `close_time`, `tianguis_dependence`) VALUES 
('sunday', 7,     NULL,       NULL,          1);
INSERT INTO `stand_schedule` (`day`, `stand`, `open_time`, `close_time`, `tianguis_dependence`) VALUES ('saturday', 7, NULL, NULL, 1);
INSERT INTO `stand_schedule` (`day`, `stand`, `open_time`, `close_time`, `tianguis_dependence`) VALUES ('monday', 7, '7:00:00', '18:00:00', 0);
INSERT INTO `stand_schedule` (`day`, `stand`, `open_time`, `close_time`, `tianguis_dependence`) VALUES ('sunday', 6, NULL, NULL, 1);
INSERT INTO `stand_schedule` (`day`, `stand`, `open_time`, `close_time`, `tianguis_dependence`) VALUES ('saturday', 5, '10:00:00', '17:00:00', 0);
INSERT INTO `stand_schedule` (`day`, `stand`, `open_time`, `close_time`, `tianguis_dependence`) VALUES ('sunday', 5, '10:00:00', '17:00:00', 0);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
