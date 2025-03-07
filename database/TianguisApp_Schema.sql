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
-- Table `tianguisapp`.`tianguis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`tianguis` (
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
-- Table `tianguisapp`.`tianguis_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`tianguis_schedule` (
  `day` ENUM('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') NOT NULL,
  `tianguis` BIGINT NOT NULL,
  `open_time` TIME NULL DEFAULT NULL,
  `close_time` TIME NULL DEFAULT NULL,
  PRIMARY KEY (`day`, `tianguis`),
  INDEX `idx_Schedule_Day_day` (`day` ASC) VISIBLE,
  CONSTRAINT `fk_Schedule_Day_tianguis`
    FOREIGN KEY (`tianguis`)
    REFERENCES `tianguisapp`.`tianguis` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`category` (
  `code` VARCHAR(5) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `disable` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`stand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`stand` (
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
    REFERENCES `tianguisapp`.`category` (`code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Stand_owner`
    FOREIGN KEY (`owner`)
    REFERENCES `tianguisapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`image` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(514) NOT NULL,
  `order` INT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tianguis` BIGINT NULL DEFAULT NULL,
  `item` BIGINT NULL DEFAULT NULL,
  `stand` BIGINT NULL DEFAULT NULL,
  `user` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Image_tianguis` (`tianguis` ASC) VISIBLE,
  INDEX `fk_Image_item` (`item` ASC) VISIBLE,
  INDEX `fk_Image_stand` (`stand` ASC) VISIBLE,
  INDEX `fk_image_1_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `fk_Image_item`
    FOREIGN KEY (`item`)
    REFERENCES `tianguisapp`.`item` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Image_stand`
    FOREIGN KEY (`stand`)
    REFERENCES `tianguisapp`.`stand` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Image_tianguis`
    FOREIGN KEY (`tianguis`)
    REFERENCES `tianguisapp`.`tianguis` (`id`),
  CONSTRAINT `fk_image_1`
    FOREIGN KEY (`user`)
    REFERENCES `tianguisapp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`user` (
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
    REFERENCES `tianguisapp`.`image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`status` (
  `code` VARCHAR(5) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `disable` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`item` (
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
  `category` VARCHAR(5) NULL DEFAULT NULL,
  `status` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Item_stand` (`stand` ASC) VISIBLE,
  INDEX `fk_Item_category` (`category` ASC) VISIBLE,
  INDEX `fk_Item_owner` (`owner` ASC) VISIBLE,
  INDEX `fk_Item_status` (`status` ASC) VISIBLE,
  CONSTRAINT `fk_Item_category`
    FOREIGN KEY (`category`)
    REFERENCES `tianguisapp`.`category` (`code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Item_owner`
    FOREIGN KEY (`owner`)
    REFERENCES `tianguisapp`.`user` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Item_stand`
    FOREIGN KEY (`stand`)
    REFERENCES `tianguisapp`.`stand` (`id`),
  CONSTRAINT `fk_Item_status`
    FOREIGN KEY (`status`)
    REFERENCES `tianguisapp`.`status` (`code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`favorite` (
  `item` BIGINT NOT NULL,
  `user` BIGINT NOT NULL,
  PRIMARY KEY (`item`, `user`),
  INDEX `fk_Favorite_user` (`user` ASC) VISIBLE,
  CONSTRAINT `fk_Favorite_item`
    FOREIGN KEY (`item`)
    REFERENCES `tianguisapp`.`item` (`id`),
  CONSTRAINT `fk_Favorite_user`
    FOREIGN KEY (`user`)
    REFERENCES `tianguisapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`stand_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`stand_location` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(500) NULL DEFAULT NULL,
  `location` POINT NOT NULL,
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
    REFERENCES `tianguisapp`.`stand` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Stand_Location_tianguis`
    FOREIGN KEY (`tianguis`)
    REFERENCES `tianguisapp`.`tianguis` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`tianguis_suggestion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`tianguis_suggestion` (
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
    REFERENCES `tianguisapp`.`tianguis` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tianguis_user_suggestion`
    FOREIGN KEY (`user`)
    REFERENCES `tianguisapp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tianguisapp`.`schedule_suggestion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`schedule_suggestion` (
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
    REFERENCES `tianguisapp`.`tianguis_suggestion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suggestion_user`
    FOREIGN KEY (`user`)
    REFERENCES `tianguisapp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tianguisapp`.`suggestion_response`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`suggestion_response` (
  `suggestion` BIGINT NOT NULL,
  `user` BIGINT NOT NULL,
  `approve` TINYINT NOT NULL,
  PRIMARY KEY (`suggestion`, `user`),
  INDEX `fk_tianguis_suggestion_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `fk_suggestion_user_response`
    FOREIGN KEY (`suggestion`)
    REFERENCES `tianguisapp`.`tianguis_suggestion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tianguis_base_suggestion`
    FOREIGN KEY (`user`)
    REFERENCES `tianguisapp`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tianguisapp`.`stand_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tianguisapp`.`stand_schedule` (
  `day` ENUM('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') NOT NULL,
  `stand` BIGINT NOT NULL,
  `open_time` TIME NULL DEFAULT NULL,
  `close_time` TIME NULL DEFAULT NULL,
  `tianguis_dependence` TINYINT NOT NULL DEFAULT 1,
  INDEX `fk_schedule_stand_location_idx` (`stand` ASC) VISIBLE,
  PRIMARY KEY (`day`, `stand`),
  CONSTRAINT `fk_schedule_stand_location`
    FOREIGN KEY (`stand`)
    REFERENCES `tianguisapp`.`stand_location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
